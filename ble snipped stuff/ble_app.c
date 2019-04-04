/* TODO Update license */
/**********************************************************************
 * Copyright (c) Sigma Connectivity AB
 * All Rights Reserved 2017.
 *
 * This file may not be distributed without the file ’license.txt’.
 * This file is subject to the terms and conditions defined in file
 * ’license.txt’, which is part of this source code package.
 *********************************************************************/

/** TODO
 * - What is this code about? What does it do?
 *
 * If it is a module:
 * - What is the sole responsibility of this module?
 * - Describe the list of dependencies to other modules or drivers.
 *
 * @date 20th June/2018 (created)
 * @author Saeed Ghasemi (external)
 */

#include <stdint.h>
#include <string.h>
#include "../aux/ble_app.h"
#include "nordic_common.h"
#include "nrf.h"
#include "app_error.h"
#include "ecc.h"
#include "ble.h"
#include "ble_gap.h"
#include "ble_hci.h"
#include "ble_srv_common.h"
#include "ble_advdata.h"
#include "ble_advertising.h"
#include "ble_bas.h"
#include "ble_dfu.h"
#include "ble_service_bss.h"
#include "ble_hrs.h"
#include "ble_dis.h"
#include "ble_conn_params.h"
#include "boards.h"
#include "sensorsim.h"
//#include "softdevice_handler.h"
#include "app_timer.h"
#include "peer_manager.h"
#include "bsp.h"
#include "bsp_btn_ble.h"
#include "FreeRTOS.h"
#include "task.h"
#include "timers.h"
#include "semphr.h"
#include "fds.h"
#include "../../SDK/components/libraries/fstorage/nrf_fstorage.h" //fstorage.h
#include "ble_conn_state.h"
#include "nrf_drv_clock.h"

#include "nrf_dfu_settings.h"

#define LL_LOG_MODULE_NAME          "BLE_APP "
#include "../../LL_Log.h"



/****************************************************************
 * CONFIGURATIONS
 ***************************************************************/

// Low frequency clock source to be used by the SoftDevice
#define NRF_CLOCK_LFCLKSRC      {.source        = NRF_CLOCK_LF_SRC_XTAL,            \
                                 .rc_ctiv       = 0,  /* Not needed for XTAL */     \
                                 .rc_temp_ctiv  = 0,  /* Not needed for XTAL */     \
                                 .xtal_accuracy = NRF_CLOCK_LF_ACCURACY_20_PPM}

#if (NRF_SD_BLE_API_VERSION == 3)
#define NRF_BLE_MAX_MTU_SIZE            GATT_MTU_SIZE_DEFAULT                   /**< MTU size used in the softdevice enabling and to reply to a BLE_GATTS_EVT_EXCHANGE_MTU_REQUEST event. */
#endif

#define CENTRAL_LINK_COUNT               2                                      /**< Number of central links used by the application. When changing this number remember to adjust the RAM settings*/
#define PERIPHERAL_LINK_COUNT            2                                     /**< Number of peripheral links used by the application. When changing this number remember to adjust the RAM settings*/

#define PERIPHERAL_DEVICE_NAME                      "Assa_Wear"                            /**< Name of device. Will be included in the advertising data. */
#define MANUFACTURER_NAME                "ASSA_ABLOY"                           /**< Manufacturer. Will be passed to Device Information Service. */
#define PASS_KEY                         "123456"                               /**< The bonding passkey. */
#define APP_ADV_FAST_INTERVAL            MSEC_TO_UNITS(250, UNIT_1_25_MS) //300                              /**< The advertising interval (in units of 0.625 ms. This value corresponds to 187.5 ms). */
#define APP_ADV_FAST_TIMEOUT_IN_SECONDS  0                                      /**< The advertising time-out in units of seconds. */
#define APP_ADV_SLOW_INTERVAL            MSEC_TO_UNITS(1000, UNIT_1_25_MS)//300                              /**< The advertising interval (in units of 0.625 ms. This value corresponds to 187.5 ms). */
#define APP_ADV_SLOW_TIMEOUT_IN_SECONDS  0                                      /**< The advertising time-out in units of seconds. */

#define APP_TIMER_PRESCALER              0                                      /**< Value of the RTC1 PRESCALER register. */
#define APP_TIMER_OP_QUEUE_SIZE          16                                     /**< Size of timer operation queues. */      // TODO saeed: reduce value (there is a function that returns the max timers used)

#define BATTERY_LEVEL_MEAS_INTERVAL      5000                                   /**< Battery level measurement interval (ms). */

#define MIN_CONN_INTERVAL                MSEC_TO_UNITS(7.5, UNIT_1_25_MS)       /**< Minimum acceptable connection interval (0.4 seconds). */
#define MAX_CONN_INTERVAL                MSEC_TO_UNITS(80, UNIT_1_25_MS)        /**< Maximum acceptable connection interval (0.65 second). */
#define SLAVE_LATENCY                    10                                     /**< Slave latency. */
#define CONN_SUP_TIMEOUT                 MSEC_TO_UNITS(1000, UNIT_10_MS)        /**< Connection supervisory time-out (1 seconds). */

//fast connection parameter
#define BLE_CONN_INTERVAL_FAST_MAX       MSEC_TO_UNITS(7.5, UNIT_1_25_MS)       /**< Maximum acceptable connection interval (0.65 second). */
#define BLE_CONN_INTERVAL_MID_MAX        MSEC_TO_UNITS(12.5, UNIT_1_25_MS)      /**< Maximum acceptable connection interval (0.65 second). */

#define FIRST_CONN_PARAMS_UPDATE_DELAY   10000                                  /**< Time from initiating event (connect or start of notification) to first time sd_ble_gap_conn_param_update is called (5 seconds). */
#define NEXT_CONN_PARAMS_UPDATE_DELAY    10000 //30000                          /**< Time between each call to sd_ble_gap_conn_param_update after the first call (30 seconds). */
#define MAX_CONN_PARAMS_UPDATE_COUNT     5                                      /**< Number of attempts before giving up the connection parameter negotiation. */

#define SEC_PARAM_BOND                   1                                      /**< Perform bonding. */
#define SEC_PARAM_MITM                   1                                      /**< Man In The Middle protection not required. */
#define SEC_PARAM_LESC                   1                                      /**< LE Secure Connections enabled. */
#define SEC_PARAM_KEYPRESS               0                                      /**< Keypress notifications not enabled. */
#define SEC_PARAM_IO_CAPABILITIES        BLE_GAP_IO_CAPS_NONE                   /**< No I/O capabilities. */
#define SEC_PARAM_OOB                    0                                      /**< Out Of Band data not available. */
#define SEC_PARAM_MIN_KEY_SIZE           7                                      /**< Minimum encryption key size. */
#define SEC_PARAM_MAX_KEY_SIZE           16                                     /**< Maximum encryption key size. */

#define DEAD_BEEF                        0xDEADBEEF                             /**< Value used as error code on stack dump, can be used to identify stack location on stack unwind. */

//#define OSTIMER_WAIT_FOR_QUEUE           2                                    /**< Number of ticks to wait for the timer queue to be ready */

#define APP_FEATURE_NOT_SUPPORTED        BLE_GATT_STATUS_ATTERR_APP_BEGIN + 2   /**< Reply when unsupported features are requested. */

#define BLE_GAP_LESC_P256_SK_LEN         32

/****************************************************************
 * DEFINITIONS and CONSTANTS
 ***************************************************************/

/****************************************************************
 * TYPEDEFs
 ***************************************************************/

