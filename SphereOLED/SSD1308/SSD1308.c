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
#include <SSD1308.h>
#include "SSD1308defs.h"
#include "Fonts.h"
#include <applibs/log.h>
#include <arm_neon.h>

static SSD1308_AddressModes_t addressingMode;
static int oledI2CFd = -1;
static I2C_DeviceAddress oledI2CAddr = (I2C_DeviceAddress) SSD1308_I2C_PRIMARY_ADDRESS;

typedef struct  __attribute__((__packed__)) _ssd1308_packet  {
	uint8_t header;
	uint8_t data;
} ssd1308_packet_t;

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
	ssize_t nBytesSent =  I2CMaster_Write(oledI2CFd, oledI2CAddr, data, length);
	struct timespec waitPeriod = { 0, 2 * 1000 * 1000 };
	nanosleep(&waitPeriod, NULL);
	if (length != nBytesSent)
	{
		Log_Debug("[OLED] sent only %d of %d bytes.\r", nBytesSent, length);
	}
	return nBytesSent;
}

///<summary>Sends a command with parameter over I2C to the SSD1308</summary>
/// <param name="command">Command byte (see SSD1308.h)</param>
/// <param name="param">Command parameter</param>
/// <returns>Number of bytes sent through I2C (should be 3)</returns>
bool oled_sendCommandParam(SSD1308_Commands_t command, uint8_t param)
{
	const uint8_t buf[4] = { SSD1308_COMMAND_MODE_CONT, command, SSD1308_COMMAND_MODE, param };
	return oled_sendBuffer( buf, sizeof(buf)) == sizeof(buf);
}

///<summary>Sends a single command over I2C to the SSD1308</summary>
/// <param name="command">Command byte (see SSD1308.h)</param>
/// <returns>Number of bytes sent through I2C (should be 2)</returns>
bool oled_sendCommand(SSD1308_Commands_t command)
{
	const uint8_t buf[2] = { SSD1308_COMMAND_MODE, command };
	return oled_sendBuffer(buf, sizeof(buf)) == sizeof(buf);
}


///<summary>Internal: sets Vcom deselect level</summary>
///<param name="level"><see cref="SSD1308_VcomLevels_t" /></param>
bool oled_setVcomLevel(SSD1308_VcomLevels_t level)
{
	return oled_sendCommandParam(SSD1308_CMD_SET_VCOM_DESELECT, level);
}

///<summary>Internal: sets Iref selection</summary>
///<param name="selection"><see cref="SSD1308_IrefSelection_t" /></param>
bool oled_setIrefSelect(SSD1308_IrefSelection_t selection)
{
	return oled_sendCommandParam(SSD1308_CMD_SET_IREF_SEL, selection);
}

///<summary>Internal: sets commands pads hardware</summary>
///<param name="pad">Pad hardware configuration; see <see cref="SSD1308_PadHardware_t"/></param>
bool oled_setPadsHardware(SSD1308_PadHardware_t pad)
{
	return oled_sendCommandParam(SSD1308_CMD_SET_PAD_HARDWARE, pad);
}

///<summary>Internal: sets clock divider ration/oscillator frequency</summary>
///<param name="divider">[7:4] Oscillator freq, [3:0] Divider ratio</param>
bool oled_setClockDivider(uint8_t divider)
{
	return oled_sendCommandParam(SSD1308_CMD_SET_DISP_CLOCK_DIV, divider);
}

///<summary>Internal: sets clock divider ration/oscillator frequency</summary>
///<param name="period">[7:4] Phase 1 (0 is invalid), [3:0] Phase2 (0 is invalid)</param>
bool oled_setPreCharge(uint8_t period)
{
	return oled_sendCommandParam(SSD1308_CMD_SET_PRECHARGE, period);
}

///<summary>Internal: sets adressing mode</summary>
///<param name="mode">see SSD1308_AddressModes_t</param>
bool oled_setAdressMode(SSD1308_AddressModes_t mode)
{
	addressingMode = mode;
	return oled_sendCommandParam(SSD1308_SET_ADDRESS_MODE, mode);
}


