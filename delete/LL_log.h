/**********************************************************************
 * Copyright (c) Sigma Connectivity AB
 * All Rights Reserved 2017.
 *
 * This file may not be distributed without the file ’license.txt’.
 * This file is subject to the terms and conditions defined in file
 * ’license.txt’, which is part of this source code package.
 *********************************************************************/

/**********************************************************************
 * The logging functionality of the Low-Level-FirmWare (LLFW)
 *
 * @date 27th June/2017 (created)
 *********************************************************************/

#ifndef _LLFW_LOG_H_
#define _LLFW_LOG_H_

#include "global_config.h"
#include "nrf_log_internal.h"

/**********************************************************
 * CONFIG - Low-Level FirmWare (LLFW)
 *********************************************************/
/*!
 * Add the LL_LOG_MODULE_NAME at top of each c file or before
 * including this file to have your custom module name printed !!!!
 *
 * LL_LOG_MODULE_NAME must be 8 bytes fixed!!!
 */
#ifndef LL_LOG_MODULE_NAME
#define LL_LOG_MODULE_NAME_INTERNAL     "LLFW    "  " | "
#else
#define LL_LOG_MODULE_NAME_INTERNAL     LL_LOG_MODULE_NAME  " | "
#endif

// MASTER CONTROLLER *******
#define LL_LOG_ENABLE               LL_CONFIG_GLOBAL_DEBUG_ENABLE   //<-- 1 == ENABLE / 0 = Disable

// LEVEL CONTROLLER (Disable/Enable a certain log-level)
#define LL_LOG_LEVEL_ERROR          1   // Should always be enabled!
#define LL_LOG_LEVEL_WARNING        1
#define LL_LOG_LEVEL_INFO           1
#define LL_LOG_LEVEL_DEBUG          1
#define LL_LOG_LEVEL_VERBOSE        1
#define LL_LOG_LEVEL_ALGORITHM      1
// Enable showing function start and end
#define LL_LOG_FUNCTION_SHOW        1
#define LL_LOG_THREAD_SHOW          1
#define LL_LOG_HEXDUMP_SHOW         1

// TODO saeed: Enable/Disable logging on nRF-SDK level

/************************ CONFIG END *********************/


#ifndef LL_LOG_THREAD_NAME
// Get the name of the currently running task of FreeRTOS
#define LL_LOG_THREAD_NAME          pcTaskGetName(NULL)
#endif

// PREFIXES
#define LL_LOG_PREFIX_ERROR    NRF_LOG_ERROR_COLOR_CODE   " |E| "  LL_LOG_MODULE_NAME_INTERNAL
#define LL_LOG_PREFIX_WARNING  NRF_LOG_WARNING_COLOR_CODE " |W| "  LL_LOG_MODULE_NAME_INTERNAL
#define LL_LOG_PREFIX_INFO     NRF_LOG_INFO_COLOR_CODE    " |I| "  LL_LOG_MODULE_NAME_INTERNAL
#define LL_LOG_PREFIX_DEBUG    NRF_LOG_DEBUG_COLOR_CODE   " |E| "  LL_LOG_MODULE_NAME_INTERNAL
#define LL_LOG_PREFIX_VERBOSE  NRF_LOG_DEBUG_COLOR_CODE   " |V| "  LL_LOG_MODULE_NAME_INTERNAL
#define LL_LOG_PREFIX_ALGORIT  NRF_LOG_DEBUG_COLOR_CODE " |DEV| "  LL_LOG_MODULE_NAME_INTERNAL

// RAW PRINTF
#define LL_LOG_PRINT_RAW(...)           LOG_INTERNAL(NRF_LOG_RAW, "", __VA_ARGS__)

// Log level dependent macros
#if (LL_LOG_LEVEL_ERROR == 1 && LL_LOG_ENABLE == 1)
#define LL_LOG_ERROR(...)     LOG_INTERNAL(NRF_LOG_LEVEL_ERROR, LL_LOG_PREFIX_ERROR, __VA_ARGS__)
#else
#define LL_LOG_ERROR(...)
#endif

