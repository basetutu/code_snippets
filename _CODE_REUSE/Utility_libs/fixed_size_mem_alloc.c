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

#include "fixed_size_mem_alloc.h"

// Logging modules ///////////////////////////////////////////
#define NRF_LOG_MODULE_NAME         Fixed_ALOC
#include "nrf_log.h"
NRF_LOG_MODULE_REGISTER();
#include "LL_Log.h"
///////////////////////////////////////////////////////////////

/****************************************************************
 * CONFIGURATIONS
 ***************************************************************/

/****************************************************************
 * DEFINITIONS and CONSTANTS
 ***************************************************************/

/****************************************************************
 * TYPEDEFs
 ***************************************************************/

/****************************************************************
 * MACROS
 ***************************************************************/

/**
 * Counts number of elements inside the array
 */
#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))

/****************************************************************
 * EXTERNAL VARIABLES
 ***************************************************************/

/****************************************************************
 * FORWARD DECLARATIONS
 ***************************************************************/

/****************************************************************
 * STATIC VARIABLES
 ***************************************************************/

static bool m_initialized = FALSE;

#if (FSA_SIZE_SMALL_BUFFER_COUNT > 0)
static struct {
    uint16_t                buffers_in_use;
    uint16_t                last_allocated_index;
    fsa_buf_small_t         fsa_buf_elem[FSA_SIZE_SMALL_BUFFER_COUNT];
} m_buffer_small;
#endif

#if (FSA_SIZE_MEDIUM_BUFFER_COUNT > 0)
static struct {
    uint16_t                buffers_in_use;
    uint16_t                last_allocated_index;
    fsa_buf_medium_t        fsa_buf_elem              [FSA_SIZE_MEDIUM_BUFFER_COUNT];
} m_buffer_medium;
#endif

#if (FSA_SIZE_LARGE_BUFFER_COUNT > 0)
static struct {
    uint16_t                buffers_in_use;
    uint16_t                last_allocated_index;
    fsa_buf_large_t         fsa_buf_elem              [FSA_SIZE_LARGE_BUFFER_COUNT];
} m_buffer_large;
#endif


/****************************************************************
 * ENUMERATIONS
 ***************************************************************/

/****************************************************************
 * STATIC FUNCTIONS
 ***************************************************************/

/****************************************************************
 * STATIC HANDLER FUNCTIONS
 ***************************************************************/

/****************************************************************
 * STATIC INIT FUNCTIONS
 ***************************************************************/

/****************************************************************
 * API FUNCTIONS
 ***************************************************************/

bool fsa_free_buffer(FSA_size_t bsize, void* buf)
{
  if(buf == NULL)
  {
    APP_ERROR_CHECK(TRUE);
    return FALSE;
  }

  switch (bsize)
  {
    case FSA_SIZE_SMALL:
#if (FSA_SIZE_SMALL_BUFFER_COUNT > 0)
      m_buffer_small.buffers_in_use--;
      ((fsa_buf_small_t*)buf)->in_use = FALSE;
      return TRUE;
#endif
      break;

    case FSA_SIZE_MEDIUM:
#if (FSA_SIZE_MEDIUM_BUFFER_COUNT > 0)
      m_buffer_medium.buffers_in_use--;
      ((fsa_buf_medium_t*)buf)->in_use = FALSE;
      return NULL;
#endif
      break;

    case FSA_SIZE_LARGE:
#if (FSA_SIZE_LARGE_BUFFER_COUNT > 0)
      m_buffer_large.buffers_in_use--;
      ((fsa_buf_large_t*)buf)->in_use = FALSE;
      return NULL;
#endif
      break;

    default:
      APP_ERROR_CHECK(TRUE);
      break;
  }
  return NULL;
}