///<summary>Set page adressing mode</summary>
bool OLED_SetPageMode(void)
{
	return oled_setAdressMode(SSD1308_ADDRESS_MODE_PAGE);
}

///<summary>Set horizontal adressing mode</summary>
bool OLED_SetHorizontalMode( void )
{
	return oled_setAdressMode(SSD1308_ADDRESS_MODE_HORIZONTAL);
}

///<summary>Set vertical adressing mode</summary>
bool OLED_SetVerticalMode( void )
{
	return oled_setAdressMode(SSD1308_ADDRESS_MODE_VERTICAL);
}

///<summary>Sets multiplex ratio</summary>
///<param name="mux">multiplex value [15..63]</param>
bool OLED_SetMultiplex(int mux)
{
	if (mux < 15 || mux > 63)
	{
		return false;
	}
	return oled_sendCommandParam(SSD1308_CMD_SET_MULTIPLEX, (uint8_t)mux);
}

///<summary>Set brightness of OLED display</summary>
///<param name="brightness">OLED display brightness (0..255)</param>
bool OLED_SetBrightness(uint8_t brightness)
{
	return oled_sendCommandParam(SSD1308_CMD_BRIGHTNESS, brightness);
}

///<summary>Set normal display (1 in RAM lights up dot)</summary>
bool OLED_SetNormalDisplay(void)
{
	return oled_sendCommand(SSD1308_CMD_DISPLAY_NORMAL);
}

///<summary>Set inverse display (0 in RAM lights up dot)</summary>
bool OLED_SetInverseDisplay(void)
{
	return oled_sendCommand(SSD1308_CMD_DISPLAY_INVERSE);
}

///<summary>Display RAM content</summary>
bool OLED_DisplayFromRAM(void)
{
	return oled_sendCommand(SSD1308_CMD_DISPLAY_RAM);
}

///<summary>Display all on</summary>
bool OLED_DisplayAllOn(void)
{
	return oled_sendCommand(SSD1308_CMD_DISPLAY_ALLON);
}

///<summary>Set display on</summary>
bool OLED_DisplayOn(void)
{
	return oled_sendCommand(SSD1308_CMD_DISPLAY_ON);
}

///<summary>Set display off</summary>
bool OLED_DisplayOff(void)
{
	return oled_sendCommand(SSD1308_CMD_DISPLAY_OFF);
}

///<summary>Set display on/off</summary>
///<param name="on">True: display on, False:Display off</param>
bool OLED_Display(bool on)
{
	return oled_sendCommand(on ? SSD1308_CMD_DISPLAY_ON : SSD1308_CMD_DISPLAY_OFF);
}

///<summary>Set Com output scan direction to Normal or Remapped. Depends on Multiplex ratio <see cref="OLED_setMultiplex"/></summary>
///<param name="normal">True: Normal, False:Remapped</param>
bool OLED_ScanDirection(bool normal)
{
	return oled_sendCommand(normal ? SSD1308_SET_SCAN_DIRECTION_NORMAL : SSD1308_SET_SCAN_DIRECTION_REMAPPED);
}

///<summary>Set display orientation (segment remap)</summary>
///<param name="orientation">True: Normal, False:Flipped </param>
bool OLED_DisplayOrientation(bool orientation)
{
	return oled_sendCommand(orientation ? SSD1308_CMD_SEGMENT_SEG0_C0 : SSD1308_CMD_SEGMENT_SEG0_C127);
}

