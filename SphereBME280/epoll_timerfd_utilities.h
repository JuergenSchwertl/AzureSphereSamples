#pragma once
#include <time.h>
#include <sys/epoll.h>
#include <unistd.h>

/// Forward declaration of the data type passed to the handlers.
struct EventData;

///  @brief Function signature for event handlers.
/// 
///  @param eventData The provided event data
typedef void (*EventHandler)(struct EventData *eventData);

///  @brief Contains persistent context data for epoll events. When an event is registered with 
/// RegisterEventHandlerToEpoll, supply a pointer to an instance of this struct.  
/// The pointer must remain valid for as long as the event is active.
typedef struct EventData {
    ///  @brief Function which is called when the event occurs.
    EventHandler eventHandler;
    ///  @brief  The file descriptor that generated the event.
    int fd;
    /// @brief  Event specific context
    void * context;
} EventData;

///  @brief  Creates an epoll instance.
/// 
/// @return A valid epoll file descriptor on success, or -1 on failure
int CreateEpollFd(void);

/// @brief Registers an event with the epoll instance. If the event was previously added, that
///     registration will be modified to match the new mask.
/// 
/// @param fdEpoll Epoll file descriptor
/// @param eventFd File descriptor generating events for the epoll
/// @param persistentEventData Persistent event data structure. This must stay in memory
/// until the handler is removed from the epoll.
/// @param epollEventMask Bit mask for the epoll event type
/// @return 0 on success, or -1 on failure
int RegisterEventHandlerToEpoll(int fdEpoll, int eventFd, EventData *persistentEventData,
                                const uint32_t epollEventMask);

/// @brief  Unregisters an event with the epoll instance.
/// 
/// @param fdEpoll Epoll file descriptor 
/// @param eventFd File descriptor generating events for the epoll
/// @return 0 on success, or -1 on failure
int UnregisterEventHandlerFromEpoll(int fdEpoll, int eventFd);

/// @brief Disarms a timer (setting .it_interval and .it_value to null period)
///
/// @param timerFd Timer file descriptor
int DisarmTimerFd(int timerFd);

///  @brief  Sets the period of a timer (sets .it_interval).
/// 
/// @param timerFd Timer file descriptor
/// @param period The new period
/// @returns 0 on success, or -1 on failure
int SetTimerFdToPeriod(int timerFd, const struct timespec *period);

///  @brief  Sets a timer to fire once only, after a duration specified in milliseconds.
/// 
/// @param timerFd Timer file descriptor
/// @param expiry The time elapsed before it expires once
/// @return 0 on success, or -1 on failure
int SetTimerFdToSingleExpiry(int timerFd, const struct timespec *expiry);

///  @brief  Consumes an event by reading from the timer file descriptor.
///     If the event is not consumed, then it will immediately recur.
/// 
/// @param timerFd Timer file descriptor
/// @return 0 on success, or -1 on failure
int ConsumeTimerFdEvent(int timerFd);

///  @brief  Creates a timerfd and adds it to an epoll instance.
/// 
/// @param fdEpoll Epoll file descriptor
/// @param period The timer period
/// @param persistentEventData Persistent event data structure. This must stay in memory
/// until the handler is removed from the epoll.
/// @param epollEventMask Bit mask for the epoll event type
/// @return A valid timerfd file descriptor on success, or -1 on failure
int CreateTimerFdAndAddToEpoll(int fdEpoll, const struct timespec *period,
                               EventData *persistentEventData, const uint32_t epollEventMask);

///  @brief Waits for an event on an epoll instance and triggers the handler.
/// 
/// @param fdEpoll 
///     Epoll file descriptor which was created with <see cref="CreateEpollFd" />.
/// 
/// @return 0 on success, or -1 on failure
int WaitForEventAndCallHandler(int fdEpoll);

///  @brief  Closes a file descriptor and prints an error on failure.
/// 
/// @param fd File descriptor to close
/// @param name File descriptor name to use in error message
void CloseFdAndPrintError(int fd, const char *name);