/**********************************************************************
 * Copyright (c) Sigma Connectivity AB
 * All Rights Reserved. 2017
 *
 * This file may not be distributed without the file ’license.txt’.
 * This file is subject to the terms and conditions defined in file
 * ’license.txt’, which is part of this source code package.
 *********************************************************************/

#ifndef LL_CONFIG_H_
#define LL_CONFIG_H_

/****************************************************************
 * CONFIGURATIONS
 ***************************************************************/
// See sdk_config.h for more configuration options on the SDK

// The BLE thread app will start a fast advertising after boot
#define LL_CONFIG_START_ADVERTISING_AT_BOOT             1

// Enable NRF logs (otherwise they will be flushed)
#define NRF_LOG_ENABLED                                 1 // TODO doesn't work (always enabled)
#define LL_CONFIG_GLOBAL_DEBUG_ENABLE                   1 // Requires NRF_LOG_ENABLED to be set
#define HL_CONFIG_GLOBAL_DEBUG_ENABLE                   1 // Requires NRF_LOG_ENABLED to be set

// Use this to switch from UART and SEGGER RTT (SWD output)
#define LL_CONFIG_USE_SEGGER_RTT_INSTEAD_OF_UART        0

/* Disables parameter checks in NRF functions.
 * !! Turn of before release for efficiency. !! */
#define NRF_DISABLE_PARAM_CHECK                         0

/* Disables parameter checks in LLFW and HLFW functions.
 * !! Turn of before release for efficiency. !! */
#define LL_CONFIG_DISABLE_PARAM_CHECK                   0

/************************************************************************
 * LOW LEVEL THREAD CONFIGURATIONS
 ***********************************************************************/

// THREAD NAMES (MAX 15 characters. See FreeRTOSConfig.h)
#define LL_THREAD_NAME_DEVICE_DRIVER            "DDRV"
#define LL_THREAD_NAME_PMU                      "PMU"
#define LL_THREAD_NAME_BLE                      "BLE"
#define LL_THREAD_NAME_SPP                      "SPP"
#define LL_THREAD_NAME_LOGGER                   "LOG"
#define LL_THREAD_NAME_CLI                      "CLI"
#define LL_THREAD_NAME_TEST_APP                 "TEST_APP"

// THREAD PRIORITIES (IMPORTANT: Priority 3 and 4 are reserved for BLE and driver operations !!!!!!)
#define LL_THREAD_PRIORITY_DEVICE_DRIVER        4   //< Must have adequate priority to enable in time data acquisition.
#define LL_THREAD_PRIORITY_PMU                  4   //< Must have adequate priority to enable in time data acquisition.
#define LL_THREAD_PRIORITY_BLE                  3   //< Must have adequate priority to push out buffered data and avoid bottleneck here.
#define LL_THREAD_PRIORITY_SPP                  3   //< Must have adequate priority to push out buffered data and avoid bottleneck here.
#define LL_THREAD_PRIORITY_LOGGER               1
#define LL_THREAD_PRIORITY_CLI                  1
#define LL_THREAD_PRIORITY_TEST_APP             1   //< Low priority due to avoiding higher sampling than what is possible to achieve.

// THREAD STACK SIZES
#define LL_THREAD_TACK_SIZE_DEVICE_DRIVER       512
#define LL_THREAD_TACK_SIZE_PMU                 128
#define LL_THREAD_TACK_SIZE_BLE                 256
#define LL_THREAD_TACK_SIZE_SPP                 256
#define LL_THREAD_TACK_SIZE_LOGGER              256
#define LL_THREAD_TACK_SIZE_CLI                 256
#define LL_THREAD_TACK_SIZE_TEST_APP            256

/************************************************************************
 * HIGH LEVEL THREAD CONFIGURATIONS
 ***********************************************************************/

// THREAD NAMES (MAX 15 characters. See FreeRTOSConfig.h)
#define HL_THREAD_NAME_FAST_SAMPLE              "FASTSAMPLE"
#define HL_THREAD_NAME_SLOW_SAMPLE              "SLOWSAMPLE"
#define HL_THREAD_NAME_DATA_TRANSFER            "DATATRANS"

// THREAD PRIORITIES (IMPORTANT: Priority 3 and 4 are reserved for BLE and driver operations !!!!!!)
// MAXIMUM ALLOWED PRIORITY IS 3!
#define HL_THREAD_PRIORITY_FAST_SAMPLE          5 /* No transmission or any other activity should be in here */
#define HL_THREAD_PRIORITY_SLOW_SAMPLE          5 /* No transmission or any other activity should be in here */
                  /* Priority 3-4 are reserved */
#define HL_THREAD_PRIORITY_DATA_TRANSFER        2

// THREAD STACK SIZES
#define HL_THREAD_TACK_SIZE_FAST_SAMPLE         768
#define HL_THREAD_TACK_SIZE_SLOW_SAMPLE         256
#define HL_THREAD_TACK_SIZE_DATA_TRANSFER       256

/************************************************************************
 * INTERNALS (do not change)
 ***********************************************************************/

#if NRF_DISABLE_PARAM_CHECK
#define DISABLE_PARAM_CHECK
#endif // NRF_DISABLE_PARAM_CHECK

#if LL_CONFIG_USE_SEGGER_RTT_INSTEAD_OF_UART
#define CLI_USES_SEGGER_RTT
#endif // LL_CONFIG_USE_SEGGER_RTT_INSTEAD_OF_UART

#endif // LL_CONFIG_H_
