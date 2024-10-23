#include <stdio.h>
#include <string.h>

#if !(defined __TI_COMPILER_VERSION__)
#include <intrinsics.h>
#endif

#include <ti/sysbios/knl/Clock.h>
#include <ti/sysbios/knl/Task.h>

#include <ti/drivers/I2C.h>
#include <ti/drivers/PIN.h>
#include <ti/drivers/UART.h>
#include <ti/drivers/pin/PINCC26XX.h>
#include <ti/drivers/uart/UARTCC26XX.h>

#include "ExtFlash.h"
#include "printf.h"
#include "util.h"

#include <board.h>
#include <board_key.h>

#include "common_jobs.h"

// Task configuration
#define CJ_TASK_PRIORITY 2
#ifndef CJ_TASK_STACK_SIZE
#define CJ_TASK_STACK_SIZE 512
#endif

#define TIMEOUT_US 5000

#define MPU_WHO_AM_I_REGISTER 0x75
#define MPU_WHO_AM_I_RESPONSE 0x68
#define MPU_ADDRESS 0b1101000 // AD0 = 0

// Task configuration
Task_Struct cjTask;
#if defined __TI_COMPILER_VERSION__
#pragma DATA_ALIGN(cjTaskStack, 8)
#else
#pragma data_alignment = 8
#endif
uint8_t cjTaskStack[CJ_TASK_STACK_SIZE];

PIN_Handle ledPinHandle;
UART_Handle uart;
I2C_Handle i2c;
#define MAX_NUM_RX_BYTES 256     // Maximum RX bytes to receive in one go
uint8_t rxBuf[MAX_NUM_RX_BYTES]; // Receive buffer
size_t rxBufCounter = 0;

PIN_Config pinTable[] = {
#if defined(Board_CC1350_LAUNCHXL)
    Board_DIO30_SWPWR | PIN_GPIO_OUTPUT_EN | PIN_GPIO_HIGH | PIN_PUSHPULL |
        PIN_DRVSTR_MAX,
#endif
    Board_PIN_LED1 | PIN_GPIO_OUTPUT_EN | PIN_GPIO_LOW | PIN_PUSHPULL |
        PIN_DRVSTR_MAX,
    Board_PIN_LED2 | PIN_GPIO_OUTPUT_EN | PIN_GPIO_LOW | PIN_PUSHPULL |
        PIN_DRVSTR_MAX,
    PIN_TERMINATE};

static void CommonJobs_init(void);
static void CommonJobs_taskFxn(UArg a0, UArg a1);

void uart_print(char *format, ...) {
  if (!uart) {
    return;
  }
  va_list arguments;
  char buffer[128] = {0};

  va_start(arguments, format);
  vsnprintf_(buffer, sizeof(buffer), format, arguments);
  va_end(arguments);

  if (strlen(buffer) == 0) {
    return;
  }

  UART_write(uart, buffer, strlen(buffer));
}

void CommonJobs_createTask(void) {
  Task_Params taskParams;

  // Configure task
  Task_Params_init(&taskParams);
  taskParams.stack = cjTaskStack;
  taskParams.stackSize = CJ_TASK_STACK_SIZE;
  taskParams.priority = CJ_TASK_PRIORITY;

  Task_construct(&cjTask, CommonJobs_taskFxn, &taskParams, NULL);
}

static void CommonJobs_init(void) {
  UART_Params uartParams;

  UART_init();
  UART_Params_init(&uartParams);

  uartParams.baudRate = 115200;
  uartParams.writeDataMode = UART_DATA_BINARY;
  uartParams.readDataMode = UART_DATA_BINARY;
  uartParams.readReturnMode = UART_RETURN_FULL;
  uartParams.readEcho = UART_ECHO_OFF;
  uartParams.readTimeout =
      TIMEOUT_US / ClockP_tickPeriod; // Default tick period is 10us

  uart = UART_open(Board_UART0, &uartParams);
  if (uart == NULL) {
    /* UART_open() failed */
    while (1)
      ;
  }

  uart_print("uart initialized!\n");

  I2C_Params i2cParams;

  I2C_init();

  I2C_Params_init(&i2cParams);

  i2cParams.bitRate = I2C_400kHz;
  i2c = I2C_open(Board_I2C_TMP, &i2cParams);
  if (i2c == NULL) {
    uart_print("I2C init error\n");
    while (1)
      ;
  }

  PIN_State ledPinState;
  /* Open LED pins */
  ledPinHandle = PIN_open(&ledPinState, pinTable);
  if (ledPinHandle == NULL) {
    while (1)
      ;
  }
}

static void MPU_6050_Exists(void) {
  uint8_t txBuffer[1];
  uint8_t rxBuffer[1];
  I2C_Transaction i2cTransaction;

  i2cTransaction.writeBuf = txBuffer;
  i2cTransaction.writeCount = 1;
  i2cTransaction.readBuf = rxBuffer;
  i2cTransaction.readCount = 1;
  i2cTransaction.slaveAddress = MPU_ADDRESS;

  txBuffer[0] = MPU_WHO_AM_I_REGISTER;

  if (!I2C_transfer(i2c, &i2cTransaction)) {
    /* Could not resolve a sensor, error */
    uart_print("I2C read error\n");
    while (1)
      ;
  }

  if (rxBuffer[0] != MPU_WHO_AM_I_RESPONSE) {
    uart_print("WHO_AM_I_NOK 0x%X\n", rxBuffer[0]);
  } else {
    uart_print("WHO_AM_I_OK\n");
  }
}

static void external_flash_check(void) {
  uint8_t write_buf = 9;
  uint8_t read_buf = 0;

  ExtFlash_open();
  const ExtFlashInfo_t *pExtFlashInfo = ExtFlash_info();

  ExtFlash_erase(0, pExtFlashInfo->deviceSize);

  ExtFlash_write(0, 1, &write_buf);
  ExtFlash_read(0, 1, &read_buf);

  if (write_buf == read_buf) {
    uart_print("EXT_FLASH_OK\n");
  } else {
    uart_print("EXT_FLASH_NOK: 0x%X\n", read_buf);
  }

  ExtFlash_close();
}

static void CommonJobs_taskFxn(UArg a0, UArg a1) {
  // Initialize application
  CommonJobs_init();

  MPU_6050_Exists();

  external_flash_check();

  // Application main loop
  for (;;) {
    // try to read data from uart with timeout
    uint8_t revbyte = 0;
    int rxBytes = UART_read(uart, &revbyte, 1);
    if (rxBytes) {
      rxBuf[rxBufCounter++] = revbyte;
      if (revbyte == (uint8_t)'\n') {
        rxBufCounter = 0;
        memset(rxBuf, 0, sizeof(rxBuf));
        uart_print("proceed to process\n");
      }
    }
  }
}
