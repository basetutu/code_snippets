/**********************************************************************
 * Copyright (c) Sigma Connectivity AB
 * All Rights Reserved 2017.
 *
 * This file may not be distributed without the file ’license.txt’.
 * This file is subject to the terms and conditions defined in file
 * ’license.txt’, which is part of this source code package.
 *********************************************************************/

/**********************************************************************
 * The logging functionality of the High-Level-FirmWare (HLFW)
 *
 * @date 27th June/2017 (created)
 *********************************************************************/

#ifndef _HLFW_LOG_H_
#define _HLFW_LOG_H_

#include "global_config.h"
#include "nrf_log_internal.h"

/**********************************************************
 * CONFIG - High-Level FirmWare (HLFW)
 *********************************************************/
/*!
 * Add the HL_LOG_MODULE_NAME at top of each c file or before
 * including this file to have your custom module name printed !!!!
 *
 * HL_LOG_MODULE_NAME must be 8 bytes fixed!!!
 */
#ifndef HL_LOG_MODULE_NAME
#define HL_LOG_MODULE_NAME_INTERNAL     "HLFW    "  " | "
#else
#define HL_LOG_MODULE_NAME_INTERNAL     HL_LOG_MODULE_NAME  " | "
#endif

// MASTER CONTROLLER *******
#define HL_LOG_ENABLE               HL_CONFIG_GLOBAL_DEBUG_ENABLE   //<-- 1 == ENABLE / 0 = Disable

// LEVEL CONTROLLER (Disable/Enable a certain log-level)
#define HL_LOG_LEVEL_ERROR          1   // Should always be enabled!
#define HL_LOG_LEVEL_WARNING        1
#define HL_LOG_LEVEL_INFO           1
#define HL_LOG_LEVEL_DEBUG          1
#define HL_LOG_LEVEL_VERBOSE        1
#define HL_LOG_LEVEL_ALGORITHM      1
// Enable showing function start and end
#define HL_LOG_FUNCTION_SHOW        1
#define HL_LOG_THREAD_SHOW          1
#define HL_LOG_HEXDUMP_SHOW         1

// TODO saeed: Enable/Disable logging on nRF-SDK level

/************************ CONFIG END *********************/


#ifndef HL_LOG_THREAD_NAME
// Get the name of the currently running task of FreeRTOS
#define HL_LOG_THREAD_NAME          pcTaskGetName(NULL)
#endif

// PREFIXES
#define HL_LOG_PREFIX_ERROR    NRF_LOG_ERROR_COLOR_CODE   " |E| "  HL_LOG_MODULE_NAME_INTERNAL
#define HL_LOG_PREFIX_WARNING  NRF_LOG_WARNING_COLOR_CODE " |W| "  HL_LOG_MODULE_NAME_INTERNAL
#define HL_LOG_PREFIX_INFO     NRF_LOG_INFO_COLOR_CODE    " |I| "  HL_LOG_MODULE_NAME_INTERNAL
#define HL_LOG_PREFIX_DEBUG    NRF_LOG_DEBUG_COLOR_CODE   " |E| "  HL_LOG_MODULE_NAME_INTERNAL
#define HL_LOG_PREFIX_VERBOSE  NRF_LOG_DEBUG_COLOR_CODE   " |V| "  HL_LOG_MODULE_NAME_INTERNAL
#define HL_LOG_PREFIX_ALGORIT  NRF_LOG_DEBUG_COLOR_CODE " |DEV| "  HL_LOG_MODULE_NAME_INTERNAL

// RAW PRINTF
#define HL_LOG_PRINT_RAW(...)           LOG_INTERNAL(NRF_LOG_RAW, "", __VA_ARGS__)

// Log level dependent macros
#if (HL_LOG_LEVEL_ERROR == 1 && HL_LOG_ENABLE == 1)
#define HL_LOG_ERROR(...)     LOG_INTERNAL(NRF_LOG_LEVEL_ERROR, HL_LOG_PREFIX_ERROR, __VA_ARGS__)
#else
#define HL_LOG_ERROR(...)
#endif

