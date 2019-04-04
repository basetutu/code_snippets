
USEFULL MACROs

===============================

---------------------------------------------------------------------------------------------------
// Easy print with new line
#define PRINTF(text, ...) printf(text, ## __VA_ARGS__); printf("\n")

---------------------------------------------------------------------------------------------------

// To stringify something (in this case the __LINE__)
#define S(x) #x
#define S_(x) S(x)
#define S__LINE__ S_(__LINE__)
---------------------------------------------------------------------------------------------------

//--> overridable functions

// weak The weak attribute causes the declaration to be emitted as a weak symbol rather than a global.
// This is primarily useful in defining library functions that can be overridden in user code, though
// it can also be used with non-function declarations. Weak symbols are supported for ELF targets, and
// also for a.out targets when using the GNU assembler and linker.

#include <stdio.h>

void onKeypress(char c) __attribute__((weak))
{

}

// or

#define __weak   __attribute__((weak))

__weak void onKeypress(char c) __attribute__((weak))
{

}

---------------------------------------------------------------------------------------------------

#define SET_BIT(REG, BIT)     ((REG) |= (BIT))

#define CLEAR_BIT(REG, BIT)   ((REG) &= ~(BIT))

#define READ_BIT(REG, BIT)    ((REG) & (BIT))

#define CLEAR_REG(REG)        ((REG) = (0x0))

#define WRITE_REG(REG, VAL)   ((REG) = (VAL))

#define READ_REG(REG)         ((REG))

#define MODIFY_REG(REG, CLEARMASK, SETMASK)  WRITE_REG((REG), (((READ_REG(REG)) & (~(CLEARMASK))) | (SETMASK)))

#define POSITION_VAL(VAL)     (__CLZ(__RBIT(VAL)))


// These can also accept bit-masks instead of single bits (Must be of compatible bit length)
#define BITWISE_CLEAR_ALL_BITS(value)         (value) = (0UL)
#define BITWISE_CLEAR_MASK(value, flag)       (value) &= ~(flag)
#define BITWISE_SET_MASK(value, flag)         (value) |= (flag)
#define BITWISE_IS_MASK_SET(value, flag)      (value) & (flag)
#define BITWISE_CLEAR_FIELD(var, value, pos)  BITWISE_CLEAR_BIT(var, (value << pos))
#define BITWISE_SET_FIELD(var, value, pos)    BITWISE_CLEAR_BIT(var, (value << pos)); \
                                              BITWISE_SET_BIT(var, (value << pos))

---------------------------------------------------------------------------------------------------

// Delay constant (must be calibrated to the MCU CLK)
#define DELAY_MULTIPLIER                                  7116U // Calibrated on 64MHz CPU clock

#pragma GCC optimize("O0")
/**
  * @brief  Inserts a delay time in milliseconds. Max delay is 603564ms.
  * @param  nCount: specifies the delay time length.
  * @note   To get milliseconds, multiply by DELAY_MULTIPLIER.
  */
void delay_ms(uint32_t nCount)
{
  if(nCount > 603564)
  {
    nCount = 603564;
  }
  volatile uint32_t index = 0;
  for(index = nCount * DELAY_MULTIPLIER; index != 0; index--) { }
}
#pragma GCC reset_options

---------------------------------------------------------------------------------------------------

//__VA_ARGS__ usage method:

void termPrint(TermCommand * pCmd, const char *restrict format, ...) {
  int size = 0;
  va_list arglist;

  if (pCmd == NULL) {
    return;
  }
  if (format != NULL) {
    va_start(arglist, format);
    // Reduce size of buffer with 1 to add '\n' later
    size += vsnprintf(pCmd->printbuffer + size, sizeof(pCmd->printbuffer) - 1, format, arglist);
    va_end(arglist);
  } else {
    return;
  }
  pCmd->printbuffer[size] = '\n';     // Add a new line
  pCmd->len = size + 1;               // Indicate longer string

  // Print this byte by byte or else how (it's a string)
}


