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

// This flag is used to revert all local settings to that needed by the partner
#define LL_CONFIG_RELEASE_TO_PARTNER                    0 // 0 = SIGMA, 1 = ALTEN

// The BLE thread app will start a fast advertising after boot
#define LL_CONFIG_START_ADVERTISING_ON_BOOT             0 && !LL_CONFIG_RELEASE_TO_PARTNER

// Enable NRF logs (otherwise they will be flushed)
#define NRF_LOG_ENABLED                                 1 // TODO doesn't work. Always enabled. Change setting in sdk_config.h
#define LL_CONFIG_GLOBAL_DEBUG_ENABLE                   1 && !LL_CONFIG_RELEASE_TO_PARTNER // Requires NRF_LOG_ENABLED to be set
#define HL_CONFIG_GLOBAL_DEBUG_ENABLE                   1 // Requires NRF_LOG_ENABLED to be set

// Use this to switch from UART and SEGGER RTT (SWD output)
#define LL_CONFIG_USE_SEGGER_RTT_INSTEAD_OF_UART        0

// Use this to switch from UART and SEGGER RTT (SWD output)
#define LL_CONFIG_AUTO_FOMRAT_FLASH_IF_NEEDED           1 || LL_CONFIG_RELEASE_TO_PARTNER

/* Disables parameter checks in NRF functions.
 * !! Turn of before release for efficiency. !! */
#define NRF_DISABLE_PARAM_CHECK                         0

/* Disables parameter checks in LLFW and HLFW functions.
 * !! Turn of before release for efficiency. !! */
#define LL_CONFIG_DISABLE_PARAM_CHECK                   0 || LL_CONFIG_RELEASE_TO_PARTNER

/* Disables buttons for a duration of 3 seconds while the ADH_ON_OFF_LINE is high.
 * This avoid HLFW callbacks to be generated. */
#define LL_CONFIG_AVOID_ADH_BUTTON_INTERACTION          1

/* May only be used for battery protection circuit testing */
#define LL_CONFIG_DISABLE_PMU_OVERVOLTAGE_PROTECTION    0 && !LL_CONFIG_RELEASE_TO_PARTNER

/* Disables the extended payload feature called DLE of the BLE stack
 * This is meant as a WORKAROUND for the Samsung Android 7.0 pairing issue. */
#define LL_CONFIG_DISABLE_DLE_FEATURE_OF_BLE            1 || LL_CONFIG_RELEASE_TO_PARTNER

/* Enables light indication for the PMU charging state for the LL only. */
#define LL_CONFIG_USE_LIGHT_INDICATION_FOR_CHARGING     1 && !LL_CONFIG_RELEASE_TO_PARTNER

/* Enables CLI without pulling TP_PROD_EN pin low */
#define LL_CONFIG_ALWAYS_ENABLE_CLI_THREAD_AFTER_BOOT   1 && !LL_CONFIG_RELEASE_TO_PARTNER

/************************************************************************
 * LOW LEVEL THREAD CONFIGURATIONS
 ***********************************************************************/

// THREAD NAMES (MAX 15 characters. See FreeRTOSConfig.h)
#define LL_THREAD_NAME_DEVICE_DRIVER            "T_DEV_DRV "  //< A high priority worker thread
#define LL_THREAD_NAME_BLE                      "T_BLE     "  //< The BLE stack thread
#define LL_THREAD_NAME_SPP                      "T_SPP     "  //< SPP test app
#define LL_THREAD_NAME_NCA                      "T_NCA     "  //< A low priority worker thread
#define LL_THREAD_NAME_CLI                      "T_CLI     "  //< Used for OPUS testing
#define LL_THREAD_NAME_TEST_APP                 "T_TEST_APP"  //< Several HL test apps by Sigma
#define LL_THREAD_NAME_LOGGER                   "T_LOGGER  "

// THREAD PRIORITIES (IMPORTANT: Priority 3 and 4 are reserved for BLE and driver operations !!!!!!)
#define LL_THREAD_PRIORITY_DEVICE_DRIVER        4   //< Must have adequate priority to enable in-time data acquisition.
#define LL_THREAD_PRIORITY_BLE                  3   //< Must have adequate priority to push out buffered data and avoid a bottleneck here.
#define LL_THREAD_PRIORITY_SPP                  3   //< Must have adequate priority to push out buffered data and avoid a bottleneck here.
#define LL_THREAD_PRIORITY_NCA                  1   //< Low priority. This only sends charger indications and other PMU states.
#define LL_THREAD_PRIORITY_CLI                  1   //< Used for testing only. (Must have a higher priority than the LOGGER, otherwise unstable and leads to crash.)
#define LL_THREAD_PRIORITY_TEST_APP             1   //< Low priority to avoid higher sampling than what is possible to achieve with the driver thread.
#define LL_THREAD_PRIORITY_LOGGER               1   //< Always lowest priority to reduce execution impact

// THREAD STACK SIZES
#define LL_THREAD_STACK_SIZE_DEVICE_DRIVER      512
#define LL_THREAD_STACK_SIZE_BLE                256
#define LL_THREAD_STACK_SIZE_SPP                256
#define LL_THREAD_STACK_SIZE_NCA                128
#define LL_THREAD_STACK_SIZE_CLI                256
#define LL_THREAD_STACK_SIZE_TEST_APP           256
#define LL_THREAD_STACK_SIZE_LOGGER             256

/************************************************************************
 * HIGH LEVEL THREAD CONFIGURATIONS
 ***********************************************************************/

// THREAD NAMES (MAX 15 characters. See FreeRTOSConfig.h)
#define HL_THREAD_NAME_FAST_SAMPLE              "FASTSAMPLE"
#define HL_THREAD_NAME_SLOW_SAMPLE              "SLOWSAMPLE"
#define HL_THREAD_NAME_DATA_TRANSFER            "DATATRANS"

// THREAD PRIORITIES (IMPORTANT: Priority 3 and 4 are reserved for BLE and driver operations !!!!!!)
#define HL_THREAD_PRIORITY_FAST_SAMPLE          5
#define HL_THREAD_PRIORITY_SLOW_SAMPLE          5
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
