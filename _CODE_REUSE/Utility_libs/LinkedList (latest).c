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
 * This is a LinkedList implementation that does not need dynamic allocation and uses a node buffer
 * dedicated to this linked list and/or is shared with other linked lists.
 *
 * This linked list does not have a fixed maximum size, and the max size simply comes down to
 * how big the buffer is.
 * However, using a 'unsigned char' variable for the LLIST_LENGHT_SUPP_T, will set the maximum
 * length to 254 nodes.
 *
 * @attention A possible scenario for using the external node buffer, is to have a large 'heap' for nodes, and use this buffer for all linked lists.
 * However, doing so
 *
 * @date 20th June/2018 (created)
 * @author Saeed Ghasemi (external)
 */

#include "LinkedList.h"

#include "app_error.h" // TODO Remove when debugged

// FreeRTOS includes
#include "FreeRTOS.h"
#include "task.h"


// Logging modules ///////////////////////////////////////////
#define NRF_LOG_MODULE_NAME         LINKED_LIST
#include "nrf_log.h"
NRF_LOG_MODULE_REGISTER();
#define LOG_DEBUG_CODE              0   // 1 = keep debug codes
#include "LL_Log.h"
///////////////////////////////////////////////////////////////


/****************************************************************
 * CONFIGURATIONS
 ***************************************************************/

#define USE_NODE_STATES                     FALSE



/****************************************************************
 * TYPEDEFs
 ***************************************************************/






/****************************************************************
 * DEFINITIONS and MEMBER VARIABLES
 ***************************************************************/

//#define LLIST_DATA_SIZE                   sizeof(LLIST_CONTENT_DATA_T)

/****************************************************************
 * MACROS
 ***************************************************************/

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

/****************************************************************
 * ENUMERATIONS
 ***************************************************************/

/****************************************************************
 * STATIC FUNCTIONS
 ***************************************************************/

/* Function to get no of set bits in binary
   representation of positive integer n */
//static unsigned int count_set_bits(unsigned int n)
//{
//  unsigned int count = 0;
//  while (n)
//  {
//    count += n & 1;
//    n >>= 1;
//  }
//  return count;
//}

/* Function to get no of set bits in binary
   representation of positive integer n */
//static unsigned int count_cleared_bits(unsigned int n)
//{
//  unsigned int count = 0;
//  while (n)
//  {
//    count += !(n & 1U);
//    n >>= 1;
//  }
//  return count;
//}


static void linkedlist_deallocate_the_node(LinkedList_t* list, LinkedList_node_t* node)
{
#if USE_NODE_STATES
  // Deallocate the node from the node-buffer
  unsigned char index_of_first_node = node - list->node_buffer_inst->buffer; // Pointer arithmetic

  // Find the node_state byte in which the flag is located
  unsigned char flag_byte_index = INTEGER_DIV_WITH_CEILING(index_of_first_node, 8) - 1;

  D(if(flag_byte_index == 255) // TODO Why 255?
  {
    APP_ERROR_CHECK(TRUE);
  })

  D(if(flag_byte_index * 8 < index_of_first_node) // (TODO what?) Check to see if we have gone too far (testing)
  {
    APP_ERROR_CHECK(TRUE);
  })

  // Clear the node_state bit/flag to deallocate
  // (index_of_first_node - flag_byte_index * 8) --> bit number in the node_state byte to be cleared!
  list->node_buffer_inst->node_state[flag_byte_index] &= ~(0x01U << (index_of_first_node - flag_byte_index * 8));
#else
  node->node_occupied = FALSE;
  list->node_buffer_inst->occupied--;
#endif
}

/**
 * @brief Tries to find an empty buffer, if failed, will return false.
 * @param list
 * @param index
 * @param set_it_as_occupied
 * @return true if success.
 */