typedef struct
{
  uint8_t   sk[BLE_GAP_LESC_P256_SK_LEN];              /**< LE Secure Connections Elliptic Curve Diffie-Hellman P-256 Private Key in little-endian. */
} ble_gap_lesc_p256_sk_t;

/****************************************************************
 * MACROS
 ***************************************************************/

/****************************************************************
 * EXTERNAL VARIABLES
 ***************************************************************/

/****************************************************************
 * FORWARD DECLARATIONS
 ***************************************************************/

/****************************************************************
 * STATIC VARIABLES
 ***************************************************************/

static TaskHandle_t       m_ble_stack_thread;        /**< Definition of BLE stack thread. */
static SemaphoreHandle_t  m_ble_event_ready;    /**< Semaphore raised if there is a new event to be processed in the BLE thread. */
static SemaphoreHandle_t  m_mutex = NULL;

// Service instances
static ble_dfu_t m_dfus;                               /**< Structure used to identify the DFU service. */
static ble_bas_t m_bas;                                /**< Structure used to identify the BAS service. */

__ALIGN(4) static ble_gap_lesc_p256_sk_t m_lesc_sk;    /**< LESC ECC Private Key */
__ALIGN(4) static ble_gap_lesc_p256_pk_t m_lesc_pk;    /**< LESC ECC Public Key */
__ALIGN(4) static ble_gap_lesc_dhkey_t   m_lesc_dhkey; /**< LESC ECC DH Key*/


/* Global variable sharing among threads */
uint16_t                 m_conn_handle = BLE_CONN_HANDLE_INVALID;
ble_service_bss_t           m_spp;       // Extern from spp_driver.c
extern spp_cb_t          m_spp_cb;    // Extern to spp_driver.c
extern ble_cb_t          m_ble_cb;    // Extern to ble_driver.c
/* Local spp API variable */
static spp_cb_data_t     m_spp_cb_data;
/* Local ble API variable */
static ble_cb_data_t     m_ble_cb_data;
static bool              ble_app_initialized = FALSE;
static uint8_t           m_battery_level = 100;

static ble_uuid_t m_adv_uuids[] =                         /**< Universally unique service identifiers. */
{
    {BLE_UUID_HEART_RATE_SERVICE, BLE_UUID_TYPE_BLE},     // TODO saeed: change
    {BLE_UUID_BATTERY_SERVICE, BLE_UUID_TYPE_BLE},
    {BLE_UUID_DEVICE_INFORMATION_SERVICE, BLE_UUID_TYPE_BLE}
};

/****************************************************************
 * ENUMERATIONS
 ***************************************************************/

/****************************************************************
 * STATIC FUNCTIONS
 ***************************************************************/

static uint32_t advertising_start(void)
{
    uint32_t err_code = ble_advertising_start(BLE_ADV_MODE_FAST);

    APP_ERROR_CHECK(err_code);
    return err_code;
}

/****************************************************************
 * STATIC HANDLER FUNCTIONS
 ***************************************************************/

static uint32_t ble_new_event_handler(void)
{
	NRF_LOG_INFO("Look into this...! - ble_new_event_handler()");

    BaseType_t yield_req = pdFALSE;

    // The returned value may be safely ignored, if error is returned it only means that
    // the semaphore is already given (raised).
    UNUSED_VARIABLE(xSemaphoreGiveFromISR(m_ble_event_ready, &yield_req));

    portYIELD_FROM_ISR(yield_req);
    return NRF_SUCCESS;
}

/**@brief Function for handling events from the BSP module.
 *
 * @param[in]   event   Event generated by button press.
 */
void bsp_event_handler(bsp_event_t event)
{
    uint32_t err_code;

    switch (event)
    {
        case BSP_EVENT_SLEEP:
            //sleep_mode_enter();
            break;

        case BSP_EVENT_DISCONNECT:
            err_code = sd_ble_gap_disconnect(m_conn_handle,
                                             BLE_HCI_REMOTE_USER_TERMINATED_CONNECTION);
            if (err_code != NRF_ERROR_INVALID_STATE)
            {
                APP_ERROR_CHECK(err_code);
            }
            break;

        case BSP_EVENT_WHITELIST_OFF:
            if (m_conn_handle == BLE_CONN_HANDLE_INVALID)
            {
                err_code = ble_advertising_restart_without_whitelist();
                if (err_code != NRF_ERROR_INVALID_STATE)
                {
                    APP_ERROR_CHECK(err_code);
                }
            }
            break;
        case BSP_EVENT_WAKEUP:
                err_code = advertising_start();
                if (err_code != NRF_ERROR_INVALID_STATE)
                {
                    APP_ERROR_CHECK(err_code);
                }
            break;
        default:
            break;
    }
}

