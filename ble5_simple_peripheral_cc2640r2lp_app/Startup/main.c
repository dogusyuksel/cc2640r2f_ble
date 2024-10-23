
#include <xdc/runtime/Error.h>

#include <ti/drivers/Power.h>
#include <ti/drivers/power/PowerCC26XX.h>
#include <ti/sysbios/BIOS.h>
#include <ti/sysbios/knl/Clock.h>

#include "bcomdef.h"
#include "common_jobs.h"
#include "hal_assert.h"
#include "simple_peripheral.h"
#include <icall.h>
#ifdef PTM_MODE
#include "npi_task.h"
#endif // PTM_MODE

/* Header files required to enable instruction fetch cache */
#include <driverlib/vims.h>
#include <inc/hw_memmap.h>

#ifndef USE_DEFAULT_USER_CFG
#include "ble_user_config.h"
// BLE user defined configuration
icall_userCfg_t user0Cfg = BLE_USER_CFG;
#endif // USE_DEFAULT_USER_CFG

extern void AssertHandler(uint8 assertCause, uint8 assertSubcause);

/*******************************************************************************
 * @fn          Main
 *
 * @brief       Application Main
 *
 * input parameters
 *
 * @param       None.
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      None.
 */
int main() {
  /* Register Application callback to trap asserts raised in the Stack */
  RegisterAssertCback(AssertHandler);

  Board_initGeneral();

  // Enable iCache prefetching
  VIMSConfigure(VIMS_BASE, TRUE, TRUE);
  // Enable cache
  VIMSModeSet(VIMS_BASE, VIMS_MODE_ENABLED);

#if !defined(POWER_SAVING)
  /* Set constraints for Standby, powerdown and idle mode */
  // PowerCC26XX_SB_DISALLOW may be redundant
  Power_setConstraint(PowerCC26XX_SB_DISALLOW);
  Power_setConstraint(PowerCC26XX_IDLE_PD_DISALLOW);
#endif // POWER_SAVING

  /* Update User Configuration of the stack */
  user0Cfg.appServiceInfo->timerTickPeriod = Clock_tickPeriod;
  user0Cfg.appServiceInfo->timerMaxMillisecond = ICall_getMaxMSecs();

  /* Initialize ICall module */
  ICall_init();

  /* Start tasks of external images - Priority 5 */
  ICall_createRemoteTasks();

  SimplePeripheral_createTask();

  CommonJobs_createTask();

  /* enable interrupts and start SYS/BIOS */
  BIOS_start();

  return 0;
}

/*******************************************************************************
 * @fn          AssertHandler
 *
 * @brief       This is the Application's callback handler for asserts raised
 *              in the stack.  When EXT_HAL_ASSERT is defined in the Stack
 *              project this function will be called when an assert is raised,
 *              and can be used to observe or trap a violation from expected
 *              behavior.
 *
 *              As an example, for Heap allocation failures the Stack will raise
 *              HAL_ASSERT_CAUSE_OUT_OF_MEMORY as the assertCause and
 *              HAL_ASSERT_SUBCAUSE_NONE as the assertSubcause.  An application
 *              developer could trap any malloc failure on the stack by calling
 *              HAL_ASSERT_SPINLOCK under the matching case.
 *
 *              An application developer is encouraged to extend this function
 *              for use by their own application.  To do this, add hal_assert.c
 *              to your project workspace, the path to hal_assert.h (this can
 *              be found on the stack side). Asserts are raised by including
 *              hal_assert.h and using macro HAL_ASSERT(cause) to raise an
 *              assert with argument assertCause.  the assertSubcause may be
 *              optionally set by macro HAL_ASSERT_SET_SUBCAUSE(subCause) prior
 *              to asserting the cause it describes. More information is
 *              available in hal_assert.h.
 *
 * input parameters
 *
 * @param       assertCause    - Assert cause as defined in hal_assert.h.
 * @param       assertSubcause - Optional assert subcause (see hal_assert.h).
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      None.
 */
void AssertHandler(uint8 assertCause, uint8 assertSubcause) {
  //   Display_print0(dispHandle, 0, 0, ">>>STACK ASSERT");

  // check the assert cause
  switch (assertCause) {
  case HAL_ASSERT_CAUSE_OUT_OF_MEMORY:
    // Display_print0(dispHandle, 0, 0, "***ERROR***");
    // Display_print0(dispHandle, 2, 0, ">> OUT OF MEMORY!");
    break;

  case HAL_ASSERT_CAUSE_INTERNAL_ERROR:
    // check the subcause
    if (assertSubcause == HAL_ASSERT_SUBCAUSE_FW_INERNAL_ERROR) {
      //   Display_print0(dispHandle, 0, 0, "***ERROR***");
      //   Display_print0(dispHandle, 2, 0, ">> INTERNAL FW ERROR!");
    } else {
      //   Display_print0(dispHandle, 0, 0, "***ERROR***");
      //   Display_print0(dispHandle, 2, 0, ">> INTERNAL ERROR!");
    }
    break;

  case HAL_ASSERT_CAUSE_ICALL_ABORT:
    // Display_print0(dispHandle, 0, 0, "***ERROR***");
    // Display_print0(dispHandle, 2, 0, ">> ICALL ABORT!");
    HAL_ASSERT_SPINLOCK;
    break;

  case HAL_ASSERT_CAUSE_ICALL_TIMEOUT:
    // Display_print0(dispHandle, 0, 0, "***ERROR***");
    // Display_print0(dispHandle, 2, 0, ">> ICALL TIMEOUT!");
    HAL_ASSERT_SPINLOCK;
    break;

  case HAL_ASSERT_CAUSE_WRONG_API_CALL:
    // Display_print0(dispHandle, 0, 0, "***ERROR***");
    // Display_print0(dispHandle, 2, 0, ">> WRONG API CALL!");
    HAL_ASSERT_SPINLOCK;
    break;

  default:
    // Display_print0(dispHandle, 0, 0, "***ERROR***");
    // Display_print0(dispHandle, 2, 0, ">> DEFAULT SPINLOCK!");
    HAL_ASSERT_SPINLOCK;
  }

  return;
}

/*******************************************************************************
 * @fn          smallErrorHook
 *
 * @brief       Error handler to be hooked into TI-RTOS.
 *
 * input parameters
 *
 * @param       eb - Pointer to Error Block.
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      None.
 */
void smallErrorHook(Error_Block *eb) {
  for (;;)
    ;
}

/*******************************************************************************
 */
