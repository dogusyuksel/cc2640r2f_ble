/******************************************************************************

 @file  osal_icall_ble.c

 @brief This file contains function that allows user setup tasks

 Group: WCS, BTS
 Target Device: cc2640r2

 ******************************************************************************

 Copyright (c) 2013-2024, Texas Instruments Incorporated
 All rights reserved.

 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions
 are met:

 *  Redistributions of source code must retain the above copyright
    notice, this list of conditions and the following disclaimer.

 *  Redistributions in binary form must reproduce the above copyright
    notice, this list of conditions and the following disclaimer in the
    documentation and/or other materials provided with the distribution.

 *  Neither the name of Texas Instruments Incorporated nor the names of
    its contributors may be used to endorse or promote products derived
    from this software without specific prior written permission.

 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
 THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
 PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
 CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
 PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
 OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
 WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
 OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
 EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

 *****************************************************************************/

#include <icall.h>
#include "hal_types.h"
#include "hal_mcu.h"
#include "osal.h"
#include "osal_tasks.h"
#include "osal_snv.h"

#include "ll.h"

#if defined ( OSAL_CBTIMER_NUM_TASKS )
  #include "osal_cbtimer.h"
#endif

#include "l2cap.h"
#include "gap.h"

#if defined ( GAP_BOND_MGR )
  #include "gapbondmgr_internal.h"
#endif

#include "gatt.h"
#include "hci_tl.h"
#include "gattservapp.h"
#include "gapbondmgr.h"
#include "ble_user_config.h"
#include "ble_dispatch.h"

#ifdef USE_ICALL

#ifdef ICALL_JT
#include "icall_jt.h"
#endif

#ifdef ICALL_LITE
#include "icall_lite_translation.h"
#include "ble_dispatch_lite.h"
#endif

#endif

const pTaskEventHandlerFn tasksArr[] =
{
  LL_ProcessEvent,
  HCI_ProcessEvent,
#if defined ( OSAL_CBTIMER_NUM_TASKS )
  OSAL_CBTIMER_PROCESS_EVENT( osal_CbTimerProcessEvent ),
#endif
  L2CAP_ProcessEvent,
  GAP_ProcessEvent,
  SM_ProcessEvent,
  GATT_ProcessEvent,
  GATTServApp_ProcessEvent,
#if defined ( GAP_BOND_MGR )
  GAPBondMgr_ProcessEvent,
#endif
#ifdef ICALL_LITE
  ble_dispatch_liteProcess,
#else
  bleDispatch_ProcessEvent
#endif
};

const uint8 tasksCnt = sizeof( tasksArr ) / sizeof( tasksArr[0] );
uint16 *tasksEvents;

void osalInitTasks( void )
{
  ICall_EntityID entity;
  ICall_SyncHandle syncHandle;
  uint8 taskID = 0;
  uint8 i;

  tasksEvents = (uint16 *)osal_mem_alloc( sizeof( uint16 ) * tasksCnt);
  osal_memset( tasksEvents, 0, (sizeof( uint16 ) * tasksCnt));

  LL_Init( taskID++ );
  HCI_Init( taskID++ );

#if defined ( OSAL_CBTIMER_NUM_TASKS )
  osal_CbTimerInit( taskID );
  taskID += OSAL_CBTIMER_NUM_TASKS;
#endif

  L2CAP_Init( taskID++ );
  GAP_Init( taskID++ );
  SM_Init( taskID++ );
  GATT_Init( taskID++ );
  GATTServApp_Init( taskID++ );

#if defined ( GAP_BOND_MGR )
  GAPBondMgr_Init( taskID++ );
#endif

#ifdef ICALL_LITE
  ble_dispatch_liteInit(taskID++);
#else
  bleDispatch_Init( taskID );
#endif

  ICall_enrollService(ICALL_SERVICE_CLASS_BLE, NULL, &entity, &syncHandle);

#ifndef ICALL_LITE
  osal_enroll_dispatchid(taskID, entity);
#endif

  for (i = 0; i < taskID; i++)
  {
    osal_enroll_senderid(i, entity);
  }
}

int stack_main( void *arg )
{
#ifdef ICALL_JT
  setBleUserConfig( (icall_userCfg_t *)arg );
#else
  setBleUserConfig( (bleUserCfg_t *)arg );
#endif

  if (ICall_enrollService(ICALL_SERVICE_CLASS_BLE_MSG,
                          (ICall_ServiceFunc) osal_service_entry,
                          &osal_entity,
                          &osal_syncHandle) != ICALL_ERRNO_SUCCESS)
  {
    ICall_abort();
  }

  halIntState_t state;
  HAL_ENTER_CRITICAL_SECTION(state);

#if defined(ICALL_LITE) && (!defined(STACK_LIBRARY))
  {
    icall_liteTranslationInit((uint32_t*)bleAPItable);
  }
#endif

#ifdef ICALL_LITE
  {
    osal_set_icall_hook(icall_liteMsgParser);
  }
#endif

  osal_snv_init( );
  osal_init_system();

  HAL_EXIT_CRITICAL_SECTION(state);

  osal_start_system();

  return 0;
}

/*********************************************************************
*********************************************************************/