static void pm_evt_handler(pm_evt_t const * p_evt)
{
    ret_code_t err_code;

    switch (p_evt->evt_id)
    {
        case PM_EVT_BONDED_PEER_CONNECTED:
        {
          pm_peer_data_bonding_t peer_data;
          pm_peer_data_bonding_load(p_evt->peer_id, &peer_data);
          LL_LOG_DEBUG("Connected to previously bonded device peer %02x:%02x:%02x:%02x:%02x:%02x",
                        peer_data.peer_ble_id.id_addr_info.addr[5],
                        peer_data.peer_ble_id.id_addr_info.addr[4],
                        peer_data.peer_ble_id.id_addr_info.addr[3],
                        peer_data.peer_ble_id.id_addr_info.addr[2],
                        peer_data.peer_ble_id.id_addr_info.addr[1],
                        peer_data.peer_ble_id.id_addr_info.addr[0]);
            err_code = pm_peer_rank_highest(p_evt->peer_id);
            if (err_code != NRF_ERROR_BUSY)
            {
                APP_ERROR_CHECK(err_code);
            }
        } break; // PM_EVT_BONDED_PEER_CONNECTED

        case PM_EVT_CONN_SEC_START:
            break; // PM_EVT_CONN_SEC_START

        case PM_EVT_CONN_SEC_SUCCEEDED:
        {
            LL_LOG_DEBUG("Link secured. Role: %d. conn_handle: %d, Procedure: %d",
                                 ble_conn_state_role(p_evt->conn_handle),
                                 p_evt->conn_handle,
                                 p_evt->params.conn_sec_succeeded.procedure);
            err_code = pm_peer_rank_highest(p_evt->peer_id);
            if (err_code != NRF_ERROR_BUSY)
            {
                APP_ERROR_CHECK(err_code);
            }
        } break; // PM_EVT_CONN_SEC_SUCCEEDED

        case PM_EVT_CONN_SEC_FAILED:
        {
            /** In some cases, when securing fails, it can be restarted directly. Sometimes it can
             *  be restarted, but only after changing some Security Parameters. Sometimes, it cannot
             *  be restarted until the link is disconnected and reconnected. Sometimes it is
             *  impossible, to secure the link, or the peer device does not support it. How to
             *  handle this error is highly application dependent. */
            switch (p_evt->params.conn_sec_failed.error)
            {
                case PM_CONN_SEC_ERROR_PIN_OR_KEY_MISSING:
                    // Rebond if one party has lost its keys.
                    err_code = pm_conn_secure(p_evt->conn_handle, TRUE);
                    if (err_code != NRF_ERROR_INVALID_STATE)
                    {
                        APP_ERROR_CHECK(err_code);
                    }
                    break; // PM_CONN_SEC_ERROR_PIN_OR_KEY_MISSING

                case PM_CONN_SEC_ERROR_DISCONNECT:
                  LL_LOG_WARNING("Paring failed due to disconnection.");
                  break;

                case PM_CONN_SEC_ERROR_MIC_FAILURE:
                  LL_LOG_WARNING("Paring failed due to mismatched keys or a stray packet.");
                  break;

                case PM_CONN_SEC_ERROR_SMP_TIMEOUT:
                  LL_LOG_WARNING("Paring failed due to timeout. Disconnect and reconnect.");
                  break;

                default:
                  LL_LOG_DEBUG("Switch case not handled! ");
                    break;
            }
        } break; // PM_EVT_CONN_SEC_FAILED

        case PM_EVT_CONN_SEC_CONFIG_REQ:
        {
            // Reject pairing request from an already bonded peer.
            pm_conn_sec_config_t conn_sec_config = {.allow_repairing = FALSE};
            pm_conn_sec_config_reply(p_evt->conn_handle, &conn_sec_config);
        } break; // PM_EVT_CONN_SEC_CONFIG_REQ

        case PM_EVT_STORAGE_FULL:
        {
            // Run garbage collection on the flash.
            err_code = fds_gc();
            if (err_code == FDS_ERR_BUSY || err_code == FDS_ERR_NO_SPACE_IN_QUEUES)
            {
                // Retry.
            }
            else
            {
                APP_ERROR_CHECK(err_code);
            }
        } break; // PM_EVT_STORAGE_FULL

        case PM_EVT_ERROR_UNEXPECTED:
            // Assert.
            //APP_ERROR_CHECK(p_evt->params.error_unexpected.error);
            break; // PM_EVT_ERROR_UNEXPECTED

        case PM_EVT_PEER_DATA_UPDATE_SUCCEEDED:
            break; // PM_EVT_PEER_DATA_UPDATE_SUCCEEDED

        case PM_EVT_PEER_DATA_UPDATE_FAILED:
            // Assert.
            APP_ERROR_CHECK_BOOL(FALSE);
            break; // PM_EVT_PEER_DATA_UPDATE_FAILED

        case PM_EVT_PEER_DELETE_SUCCEEDED:
            break; // PM_EVT_PEER_DELETE_SUCCEEDED

        case PM_EVT_PEER_DELETE_FAILED:
            // Assert.
            APP_ERROR_CHECK(p_evt->params.peer_delete_failed.error);
            break; // PM_EVT_PEER_DELETE_FAILED

        case PM_EVT_PEERS_DELETE_SUCCEEDED:
            advertising_start();
            break; // PM_EVT_PEERS_DELETE_SUCCEEDED

        case PM_EVT_PEERS_DELETE_FAILED:
            // Assert.
            APP_ERROR_CHECK(p_evt->params.peers_delete_failed_evt.error);
            break; // PM_EVT_PEERS_DELETE_FAILED

        case PM_EVT_LOCAL_DB_CACHE_APPLIED:
            break; // PM_EVT_LOCAL_DB_CACHE_APPLIED

        case PM_EVT_LOCAL_DB_CACHE_APPLY_FAILED:
            // The local database has likely changed, send service changed indications.
            pm_local_database_has_changed();
            break; // PM_EVT_LOCAL_DB_CACHE_APPLY_FAILED

        case PM_EVT_SERVICE_CHANGED_IND_SENT:
            break; // PM_EVT_SERVICE_CHANGED_IND_SENT

        case PM_EVT_SERVICE_CHANGED_IND_CONFIRMED:
            break; // PM_EVT_SERVICE_CHANGED_IND_SENT

        default:
            // No implementation needed.
            break;
    }
}

/**
 * Receives events from BLE stack.
 */
static void spp_event_handler(ble_service_bss_t * p_spp, ble_service_bss_evt_t * p_evt)
{
  switch (p_evt->evt_type)
  {
    case BLE_SERVICE_BSS_EVT_OPEN:
      LL_LOG_INFO("BLE_SERVICE_BSS_EVT_OPEN");
      m_spp_cb_data.evt_type = SPP_EVT_OPEN;
      m_spp_cb_data.MTU = p_spp->MTU;
      m_spp_cb_data.RETRY = p_spp->RETRY;
      break;

    case BLE_SERVICE_BSS_EVT_CLOSE:
      LL_LOG_INFO("BLE_SERVICE_BSS_EVT_CLOSE");
      m_spp_cb_data.evt_type = SPP_EVT_CLOSE;
      break;

    case BLE_SERVICE_BSS_EVT_TX_COMPLETE:
      LL_LOG_INFO("BLE_SERVICE_BSS_EVT_TX_COMPLETE");
      m_spp_cb_data.evt_type = SPP_EVT_TX_COMPLETE;
      break;

    case BLE_SERVICE_BSS_EVT_ACK_RCVD:
      LL_LOG_INFO("BLE_SERVICE_BSS_EVT_ACK_RCVD");
      m_spp_cb_data.evt_type = SPP_EVT_ACK_RCVD;
      break;

    case BLE_SERVICE_BSS_EVT_RX_RAWDATA:
      LL_LOG_INFO("BLE_SERVICE_BSS_EVT_RX_RAWDATA");
      m_spp_cb_data.evt_type = SPP_EVT_RX_RAWDATA;
      memcpy(m_spp_cb_data.rawData, p_spp->rawData, SPP_RAWDATA_MAX_SIZE);
      m_spp_cb_data.rawData_length = p_spp->rawData_length;
      break;

    default:
      // No implementation needed.
      break;
  }

  if( m_mutex != NULL )
  {
      if( xSemaphoreTake( m_mutex, ( TickType_t ) 10 ) == pdTRUE )
      {
          if (m_spp_cb != NULL)
          {
            m_spp_cb(&m_spp_cb_data);
          }
          xSemaphoreGive( m_mutex );
      }
      else
      {
          /* We could not obtain the semaphore and can therefore not access
          the shared resource safely. */
      }
  }
}

static void ble_dfu_evt_handler(ble_dfu_t * p_dfu, ble_dfu_evt_t * p_evt)
{
    switch (p_evt->type)
    {
        case BLE_DFU_EVT_INDICATION_DISABLED:
            LL_LOG_INFO("Indication for BLE_DFU is disabled");
            break;

        case BLE_DFU_EVT_INDICATION_ENABLED:
            LL_LOG_INFO("Indication for BLE_DFU is enabled");
            break;

        case BLE_DFU_EVT_ENTERING_BOOTLOADER:
            LL_LOG_INFO("Device is entering bootloader mode!");
            break;
        default:
            LL_LOG_INFO("Unknown event from ble_dfu");
            break;
    }
}

static void conn_params_error_handler(uint32_t nrf_error)
{
    LL_LOG_ENTER_FUNC();
    LL_LOG_ERROR("ERROR: conn_params_error_handler() - %d", nrf_error);
    APP_ERROR_HANDLER(nrf_error);
    LL_LOG_EXIT_FUNC();
}

static void on_conn_params_evt(ble_conn_params_evt_t * p_evt)
{
  LL_LOG_DEBUG("on_conn_params_evt()");

    switch (p_evt->evt_type)
    {
        case BLE_CONN_PARAMS_EVT_SUCCEEDED:
            LL_LOG_INFO("Connection Event received: SUCCESS");
            break;
        case BLE_CONN_PARAMS_EVT_FAILED:
            LL_LOG_INFO("Connection Event received: FAILED");
            break;
        default:
            LL_LOG_WARNING("Connection Event received: Switch case not handled!");
            break;
    }
}

