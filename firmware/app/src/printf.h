
#ifndef _PRINTF_H_
#define _PRINTF_H_

#include <stdarg.h>
#include <stddef.h>

#ifdef __cplusplus
extern "C" {
#endif

int sprintf_(char *buffer, const char *format, ...);
int snprintf_(char *buffer, size_t count, const char *format, ...);
int vsnprintf_(char *buffer, size_t count, const char *format, va_list va);
int vprintf_(const char *format, va_list va);

#ifdef __cplusplus
}
#endif

#endif // _PRINTF_H_
