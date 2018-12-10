#include <errno.h>
#include <stdbool.h>
#include <string.h>
#include <unistd.h>
#include <sys/epoll.h>

#include "applibs_versions.h"
#include <applibs/uart.h>
#include <applibs/gpio.h>
#include <applibs/log.h>

#include "mt3620_rdb.h"
#include "UART_utilities.h"
#include "epoll_timerfd_utilities.h"

/// <summary>
/// UART_utilities.c demonstrates how to use Epoll to handle UART events 
/// It collects UART data in a 'ring'-buffer until a full line is received
/// and invokes the given callback to handle the UART string. 
/// The sample opens UART ISU0 with a baud rate of 9600 Baud.
///</summary>

// Uncomment following line to get verbose output for UART received data fragments
//#define VERBOSE 1

///<summary>UART file descriptor</summary>
static int m_UartFd = -1;

///<summary>UART Id</summary>
static UART_Id m_UartId = -1;

///<summary>Address of line received handler</summary>
static uart_line_received_handler_t m_HandleLineReceived = NULL;

///<summary>static receive buffer for UART</summary>
static char receiveBuffer[RECEIVE_BUFFER_SIZE];

///<summary>Number of bytes in ring buffer</summary>
static size_t nBytesInBuffer = 0;

/// <summary>
///     Handle UART event: read incoming data fragments into 'ring'-buffer, extract lines from buffer
///		and call line handler
/// </summary>
static void handleUartEvent(struct event_data *eventData)
{
	char *pszLine = NULL;
	char *pchSegment = &receiveBuffer[nBytesInBuffer];

	// Poll the UART and store the byte(s) behind already received bytes
	ssize_t nBytesRead = read(eventData->fd, (void *)pchSegment, RECEIVE_BUFFER_SIZE - nBytesInBuffer);

	if (nBytesRead < 0) {
		Log_Debug("ERROR: Problem reading from UART: %s (%d).\n", strerror(errno), errno);
		return;
	}

	if (nBytesRead == 0) {
		return;
	}

#ifdef VERBOSE
	char *pszUart = malloc((size_t)nBytesRead + 1);
	memcpy(pszUart, pchSegment, (size_t)nBytesRead);
	pszUart[nBytesRead] = '\0';
	Log_Debug("[UART] Read: %s (%d).\n", pszUart, nBytesRead);
	free(pszUart);
#endif // VERBOSE

	nBytesInBuffer += (size_t)nBytesRead;
	char * pchLineEnd = NULL;

	// buffer may contain multiple lines ==> loop for all lines in buffer
	while ((pchLineEnd = (char *)memchr(receiveBuffer, LINE_DELIMITER, nBytesInBuffer)) != NULL) {
		*pchLineEnd++ = '\0'; // replace LINE_DELIMITER with string terminator and advance to 'next' line
		size_t nLineLength = (size_t)(pchLineEnd - receiveBuffer);
		if (nLineLength>1) {
			// create string for received line
			pszLine = (char *)malloc(nLineLength);
			memcpy((void *)pszLine, (const void *)receiveBuffer, nLineLength); // faster than strncpy
		}

		// move remaining bytes (if any) to begin of buffer
		nBytesInBuffer -= nLineLength;
		if (nBytesInBuffer > 0) {
			memcpy((void *)receiveBuffer, (const void *)pchLineEnd, nBytesInBuffer);
		}

		// handle received line and release memory
		if (pszLine != NULL) {
			Log_Debug("[UART] Received line: %s\n", pszLine);
			if (m_HandleLineReceived != NULL) {
				m_HandleLineReceived(pszLine, nLineLength);
			}
			free(pszLine);
		}
	}

	if (nBytesInBuffer >= RECEIVE_BUFFER_SIZE) // buffer overrun, discard content
	{
		Log_Debug("ERROR: UART reveiver buffer too small or EOL missing, discarding content!\n");
		nBytesInBuffer = 0;
		return;
	}
}

static event_data_t uartEventData = { .eventHandler = &handleUartEvent };

///<summary>
///		Initializes given UART port, adds (internal) event handler to Epoll and stores UART line received event handler
///</summary>
///<param name="uartId">Id of UART to initialize</param>
///<param name="epollFd">Epoll file descriptor to attach UART events</param>
///<param name="handleLineReceived">Address of line received handler</param>
///<returns>UART file decriptor or -1 on error</returns>
int UART_InitializeAndAddToEpoll(UART_Id uartId, int epollFd, uart_line_received_handler_t handleLineReceived)
{
	m_UartId = uartId;
	m_HandleLineReceived = handleLineReceived;
	// Create a UART_Config object, open the UART and set up UART event handler
	UART_Config uartConfig;
	UART_InitConfig(&uartConfig);
	uartConfig.baudRate = 9600;
	uartConfig.flowControl = UART_FlowControl_None;
	m_UartFd = UART_Open(uartId, &uartConfig);
	if (m_UartFd < 0) {
		Log_Debug("ERROR: Could not open UART: %s (%d).\n", strerror(errno), errno);
		return -1;
	}

	// Register the UART file descriptor on the epoll instance referred by epollFd
	// and register the eventHandler handler for events in epollEventMask
	if (RegisterEventHandlerToEpoll(epollFd, m_UartFd, &uartEventData, EPOLLIN) == -1) {
		Log_Debug("ERROR: Could not add event to epoll instance %s (%d)\n", strerror(errno), errno);
		return -1;
	}

	return m_UartFd;
}


/// <summary>
///		Closes the previously opened UART
///</summary>
void UART_Close(void)
{
	if (m_UartFd >= 0) {
		if (close(m_UartFd) != 0) {
			Log_Debug("WARNING: Could not close UART: %s (%d).\n", strerror(errno), errno);
		}
	}
}


/// <summary>
///     Helper function to send a fixed message via the previously opened UART.
/// </summary>
/// <param name="dataToSend">The data to send over the UART</param>
void UART_SendMessage(const char *dataToSend)
{
	size_t totalBytesSent = 0;
	size_t totalBytesToSend = strlen(dataToSend);
	int sendIterations = 0;
	while (totalBytesSent < totalBytesToSend) {
		sendIterations++;

		// Send as much of the remaining data as possible
		size_t bytesLeftToSend = totalBytesToSend - totalBytesSent;
		const char *remainingMessageToSend = dataToSend + totalBytesSent;
		ssize_t bytesSent = write(m_UartFd, remainingMessageToSend, bytesLeftToSend);
		if (bytesSent < 0) {
			Log_Debug("ERROR: Could not write to UART: %s (%d).\n", strerror(errno), errno);
			return;
		}

		totalBytesSent += (size_t)bytesSent;
	}

	Log_Debug("[UART] Sent %d bytes in %d calls\n", totalBytesSent, sendIterations);
}

