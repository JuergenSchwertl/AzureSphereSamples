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

typedef enum _SSD1308_I2cAddress
{
    ///<summary>Primary I2C address 0x3c for SSD1308</summary>
    SSD1308_I2C_PRIMARY_ADDRESS = 0x3c,
    ///<summary>Secondary I2C address 0x3d for SSD1308</summary>
    SSD1308_I2C_SECONDARY_ADDRESS = 0x3d
} SSD1308_I2cAddress_t;


typedef enum _SSD1308_CommandPrefix {
    ///<summary>Prefix byte to initiate command sequence</summary>
    SSD1308_COMMAND_MODE = 0x00, // 0x80
    ///<summary>Prefix byte to initiate command sequence</summary>
    SSD1308_COMMAND_MODE_CONT = 0x80, // 0x80
    ///<summary>Prefix byte to initiate data write</summary>
    SSD1308_DATA_MODE_CONT = 0xC0,
    ///<summary>Prefix byte to initiate data write</summary>
    SSD1308_DATA_MODE = 0x40
} SSD1308_CommandPrefix_t;


typedef enum _SSD1308_Commands
{
    ///<summary>Set adressing mode <seealso cref="SSD1308_AddressModes" /></summary>
    SSD1308_SET_ADDRESS_MODE        = 0x20,

    ///<summary>Set page start address (row). Applies only to <see cref="SSD1308_ADDRESS_MODE_PAGE" /></summary>
    SSD1308_SET_PAGE_START_ADDRESS  = 0xB0,
    ///<summary>Set column address (high nibble). Applies only to <see cref="SSD1308_ADDRESS_MODE_PAGE" /></summary>
    SSD1308_SET_COLUMN_ADDRESS_LOW  = 0x00,
    ///<summary>Set column address (low nibble). Applies only to <see cref="SSD1308_ADDRESS_MODE_PAGE" /></summary>
    SSD1308_SET_COLUMN_ADDRESS_HIGH = 0x10,

    ///<summary>Stop scrolling</summary>
    SSD1308_CMD_SCROLL_DEACTIVATE   = 0x2E,
    ///<summary>Start scrolling</summary>
    SSD1308_CMD_SCROLL_ACTIVATE     = 0x2F,

    ///<summary>Set Brighness 0..255</summary>
    SSD1308_CMD_BRIGHTNESS          = 0x81,

    ///<summary>Set segment re-map (col address 0 is SEG0)</summary>
    SSD1308_CMD_SEGMENT_SEG0_C0	    = 0xA0,
    ///<summary>Set segment re-map (col address 127 is SEG0)</summary>
    SSD1308_CMD_SEGMENT_SEG0_C127	= 0xA1,


    ///<summary>Display follows RAM content</summary>
    SSD1308_CMD_DISPLAY_RAM			= 0xA4,
    ///<summary>Display is on (ignore RAM content)</summary>
    SSD1308_CMD_DISPLAY_ALLON		= 0xA5,

    ///<summary>Show display normal (1 equals dot)</summary>
    SSD1308_CMD_DISPLAY_NORMAL		= 0xA6,
    ///<summary>Show display inverted (1 equals black)</summary>
    SSD1308_CMD_DISPLAY_INVERSE		= 0xA7,

    ///<summary>Set Mutiplex ratio [15...63] MUX16-MUX63, RESET=63</summary>
    SSD1308_CMD_SET_MULTIPLEX		= 0xA8,

    ///<summary>Set Iref Selection (0x00: external, 0x10: internal)</summary>
    SSD1308_CMD_SET_IREF_SEL		= 0xAD,

    ///<summary>Display switched off (sleep mode)</summary>
    SSD1308_CMD_DISPLAY_OFF         = 0xAE,
    ///<summary>Display is switched on</summary>
    SSD1308_CMD_DISPLAY_ON          = 0xAF,

    ///<summary>Set COM output scan direction to Normal: Scan from Com0..Com[N-1]; N=Multiplex ratio see <see cref="SSD1308_CMD_SET_MULTIPLEX"/></summary>
    SSD1308_SET_SCAN_DIRECTION_NORMAL = 0xC0,
    ///<summary>Set COM output scan direction to Remapped; Scan from Com[N-1]..Com0; N=Multiplex ratio see <see cref="SSD1308_CMD_SET_MULTIPLEX"/></summary>
    SSD1308_SET_SCAN_DIRECTION_REMAPPED = 0xC8,

    ///<summary>Set Display clock divider (default 0x80)</summary>
    SSD1308_CMD_SET_DISP_CLOCK_DIV  = 0xD5,

    ///<summary>Set precharge period: [7:4] Phase 2 [3:0] Phase 1</summary>
    SSD1308_CMD_SET_PRECHARGE       = 0xD9,

    ///<summary>Set V(COMH) deselect level</summary>
    SSD1308_CMD_SET_PAD_HARDWARE    = 0xDA,

    ///<summary>Set V(COMH) deselect level</summary>
    SSD1308_CMD_SET_VCOM_DESELECT   = 0xDB,

    ///<summary>No Operation</summary>
    SSD1308_CMD_NOP                 = 0xE3

} SSD1308_Commands_t;


