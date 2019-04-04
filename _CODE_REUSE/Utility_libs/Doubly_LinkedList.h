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

#ifndef __LINKEDLIST_H__
#define __LINKEDLIST_H__

#include "global_types_and_ReturnCode.h"


/****************************************************************
 * CONFIGURATIONS
 ***************************************************************/

#ifndef LLIST_CONTENT_DATA_TYPE
  #define LLIST_CONTENT_DATA_TYPE             uint8_t         /**< This defines the data type that the linked list can store. */
#endif // LLIST_CONTENT_DATA_TYPE

#ifndef LINKEDLIST_NODE_MAX_COUNT
  #define LINKEDLIST_NODE_MAX_COUNT           (64)            /**< Number of nodes that can be stored in the buffer. */
#endif // LINKEDLIST_NODE_MAX_COUNT

/**
 * Using types with more bit width allows for longer link length. (currently limited to 255)
 */
//#define LLIST_LENGHT_SUPP_TYPE                unsigned char   /**< This defines the type that internal variables use to store internal variables, like length. */

/****************************************************************
 * DEFINITIONS
 ***************************************************************/

#define LINKEDLIST_NODE_MAX_COUNT_SUPPORTED       255

#if LINKEDLIST_NODE_MAX_COUNT > LINKEDLIST_NODE_MAX_COUNT_SUPPORTED
#error "The number of nodes may not exceed the maximum supported node."
#endif

/****************************************************************
 * TYPEDEFs
 ***************************************************************/

typedef struct LinkedList_node_s LinkedList_node_t;

struct LinkedList_node_s
{
  bool                  node_occupied :1;  /**< Indicates whether this node is occupied in the buffer. */
  LinkedList_node_t*    prev_node;
  LinkedList_node_t*    next_node;
  LLIST_CONTENT_DATA_TYPE  data;
};

typedef struct{
  /**< The common node buffer for all LinkedList instances. Used for dynamic allocation. */
  LinkedList_node_t   buffer[LINKEDLIST_NODE_MAX_COUNT];
  /**< Last index used in search for finding an unoccupied node in the buffer. */
  unsigned char       last_index_searched;
#if USE_NODE_STATES
  /**< A low flag/bit means an empty node-element in that index. */
  unsigned char       node_state[INTEGER_DIV_WITH_CEILING(LINKEDLIST_NODE_MAX_COUNT, 8)];
#endif
  /**< States how many nodes are occupied. */
  unsigned char       occupied;         // Max support of nodes = 254 (255 = error code)
  bool                initialized;
} LinkedList_node_buffer_t;

typedef struct
{
  /**< The node buffer to allocate nodes from. */
  LinkedList_node_buffer_t* node_buffer_inst;
  /**< */
  LinkedList_node_t*        p_first_node;
  LinkedList_node_t*        p_last_node;
  /**< Used for statistics and diagnostic. */
  unsigned char             max_filled;       // Max support of nodes = 254 (255 = error code)
  unsigned char             length;           // Max support of nodes = 254 (255 = error code)
} LinkedList_t;

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

/// INIT FUNCTIONS
ReturnCode_t linkedlist_node_buffer_init(LinkedList_node_buffer_t* node_buffer);
ReturnCode_t linkedlist_init(LinkedList_t* list, LinkedList_node_buffer_t* node_buffer);
/// PEEK FUNCTIONS
ReturnCode_t linkedlist_peek_index(LinkedList_t* list, LLIST_CONTENT_DATA_TYPE* data, unsigned char index);
ReturnCode_t linkedlist_peek_front(LinkedList_t* list, LLIST_CONTENT_DATA_TYPE* data);
ReturnCode_t linkedlist_peek_back(LinkedList_t* list, LLIST_CONTENT_DATA_TYPE* data);
/// GET FUNCTIONS
ReturnCode_t linkedlist_get_index(LinkedList_t* list, LLIST_CONTENT_DATA_TYPE* data, unsigned char index);
ReturnCode_t linkedlist_get_front(LinkedList_t* list, LLIST_CONTENT_DATA_TYPE* data);
ReturnCode_t linkedlist_get_back(LinkedList_t* list, LLIST_CONTENT_DATA_TYPE* data);
/// SET FUNCTIONS
ReturnCode_t linkedlist_set_index(LinkedList_t* list, LLIST_CONTENT_DATA_TYPE* data, unsigned char index);
ReturnCode_t linkedlist_set_to_front(LinkedList_t* list, LLIST_CONTENT_DATA_TYPE* data);
ReturnCode_t linkedlist_set_to_back(LinkedList_t* list, LLIST_CONTENT_DATA_TYPE* data);

unsigned char linkedlist_get_length(LinkedList_t* list);
ReturnCode_t linkedlist_clear_all(LinkedList_t* list);
ReturnCode_t linkedlist_print_all(LinkedList_t* list);

/****************************************************************
 * THREAD FUNCTION
 ***************************************************************/

#endif // __LINKEDLIST_H__
