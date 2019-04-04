/**********************************************************************
 * Copyright (c) Sigma Connectivity AB
 * All Rights Reserved.
 *
 * This file may not be distributed without the file ’license.txt’.
 * This file is subject to the terms and conditions defined in file
 * ’license.txt’, which is part of this source code package.
 *********************************************************************/

/**********************************************************************
 * Contains the definitions of all types used system wide in the
 * Low-Level-FirmWare (LLFW) and the High-Level-FireWare (HLFW) as
 * well as others.
 *
 * @date 09th August/2017 (created)
 *********************************************************************/

#ifndef _GLOBAL_TYPES_H_
#define _GLOBAL_TYPES_H_

#include <inttypes.h>
#include <global_config.h>

/***************************************************************
 * Globally used macros
 **************************************************************/

#define LL_VERIFY_TRUE(statement, err_code)           \
      do {                                            \
        if (!(statement))                             \
        {                                             \
          return convert_NRF_to_ReturnCode(err_code); \
        }                                             \
      } while (0)

/**@brief Macro for verifying that a function returned NRF_SUCCESS. It will cause the exterior
 *        function to return err_code if the err_code is not @ref NRF_SUCCESS.
 *
 * @param[in] err_code The error code to check.
 */
#if LL_CONFIG_DISABLE_PARAM_CHECK
#define LL_VERIFY_SUCCESS()
#else
#define LL_VERIFY_SUCCESS(err_code)    LL_VERIFY_TRUE((err_code) == NRF_SUCCESS, (err_code))
#endif /* LL_CONFIG_DISABLE_PARAM_CHECK */

/***************************************************************
 * Globally used definitions or constants
 **************************************************************/
#ifndef NULL
#define NULL    ((void*)0)
#endif

#ifndef TRUE
#define TRUE    0x1
#endif

#ifndef FALSE
#define FALSE   0x0
#endif

/***************************************************************
 * Two Return codes to use for error handling between functions
 **************************************************************/
/**
 * The return code used for all functions of the driver API
 * and higher levels of logic.
 */
typedef enum {
  /* SUCCESS */
  Code_Success,
  /* Guide: Unknown driver error at the lowest level.
   * This is the only error that can be received from the lowest driver level. */
  Code_Fail_Driver,
  /* Guide: Default failed code with no helping indication. */
  Code_Fail_Unknown,
  /* Guide: Failed possibly due to lack of memory. */
  Code_Fail_NoMemory,
  /* Guide: Failed due to invalid state. */
  Code_Fail_InvalidState,
  /* Guide: Cannot perform the operation at this point in time. */
  Code_Fail_Unavailable,
  /* Guide: The operation or the entire module is globally suspended
   * and cannot be utilized at this point in time.
   * Intentional unavailability. */
  Code_Fail_ActivitySuspended,
  /* Guide: This operation can not be allowed at this point. */
  Code_Fail_InvalidOperation,
  /* Guide: Wrong/invalid input parameters */
  Code_Fail_InvalidParameter,
  /* Guide: Operation is unavailable but in working condition. Try again later. */
  Code_Fail_Busy,
  /* Guide: Failed due to timeout. */
  Code_Fail_Timeout,
  /* Guide: Used during development and indicates pending work. */  // TODO remove before final release
  Code_Fail_NotImplemented,
} ReturnCode_t;

#define RETURNCODE_FAIL_MESSAGE_MAX_LENGTH            80 // [chars]

/*
 * Will contain a message upon an error and when passed to a function
 * as a pointer.
 * NULL must be accepted by the function instead of this parameter!
 * ReturnCode_t != Code_Success should be used as an indicator that
 * a message has been returned.
 *
 * @param message The error message of max length CODE_FAIL_MESSAGE_MAX_LENGTH.
 * @param message_size Actual length of the message.
 */
typedef struct {
    char message[RETURNCODE_FAIL_MESSAGE_MAX_LENGTH];
    int message_size;
} ReturnCodeMessage_t;

/****************************************************************
 * API FUNCTIONS
 ***************************************************************/

ReturnCode_t convert_NRF_to_ReturnCode(uint32_t nrf_error_code);

#endif // _GLOBAL_TYPES_H_
