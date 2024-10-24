
#include <stdbool.h>
#include <ti/sysbios/family/arm/m3/Hwi.h>
#include <ti/sysbios/knl/Clock.h>
#include <ti/sysbios/knl/Queue.h>
#include <ti/sysbios/knl/Semaphore.h>

#include <ti/drivers/pin/PINCC26XX.h>

#ifdef USE_ICALL
#include <icall.h>
#endif

#include <inc/hw_ints.h>

#include "board.h"
#include "board_key.h"
#include "util.h"

static void Board_keyChangeHandler(UArg a0);
static void Board_keyCallback(PIN_Handle hPin, PIN_Id pinId);

// Value of keys Pressed
static uint8_t keysPressed;

// Key debounce clock
static Clock_Struct keyChangeClock;

// Pointer to application callback
keysPressedCB_t appKeyChangeHandler = NULL;

// Memory for the GPIO module to construct a Hwi
Hwi_Struct callbackHwiKeys;

// PIN configuration structure to set all KEY pins as inputs with pullups
// enabled
PIN_Config keyPinsCfg[] = {
#if defined(CC26X2R1_LAUNCHXL) || defined(CC13X2R1_LAUNCHXL) ||                \
    defined(CC13X2P1_LAUNCHXL)
    Board_PIN_BUTTON0 | PIN_GPIO_OUTPUT_DIS | PIN_INPUT_EN | PIN_PULLUP,
    Board_PIN_BUTTON1 | PIN_GPIO_OUTPUT_DIS | PIN_INPUT_EN | PIN_PULLUP,
#elif defined(CC2650_LAUNCHXL) || defined(CC2640R2_LAUNCHXL) ||                \
    defined(CC1350_LAUNCHXL)
    Board_BTN1 | PIN_GPIO_OUTPUT_DIS | PIN_INPUT_EN | PIN_PULLUP,
    Board_BTN2 | PIN_GPIO_OUTPUT_DIS | PIN_INPUT_EN | PIN_PULLUP,
#elif defined(CC2650DK_7ID) || defined(CC1350DK_7XD)
    Board_KEY_SELECT | PIN_GPIO_OUTPUT_DIS | PIN_INPUT_EN | PIN_PULLUP,
    Board_KEY_UP | PIN_GPIO_OUTPUT_DIS | PIN_INPUT_EN | PIN_PULLUP,
    Board_KEY_DOWN | PIN_GPIO_OUTPUT_DIS | PIN_INPUT_EN | PIN_PULLUP,
    Board_KEY_LEFT | PIN_GPIO_OUTPUT_DIS | PIN_INPUT_EN | PIN_PULLUP,
    Board_KEY_RIGHT | PIN_GPIO_OUTPUT_DIS | PIN_INPUT_EN | PIN_PULLUP,
#endif
    PIN_TERMINATE};

PIN_State keyPins;
PIN_Handle hKeyPins;

/*********************************************************************
 * PUBLIC FUNCTIONS
 */
/*********************************************************************
 * @fn      Board_initKeys
 *
 * @brief   Enable interrupts for keys on GPIOs.
 *
 * @param   appKeyCB - application key pressed callback
 *
 * @return  none
 */
