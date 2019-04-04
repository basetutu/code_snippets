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

#define LL_LOG_MODULE_NAME     "LINKED_LIST"
#include "LL_Log.h"



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
static ReturnCode_t linkedlist_get_index_internal(LinkedList_t* list, LLIST_CONTENT_DATA_TYPE* data,
                                                  unsigned char index, bool deallocate)
{
  LinkedList_node_t* removed_node;

  if(list->node_buffer_inst->initialized == FALSE)
  {
    LL_LOG_ERROR("Code_Fail_InvalidState");
    return Code_Fail_InvalidState;
  }

  if(list->length == 0)
  {
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
    removed_node = list->p_first_node;
    memcpy(data, &removed_node->data, sizeof(LLIST_CONTENT_DATA_TYPE));
    LL_LOG_DEBUG("Get from front (index = %d) (data = %d)", index, *data);

    if(deallocate)
    {
      LL_LOG_DEBUG("Removed the node from link!");
      list->p_first_node = removed_node->next_node; // The next node of the first node is now the first node
      list->p_first_node->prev_node = NULL; // No previous node (anchor)
    }
  }
  else if(index == list->length - 1) // Add it to the back (end) // TODO fixed here
  {
    removed_node = list->p_last_node;
    LL_LOG_DEBUG("last_node: data = %d", list->p_last_node->data);
    LL_LOG_DEBUG("removed_node: data = %d", removed_node->data);

    memcpy(data, &removed_node->data, sizeof(LLIST_CONTENT_DATA_TYPE));
    LL_LOG_INFO("Get from back (index = %d) (data = %d)", index, *data);

    if(deallocate)
    {
      LL_LOG_DEBUG("Removed the node from link!");
      list->p_last_node = removed_node->prev_node; // The previous node of the last node is now the last node
      list->p_last_node->next_node = NULL; // No next node (anchor)
    }
  }
  else // 1 <= index <= (length - 2)
  {
    unsigned char current_index;

    // Get the node at index
    // Search from which end? (front or back)
//    if(index < (list->length / 2))
    if(TRUE)
    {
      LL_LOG_DEBUG("get - Start counting from the front");
      // Start counting from the front
      current_index = 0;
      unsigned char diff = index - current_index;

      LL_LOG_DEBUG("index: %d, diff: %d", index, diff);

      removed_node = list->p_first_node;

      for (unsigned char i = 0; i < diff; ++i)
      {
        removed_node = removed_node->next_node;
        D(if(removed_node == NULL)
        {
          APP_ERROR_CHECK(TRUE);
        })
      }
    }
    else
    {
      LL_LOG_DEBUG("get - Start counting from the back");
      // Start counting from the back
      current_index = list->length - 1; // should have been list->length - 2 because of the 'else if' above
      unsigned char diff = current_index - index;

      LL_LOG_DEBUG("index: %d, diff: %d", index, diff);

      removed_node = list->p_last_node;

      for (unsigned char i = 0; i < diff; ++i)
      {
        removed_node = removed_node->prev_node;
        D(if(removed_node == NULL)
        {
          APP_ERROR_CHECK(TRUE);
        })
      }
    }

    // Remove node in the middle of the link
    memcpy(data, &removed_node->data, sizeof(LLIST_CONTENT_DATA_TYPE));
    LL_LOG_DEBUG("Get from index (index = %d) (data = %d)", index, *data);

    if(deallocate)
    {
      LL_LOG_DEBUG("Removed the node from link!");
      removed_node->prev_node->next_node = removed_node->next_node; // The previous node of the found node is now pointing the next node of the found node
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

unsigned char linkedlist_get_length(LinkedList_t* list)
{
  return list->length;
}


// TODO extract the delete functions out of the get index function and use it separately from the get_index function!
ReturnCode_t linkedlist_clear_all(LinkedList_t* list)
{
  ReturnCode_t ret = Code_Success;
  LLIST_CONTENT_DATA_TYPE data;
  unsigned char size = list->length;

  for (uint8_t i = 0; i < size; ++i)
  {
    ret = linkedlist_get_front(list, &data);
  }
  return ret;
}


ReturnCode_t linkedlist_print_all(LinkedList_t* list)
{
#if (LLIST_CONTENT_DATA_TYPE == uint8_t)
  LL_LOG_ERROR("Started printing!");

  ReturnCode_t ret = Code_Success;
  LLIST_CONTENT_DATA_TYPE data;

  for (uint8_t i = 0; i < list->length; ++i)
  {
    ret = linkedlist_get_index_internal(list, &data, i, FALSE);
    LL_LOG_INFO("Print() data: %d", data);
  }
  LL_LOG_WARNING("Finished printing!");
  return ret;

#else
  LL_LOG_DEBUG("Printing is not implemented for current type. (LLIST_CONTENT_DATA_TYPE)");
  return Code_Fail_NotImplemented;
#endif
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
ReturnCode_t linkedlist_set_index(LinkedList_t* list, LLIST_CONTENT_DATA_TYPE* data, unsigned char index)
{
  if(list->node_buffer_inst->initialized == FALSE)
  {
    LL_LOG_ERROR("Code_Fail_InvalidState");
    return Code_Fail_InvalidState;
  }

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
  if (list->length < 2)
  {
    // Only p_first_node is used
    if (index == 0)  // Add it front most (Initializes both ends (p_first_node, p_last_node) to point to each other)
    {
      node->data = *data;

      // Link the first and last node if this is the first node ever
      if (list->length != 0)
      {
        LL_LOG_INFO("Add to front (index = %d) (data = %d)", index, *data);

        node->next_node = list->p_first_node; // Point to the node that was the first.
        node->prev_node = NULL;               // since becoming the first node, we cannot point backwards.
        list->p_first_node->prev_node = node; // The last first node's previous node is now the new node.
        list->p_first_node = node;            // Anchor the new node

        list->p_last_node->next_node = NULL;  // Making sure that the last_node's next node is no longer pointing to the first_node
      }
      else // list->length == 0 (The first case to be used when placing the first node in the link !!!)
      {
        LL_LOG_DEBUG("Made both ends point towards each other! (initial node insertion)");
        // Make the new node point to itself in both directions and bind it to both ends of the link
        node->next_node = node;
        node->prev_node = node;
        list->p_first_node = node;
        list->p_last_node = node;
      }
    }
    else if (index == 1)  // Add it to the back (end) (initializes p_last_node)
    {
      LL_LOG_INFO("Add to back (length == 1) (index = %d) (data = %d)", index, *data);
      node->data = *data;

      node->next_node = NULL;               // since becoming the last node, we cannot point forward.
      node->prev_node = list->p_last_node;  // since becoming the first node, we cannot point backwards.
      list->p_last_node->next_node = node;  // The last last_node's next node is now the new node.
      list->p_last_node = node;             // Anchor the new node

      list->p_first_node->prev_node = NULL; // Making sure that the first_node's previous node is no longer pointing to the last_node
    }
  }
  else if (index == list->length)  // Add it to the back (end)
  {
    LL_LOG_INFO("Add to back (index = %d) (data = %d)", index, *data);
    node->data = *data;

    node->next_node = NULL;       // There is no next node
    node->prev_node = list->p_last_node;  // last node is now my previous node
    list->p_last_node->next_node = node;  // Last node will now point to the new node
    list->p_last_node = node;       // Anchor the new node
  }
  else // 1 <= index <= (length - 1)
  {
    LL_LOG_INFO("Add to index (index = %d) (data = %d)", index, *data);
    LinkedList_node_t* before_index_node;
    unsigned char current_index;

    // Search from which end? (front or back)
//    if(index < (list->length / 2)) TODO
    if(TRUE)
    {
      LL_LOG_DEBUG("set - Start counting from the front");
      // Start counting from the front
      current_index = 0;
      unsigned char diff = index - current_index; // redundant

      LL_LOG_DEBUG("index: %d, diff: %d", index, diff);

      before_index_node = list->p_first_node;

      for (unsigned char i = 0; i < diff; ++i)
      {
        before_index_node = before_index_node->next_node;
      }

      linkedlist_print_all(list);

    }
    else
    {
      LL_LOG_DEBUG("set - Start counting from the back");
      // Start counting from the back
      current_index = list->length - 1;
      unsigned char diff = current_index - index;

      before_index_node = list->p_last_node;

      for (unsigned char i = 0; i < diff; ++i)
      {
        before_index_node = before_index_node->prev_node;
      }
    }
    // Found the node that will be pushed towards the back at the index.

    // Inject node in the middle of the link
    node->data = *data;
    node->next_node = before_index_node;   // Make him be my next node (him = the found node at index)
    node->prev_node = before_index_node->prev_node;  // his previous node is now my previous node
    before_index_node->prev_node = node;  // Make me to his previous node (push him forward)
    if(node->prev_node != NULL)
    {
      node->prev_node->next_node = node;  // Make his previous node point to me
    }
  }
  // Node injected!
  list->length++;

//  linkedlist_print_all(list);

  return Code_Success;
}


/**
 * @brief Puts the data in front of the list.
 * @param list  The instance of the linked list.
 * @param data  The data to store.
 * @return ReturnCode_t
 */
ReturnCode_t linkedlist_set_to_front(LinkedList_t* list, LLIST_CONTENT_DATA_TYPE* data)
{
  return linkedlist_set_index(list, data, 0); // front
}


/**
 * @brief Puts the data in back of the list.
 * @param list  The instance of the linked list.
 * @param data  The data to store.
 * @return ReturnCode_t
 */
ReturnCode_t linkedlist_set_to_back(LinkedList_t* list, LLIST_CONTENT_DATA_TYPE* data)
{
  return linkedlist_set_index(list, data, list->length); // back
}


/***************************
 * GET FUNCTIONS
 **************************/

ReturnCode_t linkedlist_get_index(LinkedList_t* list, LLIST_CONTENT_DATA_TYPE* data, unsigned char index)
{
  return linkedlist_get_index_internal(list, data, index, TRUE); // index
}


ReturnCode_t linkedlist_get_front(LinkedList_t* list, LLIST_CONTENT_DATA_TYPE* data)
{
  return linkedlist_get_index_internal(list, data, 0, TRUE); // front
}


ReturnCode_t linkedlist_get_back(LinkedList_t* list, LLIST_CONTENT_DATA_TYPE* data)
{
  return linkedlist_get_index_internal(list, data, list->length - 1, TRUE); // back most
}


/***************************
 * PEEK FUNCTIONS
 **************************/

ReturnCode_t linkedlist_peek_index(LinkedList_t* list, LLIST_CONTENT_DATA_TYPE* data, unsigned char index)
{
  return linkedlist_get_index_internal(list, data, index, FALSE); // index
}


ReturnCode_t linkedlist_peek_front(LinkedList_t* list, LLIST_CONTENT_DATA_TYPE* data)
{
  return linkedlist_get_index_internal(list, data, 0, FALSE); // front
}


ReturnCode_t linkedlist_peek_back(LinkedList_t* list, LLIST_CONTENT_DATA_TYPE* data)
{
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
  list->p_last_node = NULL;
  list->max_filled = 0;
  list->length = 0;

  return Code_Success;
}