typedef enum SSD1308_AddressModes {
    ///<summary>Set adressing mode: Horizontal, see <see cref="SSD1308_SET_ADDRESS_MODE" /></summary>
    SSD1308_ADDRESS_MODE_HORIZONTAL = 0x00,
    ///<summary>Set adressing mode: Vertical, see  <see cref="SSD1308_SET_ADDRESS_MODE" /></summary>
    SSD1308_ADDRESS_MODE_VERTICAL   = 0x01,
    ///<summary>Set adressing mode: Page, see <see cref="SSD1308_SET_ADDRESS_MODE" /></summary>
    SSD1308_ADDRESS_MODE_PAGE       = 0x02
} SSD1308_AddressModes_t;


typedef enum _SSD1308_IrefSelection {
    ///<summary>Iref Selection: external; see <see cref="SSD1308_CMD_SET_IREF_SEL" /></summary>
    SSD1308_IREF_SEL_EXTERNAL = 0x00,
    ///<summary>Iref Selection: external; see <see cref="SSD1308_CMD_SET_IREF_SEL" /></summary>
    SSD1308_IREF_SEL_INTERNAL = 0x10
} SSD1308_IrefSelection_t;


typedef enum _SSD1308_PadHardware {
    ///<summary>Sequential COM pin configuration</summary>
    SSD1308_PAD_SEQUENTIAL = 0x02,
    ///<summary>Iref Selection: external; see <see cref="SSD1308_CMD_SET_IREF_SEL" /></summary>
    SSD1308_PAD_ALTERNATIVE = 0x12
} SSD1308_PadHardware_t;


typedef enum _SSD1308_VcomLevels {
    ///<summary>~0.65 Vcc V(COMH) deselect level <see cref="SSD1308_CMD_SET_VCOM_DESELECT" /></summary>
    SSD1308_VCOM_0_65_VCC = 0x00U,
    ///<summary>~0.77 Vcc V(COMH) deselect level <see cref="SSD1308_CMD_SET_VCOM_DESELECT" /></summary>
    SSD1308_VCOM_0_77_VCC = 0x20U,
    ///<summary>~0.83 Vcc V(COMH) deselect level <see cref="SSD1308_CMD_SET_VCOM_DESELECT" /></summary>
    SSD1308_VCOM_0_83_VCC = 0x30U
} SSD1308_VcomLevels_t;



typedef enum _SSD1308_ScrollDirection {
    Scroll_Left             = 0x00,
    Scroll_Right            = 0x01
} SSD1308_ScrollDirection_t; 

#define Scroll_2Frames          0x7
#define Scroll_3Frames          0x4
#define Scroll_4Frames          0x5
#define Scroll_5Frames          0x0
#define Scroll_25Frames         0x6
#define Scroll_64Frames         0x1
#define Scroll_128Frames        0x2
#define Scroll_256Frames        0x3

#endif