///<summary>Set column and row address for next text output</summary>
///<param name="column">Column position (0..15)</param>
///<param name="row">Row position (0..7)</param>
bool OLED_SetTextPos(uint8_t column, uint8_t row)
{
	bool bSuccess = true;
	bSuccess &= oled_sendCommand(SSD1308_SET_PAGE_START_ADDRESS + (row & 0x0F));
	bSuccess &= oled_sendCommand(SSD1308_SET_COLUMN_ADDRESS_LOW + ((column << 3) & 0x0F));
	bSuccess &= oled_sendCommand(SSD1308_SET_COLUMN_ADDRESS_HIGH + ((column > 1) & 0x0F));
	return bSuccess;

	//uint8_t buf[6] =
	//{
	//	SSD1308_COMMAND_MODE_CONT,
	//	//set page address
	//	(uint8_t)(SSD1308_SET_PAGE_START_ADDRESS + (row & 0x0F)),
	//	SSD1308_COMMAND_MODE_CONT,
	//	//set column lower address (Column*8px)
	//	(uint8_t)(SSD1308_SET_COLUMN_ADDRESS_LOW + ((column << 3) & 0x0F)),
	//	SSD1308_COMMAND_MODE,
	//	//set column higher address (Column*8px) >> 4
	//	(uint8_t)(SSD1308_SET_COLUMN_ADDRESS_HIGH + ((column >> 1) & 0x0F))
	//};
	//return oled_sendBuffer(buf, sizeof(buf)) == sizeof(buf);
}


///<summary>Writes a character to the display at column and row set by <see cref="OLED_SetTextXY" /></summary>
///<param name="ch">Character to write to screen (32..127)</param>
bool OLED_PutChar(char ch)
{
	SSD1308_AddressModes_t oldAdressMode = addressingMode;

	if (oldAdressMode != SSD1308_ADDRESS_MODE_HORIZONTAL)
	{
		OLED_SetHorizontalMode();
	}

	if ((ch < BASICFONT_MINCHAR) || (ch > BASICFONT_MAXCHAR)) //Ignore non-printable ASCII characters. This can be modified for multilingual font.
	{
		ch = ' '; //Space
	}

	uint8_t buf[BASICFONT_CHARBYTES * 2];
	uint8_t* pBuf = buf;
	uint8_t *pChData = (uint8_t *)BasicFont[ch - BASICFONT_MINCHAR];
	for (int i = 0; i < BASICFONT_CHARBYTES-1; i++)
	{
		*pBuf++ = SSD1308_DATA_MODE_CONT;
		*pBuf++ = *pChData++;
	}
	*pBuf++ = SSD1308_DATA_MODE;
	*pBuf++ = *pChData++;

	bool bSuccess = oled_sendBuffer(buf, sizeof(buf)) == sizeof(buf);

	if (oldAdressMode != SSD1308_ADDRESS_MODE_HORIZONTAL)
	{
		return oled_setAdressMode(oldAdressMode);
	}

	return bSuccess;
}

///<summary>Writes a string to the display at column and row set by <see cref="OLED_SetTextXY" /></summary>
///<param name="text">pointer to string to output to display</param>
bool OLED_PutString(const char *String)
{
	bool bSuccess = true;

	while (*String && bSuccess)
	{
		bSuccess &= OLED_PutChar(*String++);
	}

	return bSuccess;
}