// TODO turn into MACRO
void* fsa_allocate_buffer(FSA_size_t bsize)
{
  switch (bsize)
  {
    case FSA_SIZE_SMALL:
#if (FSA_SIZE_SMALL_BUFFER_COUNT > 0)
      for (uint16_t i = 0; i < FSA_SIZE_SMALL_BUFFER_COUNT; ++i)
      {
        INCREMENT_AND_WIND_UP(m_buffer_small.last_allocated_index, FSA_SIZE_SMALL_BUFFER_COUNT);

        if(m_buffer_small.fsa_buf_elem[m_buffer_small.last_allocated_index].in_use == FALSE)
        {
          m_buffer_small.fsa_buf_elem[m_buffer_small.last_allocated_index].in_use = TRUE;  // Allocate
          m_buffer_small.buffers_in_use++;

          return &m_buffer_small.fsa_buf_elem[m_buffer_small.last_allocated_index];
        }
      }
#endif
      break;

    case FSA_SIZE_MEDIUM:
#if (FSA_SIZE_MEDIUM_BUFFER_COUNT > 0)
      for (uint16_t i = 0; i < FSA_SIZE_MEDIUM_BUFFER_COUNT; ++i)
      {
        INCREMENT_AND_WIND_UP(m_buffer_medium.last_allocated_index, FSA_SIZE_MEDIUM_BUFFER_COUNT);

        if(m_buffer_medium.fsa_buf_elem[m_buffer_medium.last_allocated_index].in_use == FALSE)
        {
          m_buffer_medium.fsa_buf_elem[m_buffer_medium.last_allocated_index].in_use = TRUE;  // Allocate
          m_buffer_medium.buffers_in_use++;

          return &m_buffer_medium.fsa_buf_elem[m_buffer_medium.last_allocated_index];
        }
      }
#endif
      break;

    case FSA_SIZE_LARGE:
#if (FSA_SIZE_LARGE_BUFFER_COUNT > 0)
      for (uint16_t i = 0; i < FSA_SIZE_LARGE_BUFFER_COUNT; ++i)
      {
        INCREMENT_AND_WIND_UP(m_buffer_large.last_allocated_index, FSA_SIZE_LARGE_BUFFER_COUNT);

        if(m_buffer_large.fsa_buf_elem[m_buffer_large.last_allocated_index].in_use == FALSE)
        {
          m_buffer_large.fsa_buf_elem[m_buffer_large.last_allocated_index].in_use = TRUE;  // Allocate
          m_buffer_large.buffers_in_use++;

          return &m_buffer_large.fsa_buf_elem[m_buffer_large.last_allocated_index];
        }
      }
#endif
      break;

    default:
      APP_ERROR_CHECK(TRUE);
      break;
  }
  LL_LOG_ERROR("No more memory - returning NULL");
  return NULL;
}


bool fsa_is_full(FSA_size_t bsize)
{
  bool ret = true;

  switch (bsize) {
    case FSA_SIZE_SMALL:
#if (FSA_SIZE_SMALL_BUFFER_COUNT > 0)
      ret = m_buffer_small.buffers_in_use == FSA_SIZE_SMALL_BUFFER_COUNT;
#else
      ret = TRUE;
#endif
      break;
    case FSA_SIZE_MEDIUM:
#if (FSA_SIZE_MEDIUM_BUFFER_COUNT > 0)
      ret = m_buffer_medium.buffers_in_use == FSA_SIZE_MEDIUM_BUFFER_COUNT;
#else
      ret = TRUE;
#endif
      break;
    case FSA_SIZE_LARGE:
#if (FSA_SIZE_LARGE_BUFFER_COUNT > 0)
      ret = m_buffer_large.buffers_in_use == FSA_SIZE_LARGE_BUFFER_COUNT;
#else
      ret = TRUE;
#endif
      break;
    default:
      // Crash
      APP_ERROR_CHECK(TRUE);
      break;
  }
  return ret;
}


uint16_t fsa_get_remaining_buffer_count(FSA_size_t bsize)
{
  switch (bsize)
  {
    case FSA_SIZE_SMALL:
#if (FSA_SIZE_SMALL_BUFFER_COUNT > 0)
      return FSA_SIZE_SMALL_BUFFER_COUNT - m_buffer_small.buffers_in_use;
#else
      return 0;
#endif
      break;
    case FSA_SIZE_MEDIUM:
      #if (FSA_SIZE_MEDIUM_BUFFER_COUNT > 0)
      return FSA_SIZE_MEDIUM_BUFFER_COUNT - m_buffer_medium.buffers_in_use;
#else
      return 0;
#endif
      break;
    case FSA_SIZE_LARGE:
      #if (FSA_SIZE_LARGE_BUFFER_COUNT > 0)
      return FSA_SIZE_LARGE_BUFFER_COUNT - m_buffer_large.buffers_in_use;
#else
      return 0;
#endif
      break;
    default:
      // Crash
      APP_ERROR_CHECK(TRUE);
      break;
  }
  return 0;
}


uint16_t fsa_get_buffer_length(FSA_size_t bsize)
{
  return bsize;
}


uint16_t fsa_get_buffer_count(FSA_size_t bsize)
{
  switch (bsize) {
    case FSA_SIZE_SMALL:
      return FSA_SIZE_SMALL_BUFFER_COUNT;
      break;
    case FSA_SIZE_MEDIUM:
      return FSA_SIZE_MEDIUM_BUFFER_COUNT;
      break;
    case FSA_SIZE_LARGE:
      return FSA_SIZE_LARGE_BUFFER_COUNT;
      break;
    default:
      APP_ERROR_CHECK(TRUE); // Crash. invalid
      break;
  }
  return 0;
}

// TODO make this module instance based so to avoid having all modules share the same memory pool
void fsa_init()
{
  if(m_initialized)
  {
    return;
  }

  // Construct buffer structures

#if (FSA_SIZE_SMALL_BUFFER_COUNT > 0)
  memset(&m_buffer_small, 0, sizeof(m_buffer_small));
#endif

#if (FSA_SIZE_MEDIUM_BUFFER_COUNT > 0)
  memset(&m_buffer_medium, 0, sizeof(m_buffer_medium));
#endif

#if (FSA_SIZE_LARGE_BUFFER_COUNT > 0)
  memset(&m_buffer_large, 0, sizeof(m_buffer_large));
#endif

  m_initialized = TRUE;
}

/****************************************************************
 * THREAD FUNCTION
 ***************************************************************/