static void on_adv_evt_handler(ble_adv_evt_t ble_adv_evt)
{
    switch (ble_adv_evt)
    {
        case BLE_ADV_EVT_FAST:
#if LL_CONFIG_RELEASE_TO_PARTNER
            uint32_t err_code = dev_indication_set(BSP_INDICATE_ADVERTISING);
            APP_ERROR_CHECK(err_code);
#else
            dev_indication_set(BSP_INDICATE_ADVERTISING);
#endif // LL_CONFIG_RELEASE_TO_PARTNER
            LL_LOG_INFO("Advertising started with BLE_ADV_EVT_FAST");

            m_ble_cb_data.ble_state = BLE_STATE_ADVERTISING;
            if( m_mutex != NULL )
            {
                if( xSemaphoreTake( m_mutex, ( TickType_t ) 10 ) == pdTRUE )
                {
                    if (m_ble_cb != NULL)
                    {
                      m_ble_cb(&m_ble_cb_data);
                    }
                    xSemaphoreGive( m_mutex );
                }
                else
                {
                    LL_LOG_ERROR("We could not obtain the semaphore");
                    /* We could not obtain the semaphore and can therefore not access
                    the shared resource safely. */
                }
            }

            break;

        case BLE_ADV_EVT_IDLE:
            LL_LOG_INFO("Advertising stopped with BLE_ADV_EVT_IDLE");

            m_ble_cb_data.ble_state = BLE_STATE_IDLE;
            if( m_mutex != NULL )
            {
                if( xSemaphoreTake( m_mutex, ( TickType_t ) 10 ) == pdTRUE )
                {
                    if (m_ble_cb != NULL)
                    {
                      m_ble_cb(&m_ble_cb_data);
                    }
                    xSemaphoreGive( m_mutex );
                }
                else
                {
                    LL_LOG_ERROR("We could not obtain the semaphore");
                    /* We could not obtain the semaphore and can therefore not access
                    the shared resource safely. */
                }
            }

            break;

        default:
            break;
    }
}

