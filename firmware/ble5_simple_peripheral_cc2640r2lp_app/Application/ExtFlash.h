
#ifndef EXT_FLASH_H
#define EXT_FLASH_H

#include <stdbool.h>
#include <stdint.h>
#include <stdlib.h>

#define EXT_FLASH_PAGE_SIZE 4096

#ifdef __cplusplus
extern "C" {
#endif

typedef struct {
  uint32_t deviceSize; // bytes
  uint8_t manfId;      // manufacturer ID
  uint8_t devId;       // device ID
} ExtFlashInfo_t;

/**
 * Initialize storage driver.
 *
 * @return True when successful.
 */
extern bool ExtFlash_open(void);

/**
 * Close the storage driver
 */
extern void ExtFlash_close(void);

/**
 * Get flash information
 */
extern ExtFlashInfo_t *ExtFlash_info(void);

/**
 * Read storage content
 *
 * @return True when successful.
 */
extern bool ExtFlash_read(size_t offset, size_t length, uint8_t *buf);

/**
 * Erase storage sectors corresponding to the range.
 *
 * @return True when successful.
 */
extern bool ExtFlash_erase(size_t offset, size_t length);

/**
 * Write to storage sectors.
 *
 * @return True when successful.
 */
extern bool ExtFlash_write(size_t offset, size_t length, const uint8_t *buf);

/**
 * Test the flash (power on self-test)
 *
 * @return True when successful.
 */
extern bool ExtFlash_test(void);

#ifdef __cplusplus
}
#endif

#endif /* EXT_FLASH_H */
