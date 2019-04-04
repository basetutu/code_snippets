
=========================================================================================================================

# CRITICAL SECTION IMPLEMENTATION IN FreeRTOS

Critical sections are entered by calling taskENTER_CRITICAL(), and subsequently exited by calling taskEXIT_CRITICAL().

The taskENTER_CRITICAL() and taskEXIT_CRITICAL() macros provide a basic critical section implementation that works by
simply disabling interrupts, either globally, or up to a specific interrupt priority level. See the vTaskSuspendAll()
and vTaskResumeAll() RTOS API function for information on creating a critical section without disabling interrupts.

vTaskSuspendAll() suspends the scheduler without disabling interrupts. Context switches will not occur while the scheduler
is suspended. RTOS ticks that occur while the scheduler is suspended will be held pending until the scheduler has been
unsuspended using a call to xTaskResumeAll().

API functions that have the potential to cause a context switch (for example, vTaskDelayUntil(), xQueueSend(), etc.) must
not be called while the scheduler is suspended.

=========================================================================================================================

# TODO
# Implement a class that can replace the xQueueCreate() API functions of the FreeRTOS that would allow seeking in the
# tasks for quickly determining whether a task that is being pushed in the queue using xQueueSend() is already queued and
# reject it.

=========================================================================================================================