static bool linkedlist_find_empty_buffer(LinkedList_t* list, unsigned char* index, bool set_it_as_occupied)
{
  // Is buffer already full?
  if(list->node_buffer_inst->occupied == LINKEDLIST_NODE_MAX_COUNT)
  {
    LL_LOG_DEBUG("ERROR");
    return FALSE;
  }

#if USE_NODE_STATES

  // Find an unused node
  for (unsigned char i = 0; i < ARRAY_SIZE(list->node_buffer_inst->node_state); ++i)
  {
    if (list->node_buffer_inst->node_state[i] != 0xFFU) // Not all occupied
    {
      // Iterate through the bits
      for (unsigned char j = 0; j < sizeof(list->node_buffer_inst->node_state[0])*8; ++j)
      {
        if((list->node_buffer_inst->node_state[i] >> j) & 0x01U)
        {
          // This index is occupied
        }
        else
        {
          // This index is NOT occupied
          *index = i*8 + j; // Calculate true index
          // Allocate the node index
          if(set_it_as_occupied)
          {
            // Set it as occupied
            list->node_buffer_inst->node_state[i] |= (0x01U << j);
            list->node_buffer_inst->occupied++;
          }
          break;
        }
      }
    }
  }

  // Check to see if we are out of bounds
  if(*index > LINKEDLIST_NODE_MAX_COUNT - 1)
  {
    return FALSE;
  }
  return TRUE;

#else

  LinkedList_node_buffer_t* buf = list->node_buffer_inst;

  // Search for an unoccupied node
  for (unsigned char i = 0; i < LINKEDLIST_NODE_MAX_COUNT; ++i)
  {
    INCREMENT_AND_WIND_UP(buf->last_index_searched, LINKEDLIST_NODE_MAX_COUNT);

    if (buf->buffer[buf->last_index_searched].node_occupied == FALSE)
    {
      *index = buf->last_index_searched;
      // Allocate the node
      if (set_it_as_occupied)
      {
        // Set it as occupied
        buf->buffer[buf->last_index_searched].node_occupied = TRUE;
        buf->occupied++;
      }
      return TRUE;
    }
  }
  LL_LOG_DEBUG("ERROR");
  return FALSE;
#endif
}


static LinkedList_node_t* linkedlist_get_empty_node(LinkedList_t* list)
{
  unsigned char index_of_empty_node;
  if(!linkedlist_find_empty_buffer(list, &index_of_empty_node, TRUE)) // TRUE = set the buffer as occupied
  {
    LL_LOG_ERROR("Code_Fail_NULL");
    return NULL;
  }
  // Return the node pointer
  return &list->node_buffer_inst->buffer[index_of_empty_node];
}

/**
 * Special case get function for internal use.
 * @param list
 * @param data
 * @param index
 * @param deallocate
 * @return ReturnCode_t
 */
