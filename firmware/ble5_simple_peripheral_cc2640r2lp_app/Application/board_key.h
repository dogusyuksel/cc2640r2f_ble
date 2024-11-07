
#ifndef BOARD_KEY_H
#define BOARD_KEY_H

#ifdef __cplusplus
extern "C" {
#endif

#define KEY_SELECT 0x0001
#define KEY_UP 0x0002
#define KEY_DOWN 0x0004
#define KEY_LEFT 0x0008
#define KEY_RIGHT 0x0010

// Debounce timeout in milliseconds
#define KEY_DEBOUNCE_TIMEOUT 200

/*********************************************************************
 * TYPEDEFS
 */
typedef void (*keysPressedCB_t)(uint8_t keysPressed);

/*********************************************************************
 * MACROS
 */

/*********************************************************************
 * API FUNCTIONS
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
void Board_initKeys(keysPressedCB_t appKeyCB);

/*********************************************************************
*********************************************************************/

#ifdef __cplusplus
}
#endif

#endif /* BOARD_KEY_H */