static void on_ble_evt_handler(ble_evt_t * p_ble_evt)
{
  uint32_t err_code;

  switch (p_ble_evt->header.evt_id)
  {
    /**************************************************
     * GAP EVENTS
     *************************************************/
    case BLE_GAP_EVT_CONNECTED:
      LL_LOG_INFO("BLE_GAP_EVT_CONNECTED");
      m_conn_handle = p_ble_evt->evt.gap_evt.conn_handle;

      LL_LOG_INFO("min_conn_interval = %d", p_ble_evt->evt.gap_evt.params.connected.conn_params.min_conn_interval);
      LL_LOG_INFO("max_conn_interval = %d", p_ble_evt->evt.gap_evt.params.connected.conn_params.max_conn_interval);
      LL_LOG_INFO("slave_latency = %d", p_ble_evt->evt.gap_evt.params.connected.conn_params.slave_latency);
      LL_LOG_INFO("conn_sup_timeout = %d", p_ble_evt->evt.gap_evt.params.connected.conn_params.conn_sup_timeout);

      if (BLE_CONN_INTERVAL_FAST_MAX >= p_ble_evt->evt.gap_evt.params.connected.conn_params.max_conn_interval)
      {
        m_ble_cb_data.ble_datarate = BLE_DATARATE_HIGH;
      }
      else if (BLE_CONN_INTERVAL_MID_MAX >= p_ble_evt->evt.gap_evt.params.connected.conn_params.max_conn_interval)
      {
        m_ble_cb_data.ble_datarate = BLE_DATARATE_MID;
      }
      else
      {
        m_ble_cb_data.ble_datarate = BLE_DATARATE_LOW;
      }
      m_ble_cb_data.ble_state = BLE_STATE_CONNECTED;
      if (m_mutex != NULL)
      {
        if ( xSemaphoreTake( m_mutex, ( TickType_t ) 10 ) == pdTRUE)
        {
          if (m_ble_cb != NULL)
          {
            m_ble_cb(&m_ble_cb_data);
          }
          xSemaphoreGive(m_mutex);
        }
        else
        {
          /* We could not obtain the semaphore and can therefore not access
           the shared resource safely. */
        }
      }
#if LL_CONFIG_RELEASE_TO_PARTNER
      err_code = dev_indication_set(BSP_INDICATE_CONNECTED);
      APP_ERROR_CHECK(err_code);
#else
      dev_indication_set(BSP_INDICATE_CONNECTED);
#endif // LL_CONFIG_RELEASE_TO_PARTNER
      break;  // BLE_GAP_EVT_CONNECTED

    case BLE_GAP_EVT_DISCONNECTED:
      LL_LOG_INFO("BLE_GAP_EVT_DISCONNECTED");
      LL_LOG_INFO("Disconnected m_conn_handle = %x", m_conn_handle);
      m_conn_handle = BLE_CONN_HANDLE_INVALID;
      m_ble_cb_data.ble_state = BLE_STATE_DISCONNECTED;
      if (m_mutex != NULL)
      {
        if ( xSemaphoreTake( m_mutex, ( TickType_t ) 10 ) == pdTRUE)
        {
          if (m_ble_cb != NULL)
          {
            m_ble_cb(&m_ble_cb_data);
          }
          xSemaphoreGive(m_mutex);
        }
        else
        {
          /* We could not obtain the semaphore and can therefore not access
           the shared resource safely. */
        }
      }
      //err_code = dev_indication_set(BSP_INDICATE_DISCONNECTED);
      //APP_ERROR_CHECK(err_code);
      break;  // BLE_GAP_EVT_DISCONNECTED

    case BLE_GAP_EVT_CONN_PARAM_UPDATE:
      LL_LOG_INFO("BLE_GAP_EVT_CONN_PARAM_UPDATE");
      LL_LOG_INFO("min_conn_interval = %d",
          p_ble_evt->evt.gap_evt.params.conn_param_update.conn_params.min_conn_interval);
      LL_LOG_INFO("max_conn_interval = %d",
          p_ble_evt->evt.gap_evt.params.conn_param_update.conn_params.max_conn_interval);
      LL_LOG_INFO("slave_latency = %d", p_ble_evt->evt.gap_evt.params.conn_param_update.conn_params.slave_latency);
      LL_LOG_INFO("conn_sup_timeout = %d",
          p_ble_evt->evt.gap_evt.params.conn_param_update.conn_params.conn_sup_timeout);

      if (BLE_CONN_INTERVAL_FAST_MAX >= p_ble_evt->evt.gap_evt.params.conn_param_update.conn_params.max_conn_interval)
      {
        m_ble_cb_data.ble_datarate = BLE_DATARATE_HIGH;
      }
      else if (BLE_CONN_INTERVAL_MID_MAX
          >= p_ble_evt->evt.gap_evt.params.conn_param_update.conn_params.max_conn_interval)
      {
        m_ble_cb_data.ble_datarate = BLE_DATARATE_MID;
      }
      else
      {
        m_ble_cb_data.ble_datarate = BLE_DATARATE_LOW;
      }
      if (m_mutex != NULL)
      {
        if ( xSemaphoreTake( m_mutex, ( TickType_t ) 10 ) == pdTRUE)
        {
          if (m_ble_cb != NULL)
          {
            m_ble_cb(&m_ble_cb_data);
          }
          xSemaphoreGive(m_mutex);
        }
        else
        {
          LL_LOG_ERROR("We could not obtain the semaphore");
          /* We could not obtain the semaphore and can therefore not access
           the shared resource safely. */
        }
      }
      break;

    case BLE_GAP_EVT_SEC_PARAMS_REQUEST:
      LL_LOG_INFO("BLE_GAP_EVT_SEC_PARAMS_REQUEST");
      break;

    case BLE_GAP_EVT_SEC_INFO_REQUEST:
      LL_LOG_INFO("BLE_GAP_EVT_SEC_INFO_REQUEST");
      break;

    case BLE_GAP_EVT_PASSKEY_DISPLAY:
      LL_LOG_INFO("BLE_GAP_EVT_PASSKEY_DISPLAY");
      break;

    case BLE_GAP_EVT_KEY_PRESSED:
      LL_LOG_INFO("BLE_GAP_EVT_KEY_PRESSED");
      break;

    case BLE_GAP_EVT_AUTH_KEY_REQUEST:
      LL_LOG_INFO("BLE_GAP_EVT_AUTH_KEY_REQUEST");
      break;

    case BLE_GAP_EVT_LESC_DHKEY_REQUEST:
      LL_LOG_INFO("BLE_GAP_EVT_LESC_DHKEY_REQUEST");
      err_code = ecc_p256_shared_secret_compute(&m_lesc_sk.sk[0],
          &p_ble_evt->evt.gap_evt.params.lesc_dhkey_request.p_pk_peer->pk[0], &m_lesc_dhkey.key[0]);
      APP_ERROR_CHECK(err_code);
      err_code = sd_ble_gap_lesc_dhkey_reply(m_conn_handle, &m_lesc_dhkey);
      APP_ERROR_CHECK(err_code);
      break;

    case BLE_GAP_EVT_AUTH_STATUS:
      LL_LOG_INFO("BLE_GAP_EVT_AUTH_STATUS");
      break;

    case BLE_GAP_EVT_CONN_SEC_UPDATE:
      LL_LOG_INFO("BLE_GAP_EVT_CONN_SEC_UPDATE");
      break;

    case BLE_GAP_EVT_TIMEOUT:
      LL_LOG_INFO("BLE_GAP_EVT_TIMEOUT");
      break;

    case BLE_GAP_EVT_RSSI_CHANGED:
      LL_LOG_INFO("BLE_GAP_EVT_RSSI_CHANGED");
      break;

    case BLE_GAP_EVT_ADV_REPORT:
      LL_LOG_INFO("BLE_GAP_EVT_ADV_REPORT");
      break;

    case BLE_GAP_EVT_SEC_REQUEST:
      LL_LOG_INFO("BLE_GAP_EVT_SEC_REQUEST");
      break;

    case BLE_GAP_EVT_CONN_PARAM_UPDATE_REQUEST:
      LL_LOG_INFO("BLE_GAP_EVT_CONN_PARAM_UPDATE_REQUEST");
      break;

    case BLE_GAP_EVT_SCAN_REQ_REPORT:
      LL_LOG_INFO("BLE_GAP_EVT_SCAN_REQ_REPORT");
      break;

      /**************************************************
       * GATTS EVENTS
       *************************************************/

    case BLE_GATTS_EVT_WRITE:
      LL_LOG_INFO("BLE_GATTS_EVT_WRITE");
      break;

    case BLE_GATTS_EVT_RW_AUTHORIZE_REQUEST:
      LL_LOG_INFO("BLE_GATTS_EVT_RW_AUTHORIZE_REQUEST");
      {
        ble_gatts_evt_rw_authorize_request_t req;
        ble_gatts_rw_authorize_reply_params_t auth_reply;

        req = p_ble_evt->evt.gatts_evt.params.authorize_request;

        if (req.type != BLE_GATTS_AUTHORIZE_TYPE_INVALID)
        {
          if ((req.request.write.op == BLE_GATTS_OP_PREP_WRITE_REQ) ||
              (req.request.write.op == BLE_GATTS_OP_EXEC_WRITE_REQ_NOW) ||
              (req.request.write.op == BLE_GATTS_OP_EXEC_WRITE_REQ_CANCEL))
          {
            if (req.type == BLE_GATTS_AUTHORIZE_TYPE_WRITE)
            {
              auth_reply.type = BLE_GATTS_AUTHORIZE_TYPE_WRITE;
            }
            else
            {
              auth_reply.type = BLE_GATTS_AUTHORIZE_TYPE_READ;
            }
            auth_reply.params.write.gatt_status = APP_FEATURE_NOT_SUPPORTED;
            err_code = sd_ble_gatts_rw_authorize_reply(p_ble_evt->evt.gatts_evt.conn_handle,
                &auth_reply);
            APP_ERROR_CHECK(err_code);
          }
        }
      }
      break;  // BLE_GATTS_EVT_RW_AUTHORIZE_REQUEST

    case BLE_GATTS_EVT_SYS_ATTR_MISSING:
      LL_LOG_INFO("BLE_GATTS_EVT_SYS_ATTR_MISSING");
      break;

    case BLE_GATTS_EVT_HVC:
      LL_LOG_INFO("BLE_GATTS_EVT_HVC");
      break;

    case BLE_GATTS_EVT_SC_CONFIRM:
      LL_LOG_INFO("BLE_GATTS_EVT_SC_CONFIRM");
      break;

#if (NRF_SD_BLE_API_VERSION == 3)
      case BLE_GATTS_EVT_EXCHANGE_MTU_REQUEST:
      LL_LOG_INFO("BLE_GATTS_EVT_EXCHANGE_MTU_REQUEST");
      err_code = sd_ble_gatts_exchange_mtu_reply(p_ble_evt->evt.gatts_evt.conn_handle,
          NRF_BLE_MAX_MTU_SIZE);
      APP_ERROR_CHECK(err_code);
      break;  // BLE_GATTS_EVT_EXCHANGE_MTU_REQUEST
#endif

      case BLE_GATTS_EVT_TIMEOUT:
        LL_LOG_INFO("BLE_GATTS_EVT_TIMEOUT");
        LL_LOG_DEBUG("GATT Server Timeout.");
        // Disconnect on GATT Server timeout event.
        err_code = sd_ble_gap_disconnect(p_ble_evt->evt.gatts_evt.conn_handle,
        BLE_HCI_REMOTE_USER_TERMINATED_CONNECTION);
        APP_ERROR_CHECK(err_code);
        break;  // BLE_GATTS_EVT_TIMEOUT

      /**************************************************
       * GATTC EVENTS
       *************************************************/

    case BLE_GATTC_EVT_PRIM_SRVC_DISC_RSP:
      LL_LOG_INFO("BLE_GATTC_EVT_PRIM_SRVC_DISC_RSP");
      break;
    case  BLE_GATTC_EVT_REL_DISC_RSP:
      LL_LOG_INFO("BLE_GATTC_EVT_REL_DISC_RSP");
      break;
    case  BLE_GATTC_EVT_CHAR_DISC_RSP:
      LL_LOG_INFO("BLE_GATTC_EVT_CHAR_DISC_RSP");
      break;
    case  BLE_GATTC_EVT_DESC_DISC_RSP:
      LL_LOG_INFO("BLE_GATTC_EVT_DESC_DISC_RSP");
      break;
    case  BLE_GATTC_EVT_ATTR_INFO_DISC_RSP:
      LL_LOG_INFO("BLE_GATTC_EVT_ATTR_INFO_DISC_RSP");
      break;
    case  BLE_GATTC_EVT_CHAR_VAL_BY_UUID_READ_RSP:
      LL_LOG_INFO("BLE_GATTC_EVT_CHAR_VAL_BY_UUID_READ_RSP");
      break;
    case  BLE_GATTC_EVT_READ_RSP:
      LL_LOG_INFO("BLE_GATTC_EVT_READ_RSP");
      break;
    case  BLE_GATTC_EVT_CHAR_VALS_READ_RSP:
      LL_LOG_INFO("BLE_GATTC_EVT_CHAR_VALS_READ_RSP");
      break;
    case  BLE_GATTC_EVT_WRITE_RSP:
      LL_LOG_INFO("BLE_GATTC_EVT_WRITE_RSP");
      break;
    case  BLE_GATTC_EVT_HVX:
      LL_LOG_INFO("BLE_GATTC_EVT_HVX");
      break;

    case BLE_GATTC_EVT_TIMEOUT:
      LL_LOG_INFO("BLE_GATTC_EVT_TIMEOUT");
      LL_LOG_DEBUG("GATT Client Timeout.");
      // Disconnect on GATT Client timeout event.
      err_code = sd_ble_gap_disconnect(p_ble_evt->evt.gattc_evt.conn_handle,
      BLE_HCI_REMOTE_USER_TERMINATED_CONNECTION);
      APP_ERROR_CHECK(err_code);
      break;  // BLE_GATTC_EVT_TIMEOUT

      /**************************************************
       * BLE EVENTS
       *************************************************/

    case BLE_EVT_TX_COMPLETE:
      LL_LOG_INFO("BLE_EVT_TX_COMPLETE");

      break;

    case BLE_EVT_USER_MEM_REQUEST:
      LL_LOG_INFO("BLE_EVT_USER_MEM_REQUEST");
      err_code = sd_ble_user_mem_reply(m_conn_handle, NULL);
      APP_ERROR_CHECK(err_code);
      break;  // BLE_EVT_USER_MEM_REQUEST

    default:
      LL_LOG_WARNING("BLE event not handled in switch! EVENT: %d", p_ble_evt->header.evt_id);
      // No implementation needed.
      break;
  }
}

