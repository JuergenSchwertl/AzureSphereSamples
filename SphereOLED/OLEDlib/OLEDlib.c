/// <summary>
/// Azure Sphere SSD130x OLED Driver Library
///
/// e.g. for the Seeed Grove - OLED Display 0.96 inch 
/// <see cref="http://wiki.seeedstudio.com/Grove-OLED_Display_0.96inch/" />
/// </summary>

/// <remarks>
/// *******************************************************************************
/// Author        :   J. Schwertl
/// Change Log    : v1.0 2019/03/20 []
///
/// *******************************************************************************
/// MIT License
/// 
/// Copyright(c) 2019 Jürgen Schwertl
/// 
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files(the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions :
/// 
/// The above copyright notice and this permission notice shall be included in all
/// copies or substantial portions of the Software.
/// 
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
/// SOFTWARE.
/// *******************************************************************************
/// </remarks>

#include <time.h>
#include <malloc.h>
#include <memory.h>
#include <OLEDlib.h>
#include "SSD1308.h"
#include "Fonts.h"
#include <applibs/log.h>

static char addressingMode;
static int oledI2CFd = -1;
static I2C_DeviceAddress oledI2CAddr = (I2C_DeviceAddress) SSD1308_I2C_PRIMARY_ADDRESS;

///<summary>Suggested RESET sequence for the LY190-128064 
/// OLED monochrome 128×64 dot matrix display module. See 
///<seealso cref="https://github.com/SeeedDocument/Grove_OLED_Display_0.96/raw/master/resource/LY190-128064.pdf" />
///</summary>
static const uint8_t oledResetSeq[] = {
	SSD1308_COMMAND_MODE, 
	SSD1308_CMD_DISPLAY_OFF, // display off
	SSD1308_CMD_SEGMENT_SEG0_C127, //segment remap
	0xda, //common pads hardware: alternative
	0x12,
	0xc8, //common output scan direction:com63~com0
	SSD1308_CMD_SET_MULTIPLEX, //multiplex ratio mode:63
	0x3f,
	SSD1308_CMD_SET_DISP_CLOCK_DIV, //display divide ratio/osc. freq. mode
	0x80,
	SSD1308_CMD_BRIGHTNESS, //contrast control
	0x50, 
	SSD1308_CMD_SET_PRECHARGE, //set pre-charge period
	0x21,
	SSD1308_SET_ADDRESS_MODE, //Set Memory Addressing Mode
	SSD1308_ADDRESS_MODE_PAGE,
	SSD1308_CMD_SET_VCOM_DESELECT, //VCOM deselect level mode
	SSD1308_VCOM_0_83_VCC,
	SSD1308_CMD_SET_IREF_SEL, //master configuration
	SSD1308_IREF_SEL_EXTERNAL,
	SSD1308_CMD_DISPLAY_RAM, //out follows RAM content
	SSD1308_CMD_DISPLAY_NORMAL, //set normal display
	SSD1308_CMD_SCROLL_DEACTIVATE,
	SSD1308_CMD_DISPLAY_ON // display on
};

///<summary>Sends a buffer command over I2C to the SSD1308</summary>
/// <param name="data">pointer to byte buffer</param>
/// <param name="length">length of buffer</param>
/// <returns>Number of bytes sent through I2C (should be length)</returns>
ssize_t oled_sendBuffer(const uint8_t *data, size_t length)
{
	if (oledI2CFd < 0)
	{
		return -1;
	}
	return I2CMaster_Write(oledI2CFd, oledI2CAddr, data, length);
}

///<summary>Sends a command with parameter over I2C to the SSD1308</summary>
/// <param name="command">Command byte (see SSD1308.h)</param>
/// <param name="param">Command parameter</param>
/// <returns>Number of bytes sent through I2C (should be 3)</returns>
ssize_t oled_sendCommandParam(uint8_t command, uint8_t param)
{
	const uint8_t buf[3] = { SSD1308_COMMAND_MODE, command, param };
	return oled_sendBuffer( buf, sizeof(buf));
}

///<summary>Sends a single command over I2C to the SSD1308</summary>
/// <param name="command">Command byte (see SSD1308.h)</param>
/// <returns>Number of bytes sent through I2C (should be 2)</returns>
ssize_t oled_sendCommand(unsigned char command)
{
	const uint8_t buf[2] = { SSD1308_COMMAND_MODE, command };
	return oled_sendBuffer(buf, sizeof(buf));
}



///<summary>
///Initializes the Seeed Grove OLED 0.96" and returns the I2C file descriptor or -1 on error
///</summary>
///<param name="i2cFd">I2C interface file descriptor</param>
///<param name="isPrimary">true if SSD1308 is on primary I2C address 0x3c, false if secondary address 0x3d is used</param>
///<returns>I2C file descriptor, -1 on error</returns>
int OLED_Init(int i2cFd, bool isPrimary)
{
	oledI2CAddr = isPrimary ? SSD1308_I2C_PRIMARY_ADDRESS : SSD1308_I2C_SECONDARY_ADDRESS;
	if ((oledI2CFd = i2cFd) <= 0)
	{
		return -1;
	}
	
	if (oled_sendBuffer(oledResetSeq, sizeof(oledResetSeq)) != sizeof(oledResetSeq))
	{
		// display didn't acknowledge sent data?
		oledI2CFd = -1;
		return -1;
	}

	OLED_ClearDisplay();
	return oledI2CFd;
}

///<summary>Internal: sets adressing mode</summary>
///<param name="brightness">OLED display brightness (0..255)</param>
void oled_setAdressMode(uint8_t mode)
{
	addressingMode = mode;
	oled_sendCommandParam(SSD1308_SET_ADDRESS_MODE, mode);
}


///<summary>Set page adressing mode</summary>
void OLED_SetPageMode(void)
{
	oled_setAdressMode(SSD1308_ADDRESS_MODE_PAGE);
}

///<summary>Set horizontal adressing mode</summary>
void OLED_SetHorizontalMode( void )
{
	oled_setAdressMode(SSD1308_ADDRESS_MODE_HORIZONTAL);
}

///<summary>Set vertical adressing mode</summary>
void OLED_SetVerticalMode( void )
{
	oled_setAdressMode(SSD1308_ADDRESS_MODE_VERTICAL);
}

///<summary>Set brightness of OLED display</summary>
///<param name="brightness">OLED display brightness (0..255)</param>
void OLED_SetBrightness(uint8_t brightness)
{
	oled_sendCommandParam(SSD1308_CMD_BRIGHTNESS, brightness);
}

///<summary>Set normal display (1 in RAM lights up dot)</summary>
void OLED_SetNormalDisplay(void)
{
	oled_sendCommand(SSD1308_CMD_DISPLAY_NORMAL);
}

///<summary>Set inverse display (0 in RAM lights up dot)</summary>
void OLED_SetInverseDisplay(void)
{
	oled_sendCommand(SSD1308_CMD_DISPLAY_INVERSE);
}

///<summary>Set column and row address for next text output</summary>
///<param name="column">Column position (0..15)</param>
///<param name="row">Row position (0..7)</param>
void OLED_SetTextPos(uint8_t column, uint8_t row)
{
	uint8_t buf[4];
	buf[0] = SSD1308_COMMAND_MODE;
	//set page address
	buf[1] = (uint8_t)(SSD1308_SET_PAGE_START_ADDRESS + (row & 0x0F));
	//set column lower address (Column*8px)
	buf[2] = (uint8_t)(SSD1308_SET_COLUMN_ADDRESS_LOW + ((column << 3) & 0x0F));  
	//set column higher address (Column*8px) >> 4
	buf[3] = (uint8_t)(SSD1308_SET_COLUMN_ADDRESS_HIGH + ((column >> 1) & 0x0F));   
	oled_sendBuffer(buf, sizeof(buf));
}


///<summary>Writes a character to the display at column and row set by <see cref="OLED_SetTextXY" /></summary>
///<param name="ch">Character to write to screen (32..127)</param>
void OLED_PutChar(char ch)
{
	if ((ch < BASICFONT_MINCHAR) || (ch > BASICFONT_MAXCHAR)) //Ignore non-printable ASCII characters. This can be modified for multilingual font.
	{
		ch = ' '; //Space
	}

	uint8_t buf[BASICFONT_CHARBYTES + 1];
	buf[0] = SSD1308_DATA_MODE;
	memcpy(&buf[1], BasicFont[ch - BASICFONT_MINCHAR], BASICFONT_CHARBYTES);
	oled_sendBuffer(buf, sizeof(buf));
}

///<summary>Writes a string to the display at column and row set by <see cref="OLED_SetTextXY" /></summary>
///<param name="text">pointer to string to output to display</param>
void OLED_PutString(const char *String)
{
	while (*String)
	{
		OLED_PutChar(*String++);
	}
}

///<summary>Clears a line on display starting at column with length characters.</summary>
///<param name="column">Column to start at</param>
///<param name="row">Row number to clear</param>
///<param name="length">Number of characters to clear</param>
void OLED_ClearPos(uint8_t column, uint8_t row, size_t length)
{
	if ((length + (size_t)column) > OLED_COLUMNS)
	{
		column %= OLED_COLUMNS; // normalize columns, just in case
		length = OLED_COLUMNS - (size_t)column;
	}
	if (length < 1)
	{
		return; // nothing to clear
	}
	OLED_SetTextPos(column, row);
	size_t bufLen = (length<<3)+1; // length*8+data-mode prefix
	uint8_t *pBuf = malloc(bufLen);
	if (pBuf != NULL)
	{
		memset(pBuf, 0, bufLen);
		*pBuf = SSD1308_DATA_MODE;
		oled_sendBuffer(pBuf, bufLen);
		free(pBuf);
	}
}

///<summary>Clears display RAM</summary>
void OLED_ClearDisplay()
{
	const size_t bufLen = OLED_HORIZONTAL_PIXELS + 1; // line buffer+data prefix
	uint8_t *pBuf = malloc(bufLen);
	if (pBuf != NULL)
	{
		//oled_sendCommand(SSD1308_CMD_DISPLAY_OFF);   //display off

		memset(pBuf, 0, bufLen);
		*pBuf = SSD1308_DATA_MODE; // set data mode
		for (uint8_t row = 0; row < 8; row++)
		{
			OLED_SetTextPos(0, row);
			oled_sendBuffer(pBuf, bufLen); // re-using buffer for all lines
		}
		free(pBuf);

		//oled_sendCommand(SSD1308_CMD_DISPLAY_ON);    //display on
	}
	OLED_SetTextPos(0, 0);
}





//
//void OLED_drawBitmap(unsigned char *bitmaparray, int bytes)
//{
//	char localAddressMode = addressingMode;
//	if (addressingMode != HORIZONTAL_MODE)
//	{
//		//Bitmap is drawn in horizontal mode
//		setHorizontalMode();
//	}
//
//	for (int i = 0; i < bytes; i++)
//	{
//		sendData(pgm_read_byte(&bitmaparray[i]));
//	}
//
//	if (localAddressMode == PAGE_MODE)
//	{
//		//If pageMode was used earlier, restore it.
//		setPageMode();
//	}
//
//}


void OLED_SetHorizontalScrollProperties(uint8_t direction, uint8_t startPage, uint8_t endPage, uint8_t scrollSpeed)
{
	uint8_t buf[] = {
	SSD1308_COMMAND_MODE,
	(direction == SCROLL_DIRECTION_LEFT) ? SCROLL_DIRECTION_LEFT : SCROLL_DIRECTION_RIGHT,
	0x00, // dummy byte
	startPage & 0x07,
	scrollSpeed & 0x07,
	endPage & 0x07,
	0x00,
	0xFF
	};

	oled_sendBuffer(buf, sizeof(buf));
}

void OLED_SetVerticalScrollProperties(uint8_t direction, uint8_t startPage, uint8_t endPage, uint8_t scrollSpeed, uint8_t verticalOffset)
{
	uint8_t buf[] = {
		SSD1308_COMMAND_MODE,
		(direction == SCROLL_VERTICAL_RIGHT) ? SCROLL_VERTICAL_RIGHT : SCROLL_VERTICAL_LEFT,
		0x00, // dummy byte
		startPage & 0x07,
		scrollSpeed & 0x07,
		endPage & 0x07,
		verticalOffset & 0x3F
	};

	oled_sendBuffer(buf, sizeof(buf));
}

void OLED_ActivateScroll(void)
{
	oled_sendCommand(SSD1308_CMD_SCROLL_ACTIVATE);
}

void OLED_DeactivateScroll(void)
{
	oled_sendCommand(SSD1308_CMD_SCROLL_DEACTIVATE);
}


