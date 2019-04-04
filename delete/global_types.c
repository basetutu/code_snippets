/**********************************************************************
 * Copyright (c) Sigma Connectivity AB
 * All Rights Reserved. 2017
 *
 * This file may not be distributed without the file ’license.txt’.
 * This file is subject to the terms and conditions defined in file
 * ’license.txt’, which is part of this source code package.
 *********************************************************************/

#include "global_types.h"
#include "nrf_error.h"

#define LL_LOG_MODULE_NAME     "GL_TYPES"
#include "LL_log.h"

/****************************************************************
 * CONFIGURATIONS*
 ***************************************************************/

/****************************************************************
 * DEFINITIONS, TYPEDEF and CONSTANTS
 ***************************************************************/

/****************************************************************
 * MACROS
 ***************************************************************/

/****************************************************************
 * STATIC VARIABLES
 ***************************************************************/

/****************************************************************
 * ENUMERATIONS
 ***************************************************************/

/****************************************************************
 * FORWARD DECLARATIONS
 ***************************************************************/

/****************************************************************
 * STATIC FUNCTIONS
 ***************************************************************/

/****************************************************************
 * API FUNCTIONS
 ***************************************************************/

ReturnCode_t convert_NRF_to_ReturnCode(uint32_t nrf_error_code)
{
  switch (nrf_error_code)
  {
    case NRF_SUCCESS:
      return Code_Success;
      break;
    case NRF_ERROR_SVC_HANDLER_MISSING:
      return Code_Fail_Unknown;
      break;
    case NRF_ERROR_SOFTDEVICE_NOT_ENABLED:
      return Code_Fail_InvalidState;
      break;
    case NRF_ERROR_INTERNAL:
      return Code_Fail_Driver;
      break;
    case NRF_ERROR_NO_MEM:
      return Code_Fail_NoMemory;
      break;
    case NRF_ERROR_NOT_FOUND:
      return Code_Fail_Unavailable;
      break;
    case NRF_ERROR_NOT_SUPPORTED:
      return Code_Fail_NotImplemented;
      break;
    case NRF_ERROR_INVALID_PARAM:
      return Code_Fail_InvalidParameter;
      break;
    case NRF_ERROR_INVALID_STATE:
      return Code_Fail_InvalidState;
      break;
    case NRF_ERROR_INVALID_LENGTH:
      return Code_Fail_Unknown;
      break;
    case NRF_ERROR_INVALID_FLAGS:
      return Code_Fail_Unknown;
      break;
    case NRF_ERROR_INVALID_DATA:
      return Code_Fail_Unknown;
      break;
    case NRF_ERROR_DATA_SIZE:
      return Code_Fail_Unknown;
      break;
    case NRF_ERROR_TIMEOUT:
      return Code_Fail_Timeout;
      break;
    case NRF_ERROR_NULL:
      return Code_Fail_InvalidOperation;
      break;
    case NRF_ERROR_FORBIDDEN:
      return Code_Fail_Unknown;
      break;
    case NRF_ERROR_INVALID_ADDR:
      return Code_Fail_Unknown;
      break;
    case NRF_ERROR_BUSY:
      return Code_Fail_Busy;
      break;
    case NRF_ERROR_CONN_COUNT:
      return Code_Fail_Unknown;
      break;
    case NRF_ERROR_RESOURCES:
      return Code_Fail_Unknown;
      break;
    default:
      return Code_Fail_Unknown;
      break;
  }
}