void Board_initKeys(keysPressedCB_t appKeyCB) {
  // Initialize KEY pins. Enable int after callback registered
  hKeyPins = PIN_open(&keyPins, keyPinsCfg);
  PIN_registerIntCb(hKeyPins, Board_keyCallback);

#if defined(CC26X2R1_LAUNCHXL) || defined(CC13X2R1_LAUNCHXL) ||                \
    defined(CC13X2P1_LAUNCHXL)
  PIN_setConfig(hKeyPins, PIN_BM_IRQ, Board_PIN_BUTTON0 | PIN_IRQ_NEGEDGE);
  PIN_setConfig(hKeyPins, PIN_BM_IRQ, Board_PIN_BUTTON1 | PIN_IRQ_NEGEDGE);
#elif defined(CC2650_LAUNCHXL) || defined(CC2640R2_LAUNCHXL) ||                \
    defined(CC1350_LAUNCHXL)
  PIN_setConfig(hKeyPins, PIN_BM_IRQ, Board_BTN1 | PIN_IRQ_NEGEDGE);
  PIN_setConfig(hKeyPins, PIN_BM_IRQ, Board_BTN2 | PIN_IRQ_NEGEDGE);
#elif defined(CC2650DK_7ID) || defined(CC1350DK_7XD)
  PIN_setConfig(hKeyPins, PIN_BM_IRQ, Board_KEY_SELECT | PIN_IRQ_NEGEDGE);
  PIN_setConfig(hKeyPins, PIN_BM_IRQ, Board_KEY_UP | PIN_IRQ_NEGEDGE);
  PIN_setConfig(hKeyPins, PIN_BM_IRQ, Board_KEY_DOWN | PIN_IRQ_NEGEDGE);
  PIN_setConfig(hKeyPins, PIN_BM_IRQ, Board_KEY_LEFT | PIN_IRQ_NEGEDGE);
  PIN_setConfig(hKeyPins, PIN_BM_IRQ, Board_KEY_RIGHT | PIN_IRQ_NEGEDGE);
#endif

#ifdef POWER_SAVING
  // Enable wakeup
#if defined(CC26X2R1_LAUNCHXL) || defined(CC13X2R1_LAUNCHXL) ||                \
    defined(CC13X2P1_LAUNCHXL)
  PIN_setConfig(hKeyPins, PINCC26XX_BM_WAKEUP,
                Board_PIN_BUTTON0 | PINCC26XX_WAKEUP_NEGEDGE);
  PIN_setConfig(hKeyPins, PINCC26XX_BM_WAKEUP,
                Board_PIN_BUTTON1 | PINCC26XX_WAKEUP_NEGEDGE);
#elif defined(CC2650_LAUNCHXL) || defined(CC2640R2_LAUNCHXL) ||                \
    defined(CC1350_LAUNCHXL)
  PIN_setConfig(hKeyPins, PINCC26XX_BM_WAKEUP,
                Board_BTN1 | PINCC26XX_WAKEUP_NEGEDGE);
  PIN_setConfig(hKeyPins, PINCC26XX_BM_WAKEUP,
                Board_BTN2 | PINCC26XX_WAKEUP_NEGEDGE);
#elif defined(CC2650DK_7ID) || defined(CC1350DK_7XD)
  PIN_setConfig(hKeyPins, PINCC26XX_BM_WAKEUP,
                Board_KEY_SELECT | PINCC26XX_WAKEUP_NEGEDGE);
  PIN_setConfig(hKeyPins, PINCC26XX_BM_WAKEUP,
                Board_KEY_UP | PINCC26XX_WAKEUP_NEGEDGE);
  PIN_setConfig(hKeyPins, PINCC26XX_BM_WAKEUP,
                Board_KEY_DOWN | PINCC26XX_WAKEUP_NEGEDGE);
  PIN_setConfig(hKeyPins, PINCC26XX_BM_WAKEUP,
                Board_KEY_LEFT | PINCC26XX_WAKEUP_NEGEDGE);
  PIN_setConfig(hKeyPins, PINCC26XX_BM_WAKEUP,
                Board_KEY_RIGHT | PINCC26XX_WAKEUP_NEGEDGE);
#endif
#endif // POWER_SAVING

  // Setup keycallback for keys
  Util_constructClock(&keyChangeClock, Board_keyChangeHandler,
                      KEY_DEBOUNCE_TIMEOUT, 0, false, 0);

  // Set the application callback
  appKeyChangeHandler = appKeyCB;
}

/*********************************************************************
 * @fn      Board_keyCallback
 *
 * @brief   Interrupt handler for Keys
 *
 * @param   none
 *
 * @return  none
 */
static void Board_keyCallback(PIN_Handle hPin, PIN_Id pinId) {
  keysPressed = 0;
#if defined(CC26X2R1_LAUNCHXL) || defined(CC13X2R1_LAUNCHXL) ||                \
    defined(CC13X2P1_LAUNCHXL)
  if (PIN_getInputValue(Board_PIN_BUTTON0) == 0) {
    keysPressed |= KEY_LEFT;
  }

  if (PIN_getInputValue(Board_PIN_BUTTON1) == 0) {
    keysPressed |= KEY_RIGHT;
  }
#elif defined(CC2650_LAUNCHXL) || defined(CC2640R2_LAUNCHXL) ||                \
    defined(CC1350_LAUNCHXL)
  if (PIN_getInputValue(Board_BTN1) == 0) {
    keysPressed |= KEY_LEFT;
  }

  if (PIN_getInputValue(Board_BTN2) == 0) {
    keysPressed |= KEY_RIGHT;
  }
#elif defined(CC2650DK_7ID) || defined(CC1350DK_7XD)
  if (PIN_getInputValue(Board_KEY_SELECT) == 0) {
    keysPressed |= KEY_SELECT;
  }

  if (PIN_getInputValue(Board_KEY_UP) == 0) {
    keysPressed |= KEY_UP;
  }

  if (PIN_getInputValue(Board_KEY_DOWN) == 0) {
    keysPressed |= KEY_DOWN;
  }

  if (PIN_getInputValue(Board_KEY_LEFT) == 0) {
    keysPressed |= KEY_LEFT;
  }

  if (PIN_getInputValue(Board_KEY_RIGHT) == 0) {
    keysPressed |= KEY_RIGHT;
  }
#endif

  Util_startClock(&keyChangeClock);
}

/*********************************************************************
 * @fn      Board_keyChangeHandler
 *
 * @brief   Handler for key change
 *
 * @param   UArg a0 - ignored
 *
 * @return  none
 */
static void Board_keyChangeHandler(UArg a0) {
  if (appKeyChangeHandler != NULL) {
    // Notify the application
    (*appKeyChangeHandler)(keysPressed);
  }
}
/*********************************************************************
*********************************************************************/
