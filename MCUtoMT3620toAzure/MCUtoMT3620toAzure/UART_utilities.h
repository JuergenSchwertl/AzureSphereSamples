#pragma once

///<summary>UART "ring" buffer size</summary>
#define RECEIVE_BUFFER_SIZE		128

///<summary>Line delimiter character</summary>
#define LINE_DELIMITER			'\n'


///<summary>Event handler for UART line received</summary>
///<param name="ppLine">Adress of pointer to received string</param>
typedef void(*uart_line_received_handler_t)(char *pszLine, size_t nBytesRead);


///<summary>
///		Initializes given UART port, adds (internal) event handler to Epoll and stores UART line received event handler
///</summary>
///<param name="uartId">Id of UART to initialize</param>
///<param name="epollFd">Epoll file descriptor to attach UART events</param>
///<param name="handleLineReceived">Address of line received handler</param>
///<returns>UART file decriptor or -1 on error</returns>
int UART_InitializeAndAddToEpoll(UART_Id uartId, int epollFd, uart_line_received_handler_t handleLineReceived);

/// <summary>
///		Helper function to close the previously opened UART
///</summary>
void UART_Close(void);

/// <summary>
///     Helper function to send a fixed message via the previously opened UART.
/// </summary>
/// <param name="dataToSend">The data to send over the UART</param>
void UART_SendMessage(const char *dataToSend);