#if (HL_LOG_LEVEL_WARNING == 1 && HL_LOG_ENABLE == 1)
#define HL_LOG_WARNING(...)   LOG_INTERNAL(NRF_LOG_LEVEL_WARNING, HL_LOG_PREFIX_WARNING, __VA_ARGS__)
#else
#define HL_LOG_WARNING(...)
#endif

#if (HL_LOG_LEVEL_INFO == 1 && HL_LOG_ENABLE == 1)
#define HL_LOG_INFO(...)      LOG_INTERNAL(NRF_LOG_LEVEL_INFO, HL_LOG_PREFIX_INFO, __VA_ARGS__)
#else
#define HL_LOG_INFO(...)
#endif

#if (HL_LOG_LEVEL_DEBUG == 1 && HL_LOG_ENABLE == 1)
#define HL_LOG_DEBUG(...)     LOG_INTERNAL(NRF_LOG_LEVEL_DEBUG, HL_LOG_PREFIX_DEBUG, __VA_ARGS__)
#else
#define HL_LOG_DEBUG(...)
#endif

#if (HL_LOG_LEVEL_VERBOSE == 1 && HL_LOG_ENABLE == 1)
#define HL_LOG_VERBOSE(...)   LOG_INTERNAL(NRF_LOG_LEVEL_INTERNAL, HL_LOG_PREFIX_VERBOSE, __VA_ARGS__)
#else
#define HL_LOG_VERBOSE(...)
#endif

/**
 * @brief For use in the beginning and the end of a function and visualizing the sequence.
 * Works only if HL_LOG_LEVEL_DEBUG is set.
 */
#if (HL_LOG_HEXDUMP_SHOW == 1 && HL_LOG_ENABLE == 1)
#define HL_LOG_HEXDUMP(p_data, len)   nrf_log_frontend_hexdump(NRF_LOG_LEVEL_INTERNAL, HL_LOG_PREFIX_DEBUG "\r\n", (p_data), (len))
#else
#define HL_LOG_HEXDUMP(...)
#endif

/**
 * @brief For use in the beginning and the end of a function and visualizing the sequence.
 * Works only if HL_LOG_LEVEL_DEBUG is set.
 */
#if (HL_LOG_FUNCTION_SHOW == 1 && HL_LOG_ENABLE == 1)
#define HL_LOG_ENTER_FUNC()   HL_LOG_DEBUG(" <START> (line:%s)", __LINE__)
#define HL_LOG_EXIT_FUNC()    HL_LOG_DEBUG("  <END>  (line:%s)", __LINE__)
#else
#define HL_LOG_ENTER_FUNC()
#define HL_LOG_EXIT_FUNC()
#endif

/**
 * @brief For use in determining which tread(s) are executing a peace of code.
 * Works only if HL_LOG_LEVEL_DEBUG is set.
 */
#if (HL_LOG_THREAD_SHOW == 1 && HL_LOG_ENABLE == 1)
#define HL_LOG_THREAD()       HL_LOG_DEBUG(" THREAD = %s", HL_LOG_THREAD_NAME)
#else
#define HL_LOG_THREAD()
#endif

/*!
 * !!! MAY ONLY BE USED LOCALY, NEVER PUSH TO GIT REMOTE !!!
 *
 * Used only during development and is mostly useful in case
 * of developing function for mathematical computations or
 * other form of transformations/conversions.
 */
#if (HL_LOG_LEVEL_ALGORITHM == 1 && HL_LOG_ENABLE == 1)
#define HL_LOG_ALGORITHM(...)    LOG_INTERNAL(NRF_LOG_LEVEL_INTERNAL, HL_LOG_PREFIX_ALGORIT, __VA_ARGS__)
#else
#define HL_LOG_ALGORITHM(...)
#endif


#endif /* _HLFW_LOG_H_ */
