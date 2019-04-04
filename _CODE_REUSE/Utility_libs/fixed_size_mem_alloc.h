/* TODO Update license */
/**********************************************************************
 * Copyright (c) Sigma Connectivity AB
 * All Rights Reserved 2017.
 *
 * This file may not be distributed without the file ’license.txt’.
 * This file is subject to the terms and conditions defined in file
 * ’license.txt’, which is part of this source code package.
 *********************************************************************/

/**
 * This function allows for the dynamic allocation of fixed size memory blocks,
 * which can mitigate the memory fragmentation issue seen with malloc().
 *
 * @date 7th Oct/2018 (created)
 * @author Saeed Ghasemi (external)
 */

#ifndef __FIXED_SIZE_MALLOC_H__
#define __FIXED_SIZE_MALLOC_H__

#include <stdbool.h>
#include <stdint.h>

/****************************************************************
 * CONFIGURATIONS
 ***************************************************************/

#define FSA_OUT_OF_BOUNDS_GUARD               0 /* 20 bytes (recommended), otherwise we might crash before we detect it. */
// TODO saeed: out of bounds detection is not yet implemented
// The idea is to initialize all guard bytes to 0xFF and check periodically for whether they have been changed.

/**
 * @brief Used to indicate which buffer is requested.
 */
typedef enum
{
  FSA_SIZE_SMALL    = 5 + FSA_OUT_OF_BOUNDS_GUARD,
  FSA_SIZE_MEDIUM   = 32 + FSA_OUT_OF_BOUNDS_GUARD,
  FSA_SIZE_LARGE    = 40 + FSA_OUT_OF_BOUNDS_GUARD,
} FSA_size_t;

#define FSA_SIZE_SMALL_BUFFER_COUNT           (1)   /**< Statically allocated memory block count. */
#define FSA_SIZE_MEDIUM_BUFFER_COUNT          (32)  /**< Statically allocated memory block count. */
#define FSA_SIZE_LARGE_BUFFER_COUNT           (1)   /**< Statically allocated memory block count. */

// Configuration checks

#if (FSA_SIZE_SMALL_BUFFER_COUNT > 65535) || (FSA_SIZE_MEDIUM_BUFFER_COUNT > 65535) || (FSA_SIZE_LARGE_BUFFER_COUNT > 65535)
#error "Buffer count may not be larger than 65535."
#endif

#if (FSA_SIZE_SMALL > 65535) || (FSA_SIZE_MEDIUM > 65535) || (FSA_SIZE_LARGE > 65535)
#error "Buffer length may not be larger than 65535."
#endif

/****************************************************************
 * DEFINITIONS, TYPEDEF and CONSTANTS
 ***************************************************************/

/**
 * @brief A structure that can represent all the other buffer structures.
 */
typedef struct
{
    bool      in_use;
    uint8_t   buf[];    // Flexible array member
} __attribute__((packed)) fsa_buf_t;




typedef struct
{
    uint8_t   buf[FSA_SIZE_SMALL];
    uint16_t  ID;                     /** the Id of the allocating function. In case of out of bounds operation, it is possible to detect where the issue is. */
    bool      in_use;
} __attribute__((packed)) fsa_buf_small_t;

typedef struct
{
    uint8_t   buf[FSA_SIZE_MEDIUM];
    bool      in_use;
} __attribute__((packed)) fsa_buf_medium_t;

typedef struct
{
    uint8_t   buf[FSA_SIZE_LARGE];
    bool      in_use;
} __attribute__((packed)) fsa_buf_large_t;

/****************************************************************
 * MACROS
 ***************************************************************/

/****************************************************************
 * EXTERNAL VARIABLES
 ***************************************************************/

/****************************************************************
 * ENUMERATIONS
 ***************************************************************/

/****************************************************************
 * API FUNCTIONS
 ***************************************************************/

void        fsa_init(void);
void*       fsa_allocate_buffer(FSA_size_t bsize);
bool        fsa_free_buffer(FSA_size_t bsize, void* buf);
bool        fsa_is_full(FSA_size_t bsize);
uint16_t    fsa_get_remaining_buffer_count(FSA_size_t bsize);
uint16_t    fsa_get_buffer_length(FSA_size_t bsize);
uint16_t    fsa_get_buffer_count(FSA_size_t bsize);

/****************************************************************
 * THREAD FUNCTION
 ***************************************************************/

#endif // __FIXED_SIZE_MALLOC_H__