static ReturnCode_t linkedlist_get_index_internal(LinkedList_t* list, void* data,
                                                  unsigned char index, bool deallocate)
{
  LL_LOG_ENTER_FUNC();
  LL_LOG_DEBUG("index: %d", index);

  LinkedList_node_t* removed_node;

  if(list->node_buffer_inst->initialized == FALSE)
  {
    LL_LOG_ERROR("Code_Fail_InvalidState");
    return Code_Fail_InvalidState;
  }

  LL_LOG_DEBUG("Current length of the list is = %d", list->length);

  if(list->length == 0)
  {
    // Out of bounds (last index is list->length - 1)
    LL_LOG_ERROR("Code_Fail_InvalidRequest");
    return Code_Fail_InvalidRequest;
  }

  //list->length - 1 is the last occupied index. list->length is the next index to occupy in the 'back'
  if(index >= list->length)
  {
    // Out of bounds (last index is list->length - 1)
    LL_LOG_ERROR("Code_Fail_InvalidParameter");
    return Code_Fail_InvalidParameter;
  }



  // Find the node to get

  if(index == 0) // Take from front
  {
    LL_LOG_DEBUG("Get from front (index = %d)", index);

    removed_node = list->p_first_node;
    LL_LOG_DEBUG("removed_node: data = %d", removed_node->data);
    memcpy(data, &(removed_node->data), sizeof(void*));

//    LL_LOG_DEBUG("Get from front (index = %d) (data = %d)", index, *data);
//    LL_LOG_DEBUG("Get from front (index = %d)", index);

    LL_LOG_DEBUG("removed_node: %p", removed_node);
    LL_LOG_DEBUG("removed_node.next: %p", removed_node->next_node);
    LL_LOG_DEBUG("removed_node.data: %d", removed_node->data);
    LL_LOG_DEBUG("-------------");

    if(deallocate)
    {
      LL_LOG_DEBUG("Removed the node from link!");
      list->p_first_node = removed_node->next_node; // The next node of the first node is now the first node
      list->p_first_node->prev_node = NULL; // No previous node (anchor)
    }
  }
  else if (index == list->length - 1)  // Add it to the back (end) // TODO fixed here
  {
    LL_LOG_DEBUG("Get from back (index = %d)", index);

    removed_node = list->p_first_node;

    LL_LOG_DEBUG("removed_node: %p", removed_node);
    LL_LOG_DEBUG("removed_node.next: %p", removed_node->next_node);
    LL_LOG_DEBUG("removed_node.data: %d", removed_node->data);
    LL_LOG_DEBUG("-------------");

    unsigned char size = list->length;

    for (uint8_t i = 0; i < size; ++i)
    {
      LL_LOG_DEBUG("Go to next node: i = %d", i);

      if (removed_node != NULL)
      {
//        LL_LOG_DEBUG("removed_node is NOT NULL");

        if (removed_node->next_node != NULL)
        {
          //    while(1);
          removed_node = removed_node->next_node;
        }
        else
        {
//          LL_LOG_DEBUG("next is NULL");
        }
      }
      else
      {
//        LL_LOG_DEBUG("removed_node is NULL");
      }

    }

    LL_LOG_DEBUG("removed_node: data = %d", removed_node->data);
    memcpy(data, &(removed_node->data), sizeof(void*));
//    LL_LOG_DEBUG("Get from index (index = %d) (data = %d)", index, *data);
//    LL_LOG_DEBUG("Get from index (index = %d)", index);

//    LL_LOG_DEBUG("removed_node: %p", removed_node);
//    LL_LOG_DEBUG("removed_node.next: %p", removed_node->next_node);
//    LL_LOG_DEBUG("removed_node.data: %d", removed_node->data);
//    LL_LOG_DEBUG("-------------");

    if (deallocate)
    {
      LL_LOG_DEBUG("Removed the last node from link!");
      removed_node->prev_node->next_node = NULL;
    }
  }
  else  // 1 <= index <= (length - 2)
  {
    LL_LOG_DEBUG("Get from index (index = %d)", index);

    removed_node = list->p_first_node;

//    LL_LOG_DEBUG("removed_node: %p", removed_node);
//    LL_LOG_DEBUG("removed_node.next: %p", removed_node->next_node);
//    LL_LOG_DEBUG("removed_node.data: %d", removed_node->data);
//    LL_LOG_DEBUG("-------------");


    for (unsigned char i = 0; i < index; ++i)
    {
      removed_node = removed_node->next_node;
      D(if(removed_node == NULL)
      {
        APP_ERROR_CHECK(TRUE);
      })
    }

    LL_LOG_DEBUG("removed_node: data = %d", removed_node->data);
    // Remove node in the middle of the link
    memcpy(data, &removed_node->data, sizeof(void*));
//    LL_LOG_DEBUG("Get from index (index = %d) (data = %d) (removed_node->data = %d)", index, *data, removed_node->data);
//    LL_LOG_DEBUG("Get from index (index = %d) (removed_node->data = %d)", index, removed_node->data);

//    LL_LOG_DEBUG("removed_node: %p", removed_node);
//    LL_LOG_DEBUG("removed_node.next: %p", removed_node->next_node);
//    LL_LOG_DEBUG("removed_node.data: %d", removed_node->data);
//    LL_LOG_DEBUG("-------------");

    if (deallocate)
    {
      LL_LOG_DEBUG("Removed the node from link!");
      removed_node->prev_node->next_node = removed_node->next_node;  // The previous node of the found node is now pointing the next node of the found node
    }
  }

//  LL_LOG_DEBUG("length: %d, buffer_occupied: %d, data: %d, index: %d",
//      list->length, list->node_buffer_inst->occupied, *data, index);

  if(deallocate)
  {
    LL_LOG_DEBUG("Unallocated the node!");
    // Deallocate the last node
    linkedlist_deallocate_the_node(list, removed_node);
    list->length--;
  }
  return Code_Success;
}


