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

#ifndef OLEDlib_H
#define OLEDlib_H

#include <stdint.h>
#include <stdbool.h>
#include <applibs/i2c.h>

#define OLED_HORIZONTAL_PIXELS		128
#define OLED_VERTICAL_PIXELS		64

#define OLED_COLUMNS				(OLED_HORIZONTAL_PIXELS/8)	// 16 columns
#define OLED_ROWS					(OLED_VERTICAL_PIXELS/8)	// 8 lines

#define SCROLL_PER_5_FRAMES			0x00
#define SCROLL_PER_64_FRAMES		0x01
#define SCROLL_PER_128_FRAMES		0x02
#define SCROLL_PER_256_FRAMES		0x03
#define SCROLL_PER_3_FRAMES			0x04
#define SCROLL_PER_4_FRAMES			0x05
#define SCROLL_PER_25_FRAMES		0x06
#define SCROLL_PER_2_FRAMES			0x07

#define SCROLL_DIRECTION_RIGHT		0x26
#define SCROLL_DIRECTION_LEFT		0x27

#define SCROLL_VERTICAL_RIGHT		0x29
#define SCROLL_VERTICAL_LEFT		0x2a

///<summary>
///Initializes the Seeed Grove OLED 0.96" and returns the I2C file descriptor
///</summary>
///<param name="i2cFd">I2C interface file descriptor</param>
///<param name="isPrimary">true if SSD1308 is on primary I2C address 0x3c, false if secondary address 0x3d is used</param>
///<returns>I2C file descriptor, -1 on error</returns>
int OLED_Init(int fdOledI2C, bool isPrimary);

///<summary>Set page adressing mode</summary>
bool OLED_SetPageMode(void);
///<summary>Set horizontal adressing mode</summary>
bool OLED_SetHorizontalMode(void);
///<summary>Set vertical adressing mode</summary>
bool OLED_SetVerticalMode(void);

///<summary>Set brightness of OLED display</summary>
///<param name="brightness">OLED display brightness (0..255)</param>
bool OLED_SetBrightness(uint8_t brightness);

///<summary>Set normal display (1 in RAM lights up dot)</summary>
bool OLED_SetNormalDisplay(void);
///<summary>Set inverse display (0 in RAM lights up dot)</summary>
bool OLED_SetInverseDisplay(void);

///<summary>Display RAM content</summary>
bool OLED_DisplayFromRAM(void);

///<summary>Display all on</summary>
bool OLED_DisplayAllOn(void);


///<summary>Set display on</summary>
bool OLED_DisplayOn(void);
///<summary>Set display off</summary>
bool OLED_DisplayOff(void);


///<summary>Set display on/off</summary>
///<param name="on">True: display on, False:Display off</param>
bool OLED_Display(bool on);

///<summary>Set Com output scan direction to Normal or Remapped. Depends on Multiplex ratio <see cref="OLED_setMultiplex"/></summary>
///<param name="normal">True: Normal, False:Remapped</param>
bool OLED_ScanDirection(bool normal);

///<summary>Set display orientation (segment remap)</summary>
///<param name="orientation">True: Normal, False:Flipped </param>
bool OLED_DisplayOrientation(bool orientation);


///<summary>Set column and row address for next text output</summary>
///<param name="column">Column position (0..15)</param>
///<param name="row">Row position (0..7)</param>
bool OLED_SetTextPos(uint8_t column, uint8_t row);

///<summary>Writes a character to the display at column and row set by <see cref="OLED_SetTextXY" /></summary>
///<param name="ch">Character to write to screen (32..127)</param>
bool OLED_PutChar(char ch);

///<summary>Writes a string to the display at column and row set by <see cref="OLED_SetTextXY" /></summary>
///<param name="text">pointer to string to output to display</param>
bool OLED_PutString(const char *text);

///<summary>Clears a line on display starting at column with length characters.</summary>
///<param name="column">Column to start at</param>
///<param name="row">Row number to clear</param>
///<param name="length">Number of characters to clear</param>
bool OLED_ClearPos(uint8_t column, uint8_t row, size_t length);

///<summary>Fills display RAM</summary>
bool OLED_FillDisplay(uint8_t fillByte);

///<summary>Clears display RAM</summary>
bool OLED_ClearDisplay(void);

//bool OLED_drawBitmap(unsigned char *bitmaparray, int bytes);

bool OLED_SetHorizontalScrollProperties(uint8_t direction, uint8_t startPage, uint8_t endPage, uint8_t scrollSpeed);
bool OLED_SetVerticalScrollProperties(uint8_t direction, uint8_t startPage, uint8_t endPage, uint8_t scrollSpeed, uint8_t verticalOffset);

bool OLED_ActivateScroll(void);

bool OLED_DeactivateScroll(void);

#endif