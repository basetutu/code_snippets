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
#include "global_types.h"
#include "the_print_module.h"
#include "logger_thread.h"

#include "FreeRTOS.h"
#include "task.h"

#define NEW_LINE      "\r\n"

/**********************************************************
 * CONFIG - Low-Level FirmWare (LLFW)
 *********************************************************/
/**!
 * Define LL_LOG_ENABLE as 1 or 0 to force enable or disable logging in a module.
 */

/*!
 * Add the LL_LOG_MODULE_NAME at top of each c file or before
 * including this file to have your custom module name printed !!!!
 *
 * (!) LL_LOG_MODULE_NAME must be 8 bytes fixed !!!
 */

// LEVEL CONTROLLER (Disable/Enable a certain log-level)
#define LOG_LEVEL_ERROR           1   // Should always be enabled!
#define LOG_LEVEL_WARNING         1
#define LOG_LEVEL_INFO            1
#ifndef LOG_LEVEL_DEBUG           // This is used to selectively block levels below DEBUG in modules/files
  #define LOG_LEVEL_DEBUG         1
  #define LOG_LEVEL_VERBOSE       1
  #define LOG_LEVEL_ALGORITHM     1
  // Enable showing function start and end
  #define LOG_SHOW_FUNCTION       1
  #define LOG_SHOW_THREAD         1
  #define LOG_SHOW_HEXDUMP        1
  // Enable debug codes
  #define LOG_DEBUG_CODE          1
#endif // LOG_LEVEL_DEBUG

// Separator
#define SEPARATOR                 " | "

/************************ CONFIG END **************************/


/********************** INTERNALS START ***********************/

// MASTER CONTROLLER *******
#ifndef LL_LOG_ENABLE                                             //<-- Use this to force enable or disable logs in a module
#define LOG_ENABLE                LL_CONFIG_GLOBAL_DEBUG_ENABLE   //<-- 1 == ENABLE / 0 = Disable
#else
#define LOG_ENABLE                LL_LOG_ENABLE
#endif

// The double expansion trick
#define S(x) #x
#define STRINGIFY(x) S(x)
#define S__LINE__ STRINGIFY(__LINE__)

// Send notification to the logger thread
#ifndef LOG_NOTIFY
#define LOG_NOTIFY()                  logger_thread_notify()
#endif

// MODULE NAMING
#ifndef LL_LOG_MODULE_NAME
#define LOG_MODULE_NAME_INTERNAL      "LLFW    "
#else
#define LOG_MODULE_NAME_INTERNAL      LL_LOG_MODULE_NAME
#endif

// PREFIXES (the log level name lengths allow for better visual)
#define LOG_PREFIX_ERROR     " |Error| "    LOG_MODULE_NAME_INTERNAL  SEPARATOR  S__LINE__  SEPARATOR
#define LOG_PREFIX_WARNING   " |Warn | "    LOG_MODULE_NAME_INTERNAL  SEPARATOR  S__LINE__  SEPARATOR
#define LOG_PREFIX_INFO      " |I    | "    LOG_MODULE_NAME_INTERNAL  SEPARATOR  S__LINE__  SEPARATOR
#define LOG_PREFIX_DEBUG     " |D    | "    LOG_MODULE_NAME_INTERNAL  SEPARATOR  S__LINE__  SEPARATOR
#define LOG_PREFIX_VERBOSE   " |V    | "    LOG_MODULE_NAME_INTERNAL  SEPARATOR  S__LINE__  SEPARATOR
#define LOG_PREFIX_ALGORIT   " |ALG  | "    LOG_MODULE_NAME_INTERNAL  SEPARATOR  S__LINE__  SEPARATOR

// RAW PRINTF
#define LL_LOG_PRINT_RAW(...)           LOG_INTERNAL(NRF_LOG_RAW, "", __VA_ARGS__); LOG_NOTIFY()



/******************************************************************
 * General purpose LOGGING FUNCTIONS
 *****************************************************************/

// Log level macros //////////////////////////////////////////////////////

// The LL_LOG_ERROR macro delays execution by 2s
#if (LOG_LEVEL_ERROR == 1 && LOG_ENABLE == 1)
#define LL_LOG_ERROR(...)     LOG_INTERNAL(NRF_LOG_LEVEL_ERROR, LOG_PREFIX_ERROR, __VA_ARGS__); LOG_NOTIFY(); \
                              if(!IS_INTERRUPT) {vTaskDelay(2000 / portTICK_PERIOD_MS);}