/****************************************************************
 * STATIC HANDLER FUNCTIONS
 ***************************************************************/

/****************************************************************
 * STATIC INIT FUNCTIONS
 ***************************************************************/

/****************************************************************
 * API FUNCTIONS
 ***************************************************************/

/**
 * @brief Returns the current length of the linkedlist.
 * @attention Make sure not to use this in a for-loop when using one of the get functions in the for-loop!
 * @param list  The linkedlist instance pointer.
 * @return The length of the list.
 */
unsigned char linkedlist_get_length(LinkedList_t* list)
{
  return list->length;
}


ReturnCode_t linkedlist_clear_all(LinkedList_t* list)
{
  LL_LOG_INFO("Clearing... Length: %d", list->length);
  ReturnCode_t ret = Code_Success;
  void* data;
  unsigned char size = list->length;

  for (unsigned char i = 0; i < size; ++i)
  {
    LL_LOG_DEBUG("Clearing index %d", i);
    ret = linkedlist_get_front(list, &data);
  }

  LL_LOG_INFO("Clearing DONE! Length: %d", list->length);
  if(ret != Code_Success)
  {
    LL_LOG_ERROR("ERROR");
  }
  return ret;
}


ReturnCode_t linkedlist_print_all(LinkedList_t* list)
{
  LL_LOG_INFO("Started printing! -------------------------------------------------");
  LL_LOG_DEBUG("Current length is = %d", list->length);

  ReturnCode_t ret = Code_Success;
  void* data;
  unsigned char size = list->length;

  for (uint8_t i = 0; i < size; ++i)
  {
    ret = linkedlist_peek_index(list, &data, i);
    LL_LOG_DEBUG("Print() - data: %d, index: %d", data, i);
  }
  LL_LOG_DEBUG("Finished printing! -------------------------------------------------");
  return ret;
}


/***************************
 * SET FUNCTIONS
 **************************/

/**
 * @brief Puts the data at the indicated index in the list.
 *
 * @param list  The instance of the linked list.
 * @param data  The data to store.
 * @return ReturnCode_t
 */
