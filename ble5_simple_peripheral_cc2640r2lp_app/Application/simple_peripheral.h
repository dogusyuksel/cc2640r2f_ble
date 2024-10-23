#ifndef SIMPLEPERIPHERAL_H
#define SIMPLEPERIPHERAL_H

#ifdef __cplusplus
extern "C" {
#endif

/*
 * Task creation function for the Simple Peripheral.
 */
extern void SimplePeripheral_createTask(void);

/*
 * Functions for menu action
 */

/* Actions for Menu: Set PHY - Select */
bool SimplePeripheral_doSetConnPhy(uint8 index);

#ifdef PTM_MODE
/* Actions for Menu: Enable PTM Mode */
bool SimplePeripheral_doEnablePTMMode(uint8 index);
#endif

#ifdef __cplusplus
}
#endif

#endif /* SIMPLEPERIPHERAL_H */