static void ble_evt_dispatch(ble_evt_t * p_ble_evt)
{
    /** The Connection state module has to be fed BLE events in order to function correctly
     * Remember to call ble_conn_state_on_ble_evt before calling any ble_conns_state_* functions. */
    ble_conn_state_on_ble_evt(p_ble_evt);
    pm_on_ble_evt(p_ble_evt);
    ble_service_bss_on_ble_evt(&m_spp, p_ble_evt);
    ble_conn_params_on_ble_evt(p_ble_evt);
    bsp_btn_ble_on_ble_evt(p_ble_evt);
    on_ble_evt_handler(p_ble_evt);
    ble_advertising_on_ble_evt(p_ble_evt);
    ble_dfu_on_ble_evt(&m_dfus, p_ble_evt);
}

static void sys_evt_dispatch(uint32_t sys_evt)
{
    // Dispatch the system event to the fstorage module, where it will be
    // dispatched to the Flash Data Storage (FDS) module.
    fs_sys_event_handler(sys_evt);

    // Dispatch to the Advertising module last, since it will check if there are any
    // pending flash operations in fstorage. Let fstorage process system events first,
    // so that it can report correctly to the Advertising module.
    ble_advertising_on_sys_evt(sys_evt);
}

/****************************************************************
 * STATIC INIT FUNCTIONS
 ***************************************************************/

/**@brief Function for the Timer initialization.
 *
 * @details Initializes the timer module. This creates and starts application timers.
 */
/*static void timers_init(void)
{
    // Initialize timer module.
    APP_TIMER_INIT(APP_TIMER_PRESCALER, APP_TIMER_OP_QUEUE_SIZE, FALSE);

    // Create timers.
    m_battery_timer = xTimerCreate("BATT",
                                   BATTERY_LEVEL_MEAS_INTERVAL,
                                   pdFALSE,
                                   NULL,
                                   battery_level_meas_timeout_handler);

    if (NULL == m_battery_timer)
    {
        APP_ERROR_HANDLER(NRF_ERROR_NO_MEM);
    }
}*/

/**@brief Function for initializing buttons.
 *
 * @param[out] p_erase_bonds  Will be TRUE if the clear bonding button was pressed to wake the application up.
 */
static void buttons_init(bool * p_erase_bonds)
{
    bsp_event_t startup_event;
    uint32_t err_code;

    err_code = bsp_btn_ble_init(NULL, &startup_event);
    APP_ERROR_CHECK(err_code);

    *p_erase_bonds = (startup_event == BSP_EVENT_CLEAR_BONDING_DATA);
}

/**@brief Function for initializing the BLE stack.
 *
 * @details Initializes the SoftDevice and the BLE event interrupt.
 */
static void ble_stack_init(void)
{
    uint32_t err_code;

    //Create Semaphore
    m_mutex = xSemaphoreCreateMutex();

    nrf_clock_lf_cfg_t clock_lf_cfg = NRF_CLOCK_LFCLKSRC;

    // Initialize the SoftDevice handler module.
    SOFTDEVICE_HANDLER_INIT(&clock_lf_cfg, ble_new_event_handler);

    ble_enable_params_t ble_enable_params;                              // TODO needed
    err_code = softdevice_enable_get_default_config(CENTRAL_LINK_COUNT,
                                                    PERIPHERAL_LINK_COUNT,
                                                    &ble_enable_params);
    APP_ERROR_CHECK(err_code);

    if(ble_enable_params.common_enable_params.p_conn_bw_counts != NULL)
    {
        LL_LOG_INFO("xxd high=%d,mid=%d,low=%d",ble_enable_params.common_enable_params.p_conn_bw_counts->tx_counts.high_count, ble_enable_params.common_enable_params.p_conn_bw_counts->tx_counts.mid_count,ble_enable_params.common_enable_params.p_conn_bw_counts->tx_counts.low_count);
    }

    //Configure the memory pools available for application packets
    ble_conn_bw_counts_t conn_bw_counts = {
        .tx_counts = {.high_count = 1, .mid_count = 0, .low_count = 0},
              .rx_counts = {.high_count = 1, .mid_count = 0, .low_count = 0}
      };

    //Configure conn_bw_counts in enable_params (along with others)
    ble_enable_params.common_enable_params.p_conn_bw_counts = &conn_bw_counts;

    CHECK_RAM_START_ADDR(CENTRAL_LINK_COUNT, PERIPHERAL_LINK_COUNT);

    // Enable BLE stack.
#if (NRF_SD_BLE_API_VERSION == 3)
    ble_enable_params.gatt_enable_params.att_mtu = NRF_BLE_MAX_MTU_SIZE;
#endif
    err_code = softdevice_enable(&ble_enable_params);
    APP_ERROR_CHECK(err_code);

    ble_opt_t ble_opt; //refer to "ble.h"

    //Configure the bandwidth for each connection
    memset(&ble_opt, 0x00, sizeof(ble_opt));
    ble_opt.common_opt.conn_bw.conn_bw.conn_bw_tx = BLE_CONN_BW_HIGH;   //< Connection bandwidth configuration for transmission, see @ref BLE_CONN_BWS.
    ble_opt.common_opt.conn_bw.conn_bw.conn_bw_rx = BLE_CONN_BW_HIGH;   //< Connection bandwidth configuration for reception, see @ref BLE_CONN_BWS.
    ble_opt.common_opt.conn_bw.role = BLE_GAP_ROLE_PERIPH | BLE_GAP_ROLE_CENTRAL;
    err_code = sd_ble_opt_set(BLE_COMMON_OPT_CONN_BW, &ble_opt);
    APP_ERROR_CHECK(err_code);

#if LL_CONFIG_DISABLE_DLE_FEATURE_OF_BLE
    // WORKAROUND for Samsung Android 7.0 pairing issue /////////////////////////////

    /*(!)
     * At least s132_nrf52_3.1.0_softdevice.hex must have been flashed onto the device for this to work!
     */

    // Enable compatibility mode 2
    memset(&ble_opt, 0x00, sizeof(ble_opt));
    ble_opt.gap_opt.compat_mode_2.mode_2_enable = TRUE;
    err_code = sd_ble_opt_set(BLE_GAP_OPT_COMPAT_MODE_2, &ble_opt);
    APP_ERROR_CHECK(err_code);

    // Setting the Extended Lenght payload size to 0 (disable)
    memset(&ble_opt, 0x00, sizeof(ble_opt));
    ble_opt.gap_opt.ext_len.rxtx_max_pdu_payload_size = 0;
    err_code = sd_ble_opt_set(BLE_GAP_OPT_EXT_LEN, &ble_opt);
    APP_ERROR_CHECK(err_code);

    // Completely disabling the DLE functionality (workaround for Samsung Android 7.0 paring issue)
    err_code = sd_ble_opt_set(BLE_GAP_OPT_DLE_DISABLE, &ble_opt);
    APP_ERROR_CHECK(err_code);

    /////////////////////////////////////////////////////////////////////////////////
#endif // LL_CONFIG_DISABLE_DLE_FEATURE_OF_BLE

    // Register with the SoftDevice handler module for BLE events.
    err_code = softdevice_ble_evt_handler_set(ble_evt_dispatch);
    APP_ERROR_CHECK(err_code);

    // Register with the SoftDevice handler module for BLE events.
    err_code = softdevice_sys_evt_handler_set(sys_evt_dispatch);
    APP_ERROR_CHECK(err_code);
}

