/*!
* @brief Thread based functionality that should execute a CLI interface to control the diffrent devices
*/

#include "../aux/spp_app.h"
#include "FreeRTOS.h"
#include "timers.h"
#include "task.h"
#include "app_timer.h"

#include "devicedrivers/inc/devicedriver.h"

#define LL_LOG_MODULE_NAME "SPP_TEST"
#include "LL_log.h"


/* ble */
static ble_ioctrl_data_t m_ble_ioctrl_data;
int m_ble_fileHandler = 0;
/* spp */
#define SPPDATALENGTH                   456
#define MEASURECOUNTER                  500
static uint8_t sppData[SPPDATALENGTH];
static spp_ioctrl_data_t m_spp_ioctrl_data;
int m_spp_fileHandler = 0;
int datacounter = 0;
uint32_t start = 0, diff = 0, mCounter = 0;

/* ble */
static void ble_cb_handler(ble_cb_data_t * p_ble_cb_data)
{
  switch (p_ble_cb_data->ble_state)
  {
    case BLE_STATE_CONNECTED:
      LL_LOG_INFO(" BLE_STATE_CONNECTED\r\n");
      break;

    case BLE_STATE_DISCONNECTED:
      LL_LOG_INFO(" BLE_STATE_DISCONNECTED\r\n");
      break;

    default:
        // No implementation needed.
      break;
    }

  switch (p_ble_cb_data->ble_datarate)
  {
    case BLE_DATARATE_HIGH:
      LL_LOG_INFO(" BLE_DATARATE_HIGH\r\n");

        LL_LOG_INFO(" Reset...\r\n");
        m_ble_ioctrl_data.ble_datarate = BLE_DATARATE_LOW;

      break;

    case BLE_DATARATE_MID:
      LL_LOG_INFO(" BLE_DATARATE_MID\r\n");

        LL_LOG_INFO(" Reset...\r\n");
        m_ble_ioctrl_data.ble_datarate = BLE_DATARATE_LOW;

      break;

    case BLE_DATARATE_LOW:
      LL_LOG_INFO(" BLE_DATARATE_LOW\r\n");
      if(m_ble_ioctrl_data.ble_datarate == BLE_DATARATE_HIGH)
      {
        LL_LOG_INFO(" use BLE_DATARATE_MID\r\n");
        m_ble_ioctrl_data.ble_datarate = BLE_DATARATE_MID;
        dev_ioctl(m_ble_fileHandler, BLE_REQUEST_SET_DATARATE, (void *)(&m_ble_ioctrl_data));
        m_ble_ioctrl_data.ble_datarate = BLE_DATARATE_LOW;
      }
      break;

    default:
        // No implementation needed.
      break;
    }
}
bool ble_init(void)
{
  LL_LOG_INFO(" ble_init entered");

  m_ble_fileHandler = dev_open("BLE",0,0, NULL);
  if (m_ble_fileHandler == 0)
  {
    return false;
  }

  m_ble_ioctrl_data.ble_cb = ble_cb_handler;

  dev_ioctl(m_ble_fileHandler, BLE_REQUEST_REGISTER_CALLBACK, (void *)(&m_ble_ioctrl_data));

  return true;
}
/* spp */
static void spp_cb_handler(spp_cb_data_t * p_spp_cb_data)
{
  int counter = 0;
  switch (p_spp_cb_data->evt_type)
  {
    case SPP_EVT_OPEN:
      LL_LOG_INFO(" ISEE_BLE_SPP_EVT_OPEN!!!!! MTU=%d, Retry=%d\r\n", p_spp_cb_data->MTU, p_spp_cb_data->RETRY );
      m_ble_ioctrl_data.ble_datarate = BLE_DATARATE_HIGH;
      dev_ioctl(m_ble_fileHandler, BLE_REQUEST_SET_DATARATE, (void *)(&m_ble_ioctrl_data));
      dev_ioctl(m_spp_fileHandler, SPP_REQUEST_GET_AVAILABLE_BUFFER, &counter);
      LL_LOG_INFO(" ISEE_BLE_SPP_EVT_OPEN!!!!! counter=%d\r\n", counter );
      sppData[0] = datacounter;
      sppData[SPPDATALENGTH-1] = datacounter;
      if (dev_write(m_spp_fileHandler, sppData,SPPDATALENGTH) == 0)
      {
        LL_LOG_INFO(" Error in sending data!!!!!\r\n" );
      }
      else
      {
        datacounter++;
      }
            sppData[0] = datacounter;
      sppData[SPPDATALENGTH-1] = datacounter;
      if (dev_write(m_spp_fileHandler, sppData,SPPDATALENGTH) == 0)
      {
        LL_LOG_INFO(" Error in sending data!!!!!\r\n" );
      }
            else
      {
        datacounter++;
      }
            sppData[0] = datacounter;
      sppData[SPPDATALENGTH-1] = datacounter;
      if (dev_write(m_spp_fileHandler, sppData,SPPDATALENGTH) == 0)
      {
        LL_LOG_INFO(" Error in sending data!!!!!\r\n" );
      }
            else
      {
        datacounter++;
      }
            sppData[0] = datacounter;
      sppData[SPPDATALENGTH-1] = datacounter;
      if (dev_write(m_spp_fileHandler, sppData,SPPDATALENGTH) == 0)
      {
        LL_LOG_INFO(" Error in sending data!!!!!\r\n" );
      }
            else
      {
        datacounter++;
      }
            sppData[0] = datacounter;
      sppData[SPPDATALENGTH-1] = datacounter;
      if (dev_write(m_spp_fileHandler, sppData,SPPDATALENGTH) == 0)
      {
        LL_LOG_INFO(" Error in sending data!!!!!\r\n" );
      }
            else
      {
        datacounter++;
      }
      break;

    case SPP_EVT_CLOSE:
      LL_LOG_INFO(" ISEE_BLE_SPP_EVT_CLOSE!!!!!\r\n");
      mCounter = 0;
      m_ble_ioctrl_data.ble_datarate = BLE_DATARATE_LOW;
      dev_ioctl(m_ble_fileHandler, BLE_REQUEST_SET_DATARATE, (void *)(&m_ble_ioctrl_data));
      break;

    case SPP_EVT_ACK_RCVD:
      //dev_ioctl(m_spp_fileHandler, SPP_REQUEST_GET_AVAILABLE_BUFFER, &counter);
      //LL_LOG_INFO(" SPP_EVT_TX_COMPLETE!!!!! counter=%d\r\n", counter );
      if(mCounter == 0)
      {
        start = timer_count_get();
        LL_LOG_INFO(" start = %d us\r\n", start );
        mCounter ++;
      }
      else
      {
        if(mCounter == MEASURECOUNTER)
        {
          diff = timer_count_get() - start;
          if (diff == 0) diff = 1;
          uint32_t datarate = SPPDATALENGTH*8*mCounter*1000/diff;
          LL_LOG_INFO(" %d SPP data used %dus, datarate = %d kbps\r\n", mCounter, diff, datarate );
        }
        mCounter++;
      }
            sppData[0] = datacounter;
      sppData[SPPDATALENGTH-1] = datacounter;
      if (dev_write(m_spp_fileHandler, sppData,SPPDATALENGTH) == 0)
      {
        //LL_LOG_INFO(" Error in sending data!!!!!\r\n" );
      }
            else
      {
        datacounter++;
      }
            sppData[0] = datacounter;
      sppData[SPPDATALENGTH-1] = datacounter;
      if (dev_write(m_spp_fileHandler, sppData,SPPDATALENGTH) == 0)
      {
        //LL_LOG_INFO(" Error in sending data!!!!!\r\n" );
      }
            else
      {
        datacounter++;
      }
      break;

    case SPP_EVT_RX_RAWDATA:
      LL_LOG_INFO("spp raw data\r\n");
      for (int i = 0; i < SPP_RAWDATA_MAX_SIZE; i++)
      {
        LL_LOG_INFO("rawdata[%d]=%x\r\n", i, p_spp_cb_data->rawData[i]);
      }
      break;

    default:
        // No implementation needed.
      break;
    }
}
bool spp_init(void)
{
  LL_LOG_INFO(" spp_init entered");

  for(int i=0; i < SPPDATALENGTH; i++ )
  {
    sppData[i] = i;
  }

  m_spp_fileHandler = dev_open("SPP",0,0, NULL);
  if (m_spp_fileHandler == 0)
  {
    return false;
  }

  m_spp_ioctrl_data.spp_cb = spp_cb_handler;
  dev_ioctl(m_spp_fileHandler, SPP_REQUEST_REGISTER_CALLBACK, (void *)(&m_spp_ioctrl_data));

  m_ble_ioctrl_data.ble_datarate = BLE_DATARATE_LOW;

  return true;
}

static void sppAppTest_thread(void * arg)
{
  LL_LOG_INFO("SPP TEST APP THREAD EXECUTING...");

  /* Block for 500ms. */
  const TickType_t xDelay = 500 / portTICK_PERIOD_MS;

  ble_init();
  spp_init();

  for( ;; )
  {
     vTaskDelay( xDelay );
  }
}

/*!
* @breif a example app that uses a cli interface to control the system
*/
void startSPPApp()
{
  if (pdPASS != xTaskCreate(sppAppTest_thread, LL_THREAD_NAME_SPP, LL_THREAD_STACK_SIZE_SPP, NULL, LL_THREAD_PRIORITY_SPP, NULL))
  {
    APP_ERROR_HANDLER(NRF_ERROR_NO_MEM);
  }
}