#else
#define LL_LOG_ERROR(...)
#endif

#if (LOG_LEVEL_WARNING == 1 && LOG_ENABLE == 1)
#define LL_LOG_WARNING(...)   LOG_INTERNAL(NRF_LOG_LEVEL_WARNING, LOG_PREFIX_WARNING, __VA_ARGS__); LOG_NOTIFY()
#else
#define LL_LOG_WARNING(...)
#endif

#if (LOG_LEVEL_INFO == 1 && LOG_ENABLE == 1)
#define LL_LOG_INFO(...)      LOG_INTERNAL(NRF_LOG_LEVEL_INFO, LOG_PREFIX_INFO, __VA_ARGS__); LOG_NOTIFY()
#else
#define LL_LOG_INFO(...)
#endif

#if (LOG_LEVEL_DEBUG == 1 && LOG_ENABLE == 1)
#define LL_LOG_DEBUG(...)     LOG_INTERNAL(NRF_LOG_LEVEL_DEBUG, LOG_PREFIX_DEBUG, __VA_ARGS__); LOG_NOTIFY()
#else
#define LL_LOG_DEBUG(...)
#endif

#if (LOG_LEVEL_VERBOSE == 1 && LOG_ENABLE == 1)
#define LL_LOG_VERBOSE(...)   LOG_INTERNAL(NRF_LOG_LEVEL_INTERNAL, LOG_PREFIX_VERBOSE, __VA_ARGS__); LOG_NOTIFY()
#else
#define LL_LOG_VERBOSE(...)
#endif

/**
 * @brief For use in the beginning and the end of a function and visualizing the sequence.
 */
#if (LOG_SHOW_HEXDUMP == 1 && LOG_ENABLE == 1)
#define LL_LOG_HEXDUMP_VERBOSE(p_data, len)   nrf_log_frontend_hexdump(NRF_LOG_LEVEL_INTERNAL,          \
                                                LOG_PREFIX_VERBOSE "\r\n", (p_data), (len)); LOG_NOTIFY()
#else
#define LL_LOG_HEXDUMP_VERBOSE(...)
#endif

/****************************************************************
 * DEBUG CODE CONTROL
 ***************************************************************/

/**
 * @brief The code written using this MACRO will disappear if DEBUG_CODE is set to 0.
 */
#if (LOG_DEBUG_CODE == 1 && LOG_ENABLE == 1)
#define LL_DEBUG_CODE(code)   { code }
#else
#define LL_DEBUG_CODE(code)
#endif

/****************************************************************
 * SEQUENCE LOG
 ***************************************************************/

/**
 * @brief For use in the beginning and the end of a function and visualizing the sequence.
 * Works only if LOG_LEVEL_DEBUG is set.
 */
#if (LOG_SHOW_THREAD == 1 && LOG_ENABLE == 1)
#define LL_LOG_THREAD_NAME()   LL_LOG_DEBUG("(T) CALLING THREAD: (%s)", (uint32_t)pcTaskGetTaskName(NULL))
#else
#define LL_LOG_THREAD_NAME()
#endif

/**
 * @brief For use in the beginning and the end of a function and visualizing the sequence.
 * Works only if LOG_LEVEL_DEBUG is set.
 */
#if (LOG_SHOW_FUNCTION == 1 && LOG_ENABLE == 1)
#define LL_LOG_ENTER_FUNC()   LL_LOG_DEBUG(">>> (START)     %s()", (uint32_t)__FUNCTION__)
#define LL_LOG_EXIT_FUNC()    LL_LOG_DEBUG("<<< (END)       %s()", (uint32_t)__FUNCTION__)
#else
#define LL_LOG_ENTER_FUNC()
#define LL_LOG_EXIT_FUNC()
#endif

/****************************************************************
 * OTHER
 ***************************************************************/

/*!
 * !!! MAY ONLY BE USED LOCALY, NEVER PUSH TO GIT REMOTE !!!
 *
 * Used only during development and is mostly useful in case
 * of developing function for mathematical computations or
 * other form of transformations/conversions.
 */
#if (LOG_LEVEL_ALGORITHM == 1 && LOG_ENABLE == 1)
#define LL_LOG_ALGORITHM(...)    LOG_INTERNAL(NRF_LOG_LEVEL_INTERNAL, LOG_PREFIX_ALGORIT, __VA_ARGS__); LOG_NOTIFY()
#else
#define LL_LOG_ALGORITHM(...)
#endif


#endif /* _LLFW_LOG_H_ */