static void peer_manager_init(bool erase_bonds)
{
    ble_gap_sec_params_t sec_param;
    ret_code_t           err_code;

    err_code = pm_init();
    APP_ERROR_CHECK(err_code);

    if (erase_bonds)
    {
        err_code = pm_peers_delete();
        APP_ERROR_CHECK(err_code);
    }

    memset(&sec_param, 0, sizeof(ble_gap_sec_params_t));

    // Security parameters to be used for all security procedures.
    sec_param.bond           = SEC_PARAM_BOND;
    sec_param.mitm           = SEC_PARAM_MITM;
    sec_param.lesc           = SEC_PARAM_LESC;
    sec_param.keypress       = SEC_PARAM_KEYPRESS;
    sec_param.io_caps        = SEC_PARAM_IO_CAPABILITIES;
    sec_param.oob            = SEC_PARAM_OOB;
    sec_param.min_key_size   = SEC_PARAM_MIN_KEY_SIZE;
    sec_param.max_key_size   = SEC_PARAM_MAX_KEY_SIZE;
    sec_param.kdist_own.enc  = 1;
    sec_param.kdist_own.id   = 1;
    sec_param.kdist_peer.enc = 1;
    sec_param.kdist_peer.id  = 1;

    err_code = pm_sec_params_set(&sec_param);
    APP_ERROR_CHECK(err_code);

    err_code = pm_register(pm_evt_handler);
    APP_ERROR_CHECK(err_code);

    //Initiate passkey
    uint8_t passkey[] = PASS_KEY;
    ble_opt_t ble_opt;
    ble_opt.gap_opt.passkey.p_passkey = &passkey[0];
    err_code = sd_ble_opt_set(BLE_GAP_OPT_PASSKEY, &ble_opt);
    APP_ERROR_CHECK(err_code);

    ecc_init(TRUE); // Initialize the Elliptic Curve Cryptography interface

    err_code = ecc_p256_keypair_gen(m_lesc_sk.sk, m_lesc_pk.pk);
    APP_ERROR_CHECK(err_code);

    /* Set the public key */
    err_code = pm_lesc_public_key_set(&m_lesc_pk);
    APP_ERROR_CHECK(err_code);
}

static void gap_init(void)
{
    uint32_t                err_code;
    ble_gap_conn_params_t   gap_conn_params;
    ble_gap_conn_sec_mode_t sec_mode;

    BLE_GAP_CONN_SEC_MODE_SET_OPEN(&sec_mode);

    err_code = sd_ble_gap_device_name_set(&sec_mode,
                                          (const uint8_t *)PERIPHERAL_DEVICE_NAME,
                                          strlen(PERIPHERAL_DEVICE_NAME));
    APP_ERROR_CHECK(err_code);

    err_code = sd_ble_gap_appearance_set(BLE_APPEARANCE_GENERIC_TAG);
    APP_ERROR_CHECK(err_code);

    memset(&gap_conn_params, 0, sizeof(gap_conn_params));

    gap_conn_params.min_conn_interval = MIN_CONN_INTERVAL;
    gap_conn_params.max_conn_interval = MAX_CONN_INTERVAL;
    gap_conn_params.slave_latency     = SLAVE_LATENCY;
    gap_conn_params.conn_sup_timeout  = CONN_SUP_TIMEOUT;

    err_code = sd_ble_gap_ppcp_set(&gap_conn_params);
    APP_ERROR_CHECK(err_code);
}

/**@brief Function for initializing the Advertising functionality.
 */
static void advertising_init(void)
{
  uint32_t err_code;
  ble_advdata_t advdata;
  ble_adv_modes_config_t options;

  memset(&advdata, 0, sizeof(advdata));

  advdata.name_type               = BLE_ADVDATA_FULL_NAME;
  advdata.include_appearance      = TRUE;
  advdata.flags                   = BLE_GAP_ADV_FLAGS_LE_ONLY_GENERAL_DISC_MODE;
  advdata.uuids_complete.uuid_cnt = sizeof(m_adv_uuids) / sizeof(m_adv_uuids[0]);
  advdata.uuids_complete.p_uuids  = m_adv_uuids;

  memset(&options, 0, sizeof(options));
  options.ble_adv_fast_enabled      = TRUE;
  options.ble_adv_fast_interval     = APP_ADV_FAST_INTERVAL;
  options.ble_adv_fast_timeout      = APP_ADV_FAST_TIMEOUT_IN_SECONDS;
  options.ble_adv_slow_enabled      = TRUE;
  options.ble_adv_slow_interval     = APP_ADV_FAST_INTERVAL;
  options.ble_adv_slow_timeout      = APP_ADV_FAST_TIMEOUT_IN_SECONDS;
  options.ble_adv_on_disconnect_disabled = TRUE;                          /**< Enable or disable automatic return to advertising upon disconnecting.*/
  options.ble_adv_whitelist_enabled = FALSE;                              /**< Enable or disable use of the whitelist. */
  options.ble_adv_directed_high_duty_enabled = FALSE;                     /**< Enable or disable direct advertising mode. can only be used if ble_adv_legacy_enabled is true. */
  options.ble_adv_directed_enabled  = FALSE;                              /**< Enable or disable direct advertising mode. */
  options.ble_adv_directed_interval = 0;                                  /**< Advertising interval for directed advertising. */
  options.ble_adv_directed_timeout  = 0;                                  /**< Time-out (number of tries) for direct advertising. */
  options.ble_adv_extended_enabled  = FALSE;                              /**< Enable or disable extended advertising. */
  options.ble_adv_secondary_phy = BLE_GAP_PHY_1MBPS | BLE_GAP_PHY_2MBPS;  /**< PHY for the secondary (extended) advertising @ref BLE_GAP_PHYS (BLE_GAP_PHY_1MBPS, BLE_GAP_PHY_2MBPS or BLE_GAP_PHY_CODED). */
  options.ble_adv_primary_phy   = BLE_GAP_PHY_1MBPS | BLE_GAP_PHY_2MBPS;  /**< PHY for the primary advertising. @ref BLE_GAP_PHYS (BLE_GAP_PHY_1MBPS, BLE_GAP_PHY_2MBPS or BLE_GAP_PHY_CODED). */

  err_code = ble_advertising_init(&advdata, NULL, &options, on_adv_evt_handler, NULL);
  APP_ERROR_CHECK(err_code);
}