///<summary>Clears a line on display starting at column with length characters.</summary>
///<param name="column">Column to start at</param>
///<param name="row">Row number to clear</param>
///<param name="length">Number of characters to clear</param>
bool OLED_ClearPos(uint8_t column, uint8_t row, size_t length)
{
	if ((length + (size_t)column) > OLED_COLUMNS)
	{
		column %= OLED_COLUMNS; // normalize columns, just in case
		length = OLED_COLUMNS - (size_t)column;
	}
	if (length < 1)
	{
		return true; // nothing to clear
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
	return true;
}

///<summary>Fills display RAM</summary>
bool OLED_FillDisplay(uint8_t fillByte)
{
	bool bSuccess = true;
	ssd1308_packet_t pkgBuf[OLED_HORIZONTAL_PIXELS]; // line buffer

	register ssd1308_packet_t* pPkg = pkgBuf;
	register ssd1308_packet_t* pPkgEnd = &pPkg[OLED_HORIZONTAL_PIXELS - 1];
	register ssd1308_packet_t pkg = { .header = SSD1308_DATA_MODE_CONT, .data = fillByte };
	while (pPkg < pPkgEnd)
	{
		*pPkg++ = pkg;
	}
	pkg.header = SSD1308_DATA_MODE;
	*pPkg++ = pkg;

	for (uint8_t row = 0; (row < 8) /*&& bSuccess*/; row++)
	{
		bSuccess &= oled_sendCommand(SSD1308_SET_PAGE_START_ADDRESS + (row & 0x0F));
		bSuccess &= (oled_sendBuffer((uint8_t) pkgBuf, sizeof(pkgBuf)) == sizeof(pkgBuf)); // re-using buffer for all lines
	}

	bSuccess &= OLED_SetTextPos(0, 0);
	return bSuccess;
}


///<summary>Clears display RAM</summary>
bool OLED_ClearDisplay()
{
	return OLED_FillDisplay(0x00);
}



bool OLED_Test()
{

	//OLED_SetTextPos(3, 1);
	ssd1308_packet_t buf[] =
	{
		SSD1308_COMMAND_MODE_CONT,
		//set page address
		(uint8_t)(SSD1308_SET_PAGE_START_ADDRESS + (1 & 0x0F)),
		SSD1308_COMMAND_MODE_CONT,
		//set column lower address (Column*8px)
		(uint8_t)(SSD1308_SET_COLUMN_ADDRESS_LOW + ((1 << 3) & 0x0F)),
		SSD1308_COMMAND_MODE_CONT,
		//set column higher address (Column*8px) >> 4
		(uint8_t)(SSD1308_SET_COLUMN_ADDRESS_HIGH + ((1 >> 1) & 0x0F)),
		SSD1308_DATA_MODE_CONT,
		0xAA,
		SSD1308_DATA_MODE_CONT,
		0xAA,
		SSD1308_DATA_MODE_CONT,
		0xAA,
		SSD1308_DATA_MODE_CONT,
		0xAA,
		SSD1308_DATA_MODE_CONT,
		0xAA,
		SSD1308_DATA_MODE_CONT,
		0xAA,
		SSD1308_DATA_MODE_CONT,
		0xAA,
		SSD1308_DATA_MODE,
		0xAA
	};
	bool bSuccess = oled_sendBuffer(buf, sizeof(buf)) == sizeof(buf);
	return bSuccess;

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


bool OLED_SetHorizontalScrollProperties(uint8_t direction, uint8_t startPage, uint8_t endPage, uint8_t scrollSpeed)
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

	return oled_sendBuffer(buf, sizeof(buf)) == sizeof(buf);
}

bool OLED_SetVerticalScrollProperties(uint8_t direction, uint8_t startPage, uint8_t endPage, uint8_t scrollSpeed, uint8_t verticalOffset)
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

	return oled_sendBuffer(buf, sizeof(buf)) == sizeof(buf);
}

bool OLED_ActivateScroll(void)
{
	return oled_sendCommand(SSD1308_CMD_SCROLL_ACTIVATE);
}

bool OLED_DeactivateScroll(void)
{
	return oled_sendCommand(SSD1308_CMD_SCROLL_DEACTIVATE);
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

	OLED_Display( false );
	oled_setPadsHardware(SSD1308_PAD_ALTERNATIVE);
	OLED_DisplayOrientation(false);
	OLED_ScanDirection(false);
	OLED_SetMultiplex(63);
	oled_setClockDivider(0x80);
	oled_setPreCharge(0x21);
	OLED_SetBrightness(0x50);
	oled_setAdressMode(SSD1308_ADDRESS_MODE_PAGE);
	oled_setVcomLevel(SSD1308_VCOM_0_83_VCC);
	oled_setIrefSelect(SSD1308_IREF_SEL_EXTERNAL);
	OLED_DisplayFromRAM();
	OLED_SetNormalDisplay();
	OLED_DeactivateScroll();
	//OLED_ClearDisplay();
	OLED_Display( true );

	//if (oled_sendBuffer(oledResetSeq, sizeof(oledResetSeq)) != sizeof(oledResetSeq))
	//{
	//	// display didn't acknowledge sent data?
	//	oledI2CFd = -1;
	//	return -1;
	//}

	return oledI2CFd;
}