void termprintln(const char *restrict format, ...) {
  char printbuffer[130];
  int size = 0;
  va_list arglist;

  if (m_pCmd == NULL) {
    return;
  }
  if (format != NULL) {
    va_start(arglist, format);
    // Reduce size of buffer with 1 to add '\n' later
    size += vsnprintf(printbuffer, sizeof(printbuffer), format, arglist);
    va_end(arglist);
  } else {
    return;
  }
  // Send for printing
  termPrint(m_pCmd, printbuffer);
}

---------------------------------------------------------------------------------------------------

#define debugprintln(format, ...)                 debugprint(format, ##__VA_ARGS__);
#define termPrintln(pCmd, format, ...)            termPrint(pCmd, format, ##__VA_ARGS__);

---------------------------------------------------------------------------------------------------

xTaskHandle taskHandles[NUMBER_OF_TASKS] = {[0 ... (NUMBER_OF_TASKS-1)] =  NULL};

---------------------------------------------------------------------------------------------------

/// Get array element count
#define GET_ELEMENT_COUNT_OF_ARRAY(type)          (sizeof(type) / sizeof(type[0]))

---------------------------------------------------------------------------------------------------

!!!!!!!!!! The debugger.h module can be converted and used as a thread safe versatile FIFO buffer !!!!!!!!!!!!

---------------------------------------------------------------------------------------------------

// what does this do?
#pragma pack(1)

---------------------------------------------------------------------------------------------------

// To check whether a call is made from an interrupt
#define IsInterrupt                   (SCB->ICSR & SCB_ICSR_VECTACTIVE_Msk)

#include <cmsis_os.h>
/* Determine whether we are in thread mode or handler mode. */
static int inHandlerMode (void)
{
  return __get_IPSR() != 0;
}

---------------------------------------------------------------------------------------------------

/**
 * @brief Macros to include/exclude code depending on beta/release code.
 * @details RELEASECODE will only be present if #APPLICATION_REV_BRANCH > 0
 *          DEBUGCODE will only be present if #APPLICATION_REV_BRANCH == 0
 */
#if (BUILDTYPE_RELEASE == 1)
#define RELEASECODE(__releasearg__) \
  do { __releasearg__; } while(0);
#define DEBUGCODE(__debugarg__)
#define DEBUGINSERTSTATEMENT(__debugarg__)
#else
#define RELEASECODE(__releasearg__)
#define DEBUGCODE(__debugarg__)         \
    do { __debugarg__; } while(0);
// Use the below with more caution
#define DEBUGINSERTSTATEMENT(__debugarg__) __debugarg__
#endif

---------------------------------------------------------------------------------------------------

/*
 * @brief Check if we are debugging via JTAG/SWD.
 */
#define JTAG_ATTACHED() ((CoreDebug->DHCSR & CoreDebug_DHCSR_C_DEBUGEN_Msk) ? true : false)


// A programable breakpoint (DEBUGCODE is defined above)
#define BREAKPOINT    DEBUGCODE(                  \
                        if (JTAG_ATTACHED()) {    \
                          __ASM ("bkpt #01");     \
                        }                         \
                      )

---------------------------------------------------------------------------------------------------

// Converts a 32 bit register to a uint8_t to only read the byte at a certain position, being at position 0,1,2,3.
#define BYTE_OF(reg, byte_pos)                  (*( ((__IO uint8_t *)&reg) + byte_pos) )

---------------------------------------------------------------------------------------------------

// Runtime conditional code

/**
 * @brief Shall be used to write clean code. Can f.ex. be used to write
 *        small filtering code to exclude certain outputs or behavior.
 */
#define IF_CODE(condition, code_true, code_false)                 \
              if(condition) {                                     \
                code_true                                         \
              } else {                                            \
                code_false                                        \
              }

---------------------------------------------------------------------------------------------------

