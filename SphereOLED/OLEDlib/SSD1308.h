#pragma once
/// <summary>
/// Azure Sphere SSD130x OLED Driver Library: Internal definitions for commands and options.
///
/// For further information on the Solomon Systech SSD130x OLED dot matrix driver, see 
/// <see cref="https://github.com/SeeedDocument/Grove_OLED_Display_0.96/raw/master/resource/SSD1308_1.0.pdf" />
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
#ifndef SSD1308_H
#define SSD1308_H


///<summary>Primary I2C address 0x3c for SSD1308</summary>
#define SSD1308_I2C_PRIMARY_ADDRESS		(0x3c)

///<summary>Secondary I2C address 0x3d for SSD1308</summary>
#define SSD1308_I2C_SECONDARY_ADDRESS	(0x3d)

///<summary>Set adressing mode <seealso cref="SSD1308_ADDRESS_MODE_*" /></summary>
#define SSD1308_SET_ADDRESS_MODE		((uint8_t)0x20U)
///<summary>Set adressing mode: Horizontal, see <see cref="SSD1308_SET_ADDRESS_MODE" /></summary>
#define SSD1308_ADDRESS_MODE_HORIZONTAL	((uint8_t)0x00U)
///<summary>Set adressing mode: Vertical, see  <see cref="SSD1308_SET_ADDRESS_MODE" /></summary>
#define SSD1308_ADDRESS_MODE_VERTICAL	((uint8_t)0x01U)
///<summary>Set adressing mode: Page, see <see cref="SSD1308_SET_ADDRESS_MODE" /></summary>
#define SSD1308_ADDRESS_MODE_PAGE		((uint8_t)0x02U)

///<summary>Set page start address (row). Applies only to <see cref="SSD1308_ADDRESS_MODE_PAGE" /></summary>
#define SSD1308_SET_PAGE_START_ADDRESS	((uint8_t)0xB0U)
///<summary>Set column address (high nibble). Applies only to <see cref="SSD1308_ADDRESS_MODE_PAGE" /></summary>
#define SSD1308_SET_COLUMN_ADDRESS_LOW	((uint8_t)0x00U)
///<summary>Set column address (low nibble). Applies only to <see cref="SSD1308_ADDRESS_MODE_PAGE" /></summary>
#define SSD1308_SET_COLUMN_ADDRESS_HIGH	((uint8_t)0x10U)

///<summary>Prefix byte to initiate command sequence</summary>
#define SSD1308_COMMAND_MODE			((uint8_t)0x00U) // 0x80
///<summary>Prefix byte to initiate data write</summary>
#define SSD1308_DATA_MODE				((uint8_t)0x40U)

///<summary>Set segment re-map (col address 0 is SEG0)</summary>
#define SSD1308_CMD_SEGMENT_SEG0_C0		((uint8_t)0xA0U)
///<summary>Set segment re-map (col address 127 is SEG0)</summary>
#define SSD1308_CMD_SEGMENT_SEG0_C127	((uint8_t)0xA1U)


///<summary>Display follows RAM content</summary>
#define SSD1308_CMD_DISPLAY_RAM			((uint8_t)0xA4U)
///<summary>Display is on (ignore RAM content)</summary>
#define SSD1308_CMD_DISPLAY_ALLON		((uint8_t)0xA5U)

///<summary>Show display normal (1 equals dot)</summary>
#define SSD1308_CMD_DISPLAY_NORMAL		((uint8_t)0xA6U)
///<summary>Show display inverted (1 equals black)</summary>
#define SSD1308_CMD_DISPLAY_INVERSE		((uint8_t)0xA7U)

///<summary>Set Mutiplex ratio</summary>
#define SSD1308_CMD_SET_MULTIPLEX		((uint8_t)0xA8U)

///<summary>Set Iref Selection (0x00: external, 0x10: internal)</summary>
#define SSD1308_CMD_SET_IREF_SEL		((uint8_t)0xADU)
///<summary>Iref Selection: external; see <see cref="SSD1308_CMD_SET_IREF_SEL" /></summary>
#define SSD1308_IREF_SEL_EXTERNAL		((uint8_t)0x00U)
///<summary>Iref Selection: external; see <see cref="SSD1308_CMD_SET_IREF_SEL" /></summary>
#define SSD1308_IREF_SEL_INTERNAL		((uint8_t)0x10U)

///<summary>Display switched off (sleep mode)</summary>
#define SSD1308_CMD_DISPLAY_OFF			((uint8_t)0xAEU)
///<summary>Display is switched on</summary>
#define SSD1308_CMD_DISPLAY_ON			((uint8_t)0xAFU)

#define SSD1308_CMD_SCROLL_ACTIVATE		((uint8_t)0x2FU)
#define SSD1308_CMD_SCROLL_DEACTIVATE	((uint8_t)0x2EU)
#define SSD1308_CMD_BRIGHTNESS			((uint8_t)0x81U)

///<summary>Set Display clock divider (default 0x80)</summary>
#define SSD1308_CMD_SET_DISP_CLOCK_DIV	((uint8_t)0xD5U)


///<summary>Set V(COMH) deselect level</summary>
#define SSD1308_CMD_SET_VCOM_DESELECT   ((uint8_t)0xDBU)
///<summary>~0.65 Vcc V(COMH) deselect level <see cref="SSD1308_CMD_SET_VCOM_DESELECT" /></summary>
#define SSD1308_VCOM_0_65_VCC			((uint8_t)0x00U)
///<summary>~0.77 Vcc V(COMH) deselect level <see cref="SSD1308_CMD_SET_VCOM_DESELECT" /></summary>
#define SSD1308_VCOM_0_77_VCC			((uint8_t)0x20U)
///<summary>~0.83 Vcc V(COMH) deselect level <see cref="SSD1308_CMD_SET_VCOM_DESELECT" /></summary>
#define SSD1308_VCOM_0_83_VCC			((uint8_t)0x30U)

#define SSD1308_CMD_SET_PRECHARGE		((uint8_t)0xD9U)



#define Scroll_Left             0x00
#define Scroll_Right            0x01

#define Scroll_2Frames          0x7
#define Scroll_3Frames          0x4
#define Scroll_4Frames          0x5
#define Scroll_5Frames          0x0
#define Scroll_25Frames         0x6
#define Scroll_64Frames         0x1
#define Scroll_128Frames        0x2
#define Scroll_256Frames        0x3

#endif