ReturnCode_t linkedlist_set_index(LinkedList_t* list, void* data, unsigned char index)
{
  LL_LOG_ENTER_FUNC();
//  LL_LOG_DEBUG("index: %d, data: %d", index, *data);
//  LL_LOG_DEBUG("index: %d", index);

  if(list->node_buffer_inst->initialized == FALSE)
  {
    LL_LOG_ERROR("Code_Fail_InvalidState");
    return Code_Fail_InvalidState;
  }

  LL_LOG_DEBUG("length = %d, set-index = %d", list->length, index);

  //list->length - 1 is the last occupied index. list->length is the next index to occupy in the 'back'
  if(index > list->length)
  {
    // Out of bounds (the index is further than the 'back' of the linked list!)
    LL_LOG_ERROR("Code_Fail_InvalidParameter");
    return Code_Fail_InvalidParameter;
  }

  // Allocate an empty node
  LinkedList_node_t* node = linkedlist_get_empty_node(list);
  if(node == NULL)
  {
    LL_LOG_ERROR("Code_Fail_NoMemory");
    return Code_Fail_NoMemory;
  }

  // Inject the new node
  if (index == 0)  // Add it front most (Initializes both ends (p_first_node, p_last_node) to point to each other)
  {
//    node->data = *data;
    memcpy(&node->data, data, sizeof(void*));

//    LL_LOG_DEBUG("Add to front (index = %d) (data = %d)", index, *data);
//    LL_LOG_DEBUG("Add to front (index = %d)", index);

    node->next_node = list->p_first_node;  // Point to the node that was the first.
    node->prev_node = NULL;               // since becoming the first node, we cannot point backwards.
    list->p_first_node->prev_node = node;  // The last first node's previous node is now the new node.
    list->p_first_node = node;            // Anchor the new node

//    LL_LOG_DEBUG("first_node: %p", (uint32_t)list->p_first_node);
//    LL_LOG_DEBUG("first_node.next: %p", (uint32_t)list->p_first_node->next_node);
//    LL_LOG_DEBUG("first_node.data: %d", list->p_first_node->data);
//    LL_LOG_DEBUG("-------------");

//    LL_LOG_DEBUG("node: %p", (uint32_t)node);
//    LL_LOG_DEBUG("node.next: %p", (uint32_t)node->next_node);
//    LL_LOG_DEBUG("node.data: %d", node->data);
//    LL_LOG_DEBUG("-------------");

  }
  else if (index == list->length)  // Add it to the back (end)
  {
//    LL_LOG_DEBUG("Add to back (index = %d) (data = %d) (length = %d)", index, *data, list->length);
    LL_LOG_DEBUG("Add to back (index = %d) (length = %d)", index, list->length);

    LinkedList_node_t* before_index_node = list->p_first_node;

    LL_LOG_DEBUG("before_index_node: %p", before_index_node);
    LL_LOG_DEBUG("before_index_node.next: %p", before_index_node->next_node);
    LL_LOG_DEBUG("before_index_node.data: %d", before_index_node->data);
    LL_LOG_DEBUG("-------------");


    for (unsigned char i = 0; i < index - 1; ++i) // -1 because TODO evaluate -1
    {
      if (before_index_node != NULL)  // && before_index_node->next_node != NULL)
      {
        if (before_index_node->next_node != NULL)
        {
//    while(1);
          before_index_node = before_index_node->next_node;
        }
        else
        {
          LL_LOG_DEBUG("next is NULL");
        }

        D(if (before_index_node == NULL)
        {
          LL_LOG_ERROR("before_index_node is NULL");
          APP_ERROR_CHECK(TRUE);
        }else{
//          LL_LOG_DEBUG("before_index_node is NOT NULL");
        })
      }
      else
      {
        LL_LOG_DEBUG("before_index_node is NULL");
      }

      LL_LOG_DEBUG("before_index_node: %p", before_index_node);
      LL_LOG_DEBUG("before_index_node.next: %p", before_index_node->next_node);
      LL_LOG_DEBUG("before_index_node.data: %d", before_index_node->data);
      LL_LOG_DEBUG("-------------");
    }

    D(if(before_index_node->next_node != NULL)
    {
      APP_ERROR_CHECK(TRUE);
    }else{
//      LL_LOG_DEBUG("next still NULL");
    })


    // Inject node in the middle of the link
//    node->data = *data;
    memcpy(&node->data, data, sizeof(void*));
    node->next_node = NULL;   // Make him be my next node (him = the found node at index)
    node->prev_node = before_index_node;  // his previous node is now my previous node
    before_index_node->next_node = node;  // Make me to his previous node (push him forward)
//    while(1);
  }
  else  // 1 <= index <= (length - 1)
  {
//    LL_LOG_DEBUG("Add to index (index = %d) (data = %d)", index, *data);
//    LL_LOG_DEBUG("Add to index (index = %d)", index);

    LinkedList_node_t* before_index_node;

    before_index_node = list->p_first_node;

//    LL_LOG_DEBUG("before_index_node: %p", before_index_node);
//    LL_LOG_DEBUG("before_index_node.next: %p", before_index_node->next_node);
//    LL_LOG_DEBUG("before_index_node.data: %d", before_index_node->data);
//    LL_LOG_DEBUG("-------------");


    for (unsigned char i = 0; i < index; ++i)
    {
      before_index_node = before_index_node->next_node;
      if (before_index_node == NULL)
      {
        APP_ERROR_CHECK(TRUE);
      }
    }

    // Found the node that will be pushed towards the back at the index.

    // Inject node in the middle of the link
//    node->data = *data;
    memcpy(&node->data, data, sizeof(void*));
    node->next_node = before_index_node;   // Make him be my next node (him = the found node at index)
    node->prev_node = before_index_node->prev_node;  // his previous node is now my previous node
    before_index_node->prev_node = node;  // Make me to his previous node (push him forward)
    if (node->prev_node != NULL)
    {
      node->prev_node->next_node = node;  // Make his previous node point to me
    }
  }
  // Node injected!
  list->length++;
  return Code_Success;
}


