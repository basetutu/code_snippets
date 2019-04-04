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

#include <stdbool.h>
#include <inttypes.h>
#include <stdint.h>
#include "nrf_spis.h"
#include "sdk_errors.h"

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


/**
 * @brief Shall be used to write clean code. Can f.ex. be used to write
 *        small filtering code to exclude certain outputs or behavior.
 */
#define IF_CODE(condition, code_true, code_false)                 \
              if(condition) {                                     \
                code_true                                         \
              } else {                                            \
                code_false                                        \
              }

/***************************************************************
 * Globally used MACROs, DEFINITIONs and CONSTANTs
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

// These can also accept bit-masks instead of single bits (Must be of compatible bit length)
#define BITWISE_CLEAR_ALL_BITS(value)     (value) = (0UL)
#define BITWISE_CLEAR_BIT(value, flag)    (value) &= ~(flag)
#define BITWISE_SET_BIT(value, flag)      (value) |= (flag)
#define BITWISE_IS_BIT_SET(value, flag)   (value) & (flag) > 0

// To check whether a call is made from an interrupt
#define IS_INTERRUPT                      (SCB->ICSR & SCB_ICSR_VECTACTIVE_Msk)

/***************************************************************
 * Two Return codes to use for error handling between functions
 **************************************************************/
/**
 * The return code used for all functions of the driver API
 * and higher levels of logic.
 */
typedef enum {

  /* Meaning: SUCCESS */
  Code_Success                                                     = 0,
  
  /* Meaning: Default failed code with no helping indication. */
  Code_Fail_Unknown                                                = 1,

  /* Meaning: Failed due to lack of memory. */
  Code_Fail_NoMemory                                               = 2,

  /* Meaning: A specific entity could not be found. */
  Code_Fail_NotFound                                               = 3,

  /* Meaning: The operation or the entire module is globally
   * suspended and cannot be utilized at this point in time.
   * Intentional unavailability. */
  Code_Fail_Suspended                                              = 4,

  /* Meaning: Not in an appropriate state for this call. */
  Code_Fail_InvalidState                                           = 5,

  /* Meaning: This operation can not be allowed at this point. */
  Code_Fail_InvalidOperation                                       = 6,

  /* Meaning: Wrong/invalid input parameters. */
  Code_Fail_InvalidParameter                                       = 7,

  /* Meaning: The request could not be accepted. */
  Code_Fail_InvalidRequest                                         = 8,

  /* Meaning: The channel is not setup or available. */
  Code_ChannelUnavailable                                          = 9,

  /* Meaning: A resource needed by this operation or call is busy.
   * Try again later. */
  Code_Fail_Busy                                                   = 10,

  /* Meaning: Failed due to timeout. */
  Code_Fail_Timeout                                                = 11,

  /* Meaning: Unknown driver error at the lowest level. This is
   * the only error that can be received from the lowest driver
   * level, since they usually operate with Booleans in return
   * code. */
  Code_Fail_Driver                                                 = 12,

  /* Meaning: This operation is not supported due to limited
   * implementation or need. */
  Code_Fail_NotImplemented                                         = 13,

  /* Meaning: This operation cannot be performed, since it is
   * blocked or not allowed. */
  Code_Fail_NotAllowed                                             = 14,

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

ReturnCode_t  convert_NRF_to_ReturnCode(uint32_t nrf_error_code);
void          convert_ReturnCode_toString(ReturnCode_t returnCode);

#endif // _GLOBAL_TYPES_H_