static void services_init(void)
{
    uint32_t       err_code;
    ble_service_bss_init_t spp_init;
    ble_dis_init_t dis_init;
    ble_bas_init_t bas_init;
    ble_dfu_init_t dfus_init;

    uint32_t       fw_app_version;
    uint32_t       fw_bootloader_version;

    // Initialize ISEE SPP Service.
    memset(&spp_init, 0, sizeof(spp_init));
    spp_init.evt_handler = spp_event_handler;
    err_code = ble_service_bss_init(&m_spp, &spp_init);
    APP_ERROR_CHECK(err_code);


    // Initialize the Device Firmware Update Service.
    m_dfus.uuid_type = m_spp.uuid_type;
    memset(&dfus_init, 0, sizeof(dfus_init));
    dfus_init.evt_handler                               = ble_dfu_evt_handler;
    dfus_init.ctrl_point_security_req_write_perm        = SEC_SIGNED;
    dfus_init.ctrl_point_security_req_cccd_write_perm   = SEC_SIGNED;
    err_code = ble_dfu_init(&m_dfus, &dfus_init);
    APP_ERROR_CHECK(err_code);


    // Initialize Device Information Service.
    memset(&dis_init, 0, sizeof(dis_init));
    ble_srv_ascii_to_utf8(&dis_init.manufact_name_str, (char *)MANUFACTURER_NAME);
    BLE_GAP_CONN_SEC_MODE_SET_OPEN(&dis_init.dis_attr_md.read_perm);
    BLE_GAP_CONN_SEC_MODE_SET_NO_ACCESS(&dis_init.dis_attr_md.write_perm);
    err_code = ble_dis_init(&dis_init);
    APP_ERROR_CHECK(err_code);


    // Initialize Battery Service.
    memset(&bas_init, 0, sizeof(bas_init));
    // Here the sec level for the Battery Service can be changed/increased.
    BLE_GAP_CONN_SEC_MODE_SET_OPEN(&bas_init.battery_level_char_attr_md.cccd_write_perm);
    BLE_GAP_CONN_SEC_MODE_SET_OPEN(&bas_init.battery_level_char_attr_md.read_perm);
    BLE_GAP_CONN_SEC_MODE_SET_NO_ACCESS(&bas_init.battery_level_char_attr_md.write_perm);
    BLE_GAP_CONN_SEC_MODE_SET_OPEN(&bas_init.battery_level_report_read_perm);
    bas_init.evt_handler          = NULL;
    bas_init.support_notification = TRUE;
    bas_init.p_report_ref         = NULL;
    bas_init.initial_batt_level   = m_battery_level;
    err_code = ble_bas_init(&m_bas, &bas_init);
    APP_ERROR_CHECK(err_code);

    ble_app_initialized = TRUE;

    fw_app_version = s_dfu_settings.app_version;
    fw_bootloader_version = s_dfu_settings.bootloader_version;
    LL_LOG_INFO(" fw_app_version = %d", fw_app_version);
    LL_LOG_INFO(" fw_bootloader_version = %d", fw_bootloader_version);
}

static void conn_params_init(void)
{
    uint32_t               err_code;
    ble_conn_params_init_t cp_init;

    memset(&cp_init, 0, sizeof(cp_init));
    cp_init.p_conn_params                  = NULL;
    cp_init.first_conn_params_update_delay = FIRST_CONN_PARAMS_UPDATE_DELAY;
    cp_init.next_conn_params_update_delay  = NEXT_CONN_PARAMS_UPDATE_DELAY;
    cp_init.max_conn_params_update_count   = MAX_CONN_PARAMS_UPDATE_COUNT;
//    cp_init.start_on_notify_cccd_handle    = m_spp.spp_sensor_data_handles.cccd_handle;
    cp_init.start_on_notify_cccd_handle    = BLE_GATT_HANDLE_INVALID;
    cp_init.disconnect_on_fail             = FALSE;
    cp_init.evt_handler                    = on_conn_params_evt;
    cp_init.error_handler                  = conn_params_error_handler;
    err_code = ble_conn_params_init(&cp_init);
    APP_ERROR_CHECK(err_code);
}

/****************************************************************
 * API FUNCTIONS
 ***************************************************************/

void assert_nrf_callback(uint16_t line_num, const uint8_t * p_file_name)
{
    app_error_handler(DEAD_BEEF, line_num, p_file_name);
}

int ble_app_set_battery_level(uint8_t level)
{
  int err = 0;

  if (ble_app_initialized)
  {
    err = (int)ble_bas_battery_level_update(&m_bas, level);
  }
  else
  {
    m_battery_level = level;
  }
  return err;
}

void ble_get_bd_address(ble_gap_addr_t* gap_address)
{
  //sd_ble_gap_address_get(gap_address);
}


/****************************************************************
 * THREAD FUNCTION
 ***************************************************************/

/**@brief Thread for handling the Application's BLE Stack events.
 *
 * @details This thread is responsible for handling BLE Stack events sent from on_ble_evt_handler().
 *
 * @param[in]   arg   Pointer used for passing some arbitrary information (context) from the
 *                    osThreadCreate() call to the thread.
 */
static void ble_stack_thread(void * arg)
{
    UNUSED_PARAMETER(arg);

    LL_LOG_INFO("BLE STACK THREAD EXECUTING...");
    bool erase_bonds = FALSE; // Initialize

    // Init a semaphore for the BLE thread.
    m_ble_event_ready = xSemaphoreCreateBinary();

    // Initialization
    //timers_init();
    buttons_init(&erase_bonds);

    ble_stack_init();
    peer_manager_init(erase_bonds);
    gap_init();                                  // Set GAP Peripheral Preferred Connection Parameters.
    advertising_init();
    services_init();
    conn_params_init();

    LL_LOG_INFO("Stored peers: %d", pm_peer_count());

    // Start advertising
#if LL_CONFIG_START_ADVERTISING_ON_BOOT
    LL_LOG_INFO("LL_CONFIG_START_ADVERTISING_ON_BOOT");
    advertising_start();
#endif

    while (1)
    {
        /* Wait for event from SoftDevice */
        while (pdFALSE == xSemaphoreTake(m_ble_event_ready, portMAX_DELAY))
        {
            // Just wait again in the case when INCLUDE_vTaskSuspend is not enabled
        }

        // This function gets events from the SoftDevice and processes them by calling the function
        // registered by softdevice_ble_evt_handler_set during stack initialization.
        // In this code ble_evt_dispatch would be called for every event found.
        intern_softdevice_events_execute();
    }
}

bool startBLE(void)
{
  if (NULL == m_ble_event_ready)
  {
    APP_ERROR_HANDLER(NRF_ERROR_NO_MEM);
  }

  // Start BLE stack thread
  if (pdPASS != xTaskCreate(ble_stack_thread, LL_THREAD_NAME_BLE, LL_THREAD_STACK_SIZE_BLE,
      NULL, LL_THREAD_PRIORITY_BLE, &m_ble_stack_thread))
  {
    APP_ERROR_HANDLER(NRF_ERROR_NO_MEM);
  }

  return TRUE;
}