/**
 * @brief Puts the data in front of the list.
 * @param list  The instance of the linked list.
 * @param data  The data to store.
 * @return ReturnCode_t
 */
ReturnCode_t linkedlist_set_to_front(LinkedList_t* list, void* data)
{
  LL_LOG_INFO("linkedlist_set_to_front()");
  return linkedlist_set_index(list, data, 0); // front
}


/**
 * @brief Puts the data in back of the list.
 * @param list  The instance of the linked list.
 * @param data  The data to store.
 * @return ReturnCode_t
 */
ReturnCode_t linkedlist_set_to_back(LinkedList_t* list, void* data)
{
  LL_LOG_INFO("linkedlist_set_to_back()");
  return linkedlist_set_index(list, data, list->length); // back
}


/***************************
 * GET FUNCTIONS
 **************************/

ReturnCode_t linkedlist_get_index(LinkedList_t* list, void* data, unsigned char index)
{
  LL_LOG_INFO("linkedlist_get_index()");
  return linkedlist_get_index_internal(list, data, index, TRUE); // index
}


ReturnCode_t linkedlist_get_front(LinkedList_t* list, void* data)
{
  LL_LOG_INFO("linkedlist_get_front()");
  return linkedlist_get_index_internal(list, data, 0, TRUE); // front
}


ReturnCode_t linkedlist_get_back(LinkedList_t* list, void* data)
{
  LL_LOG_INFO("linkedlist_get_back()");
  return linkedlist_get_index_internal(list, data, list->length - 1, TRUE); // back most
}


/***************************
 * PEEK FUNCTIONS
 **************************/

ReturnCode_t linkedlist_peek_index(LinkedList_t* list, void* data, unsigned char index)
{
  LL_LOG_INFO("linkedlist_peek_index()");
  return linkedlist_get_index_internal(list, data, index, FALSE); // index
}


ReturnCode_t linkedlist_peek_front(LinkedList_t* list, void* data)
{
  LL_LOG_INFO("linkedlist_peek_front()");
  return linkedlist_get_index_internal(list, data, 0, FALSE); // front
}


ReturnCode_t linkedlist_peek_back(LinkedList_t* list, void* data)
{
  LL_LOG_INFO("linkedlist_peek_back()");
  return linkedlist_get_index_internal(list, data, list->length - 1, FALSE); // back
}


/****************************************************************
 * INIT FUNCTION
 ***************************************************************/

/**
 * Initializes the node buffer instance.
 * @param node_buffer
 * @return
 */
ReturnCode_t linkedlist_node_buffer_init(LinkedList_node_buffer_t* node_buffer)
{
  if(node_buffer->initialized == TRUE)
  {
    LL_LOG_WARNING("The buffer is already initialized!");
    if(node_buffer->occupied != 0)
    {
      LL_LOG_WARNING("The buffer contains data!");
    }
  }
  memset(node_buffer->buffer, 0, sizeof(node_buffer->buffer));
#if USE_NODE_STATES
  memset(node_buffer->node_state, 0, sizeof(node_buffer->node_state)); // Set all to empty
#endif
  node_buffer->occupied = 0; // All nodes are unused!
  node_buffer->initialized = TRUE;

  return Code_Success;
}

/**
 * Initializes the linked list instance. the node buffer instance must have been initialized already.
 * @param list
 * @param node_buffer
 * @return
 */
ReturnCode_t linkedlist_init(LinkedList_t* list, LinkedList_node_buffer_t* node_buffer)
{
  if(node_buffer->initialized == FALSE)
  {
    LL_LOG_ERROR("Code_Fail_InvalidParameter");
    return Code_Fail_InvalidParameter;
  }
  list->node_buffer_inst = node_buffer;
  list->p_first_node = NULL;
//  list->p_last_node = NULL;
  list->max_filled = 0;
  list->length = 0;

  return Code_Success;
}

