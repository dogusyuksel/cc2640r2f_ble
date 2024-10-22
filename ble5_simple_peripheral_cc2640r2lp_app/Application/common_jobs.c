#include <string.h>

#if !(defined __TI_COMPILER_VERSION__)
#include <intrinsics.h>
#endif

#include <ti/sysbios/knl/Task.h>
#include <ti/sysbios/knl/Clock.h>

#include <ti/drivers/UART.h>
#include <ti/drivers/uart/UARTCC26XX.h>

#include "util.h"

#include <board.h>
#include <board_key.h>

#include "common_jobs.h"

// Task configuration
#define CJ_TASK_PRIORITY                     2

#ifndef CJ_TASK_STACK_SIZE
#define CJ_TASK_STACK_SIZE                   512
#endif

#define TIMEOUT_US     5000

// Task configuration
Task_Struct cjTask;
#if defined __TI_COMPILER_VERSION__
#pragma DATA_ALIGN(cjTaskStack, 8)
#else
#pragma data_alignment=8
#endif
uint8_t cjTaskStack[CJ_TASK_STACK_SIZE];

UART_Handle uart;
#define MAX_NUM_RX_BYTES    256   // Maximum RX bytes to receive in one go
uint8_t rxBuf[MAX_NUM_RX_BYTES];   // Receive buffer
size_t rxBufCounter = 0;

static void CommonJobs_init(void);
static void CommonJobs_taskFxn(UArg a0, UArg a1);

void CommonJobs_createTask(void)
{
  Task_Params taskParams;

  // Configure task
  Task_Params_init(&taskParams);
  taskParams.stack = cjTaskStack;
  taskParams.stackSize = CJ_TASK_STACK_SIZE;
  taskParams.priority = CJ_TASK_PRIORITY;

  Task_construct(&cjTask, CommonJobs_taskFxn, &taskParams, NULL);
}

static void CommonJobs_init(void)
{
  UART_Params uartParams;

  UART_init();
  UART_Params_init(&uartParams);

  uartParams.baudRate = 115200;
  uartParams.writeDataMode = UART_DATA_BINARY;
  uartParams.readDataMode = UART_DATA_BINARY;
  uartParams.readReturnMode = UART_RETURN_FULL;
  uartParams.readEcho = UART_ECHO_OFF;
  uartParams.readTimeout   = TIMEOUT_US / ClockP_tickPeriod; // Default tick period is 10us

  uart = UART_open(Board_UART0, &uartParams);
  if (uart == NULL) {
      /* UART_open() failed */
      while (1);
  }

  UART_write(uart, "uart initialized\n", 17);
}

static void CommonJobs_taskFxn(UArg a0, UArg a1)
{
  // Initialize application
  CommonJobs_init();

  // Application main loop
  for (;;)
  {
    //try to read data from uart with timeout
    uint8_t revbyte = 0;
    int rxBytes = UART_read(uart, &revbyte, 1);
    if (rxBytes) {
        rxBuf[rxBufCounter++] = revbyte;
        if (revbyte == (uint8_t)'\n') {
            rxBufCounter = 0;
            memset(rxBuf, 0, sizeof(rxBuf));
            UART_write(uart, "proceed to process\n", 19);
        }
    }
  }
}