/**@brief Concatenates three parameters.
 *
 * It realizes two level expansion to make it sure that all the parameters
 * are actually expanded before gluing them together.
 *
 * @param p1 First parameter to concatenating
 * @param p2 Second parameter to concatenating
 * @param p3 Third parameter to concatenating
 *
 * @return Three parameters glued together.
 *         They have to create correct C mnemonic in other case
 *         preprocessor error would be generated.
 *
 * @sa CONCAT_2
 */
#define CONCAT_3(p1, p2, p3)  CONCAT_3_(p1, p2, p3)
/** Auxiliary macro used by @ref CONCAT_3 */
#define CONCAT_3_(p1, p2, p3) p1##p2##p3

---------------------------------------------------------------------------------------------------

/**@brief Concatenates two parameters.
 *
 * It realizes two level expansion to make it sure that all the parameters
 * are actually expanded before gluing them together.
 *
 * @param p1 First parameter to concatenating
 * @param p2 Second parameter to concatenating
 *
 * @return Two parameters glued together.
 *         They have to create correct C mnemonic in other case
 *         preprocessor error would be generated.
 *
 * @sa CONCAT_3
 */
#define CONCAT_2(p1, p2)      CONCAT_2_(p1, p2)
/** Auxiliary macro used by @ref CONCAT_2 */
#define CONCAT_2_(p1, p2)     p1##p2

---------------------------------------------------------------------------------------------------

// Print bits in printf()

#define NIBBLE_TO_BINARY_PATTERN "0b%c%c%c%c%c%c%c%c"

#define NIBBLE_TO_BINARY(byte) \
    (byte & 0x80 ? '1' : '0'), \
    (byte & 0x40 ? '1' : '0'), \
    (byte & 0x20 ? '1' : '0'), \
    (byte & 0x10 ? '1' : '0'), \
    (byte & 0x08 ? '1' : '0'), \
    (byte & 0x04 ? '1' : '0'), \
    (byte & 0x02 ? '1' : '0'), \
    (byte & 0x01 ? '1' : '0')

LL_LOG_DEBUG("NIBBLE: " NIBBLE_TO_BINARY_PATTERN, NIBBLE_TO_BINARY(0x55));

---------------------------------------------------------------------------------------------------

// System OFF mode of nRF52

int32_t ret = sd_power_system_off();
// get here if softdevice is not running
LL_LOG_INFO("sd_power_system_off() == %d", ret);
NRF_POWER->TASKS_LOWPWR = 1;
NRF_POWER->SYSTEMOFF = POWER_SYSTEMOFF_SYSTEMOFF_Enter;
while (TRUE){};

// To wake up from OFF mode using GPIO interrupt
nrf_gpio_cfg_sense_input(PIN_NUMBER, NRF_GPIO_PIN_PULLUP, NRF_GPIO_PIN_SENSE_LOW);

---------------------------------------------------------------------------------------------------

// Function pointer prototype
typedef void (*function)(int nbr);

---------------------------------------------------------------------------------------------------

// Bit fields (work also in union but should not be used!)

#include <stdio.h>
 
// A structure without forced alignment
struct test1
{
   unsigned int x: 5;
   unsigned int y: 8;
};
 
// A structure with forced alignment
struct test2
{
   unsigned int x: 5;
   unsigned int: 0;
   unsigned int y: 8;
};
 
int main()
{
   printf("Size of test1 is %d bytes\n", sizeof(struct test1));
   printf("Size of test2 is %d bytes\n", sizeof(struct test2));
   return 0;
}

Output:

Size of test1 is 4 bytes
Size of test2 is 8 bytes

---------------------------------------------------------------------------------------------------

// How to allocate a certain specific location in memory

#define ALLOCATED_SIZE                        10

typedef struct myLengthType { unsigned char x[ALLOCATED_SIZE]; } myLengthType;

#define MY_REGISTER (*(volatile myLengthType*)0x0000000Au)