#if (LL_LOG_LEVEL_WARNING == 1 && LL_LOG_ENABLE == 1)
#define LL_LOG_WARNING(...)   LOG_INTERNAL(NRF_LOG_LEVEL_WARNING, LL_LOG_PREFIX_WARNING, __VA_ARGS__)
#else
#define LL_LOG_WARNING(...)
#endif

#if (LL_LOG_LEVEL_INFO == 1 && LL_LOG_ENABLE == 1)
#define LL_LOG_INFO(...)      LOG_INTERNAL(NRF_LOG_LEVEL_INFO, LL_LOG_PREFIX_INFO, __VA_ARGS__)
#else
#define LL_LOG_INFO(...)
#endif

#if (LL_LOG_LEVEL_DEBUG == 1 && LL_LOG_ENABLE == 1)
#define LL_LOG_DEBUG(...)     LOG_INTERNAL(NRF_LOG_LEVEL_DEBUG, LL_LOG_PREFIX_DEBUG, __VA_ARGS__)
#else
#define LL_LOG_DEBUG(...)
#endif

#if (LL_LOG_LEVEL_VERBOSE == 1 && LL_LOG_ENABLE == 1)
#define LL_LOG_VERBOSE(...)   LOG_INTERNAL(NRF_LOG_LEVEL_INTERNAL, LL_LOG_PREFIX_VERBOSE, __VA_ARGS__)
#else
#define LL_LOG_VERBOSE(...)
#endif

/**
 * @brief For use in the beginning and the end of a function and visualizing the sequence.
 * Works only if LL_LOG_LEVEL_DEBUG is set.
 */
#if (LL_LOG_HEXDUMP_SHOW == 1 && LL_LOG_ENABLE == 1)
#define LL_LOG_HEXDUMP(p_data, len)   nrf_log_frontend_hexdump(NRF_LOG_LEVEL_INTERNAL, LL_LOG_PREFIX_DEBUG "\r\n", (p_data), (len))
#else
#define LL_LOG_HEXDUMP(...)
#endif

/**
 * @brief For use in the beginning and the end of a function and visualizing the sequence.
 * Works only if LL_LOG_LEVEL_DEBUG is set.
 */
#if (LL_LOG_FUNCTION_SHOW == 1 && LL_LOG_ENABLE == 1)
#define LL_LOG_ENTER_FUNC()   LL_LOG_DEBUG(" <START> (line:%s)", __LINE__)
#define LL_LOG_EXIT_FUNC()    LL_LOG_DEBUG("  <END>  (line:%s)", __LINE__)
#else
#define LL_LOG_ENTER_FUNC()
#define LL_LOG_EXIT_FUNC()
#endif

/**
 * @brief For use in determining which tread(s) are executing a peace of code.
 * Works only if LL_LOG_LEVEL_DEBUG is set.
 */
#if (LL_LOG_THREAD_SHOW == 1 && LL_LOG_ENABLE == 1)
#define LL_LOG_THREAD()       LL_LOG_DEBUG(" THREAD = %s", LL_LOG_THREAD_NAME)
#else
#define LL_LOG_THREAD()
#endif

/*!
 * !!! MAY ONLY BE USED LOCALY, NEVER PUSH TO GIT REMOTE !!!
 *
 * Used only during development and is mostly useful in case
 * of developing function for mathematical computations or
 * other form of transformations/conversions.
 */
#if (LL_LOG_LEVEL_ALGORITHM == 1 && LL_LOG_ENABLE == 1)
#define LL_LOG_ALGORITHM(...)    LOG_INTERNAL(NRF_LOG_LEVEL_INTERNAL, LL_LOG_PREFIX_ALGORIT, __VA_ARGS__)
#else
#define LL_LOG_ALGORITHM(...)
#endif


#endif /* _LLFW_LOG_H_ */