// => This allocates 10 bytes at the location = 0x0000000A.
// => MY_REGISTER can be used as any variable.
// => &MY_REGISTER is pointing at the first byte and can be casted to anything else.
// example:
uint8_t* non_volatile_array = &MY_REGISTER;
non_volatile_array[0] = 0;

---------------------------------------------------------------------------------------------------

// Bit widths

bool , char , unsigned char , signed char , __int8          1 byte
__int16 , short , unsigned short , wchar_t , __wchar_t      2 bytes
float , __int32 , int , unsigned int , long , unsigned long 4 bytes
double , __int64 , long double , long long                  8 bytes

---------------------------------------------------------------------------------------------------

/**
 * @brief Get the first argument
 *
 * @param ... Arguments to select
 *
 * @return First argument or empty if no arguments are provided
 */
#define GET_VA_ARG_1(...) GET_VA_ARG_1_(__VA_ARGS__, ) // Make sure that also for 1 argument it works
#define GET_VA_ARG_1_(a1, ...) a1

/**
 * @brief Get all the arguments but the first one
 *
 * @param ... Arguments to select
 *
 * @return All arguments after the first one or empty if less than 2 arguments are provided
 */
#define GET_ARGS_AFTER_1(...) GET_ARGS_AFTER_1_(__VA_ARGS__, ) // Make sure that also for 1 argument it works
#define GET_ARGS_AFTER_1_(a1, ...) __VA_ARGS__


// Usage example:

#define NRF_LOG_INTERNAL_INIT(...)               \
        nrf_log_init(GET_VA_ARG_1(__VA_ARGS__),  \
                     GET_VA_ARG_1(GET_ARGS_AFTER_1(__VA_ARGS__, NRF_LOG_TIMESTAMP_DEFAULT_FREQUENCY)))

---------------------------------------------------------------------------------------------------

// Bit-field endianness

struct iphdr
  {
#if __BYTE_ORDER == __LITTLE_ENDIAN
    unsigned int ihl:4;
    unsigned int version:4;
#elif __BYTE_ORDER == __BIG_ENDIAN
    unsigned int version:4;
    unsigned int ihl:4;
#else
# error "Please fix <bits/endian.h>"
#endif
    u_int8_t tos;
    u_int16_t tot_len;
    u_int16_t id;
    u_int16_t frag_off;
    u_int8_t ttl;
    u_int8_t protocol;
    u_int16_t check;
    u_int32_t saddr;
    u_int32_t daddr;
    /*The options start here. */
  };


Most targets also support the #pragma scalar_storage_order directive which lays out structures and unions subsequently defined as the documented __attribute__ ((scalar_storage_order)).

#pragma scalar_storage_order big-endian sets the storage order of the scalar fields to big-endian.
#pragma scalar_storage_order little-endian sets the storage order of the scalar fields to little-endian.
#pragma scalar_storage_order default goes back to the endianness that was in effect when compilation started (see also command-line option -fsso-struct=endianness see C Dialect Options).

-fsso-struct=endianness
Set the default scalar storage order of structures and unions to the specified endianness. The accepted values are ‘big-endian’, ‘little-endian’ and ‘native’ for the native endianness of the target (the default). This option is not supported for C++.

Warning: the -fsso-struct switch causes GCC to generate code that is not binary compatible with code generated without it if the specified endianness is not the native endianness of the target.

---------------------------------------------------------------------------------------------------

// To make the struct as small as possible, use __attribute__((packed))
// Arrange the elements in order of size.

typedef struct buf_node {
    struct buf_node*      ptr_to_next;
    struct buf_node*      ptr_to_previous;
    uint16_t              length;       /**< The length of the fragment payload. */
    uint8_t               payload[20];  /**< The data of the fragment payload. */
    uint8_t               byte[];       // This is called a 'flexible array member' and must be in the end of the struct.
} __attribute__((packed)) bss_fragment_node_t;

---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------





