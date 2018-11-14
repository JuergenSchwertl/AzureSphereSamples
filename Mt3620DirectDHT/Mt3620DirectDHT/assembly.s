   1              		.cpu cortex-a7
   2              		.eabi_attribute 28, 1	@ Tag_ABI_VFP_args
   3              		.eabi_attribute 20, 1	@ Tag_ABI_FP_denormal
   4              		.eabi_attribute 21, 1	@ Tag_ABI_FP_exceptions
   5              		.eabi_attribute 23, 3	@ Tag_ABI_FP_number_model
   6              		.eabi_attribute 24, 1	@ Tag_ABI_align8_needed
   7              		.eabi_attribute 25, 1	@ Tag_ABI_align8_preserved
   8              		.eabi_attribute 26, 2	@ Tag_ABI_enum_size
   9              		.eabi_attribute 30, 6	@ Tag_ABI_optimization_goals
  10              		.eabi_attribute 34, 1	@ Tag_CPU_unaligned_access
  11              		.eabi_attribute 18, 4	@ Tag_ABI_PCS_wchar_t
  12              		.file	"parson.c"
  13              	@ GNU C11 (GCC) version 6.3.0 (arm-poky-linux-musleabi)
  14              	@	compiled by GNU C version 6.3.0, GMP version 6.1.2, MPFR version 3.1.5, MPC version 1.0.3, isl ve
  15              	@ GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
  16              	@ options passed: 
  17              	@ -I C:\Program Files (x86)\Microsoft Azure Sphere SDK\\SysRoot\usr\include\azureiot
  18              	@ -I C:\Program Files (x86)\Microsoft Azure Sphere SDK\\SysRoot\usr\include
  19              	@ -iprefix c:\program files (x86)\microsoft azure sphere sdk\sysroot\tools\gcc\../../lib/arm-poky-l
  20              	@ -isysroot C:\Program Files (x86)\Microsoft Azure Sphere SDK\\SysRoot
  21              	@ -D _POSIX_C_SOURCE -D AZURE_IOT_HUB_CONFIGURED
  22              	@ -D AZURE_IOT_HUB_CONFIGURED -D AZURE_IOT_HUB_CONFIGURED
  23              	@ -D AZURE_IOT_HUB_CONFIGURED parson.c -march=armv7ve -mthumb -mfpu=neon
  24              	@ -mfloat-abi=hard -mcpu=cortex-a7 -mtls-dialect=gnu
  25              	@ -auxbase-strip obj\ARM\Debug\parson.o -g2 -gdwarf-2 -g -O0 -Wall -Wswitch
  26              	@ -Wno-deprecated-declarations -Wempty-body -Wconversion -Wreturn-type
  27              	@ -Wparentheses -Wno-pointer-sign -Wformat=0 -Wuninitialized
  28              	@ -Wunused-function -Wunused-value -Wunused-variable
  29              	@ -Werror=implicit-function-declaration -std=c11 -fno-strict-aliasing
  30              	@ -fno-omit-frame-pointer -fno-exceptions -fverbose-asm
  31              	@ options enabled:  -faggressive-loop-optimizations -fauto-inc-dec
  32              	@ -fchkp-check-incomplete-type -fchkp-check-read -fchkp-check-write
  33              	@ -fchkp-instrument-calls -fchkp-narrow-bounds -fchkp-optimize
  34              	@ -fchkp-store-bounds -fchkp-use-static-bounds
  35              	@ -fchkp-use-static-const-bounds -fchkp-use-wrappers -fcommon
  36              	@ -fdelete-null-pointer-checks -fdwarf2-cfi-asm -fearly-inlining
  37              	@ -feliminate-unused-debug-types -ffunction-cse -fgcse-lm -fgnu-runtime
  38              	@ -fgnu-unique -fident -finline-atomics -fira-hoist-pressure
  39              	@ -fira-share-save-slots -fira-share-spill-slots -fivopts
  40              	@ -fkeep-static-consts -fleading-underscore -flifetime-dse
  41              	@ -flto-odr-type-merging -fmath-errno -fmerge-debug-strings -fpeephole
  42              	@ -fplt -fprefetch-loop-arrays -freg-struct-return
  43              	@ -fsched-critical-path-heuristic -fsched-dep-count-heuristic
  44              	@ -fsched-group-heuristic -fsched-interblock -fsched-last-insn-heuristic
  45              	@ -fsched-rank-heuristic -fsched-spec -fsched-spec-insn-heuristic
  46              	@ -fsched-stalled-insns-dep -fsemantic-interposition -fshow-column
  47              	@ -fsigned-zeros -fsplit-ivs-in-unroller -fssa-backprop -fstdarg-opt
  48              	@ -fstrict-volatile-bitfields -fsync-libcalls -ftrapping-math -ftree-cselim
  49              	@ -ftree-forwprop -ftree-loop-if-convert -ftree-loop-im -ftree-loop-ivcanon
  50              	@ -ftree-loop-optimize -ftree-parallelize-loops= -ftree-phiprop
  51              	@ -ftree-reassoc -ftree-scev-cprop -funit-at-a-time -fverbose-asm
  52              	@ -fzero-initialized-in-bss -masm-syntax-unified -mlittle-endian -mmusl
  53              	@ -mpic-data-is-text-relative -msched-prolog -mthumb -munaligned-access
  54              	@ -mvectorize-with-neon-quad
  55              	
  56              		.text
  57              	.Ltext0:
  58              		.cfi_sections	.debug_frame
  59              		.align	1
  60              		.syntax unified
  61              		.thumb
  62              		.thumb_func
  63              		.fpu neon
  65              	__isspace:
  66              	.LFB0:
  67              		.file 1 "c:\\program files (x86)\\microsoft azure sphere sdk\\sysroot\\usr\\include\\ctype.h"
   1:c:\program files (x86)\microsoft azure sphere sdk\sysroot\usr\include\ctype.h **** #ifndef	_CTYPE_H
   2:c:\program files (x86)\microsoft azure sphere sdk\sysroot\usr\include\ctype.h **** #define	_CTYPE_H
   3:c:\program files (x86)\microsoft azure sphere sdk\sysroot\usr\include\ctype.h **** 
   4:c:\program files (x86)\microsoft azure sphere sdk\sysroot\usr\include\ctype.h **** #ifdef __cplusplus
   5:c:\program files (x86)\microsoft azure sphere sdk\sysroot\usr\include\ctype.h **** extern "C" {
   6:c:\program files (x86)\microsoft azure sphere sdk\sysroot\usr\include\ctype.h **** #endif
   7:c:\program files (x86)\microsoft azure sphere sdk\sysroot\usr\include\ctype.h **** 
   8:c:\program files (x86)\microsoft azure sphere sdk\sysroot\usr\include\ctype.h **** #include <features.h>
   9:c:\program files (x86)\microsoft azure sphere sdk\sysroot\usr\include\ctype.h **** 
  10:c:\program files (x86)\microsoft azure sphere sdk\sysroot\usr\include\ctype.h **** int   isalnum(int);
  11:c:\program files (x86)\microsoft azure sphere sdk\sysroot\usr\include\ctype.h **** int   isalpha(int);
  12:c:\program files (x86)\microsoft azure sphere sdk\sysroot\usr\include\ctype.h **** int   isblank(int);
  13:c:\program files (x86)\microsoft azure sphere sdk\sysroot\usr\include\ctype.h **** int   iscntrl(int);
  14:c:\program files (x86)\microsoft azure sphere sdk\sysroot\usr\include\ctype.h **** int   isdigit(int);
  15:c:\program files (x86)\microsoft azure sphere sdk\sysroot\usr\include\ctype.h **** int   isgraph(int);
  16:c:\program files (x86)\microsoft azure sphere sdk\sysroot\usr\include\ctype.h **** int   islower(int);
  17:c:\program files (x86)\microsoft azure sphere sdk\sysroot\usr\include\ctype.h **** int   isprint(int);
  18:c:\program files (x86)\microsoft azure sphere sdk\sysroot\usr\include\ctype.h **** int   ispunct(int);
  19:c:\program files (x86)\microsoft azure sphere sdk\sysroot\usr\include\ctype.h **** int   isspace(int);
  20:c:\program files (x86)\microsoft azure sphere sdk\sysroot\usr\include\ctype.h **** int   isupper(int);
  21:c:\program files (x86)\microsoft azure sphere sdk\sysroot\usr\include\ctype.h **** int   isxdigit(int);
  22:c:\program files (x86)\microsoft azure sphere sdk\sysroot\usr\include\ctype.h **** int   tolower(int);
  23:c:\program files (x86)\microsoft azure sphere sdk\sysroot\usr\include\ctype.h **** int   toupper(int);
  24:c:\program files (x86)\microsoft azure sphere sdk\sysroot\usr\include\ctype.h **** 
  25:c:\program files (x86)\microsoft azure sphere sdk\sysroot\usr\include\ctype.h **** #ifndef __cplusplus
  26:c:\program files (x86)\microsoft azure sphere sdk\sysroot\usr\include\ctype.h **** static __inline int __isspace(int _c)
  27:c:\program files (x86)\microsoft azure sphere sdk\sysroot\usr\include\ctype.h **** {
  68              		.loc 1 27 0
  69              		.cfi_startproc
  70              		@ args = 0, pretend = 0, frame = 8
  71              		@ frame_needed = 1, uses_anonymous_args = 0
  72              		@ link register save eliminated.
  73 0000 80B4     		push	{r7}	@
  74              	.LCFI0:
  75              		.cfi_def_cfa_offset 4
  76              		.cfi_offset 7, -4
  77 0002 83B0     		sub	sp, sp, #12	@,,
  78              	.LCFI1:
  79              		.cfi_def_cfa_offset 16
  80 0004 00AF     		add	r7, sp, #0	@,,
  81              	.LCFI2:
  82              		.cfi_def_cfa_register 7
  83 0006 7860     		str	r0, [r7, #4]	@ _c, _c
  28:c:\program files (x86)\microsoft azure sphere sdk\sysroot\usr\include\ctype.h **** 	return _c == ' ' || (unsigned)_c-'\t' < 5;
  84              		.loc 1 28 0
  85 0008 7B68     		ldr	r3, [r7, #4]	@ tmp114, _c
  86 000a 202B     		cmp	r3, #32	@ tmp114,
  87 000c 03D0     		beq	.L2	@,
  88              		.loc 1 28 0 is_stmt 0 discriminator 2
  89 000e 7B68     		ldr	r3, [r7, #4]	@ _c.81_3, _c
  90 0010 093B     		subs	r3, r3, #9	@ _4, _c.81_3,
  91 0012 042B     		cmp	r3, #4	@ _4,
  92 0014 01D8     		bhi	.L3	@,
  93              	.L2:
  94              		.loc 1 28 0 discriminator 3
  95 0016 0123     		movs	r3, #1	@ iftmp.80_1,
  96 0018 00E0     		b	.L5	@
  97              	.L3:
  98              		.loc 1 28 0 discriminator 4
  99 001a 0023     		movs	r3, #0	@ iftmp.80_1,
 100              	.L5:
  29:c:\program files (x86)\microsoft azure sphere sdk\sysroot\usr\include\ctype.h **** }
 101              		.loc 1 29 0 is_stmt 1 discriminator 7
 102 001c 1846     		mov	r0, r3	@, <retval>
 103 001e 0C37     		adds	r7, r7, #12	@,,
 104              	.LCFI3:
 105              		.cfi_def_cfa_offset 4
 106 0020 BD46     		mov	sp, r7	@,
 107              	.LCFI4:
 108              		.cfi_def_cfa_register 13
 109              		@ sp needed	@
 110 0022 5DF8047B 		ldr	r7, [sp], #4	@,
 111              	.LCFI5:
 112              		.cfi_restore 7
 113              		.cfi_def_cfa_offset 0
 114 0026 7047     		bx	lr	@
 115              		.cfi_endproc
 116              	.LFE0:
 118              		.data
 119              		.align	2
 122              	parson_malloc:
 123 0000 00000000 		.word	malloc
 124              		.align	2
 127              	parson_free:
 128 0004 00000000 		.word	free
 129              		.text
 130              		.align	1
 131              		.syntax unified
 132              		.thumb
 133              		.thumb_func
 134              		.fpu neon
 136              	parson_strndup:
 137              	.LFB18:
 138              		.file 2 "parson.c"
   1:parson.c      **** ﻿/*
   2:parson.c      ****     This source code comes from Git repository
   3:parson.c      ****     https://github.com/kgabis/parson at commit id 4f3eaa6
   4:parson.c      ****     Patched to avoid any usage of fopen(), and removed implicit
   5:parson.c      ****     cast warnings by making them explicit.
   6:parson.c      **** */
   7:parson.c      **** 
   8:parson.c      **** /*
   9:parson.c      ****  Parson ( http://kgabis.github.com/parson/ )
  10:parson.c      ****  Copyright (c) 2012 - 2017 Krzysztof Gabis
  11:parson.c      **** 
  12:parson.c      ****  Permission is hereby granted, free of charge, to any person obtaining a copy
  13:parson.c      ****  of this software and associated documentation files (the "Software"), to deal
  14:parson.c      ****  in the Software without restriction, including without limitation the rights
  15:parson.c      ****  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
  16:parson.c      ****  copies of the Software, and to permit persons to whom the Software is
  17:parson.c      ****  furnished to do so, subject to the following conditions:
  18:parson.c      **** 
  19:parson.c      ****  The above copyright notice and this permission notice shall be included in
  20:parson.c      ****  all copies or substantial portions of the Software.
  21:parson.c      **** 
  22:parson.c      ****  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  23:parson.c      ****  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  24:parson.c      ****  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  25:parson.c      ****  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  26:parson.c      ****  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  27:parson.c      ****  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  28:parson.c      ****  THE SOFTWARE.
  29:parson.c      **** */
  30:parson.c      **** #ifdef _MSC_VER
  31:parson.c      **** #ifndef _CRT_SECURE_NO_WARNINGS
  32:parson.c      **** #define _CRT_SECURE_NO_WARNINGS
  33:parson.c      **** #endif /* _CRT_SECURE_NO_WARNINGS */
  34:parson.c      **** #endif /* _MSC_VER */
  35:parson.c      **** 
  36:parson.c      **** #include "parson.h"
  37:parson.c      **** 
  38:parson.c      **** #include <stdio.h>
  39:parson.c      **** #include <stdlib.h>
  40:parson.c      **** #include <string.h>
  41:parson.c      **** #include <ctype.h>
  42:parson.c      **** #include <math.h>
  43:parson.c      **** #include <errno.h>
  44:parson.c      **** 
  45:parson.c      **** /* Apparently sscanf is not implemented in some "standard" libraries, so don't use it, if you
  46:parson.c      ****  * don't have to. */
  47:parson.c      **** #define sscanf THINK_TWICE_ABOUT_USING_SSCANF
  48:parson.c      **** 
  49:parson.c      **** #define STARTING_CAPACITY 16
  50:parson.c      **** #define MAX_NESTING 2048
  51:parson.c      **** 
  52:parson.c      **** #define FLOAT_FORMAT "%1.17g" /* do not increase precision without incresing NUM_BUF_SIZE */
  53:parson.c      **** /* double printed with "%1.17g" shouldn't be longer than 25 bytes so let's use 64 */
  54:parson.c      **** #define NUM_BUF_SIZE 64
  55:parson.c      **** 
  56:parson.c      **** #define SIZEOF_TOKEN(a) (sizeof(a) - 1)
  57:parson.c      **** #define SKIP_CHAR(str) ((*str)++)
  58:parson.c      **** #define SKIP_WHITESPACES(str)                 \
  59:parson.c      ****     while (isspace((unsigned char)(**str))) { \
  60:parson.c      ****         SKIP_CHAR(str);                       \
  61:parson.c      ****     }
  62:parson.c      **** #define MAX(a, b) ((a) > (b) ? (a) : (b))
  63:parson.c      **** 
  64:parson.c      **** #undef malloc
  65:parson.c      **** #undef free
  66:parson.c      **** 
  67:parson.c      **** static JSON_Malloc_Function parson_malloc = malloc;
  68:parson.c      **** static JSON_Free_Function parson_free = free;
  69:parson.c      **** 
  70:parson.c      **** #define IS_CONT(b) (((unsigned char)(b)&0xC0) == 0x80) /* is utf-8 continuation byte */
  71:parson.c      **** 
  72:parson.c      **** /* Type definitions */
  73:parson.c      **** typedef union json_value_value {
  74:parson.c      ****     char *string;
  75:parson.c      ****     double number;
  76:parson.c      ****     JSON_Object *object;
  77:parson.c      ****     JSON_Array *array;
  78:parson.c      ****     int boolean;
  79:parson.c      ****     int null;
  80:parson.c      **** } JSON_Value_Value;
  81:parson.c      **** 
  82:parson.c      **** struct json_value_t {
  83:parson.c      ****     JSON_Value *parent;
  84:parson.c      ****     JSON_Value_Type type;
  85:parson.c      ****     JSON_Value_Value value;
  86:parson.c      **** };
  87:parson.c      **** 
  88:parson.c      **** struct json_object_t {
  89:parson.c      ****     JSON_Value *wrapping_value;
  90:parson.c      ****     char **names;
  91:parson.c      ****     JSON_Value **values;
  92:parson.c      ****     size_t count;
  93:parson.c      ****     size_t capacity;
  94:parson.c      **** };
  95:parson.c      **** 
  96:parson.c      **** struct json_array_t {
  97:parson.c      ****     JSON_Value *wrapping_value;
  98:parson.c      ****     JSON_Value **items;
  99:parson.c      ****     size_t count;
 100:parson.c      ****     size_t capacity;
 101:parson.c      **** };
 102:parson.c      **** 
 103:parson.c      **** /* Various */
 104:parson.c      **** static void remove_comments(char *string, const char *start_token, const char *end_token);
 105:parson.c      **** static char *parson_strndup(const char *string, size_t n);
 106:parson.c      **** static char *parson_strdup(const char *string);
 107:parson.c      **** static int hex_char_to_int(char c);
 108:parson.c      **** static int parse_utf16_hex(const char *string, unsigned int *result);
 109:parson.c      **** static int num_bytes_in_utf8_sequence(unsigned char c);
 110:parson.c      **** static int verify_utf8_sequence(const unsigned char *string, int *len);
 111:parson.c      **** static int is_valid_utf8(const char *string, size_t string_len);
 112:parson.c      **** static int is_decimal(const char *string, size_t length);
 113:parson.c      **** 
 114:parson.c      **** /* JSON Object */
 115:parson.c      **** static JSON_Object *json_object_init(JSON_Value *wrapping_value);
 116:parson.c      **** static JSON_Status json_object_add(JSON_Object *object, const char *name, JSON_Value *value);
 117:parson.c      **** static JSON_Status json_object_addn(JSON_Object *object, const char *name, size_t name_len,
 118:parson.c      ****                                     JSON_Value *value);
 119:parson.c      **** static JSON_Status json_object_resize(JSON_Object *object, size_t new_capacity);
 120:parson.c      **** static JSON_Value *json_object_getn_value(const JSON_Object *object, const char *name,
 121:parson.c      ****                                           size_t name_len);
 122:parson.c      **** static JSON_Status json_object_remove_internal(JSON_Object *object, const char *name,
 123:parson.c      ****                                                int free_value);
 124:parson.c      **** static JSON_Status json_object_dotremove_internal(JSON_Object *object, const char *name,
 125:parson.c      ****                                                   int free_value);
 126:parson.c      **** static void json_object_free(JSON_Object *object);
 127:parson.c      **** 
 128:parson.c      **** /* JSON Array */
 129:parson.c      **** static JSON_Array *json_array_init(JSON_Value *wrapping_value);
 130:parson.c      **** static JSON_Status json_array_add(JSON_Array *array, JSON_Value *value);
 131:parson.c      **** static JSON_Status json_array_resize(JSON_Array *array, size_t new_capacity);
 132:parson.c      **** static void json_array_free(JSON_Array *array);
 133:parson.c      **** 
 134:parson.c      **** /* JSON Value */
 135:parson.c      **** static JSON_Value *json_value_init_string_no_copy(char *string);
 136:parson.c      **** 
 137:parson.c      **** /* Parser */
 138:parson.c      **** static JSON_Status skip_quotes(const char **string);
 139:parson.c      **** static int parse_utf16(const char **unprocessed, char **processed);
 140:parson.c      **** static char *process_string(const char *input, size_t len);
 141:parson.c      **** static char *get_quoted_string(const char **string);
 142:parson.c      **** static JSON_Value *parse_object_value(const char **string, size_t nesting);
 143:parson.c      **** static JSON_Value *parse_array_value(const char **string, size_t nesting);
 144:parson.c      **** static JSON_Value *parse_string_value(const char **string);
 145:parson.c      **** static JSON_Value *parse_boolean_value(const char **string);
 146:parson.c      **** static JSON_Value *parse_number_value(const char **string);
 147:parson.c      **** static JSON_Value *parse_null_value(const char **string);
 148:parson.c      **** static JSON_Value *parse_value(const char **string, size_t nesting);
 149:parson.c      **** 
 150:parson.c      **** /* Serialization */
 151:parson.c      **** static int json_serialize_to_buffer_r(const JSON_Value *value, char *buf, int level, int is_pretty,
 152:parson.c      ****                                       char *num_buf);
 153:parson.c      **** static int json_serialize_string(const char *string, char *buf);
 154:parson.c      **** static int append_indent(char *buf, int level);
 155:parson.c      **** static int append_string(char *buf, const char *string);
 156:parson.c      **** 
 157:parson.c      **** /* Various */
 158:parson.c      **** static char *parson_strndup(const char *string, size_t n)
 159:parson.c      **** {
 139              		.loc 2 159 0
 140              		.cfi_startproc
 141              		@ args = 0, pretend = 0, frame = 16
 142              		@ frame_needed = 1, uses_anonymous_args = 0
 143 0028 80B5     		push	{r7, lr}	@
 144              	.LCFI6:
 145              		.cfi_def_cfa_offset 8
 146              		.cfi_offset 7, -8
 147              		.cfi_offset 14, -4
 148 002a 84B0     		sub	sp, sp, #16	@,,
 149              	.LCFI7:
 150              		.cfi_def_cfa_offset 24
 151 002c 00AF     		add	r7, sp, #0	@,,
 152              	.LCFI8:
 153              		.cfi_def_cfa_register 7
 154 002e 7860     		str	r0, [r7, #4]	@ string, string
 155 0030 3960     		str	r1, [r7]	@ n, n
 160:parson.c      ****     char *output_string = (char *)parson_malloc(n + 1);
 156              		.loc 2 160 0
 157 0032 40F20003 		movw	r3, #:lower16:parson_malloc	@ tmp115,
 158 0036 C0F20003 		movt	r3, #:upper16:parson_malloc	@ tmp115,
 159 003a 1B68     		ldr	r3, [r3]	@ parson_malloc.0_4, parson_malloc
 160 003c 3A68     		ldr	r2, [r7]	@ tmp116, n
 161 003e 0132     		adds	r2, r2, #1	@ _6, tmp116,
 162 0040 1046     		mov	r0, r2	@, _6
 163 0042 9847     		blx	r3	@ parson_malloc.0_4
 164              	.LVL0:
 165 0044 F860     		str	r0, [r7, #12]	@, output_string
 161:parson.c      ****     if (!output_string) {
 166              		.loc 2 161 0
 167 0046 FB68     		ldr	r3, [r7, #12]	@ tmp117, output_string
 168 0048 002B     		cmp	r3, #0	@ tmp117,
 169 004a 01D1     		bne	.L7	@,
 162:parson.c      ****         return NULL;
 170              		.loc 2 162 0
 171 004c 0023     		movs	r3, #0	@ _1,
 172 004e 0AE0     		b	.L8	@
 173              	.L7:
 163:parson.c      ****     }
 164:parson.c      ****     output_string[n] = '\0';
 174              		.loc 2 164 0
 175 0050 FA68     		ldr	r2, [r7, #12]	@ tmp118, output_string
 176 0052 3B68     		ldr	r3, [r7]	@ tmp119, n
 177 0054 1344     		add	r3, r3, r2	@ _10, tmp118
 178 0056 0022     		movs	r2, #0	@ tmp120,
 179 0058 1A70     		strb	r2, [r3]	@ tmp121, *_10
 165:parson.c      ****     strncpy(output_string, string, n);
 180              		.loc 2 165 0
 181 005a 3A68     		ldr	r2, [r7]	@, n
 182 005c 7968     		ldr	r1, [r7, #4]	@, string
 183 005e F868     		ldr	r0, [r7, #12]	@, output_string
 184 0060 FFF7FEFF 		bl	strncpy	@
 166:parson.c      ****     return output_string;
 185              		.loc 2 166 0
 186 0064 FB68     		ldr	r3, [r7, #12]	@ _1, output_string
 187              	.L8:
 167:parson.c      **** }
 188              		.loc 2 167 0
 189 0066 1846     		mov	r0, r3	@, <retval>
 190 0068 1037     		adds	r7, r7, #16	@,,
 191              	.LCFI9:
 192              		.cfi_def_cfa_offset 8
 193 006a BD46     		mov	sp, r7	@,
 194              	.LCFI10:
 195              		.cfi_def_cfa_register 13
 196              		@ sp needed	@
 197 006c 80BD     		pop	{r7, pc}	@
 198              		.cfi_endproc
 199              	.LFE18:
 201              		.align	1
 202              		.syntax unified
 203              		.thumb
 204              		.thumb_func
 205              		.fpu neon
 207              	parson_strdup:
 208              	.LFB19:
 168:parson.c      **** 
 169:parson.c      **** static char *parson_strdup(const char *string)
 170:parson.c      **** {
 209              		.loc 2 170 0
 210              		.cfi_startproc
 211              		@ args = 0, pretend = 0, frame = 8
 212              		@ frame_needed = 1, uses_anonymous_args = 0
 213 006e 80B5     		push	{r7, lr}	@
 214              	.LCFI11:
 215              		.cfi_def_cfa_offset 8
 216              		.cfi_offset 7, -8
 217              		.cfi_offset 14, -4
 218 0070 82B0     		sub	sp, sp, #8	@,,
 219              	.LCFI12:
 220              		.cfi_def_cfa_offset 16
 221 0072 00AF     		add	r7, sp, #0	@,,
 222              	.LCFI13:
 223              		.cfi_def_cfa_register 7
 224 0074 7860     		str	r0, [r7, #4]	@ string, string
 171:parson.c      ****     return parson_strndup(string, strlen(string));
 225              		.loc 2 171 0
 226 0076 7868     		ldr	r0, [r7, #4]	@, string
 227 0078 FFF7FEFF 		bl	strlen	@
 228 007c 0346     		mov	r3, r0	@ _3,
 229 007e 1946     		mov	r1, r3	@, _3
 230 0080 7868     		ldr	r0, [r7, #4]	@, string
 231 0082 FFF7D1FF 		bl	parson_strndup	@
 232 0086 0346     		mov	r3, r0	@ _5,
 172:parson.c      **** }
 233              		.loc 2 172 0
 234 0088 1846     		mov	r0, r3	@, <retval>
 235 008a 0837     		adds	r7, r7, #8	@,,
 236              	.LCFI14:
 237              		.cfi_def_cfa_offset 8
 238 008c BD46     		mov	sp, r7	@,
 239              	.LCFI15:
 240              		.cfi_def_cfa_register 13
 241              		@ sp needed	@
 242 008e 80BD     		pop	{r7, pc}	@
 243              		.cfi_endproc
 244              	.LFE19:
 246              		.align	1
 247              		.syntax unified
 248              		.thumb
 249              		.thumb_func
 250              		.fpu neon
 252              	hex_char_to_int:
 253              	.LFB20:
 173:parson.c      **** 
 174:parson.c      **** static int hex_char_to_int(char c)
 175:parson.c      **** {
 254              		.loc 2 175 0
 255              		.cfi_startproc
 256              		@ args = 0, pretend = 0, frame = 8
 257              		@ frame_needed = 1, uses_anonymous_args = 0
 258              		@ link register save eliminated.
 259 0090 80B4     		push	{r7}	@
 260              	.LCFI16:
 261              		.cfi_def_cfa_offset 4
 262              		.cfi_offset 7, -4
 263 0092 83B0     		sub	sp, sp, #12	@,,
 264              	.LCFI17:
 265              		.cfi_def_cfa_offset 16
 266 0094 00AF     		add	r7, sp, #0	@,,
 267              	.LCFI18:
 268              		.cfi_def_cfa_register 7
 269 0096 0346     		mov	r3, r0	@ tmp115, c
 270 0098 FB71     		strb	r3, [r7, #7]	@ tmp116, c
 176:parson.c      ****     if (c >= '0' && c <= '9') {
 271              		.loc 2 176 0
 272 009a FB79     		ldrb	r3, [r7, #7]	@ zero_extendqisi2	@ tmp117, c
 273 009c 2F2B     		cmp	r3, #47	@ tmp117,
 274 009e 05D9     		bls	.L12	@,
 275              		.loc 2 176 0 is_stmt 0 discriminator 1
 276 00a0 FB79     		ldrb	r3, [r7, #7]	@ zero_extendqisi2	@ tmp118, c
 277 00a2 392B     		cmp	r3, #57	@ tmp118,
 278 00a4 02D8     		bhi	.L12	@,
 177:parson.c      ****         return c - '0';
 279              		.loc 2 177 0 is_stmt 1
 280 00a6 FB79     		ldrb	r3, [r7, #7]	@ zero_extendqisi2	@ _3, c
 281 00a8 303B     		subs	r3, r3, #48	@ _1, _3,
 282 00aa 13E0     		b	.L13	@
 283              	.L12:
 178:parson.c      ****     } else if (c >= 'a' && c <= 'f') {
 284              		.loc 2 178 0
 285 00ac FB79     		ldrb	r3, [r7, #7]	@ zero_extendqisi2	@ tmp119, c
 286 00ae 602B     		cmp	r3, #96	@ tmp119,
 287 00b0 05D9     		bls	.L14	@,
 288              		.loc 2 178 0 is_stmt 0 discriminator 1
 289 00b2 FB79     		ldrb	r3, [r7, #7]	@ zero_extendqisi2	@ tmp120, c
 290 00b4 662B     		cmp	r3, #102	@ tmp120,
 291 00b6 02D8     		bhi	.L14	@,
 179:parson.c      ****         return c - 'a' + 10;
 292              		.loc 2 179 0 is_stmt 1
 293 00b8 FB79     		ldrb	r3, [r7, #7]	@ zero_extendqisi2	@ _5, c
 294 00ba 573B     		subs	r3, r3, #87	@ _1, _5,
 295 00bc 0AE0     		b	.L13	@
 296              	.L14:
 180:parson.c      ****     } else if (c >= 'A' && c <= 'F') {
 297              		.loc 2 180 0
 298 00be FB79     		ldrb	r3, [r7, #7]	@ zero_extendqisi2	@ tmp121, c
 299 00c0 402B     		cmp	r3, #64	@ tmp121,
 300 00c2 05D9     		bls	.L15	@,
 301              		.loc 2 180 0 is_stmt 0 discriminator 1
 302 00c4 FB79     		ldrb	r3, [r7, #7]	@ zero_extendqisi2	@ tmp122, c
 303 00c6 462B     		cmp	r3, #70	@ tmp122,
 304 00c8 02D8     		bhi	.L15	@,
 181:parson.c      ****         return c - 'A' + 10;
 305              		.loc 2 181 0 is_stmt 1
 306 00ca FB79     		ldrb	r3, [r7, #7]	@ zero_extendqisi2	@ _7, c
 307 00cc 373B     		subs	r3, r3, #55	@ _1, _7,
 308 00ce 01E0     		b	.L13	@
 309              	.L15:
 182:parson.c      ****     }
 183:parson.c      ****     return -1;
 310              		.loc 2 183 0
 311 00d0 4FF0FF33 		mov	r3, #-1	@ _1,
 312              	.L13:
 184:parson.c      **** }
 313              		.loc 2 184 0
 314 00d4 1846     		mov	r0, r3	@, <retval>
 315 00d6 0C37     		adds	r7, r7, #12	@,,
 316              	.LCFI19:
 317              		.cfi_def_cfa_offset 4
 318 00d8 BD46     		mov	sp, r7	@,
 319              	.LCFI20:
 320              		.cfi_def_cfa_register 13
 321              		@ sp needed	@
 322 00da 5DF8047B 		ldr	r7, [sp], #4	@,
 323              	.LCFI21:
 324              		.cfi_restore 7
 325              		.cfi_def_cfa_offset 0
 326 00de 7047     		bx	lr	@
 327              		.cfi_endproc
 328              	.LFE20:
 330              		.align	1
 331              		.syntax unified
 332              		.thumb
 333              		.thumb_func
 334              		.fpu neon
 336              	parse_utf16_hex:
 337              	.LFB21:
 185:parson.c      **** 
 186:parson.c      **** static int parse_utf16_hex(const char *s, unsigned int *result)
 187:parson.c      **** {
 338              		.loc 2 187 0
 339              		.cfi_startproc
 340              		@ args = 0, pretend = 0, frame = 24
 341              		@ frame_needed = 1, uses_anonymous_args = 0
 342 00e0 80B5     		push	{r7, lr}	@
 343              	.LCFI22:
 344              		.cfi_def_cfa_offset 8
 345              		.cfi_offset 7, -8
 346              		.cfi_offset 14, -4
 347 00e2 86B0     		sub	sp, sp, #24	@,,
 348              	.LCFI23:
 349              		.cfi_def_cfa_offset 32
 350 00e4 00AF     		add	r7, sp, #0	@,,
 351              	.LCFI24:
 352              		.cfi_def_cfa_register 7
 353 00e6 7860     		str	r0, [r7, #4]	@ s, s
 354 00e8 3960     		str	r1, [r7]	@ result, result
 188:parson.c      ****     int x1, x2, x3, x4;
 189:parson.c      ****     if (s[0] == '\0' || s[1] == '\0' || s[2] == '\0' || s[3] == '\0') {
 355              		.loc 2 189 0
 356 00ea 7B68     		ldr	r3, [r7, #4]	@ tmp133, s
 357 00ec 1B78     		ldrb	r3, [r3]	@ zero_extendqisi2	@ _5, *s_4(D)
 358 00ee 002B     		cmp	r3, #0	@ _5,
 359 00f0 0ED0     		beq	.L17	@,
 360              		.loc 2 189 0 is_stmt 0 discriminator 1
 361 00f2 7B68     		ldr	r3, [r7, #4]	@ tmp134, s
 362 00f4 0133     		adds	r3, r3, #1	@ _6, tmp134,
 363 00f6 1B78     		ldrb	r3, [r3]	@ zero_extendqisi2	@ _7, *_6
 364 00f8 002B     		cmp	r3, #0	@ _7,
 365 00fa 09D0     		beq	.L17	@,
 366              		.loc 2 189 0 discriminator 2
 367 00fc 7B68     		ldr	r3, [r7, #4]	@ tmp135, s
 368 00fe 0233     		adds	r3, r3, #2	@ _8, tmp135,
 369 0100 1B78     		ldrb	r3, [r3]	@ zero_extendqisi2	@ _9, *_8
 370 0102 002B     		cmp	r3, #0	@ _9,
 371 0104 04D0     		beq	.L17	@,
 372              		.loc 2 189 0 discriminator 3
 373 0106 7B68     		ldr	r3, [r7, #4]	@ tmp136, s
 374 0108 0333     		adds	r3, r3, #3	@ _10, tmp136,
 375 010a 1B78     		ldrb	r3, [r3]	@ zero_extendqisi2	@ _11, *_10
 376 010c 002B     		cmp	r3, #0	@ _11,
 377 010e 01D1     		bne	.L18	@,
 378              	.L17:
 190:parson.c      ****         return 0;
 379              		.loc 2 190 0 is_stmt 1
 380 0110 0023     		movs	r3, #0	@ _1,
 381 0112 3AE0     		b	.L19	@
 382              	.L18:
 191:parson.c      ****     }
 192:parson.c      ****     x1 = hex_char_to_int(s[0]);
 383              		.loc 2 192 0
 384 0114 7B68     		ldr	r3, [r7, #4]	@ tmp137, s
 385 0116 1B78     		ldrb	r3, [r3]	@ zero_extendqisi2	@ _12, *s_4(D)
 386 0118 1846     		mov	r0, r3	@, _12
 387 011a FFF7B9FF 		bl	hex_char_to_int	@
 388 011e 7861     		str	r0, [r7, #20]	@, x1
 193:parson.c      ****     x2 = hex_char_to_int(s[1]);
 389              		.loc 2 193 0
 390 0120 7B68     		ldr	r3, [r7, #4]	@ tmp138, s
 391 0122 0133     		adds	r3, r3, #1	@ _15, tmp138,
 392 0124 1B78     		ldrb	r3, [r3]	@ zero_extendqisi2	@ _16, *_15
 393 0126 1846     		mov	r0, r3	@, _16
 394 0128 FFF7B2FF 		bl	hex_char_to_int	@
 395 012c 3861     		str	r0, [r7, #16]	@, x2
 194:parson.c      ****     x3 = hex_char_to_int(s[2]);
 396              		.loc 2 194 0
 397 012e 7B68     		ldr	r3, [r7, #4]	@ tmp139, s
 398 0130 0233     		adds	r3, r3, #2	@ _19, tmp139,
 399 0132 1B78     		ldrb	r3, [r3]	@ zero_extendqisi2	@ _20, *_19
 400 0134 1846     		mov	r0, r3	@, _20
 401 0136 FFF7ABFF 		bl	hex_char_to_int	@
 402 013a F860     		str	r0, [r7, #12]	@, x3
 195:parson.c      ****     x4 = hex_char_to_int(s[3]);
 403              		.loc 2 195 0
 404 013c 7B68     		ldr	r3, [r7, #4]	@ tmp140, s
 405 013e 0333     		adds	r3, r3, #3	@ _23, tmp140,
 406 0140 1B78     		ldrb	r3, [r3]	@ zero_extendqisi2	@ _24, *_23
 407 0142 1846     		mov	r0, r3	@, _24
 408 0144 FFF7A4FF 		bl	hex_char_to_int	@
 409 0148 B860     		str	r0, [r7, #8]	@, x4
 196:parson.c      ****     if (x1 == -1 || x2 == -1 || x3 == -1 || x4 == -1) {
 410              		.loc 2 196 0
 411 014a 7B69     		ldr	r3, [r7, #20]	@ tmp141, x1
 412 014c B3F1FF3F 		cmp	r3, #-1	@ tmp141,
 413 0150 0BD0     		beq	.L20	@,
 414              		.loc 2 196 0 is_stmt 0 discriminator 1
 415 0152 3B69     		ldr	r3, [r7, #16]	@ tmp142, x2
 416 0154 B3F1FF3F 		cmp	r3, #-1	@ tmp142,
 417 0158 07D0     		beq	.L20	@,
 418              		.loc 2 196 0 discriminator 2
 419 015a FB68     		ldr	r3, [r7, #12]	@ tmp143, x3
 420 015c B3F1FF3F 		cmp	r3, #-1	@ tmp143,
 421 0160 03D0     		beq	.L20	@,
 422              		.loc 2 196 0 discriminator 3
 423 0162 BB68     		ldr	r3, [r7, #8]	@ tmp144, x4
 424 0164 B3F1FF3F 		cmp	r3, #-1	@ tmp144,
 425 0168 01D1     		bne	.L21	@,
 426              	.L20:
 197:parson.c      ****         return 0;
 427              		.loc 2 197 0 is_stmt 1
 428 016a 0023     		movs	r3, #0	@ _1,
 429 016c 0DE0     		b	.L19	@
 430              	.L21:
 198:parson.c      ****     }
 199:parson.c      ****     *result = (unsigned int)((x1 << 12) | (x2 << 8) | (x3 << 4) | x4);
 431              		.loc 2 199 0
 432 016e 7B69     		ldr	r3, [r7, #20]	@ tmp145, x1
 433 0170 1A03     		lsls	r2, r3, #12	@ _27, tmp145,
 434 0172 3B69     		ldr	r3, [r7, #16]	@ tmp146, x2
 435 0174 1B02     		lsls	r3, r3, #8	@ _28, tmp146,
 436 0176 1A43     		orrs	r2, r2, r3	@, _29, _27, _28
 437 0178 FB68     		ldr	r3, [r7, #12]	@ tmp147, x3
 438 017a 1B01     		lsls	r3, r3, #4	@ _30, tmp147,
 439 017c 1A43     		orrs	r2, r2, r3	@, _31, _29, _30
 440 017e BB68     		ldr	r3, [r7, #8]	@ tmp148, x4
 441 0180 1343     		orrs	r3, r3, r2	@, _32, tmp148, _31
 442 0182 1A46     		mov	r2, r3	@ _33, _32
 443 0184 3B68     		ldr	r3, [r7]	@ tmp149, result
 444 0186 1A60     		str	r2, [r3]	@ _33, *result_34(D)
 200:parson.c      ****     return 1;
 445              		.loc 2 200 0
 446 0188 0123     		movs	r3, #1	@ _1,
 447              	.L19:
 201:parson.c      **** }
 448              		.loc 2 201 0
 449 018a 1846     		mov	r0, r3	@, <retval>
 450 018c 1837     		adds	r7, r7, #24	@,,
 451              	.LCFI25:
 452              		.cfi_def_cfa_offset 8
 453 018e BD46     		mov	sp, r7	@,
 454              	.LCFI26:
 455              		.cfi_def_cfa_register 13
 456              		@ sp needed	@
 457 0190 80BD     		pop	{r7, pc}	@
 458              		.cfi_endproc
 459              	.LFE21:
 461              		.align	1
 462              		.syntax unified
 463              		.thumb
 464              		.thumb_func
 465              		.fpu neon
 467              	num_bytes_in_utf8_sequence:
 468              	.LFB22:
 202:parson.c      **** 
 203:parson.c      **** static int num_bytes_in_utf8_sequence(unsigned char c)
 204:parson.c      **** {
 469              		.loc 2 204 0
 470              		.cfi_startproc
 471              		@ args = 0, pretend = 0, frame = 8
 472              		@ frame_needed = 1, uses_anonymous_args = 0
 473              		@ link register save eliminated.
 474 0192 80B4     		push	{r7}	@
 475              	.LCFI27:
 476              		.cfi_def_cfa_offset 4
 477              		.cfi_offset 7, -4
 478 0194 83B0     		sub	sp, sp, #12	@,,
 479              	.LCFI28:
 480              		.cfi_def_cfa_offset 16
 481 0196 00AF     		add	r7, sp, #0	@,,
 482              	.LCFI29:
 483              		.cfi_def_cfa_register 7
 484 0198 0346     		mov	r3, r0	@ tmp121, c
 485 019a FB71     		strb	r3, [r7, #7]	@ tmp122, c
 205:parson.c      ****     if (c == 0xC0 || c == 0xC1 || c > 0xF4 || IS_CONT(c)) {
 486              		.loc 2 205 0
 487 019c FB79     		ldrb	r3, [r7, #7]	@ zero_extendqisi2	@ tmp123, c
 488 019e C02B     		cmp	r3, #192	@ tmp123,
 489 01a0 0AD0     		beq	.L23	@,
 490              		.loc 2 205 0 is_stmt 0 discriminator 1
 491 01a2 FB79     		ldrb	r3, [r7, #7]	@ zero_extendqisi2	@ tmp124, c
 492 01a4 C12B     		cmp	r3, #193	@ tmp124,
 493 01a6 07D0     		beq	.L23	@,
 494              		.loc 2 205 0 discriminator 2
 495 01a8 FB79     		ldrb	r3, [r7, #7]	@ zero_extendqisi2	@ tmp125, c
 496 01aa F42B     		cmp	r3, #244	@ tmp125,
 497 01ac 04D8     		bhi	.L23	@,
 498              		.loc 2 205 0 discriminator 3
 499 01ae FB79     		ldrb	r3, [r7, #7]	@ zero_extendqisi2	@ _3, c
 500 01b0 03F0C003 		and	r3, r3, #192	@ _4, _3,
 501 01b4 802B     		cmp	r3, #128	@ _4,
 502 01b6 01D1     		bne	.L24	@,
 503              	.L23:
 206:parson.c      ****         return 0;
 504              		.loc 2 206 0 is_stmt 1
 505 01b8 0023     		movs	r3, #0	@ _1,
 506 01ba 1BE0     		b	.L25	@
 507              	.L24:
 207:parson.c      ****     } else if ((c & 0x80) == 0) { /* 0xxxxxxx */
 508              		.loc 2 207 0
 509 01bc 97F90730 		ldrsb	r3, [r7, #7]	@ c.1_5, c
 510 01c0 002B     		cmp	r3, #0	@ c.1_5,
 511 01c2 01DB     		blt	.L26	@,
 208:parson.c      ****         return 1;
 512              		.loc 2 208 0
 513 01c4 0123     		movs	r3, #1	@ _1,
 514 01c6 15E0     		b	.L25	@
 515              	.L26:
 209:parson.c      ****     } else if ((c & 0xE0) == 0xC0) { /* 110xxxxx */
 516              		.loc 2 209 0
 517 01c8 FB79     		ldrb	r3, [r7, #7]	@ zero_extendqisi2	@ _7, c
 518 01ca 03F0E003 		and	r3, r3, #224	@ _8, _7,
 519 01ce C02B     		cmp	r3, #192	@ _8,
 520 01d0 01D1     		bne	.L27	@,
 210:parson.c      ****         return 2;
 521              		.loc 2 210 0
 522 01d2 0223     		movs	r3, #2	@ _1,
 523 01d4 0EE0     		b	.L25	@
 524              	.L27:
 211:parson.c      ****     } else if ((c & 0xF0) == 0xE0) { /* 1110xxxx */
 525              		.loc 2 211 0
 526 01d6 FB79     		ldrb	r3, [r7, #7]	@ zero_extendqisi2	@ _10, c
 527 01d8 03F0F003 		and	r3, r3, #240	@ _11, _10,
 528 01dc E02B     		cmp	r3, #224	@ _11,
 529 01de 01D1     		bne	.L28	@,
 212:parson.c      ****         return 3;
 530              		.loc 2 212 0
 531 01e0 0323     		movs	r3, #3	@ _1,
 532 01e2 07E0     		b	.L25	@
 533              	.L28:
 213:parson.c      ****     } else if ((c & 0xF8) == 0xF0) { /* 11110xxx */
 534              		.loc 2 213 0
 535 01e4 FB79     		ldrb	r3, [r7, #7]	@ zero_extendqisi2	@ _13, c
 536 01e6 03F0F803 		and	r3, r3, #248	@ _14, _13,
 537 01ea F02B     		cmp	r3, #240	@ _14,
 538 01ec 01D1     		bne	.L29	@,
 214:parson.c      ****         return 4;
 539              		.loc 2 214 0
 540 01ee 0423     		movs	r3, #4	@ _1,
 541 01f0 00E0     		b	.L25	@
 542              	.L29:
 215:parson.c      ****     }
 216:parson.c      ****     return 0; /* won't happen */
 543              		.loc 2 216 0
 544 01f2 0023     		movs	r3, #0	@ _1,
 545              	.L25:
 217:parson.c      **** }
 546              		.loc 2 217 0
 547 01f4 1846     		mov	r0, r3	@, <retval>
 548 01f6 0C37     		adds	r7, r7, #12	@,,
 549              	.LCFI30:
 550              		.cfi_def_cfa_offset 4
 551 01f8 BD46     		mov	sp, r7	@,
 552              	.LCFI31:
 553              		.cfi_def_cfa_register 13
 554              		@ sp needed	@
 555 01fa 5DF8047B 		ldr	r7, [sp], #4	@,
 556              	.LCFI32:
 557              		.cfi_restore 7
 558              		.cfi_def_cfa_offset 0
 559 01fe 7047     		bx	lr	@
 560              		.cfi_endproc
 561              	.LFE22:
 563              		.align	1
 564              		.syntax unified
 565              		.thumb
 566              		.thumb_func
 567              		.fpu neon
 569              	verify_utf8_sequence:
 570              	.LFB23:
 218:parson.c      **** 
 219:parson.c      **** static int verify_utf8_sequence(const unsigned char *string, int *len)
 220:parson.c      **** {
 571              		.loc 2 220 0
 572              		.cfi_startproc
 573              		@ args = 0, pretend = 0, frame = 16
 574              		@ frame_needed = 1, uses_anonymous_args = 0
 575 0200 80B5     		push	{r7, lr}	@
 576              	.LCFI33:
 577              		.cfi_def_cfa_offset 8
 578              		.cfi_offset 7, -8
 579              		.cfi_offset 14, -4
 580 0202 84B0     		sub	sp, sp, #16	@,,
 581              	.LCFI34:
 582              		.cfi_def_cfa_offset 24
 583 0204 00AF     		add	r7, sp, #0	@,,
 584              	.LCFI35:
 585              		.cfi_def_cfa_register 7
 586 0206 7860     		str	r0, [r7, #4]	@ string, string
 587 0208 3960     		str	r1, [r7]	@ len, len
 221:parson.c      ****     unsigned int cp = 0;
 588              		.loc 2 221 0
 589 020a 0023     		movs	r3, #0	@ tmp182,
 590 020c FB60     		str	r3, [r7, #12]	@ tmp182, cp
 222:parson.c      ****     *len = num_bytes_in_utf8_sequence(string[0]);
 591              		.loc 2 222 0
 592 020e 7B68     		ldr	r3, [r7, #4]	@ tmp183, string
 593 0210 1B78     		ldrb	r3, [r3]	@ zero_extendqisi2	@ _6, *string_5(D)
 594 0212 1846     		mov	r0, r3	@, _6
 595 0214 FFF7BDFF 		bl	num_bytes_in_utf8_sequence	@
 596 0218 0246     		mov	r2, r0	@ _8,
 597 021a 3B68     		ldr	r3, [r7]	@ tmp184, len
 598 021c 1A60     		str	r2, [r3]	@ _8, *len_9(D)
 223:parson.c      **** 
 224:parson.c      ****     if (*len == 1) {
 599              		.loc 2 224 0
 600 021e 3B68     		ldr	r3, [r7]	@ tmp185, len
 601 0220 1B68     		ldr	r3, [r3]	@ _11, *len_9(D)
 602 0222 012B     		cmp	r3, #1	@ _11,
 603 0224 03D1     		bne	.L31	@,
 225:parson.c      ****         cp = string[0];
 604              		.loc 2 225 0
 605 0226 7B68     		ldr	r3, [r7, #4]	@ tmp186, string
 606 0228 1B78     		ldrb	r3, [r3]	@ zero_extendqisi2	@ _85, *string_5(D)
 607 022a FB60     		str	r3, [r7, #12]	@ _85, cp
 608 022c 7FE0     		b	.L32	@
 609              	.L31:
 226:parson.c      ****     } else if (*len == 2 && IS_CONT(string[1])) {
 610              		.loc 2 226 0
 611 022e 3B68     		ldr	r3, [r7]	@ tmp187, len
 612 0230 1B68     		ldr	r3, [r3]	@ _12, *len_9(D)
 613 0232 022B     		cmp	r3, #2	@ _12,
 614 0234 15D1     		bne	.L33	@,
 615              		.loc 2 226 0 is_stmt 0 discriminator 1
 616 0236 7B68     		ldr	r3, [r7, #4]	@ tmp188, string
 617 0238 0133     		adds	r3, r3, #1	@ _13, tmp188,
 618 023a 1B78     		ldrb	r3, [r3]	@ zero_extendqisi2	@ _14, *_13
 619 023c 03F0C003 		and	r3, r3, #192	@ _16, _15,
 620 0240 802B     		cmp	r3, #128	@ _16,
 621 0242 0ED1     		bne	.L33	@,
 227:parson.c      ****         cp = string[0] & 0x1F;
 622              		.loc 2 227 0 is_stmt 1
 623 0244 7B68     		ldr	r3, [r7, #4]	@ tmp189, string
 624 0246 1B78     		ldrb	r3, [r3]	@ zero_extendqisi2	@ _17, *string_5(D)
 625 0248 03F01F03 		and	r3, r3, #31	@ tmp190, _18,
 626 024c FB60     		str	r3, [r7, #12]	@ tmp190, cp
 228:parson.c      ****         cp = (cp << 6) | (string[1] & 0x3F);
 627              		.loc 2 228 0
 628 024e FB68     		ldr	r3, [r7, #12]	@ tmp191, cp
 629 0250 9A01     		lsls	r2, r3, #6	@ _20, tmp191,
 630 0252 7B68     		ldr	r3, [r7, #4]	@ tmp192, string
 631 0254 0133     		adds	r3, r3, #1	@ _21, tmp192,
 632 0256 1B78     		ldrb	r3, [r3]	@ zero_extendqisi2	@ _22, *_21
 633 0258 03F03F03 		and	r3, r3, #63	@ _24, _23,
 634 025c 1343     		orrs	r3, r3, r2	@, tmp193, _24, _20
 635 025e FB60     		str	r3, [r7, #12]	@ tmp193, cp
 636 0260 65E0     		b	.L32	@
 637              	.L33:
 229:parson.c      ****     } else if (*len == 3 && IS_CONT(string[1]) && IS_CONT(string[2])) {
 638              		.loc 2 229 0
 639 0262 3B68     		ldr	r3, [r7]	@ tmp194, len
 640 0264 1B68     		ldr	r3, [r3]	@ _26, *len_9(D)
 641 0266 032B     		cmp	r3, #3	@ _26,
 642 0268 25D1     		bne	.L34	@,
 643              		.loc 2 229 0 is_stmt 0 discriminator 1
 644 026a 7B68     		ldr	r3, [r7, #4]	@ tmp195, string
 645 026c 0133     		adds	r3, r3, #1	@ _27, tmp195,
 646 026e 1B78     		ldrb	r3, [r3]	@ zero_extendqisi2	@ _28, *_27
 647 0270 03F0C003 		and	r3, r3, #192	@ _30, _29,
 648 0274 802B     		cmp	r3, #128	@ _30,
 649 0276 1ED1     		bne	.L34	@,
 650              		.loc 2 229 0 discriminator 2
 651 0278 7B68     		ldr	r3, [r7, #4]	@ tmp196, string
 652 027a 0233     		adds	r3, r3, #2	@ _31, tmp196,
 653 027c 1B78     		ldrb	r3, [r3]	@ zero_extendqisi2	@ _32, *_31
 654 027e 03F0C003 		and	r3, r3, #192	@ _34, _33,
 655 0282 802B     		cmp	r3, #128	@ _34,
 656 0284 17D1     		bne	.L34	@,
 230:parson.c      ****         cp = ((unsigned char)string[0]) & 0xF;
 657              		.loc 2 230 0 is_stmt 1
 658 0286 7B68     		ldr	r3, [r7, #4]	@ tmp197, string
 659 0288 1B78     		ldrb	r3, [r3]	@ zero_extendqisi2	@ _35, *string_5(D)
 660 028a 03F00F03 		and	r3, r3, #15	@ tmp198, _36,
 661 028e FB60     		str	r3, [r7, #12]	@ tmp198, cp
 231:parson.c      ****         cp = (cp << 6) | (string[1] & 0x3F);
 662              		.loc 2 231 0
 663 0290 FB68     		ldr	r3, [r7, #12]	@ tmp199, cp
 664 0292 9A01     		lsls	r2, r3, #6	@ _38, tmp199,
 665 0294 7B68     		ldr	r3, [r7, #4]	@ tmp200, string
 666 0296 0133     		adds	r3, r3, #1	@ _39, tmp200,
 667 0298 1B78     		ldrb	r3, [r3]	@ zero_extendqisi2	@ _40, *_39
 668 029a 03F03F03 		and	r3, r3, #63	@ _42, _41,
 669 029e 1343     		orrs	r3, r3, r2	@, tmp201, _42, _38
 670 02a0 FB60     		str	r3, [r7, #12]	@ tmp201, cp
 232:parson.c      ****         cp = (cp << 6) | (string[2] & 0x3F);
 671              		.loc 2 232 0
 672 02a2 FB68     		ldr	r3, [r7, #12]	@ tmp202, cp
 673 02a4 9A01     		lsls	r2, r3, #6	@ _44, tmp202,
 674 02a6 7B68     		ldr	r3, [r7, #4]	@ tmp203, string
 675 02a8 0233     		adds	r3, r3, #2	@ _45, tmp203,
 676 02aa 1B78     		ldrb	r3, [r3]	@ zero_extendqisi2	@ _46, *_45
 677 02ac 03F03F03 		and	r3, r3, #63	@ _48, _47,
 678 02b0 1343     		orrs	r3, r3, r2	@, tmp204, _48, _44
 679 02b2 FB60     		str	r3, [r7, #12]	@ tmp204, cp
 680 02b4 3BE0     		b	.L32	@
 681              	.L34:
 233:parson.c      ****     } else if (*len == 4 && IS_CONT(string[1]) && IS_CONT(string[2]) && IS_CONT(string[3])) {
 682              		.loc 2 233 0
 683 02b6 3B68     		ldr	r3, [r7]	@ tmp205, len
 684 02b8 1B68     		ldr	r3, [r3]	@ _50, *len_9(D)
 685 02ba 042B     		cmp	r3, #4	@ _50,
 686 02bc 35D1     		bne	.L35	@,
 687              		.loc 2 233 0 is_stmt 0 discriminator 1
 688 02be 7B68     		ldr	r3, [r7, #4]	@ tmp206, string
 689 02c0 0133     		adds	r3, r3, #1	@ _51, tmp206,
 690 02c2 1B78     		ldrb	r3, [r3]	@ zero_extendqisi2	@ _52, *_51
 691 02c4 03F0C003 		and	r3, r3, #192	@ _54, _53,
 692 02c8 802B     		cmp	r3, #128	@ _54,
 693 02ca 2ED1     		bne	.L35	@,
 694              		.loc 2 233 0 discriminator 2
 695 02cc 7B68     		ldr	r3, [r7, #4]	@ tmp207, string
 696 02ce 0233     		adds	r3, r3, #2	@ _55, tmp207,
 697 02d0 1B78     		ldrb	r3, [r3]	@ zero_extendqisi2	@ _56, *_55
 698 02d2 03F0C003 		and	r3, r3, #192	@ _58, _57,
 699 02d6 802B     		cmp	r3, #128	@ _58,
 700 02d8 27D1     		bne	.L35	@,
 701              		.loc 2 233 0 discriminator 3
 702 02da 7B68     		ldr	r3, [r7, #4]	@ tmp208, string
 703 02dc 0333     		adds	r3, r3, #3	@ _59, tmp208,
 704 02de 1B78     		ldrb	r3, [r3]	@ zero_extendqisi2	@ _60, *_59
 705 02e0 03F0C003 		and	r3, r3, #192	@ _62, _61,
 706 02e4 802B     		cmp	r3, #128	@ _62,
 707 02e6 20D1     		bne	.L35	@,
 234:parson.c      ****         cp = string[0] & 0x7;
 708              		.loc 2 234 0 is_stmt 1
 709 02e8 7B68     		ldr	r3, [r7, #4]	@ tmp209, string
 710 02ea 1B78     		ldrb	r3, [r3]	@ zero_extendqisi2	@ _63, *string_5(D)
 711 02ec 03F00703 		and	r3, r3, #7	@ tmp210, _64,
 712 02f0 FB60     		str	r3, [r7, #12]	@ tmp210, cp
 235:parson.c      ****         cp = (cp << 6) | (string[1] & 0x3F);
 713              		.loc 2 235 0
 714 02f2 FB68     		ldr	r3, [r7, #12]	@ tmp211, cp
 715 02f4 9A01     		lsls	r2, r3, #6	@ _66, tmp211,
 716 02f6 7B68     		ldr	r3, [r7, #4]	@ tmp212, string
 717 02f8 0133     		adds	r3, r3, #1	@ _67, tmp212,
 718 02fa 1B78     		ldrb	r3, [r3]	@ zero_extendqisi2	@ _68, *_67
 719 02fc 03F03F03 		and	r3, r3, #63	@ _70, _69,
 720 0300 1343     		orrs	r3, r3, r2	@, tmp213, _70, _66
 721 0302 FB60     		str	r3, [r7, #12]	@ tmp213, cp
 236:parson.c      ****         cp = (cp << 6) | (string[2] & 0x3F);
 722              		.loc 2 236 0
 723 0304 FB68     		ldr	r3, [r7, #12]	@ tmp214, cp
 724 0306 9A01     		lsls	r2, r3, #6	@ _72, tmp214,
 725 0308 7B68     		ldr	r3, [r7, #4]	@ tmp215, string
 726 030a 0233     		adds	r3, r3, #2	@ _73, tmp215,
 727 030c 1B78     		ldrb	r3, [r3]	@ zero_extendqisi2	@ _74, *_73
 728 030e 03F03F03 		and	r3, r3, #63	@ _76, _75,
 729 0312 1343     		orrs	r3, r3, r2	@, tmp216, _76, _72
 730 0314 FB60     		str	r3, [r7, #12]	@ tmp216, cp
 237:parson.c      ****         cp = (cp << 6) | (string[3] & 0x3F);
 731              		.loc 2 237 0
 732 0316 FB68     		ldr	r3, [r7, #12]	@ tmp217, cp
 733 0318 9A01     		lsls	r2, r3, #6	@ _78, tmp217,
 734 031a 7B68     		ldr	r3, [r7, #4]	@ tmp218, string
 735 031c 0333     		adds	r3, r3, #3	@ _79, tmp218,
 736 031e 1B78     		ldrb	r3, [r3]	@ zero_extendqisi2	@ _80, *_79
 737 0320 03F03F03 		and	r3, r3, #63	@ _82, _81,
 738 0324 1343     		orrs	r3, r3, r2	@, tmp219, _82, _78
 739 0326 FB60     		str	r3, [r7, #12]	@ tmp219, cp
 740 0328 01E0     		b	.L32	@
 741              	.L35:
 238:parson.c      ****     } else {
 239:parson.c      ****         return 0;
 742              		.loc 2 239 0
 743 032a 0023     		movs	r3, #0	@ _2,
 744 032c 29E0     		b	.L36	@
 745              	.L32:
 240:parson.c      ****     }
 241:parson.c      **** 
 242:parson.c      ****     /* overlong encodings */
 243:parson.c      ****     if ((cp < 0x80 && *len > 1) || (cp < 0x800 && *len > 2) || (cp < 0x10000 && *len > 3)) {
 746              		.loc 2 243 0
 747 032e FB68     		ldr	r3, [r7, #12]	@ tmp220, cp
 748 0330 7F2B     		cmp	r3, #127	@ tmp220,
 749 0332 03D8     		bhi	.L37	@,
 750              		.loc 2 243 0 is_stmt 0 discriminator 1
 751 0334 3B68     		ldr	r3, [r7]	@ tmp221, len
 752 0336 1B68     		ldr	r3, [r3]	@ _87, *len_9(D)
 753 0338 012B     		cmp	r3, #1	@ _87,
 754 033a 0FDC     		bgt	.L38	@,
 755              	.L37:
 756              		.loc 2 243 0 discriminator 3
 757 033c FB68     		ldr	r3, [r7, #12]	@ tmp222, cp
 758 033e B3F5006F 		cmp	r3, #2048	@ tmp222,
 759 0342 03D2     		bcs	.L39	@,
 760              		.loc 2 243 0 discriminator 4
 761 0344 3B68     		ldr	r3, [r7]	@ tmp223, len
 762 0346 1B68     		ldr	r3, [r3]	@ _88, *len_9(D)
 763 0348 022B     		cmp	r3, #2	@ _88,
 764 034a 07DC     		bgt	.L38	@,
 765              	.L39:
 766              		.loc 2 243 0 discriminator 6
 767 034c FB68     		ldr	r3, [r7, #12]	@ tmp224, cp
 768 034e B3F5803F 		cmp	r3, #65536	@ tmp224,
 769 0352 05D2     		bcs	.L40	@,
 770              		.loc 2 243 0 discriminator 7
 771 0354 3B68     		ldr	r3, [r7]	@ tmp225, len
 772 0356 1B68     		ldr	r3, [r3]	@ _89, *len_9(D)
 773 0358 032B     		cmp	r3, #3	@ _89,
 774 035a 01DD     		ble	.L40	@,
 775              	.L38:
 244:parson.c      ****         return 0;
 776              		.loc 2 244 0 is_stmt 1
 777 035c 0023     		movs	r3, #0	@ _2,
 778 035e 10E0     		b	.L36	@
 779              	.L40:
 245:parson.c      ****     }
 246:parson.c      **** 
 247:parson.c      ****     /* invalid unicode */
 248:parson.c      ****     if (cp > 0x10FFFF) {
 780              		.loc 2 248 0
 781 0360 FB68     		ldr	r3, [r7, #12]	@ tmp226, cp
 782 0362 B3F5881F 		cmp	r3, #1114112	@ tmp226,
 783 0366 01D3     		bcc	.L41	@,
 249:parson.c      ****         return 0;
 784              		.loc 2 249 0
 785 0368 0023     		movs	r3, #0	@ _2,
 786 036a 0AE0     		b	.L36	@
 787              	.L41:
 250:parson.c      ****     }
 251:parson.c      **** 
 252:parson.c      ****     /* surrogate halves */
 253:parson.c      ****     if (cp >= 0xD800 && cp <= 0xDFFF) {
 788              		.loc 2 253 0
 789 036c FB68     		ldr	r3, [r7, #12]	@ tmp227, cp
 790 036e B3F5584F 		cmp	r3, #55296	@ tmp227,
 791 0372 05D3     		bcc	.L42	@,
 792              		.loc 2 253 0 is_stmt 0 discriminator 1
 793 0374 FB68     		ldr	r3, [r7, #12]	@ tmp228, cp
 794 0376 B3F5604F 		cmp	r3, #57344	@ tmp228,
 795 037a 01D2     		bcs	.L42	@,
 254:parson.c      ****         return 0;
 796              		.loc 2 254 0 is_stmt 1
 797 037c 0023     		movs	r3, #0	@ _2,
 798 037e 00E0     		b	.L36	@
 799              	.L42:
 255:parson.c      ****     }
 256:parson.c      **** 
 257:parson.c      ****     return 1;
 800              		.loc 2 257 0
 801 0380 0123     		movs	r3, #1	@ _2,
 802              	.L36:
 258:parson.c      **** }
 803              		.loc 2 258 0
 804 0382 1846     		mov	r0, r3	@, <retval>
 805 0384 1037     		adds	r7, r7, #16	@,,
 806              	.LCFI36:
 807              		.cfi_def_cfa_offset 8
 808 0386 BD46     		mov	sp, r7	@,
 809              	.LCFI37:
 810              		.cfi_def_cfa_register 13
 811              		@ sp needed	@
 812 0388 80BD     		pop	{r7, pc}	@
 813              		.cfi_endproc
 814              	.LFE23:
 816              		.align	1
 817              		.syntax unified
 818              		.thumb
 819              		.thumb_func
 820              		.fpu neon
 822              	is_valid_utf8:
 823              	.LFB24:
 259:parson.c      **** 
 260:parson.c      **** static int is_valid_utf8(const char *string, size_t string_len)
 261:parson.c      **** {
 824              		.loc 2 261 0
 825              		.cfi_startproc
 826              		@ args = 0, pretend = 0, frame = 16
 827              		@ frame_needed = 1, uses_anonymous_args = 0
 828 038a 80B5     		push	{r7, lr}	@
 829              	.LCFI38:
 830              		.cfi_def_cfa_offset 8
 831              		.cfi_offset 7, -8
 832              		.cfi_offset 14, -4
 833 038c 84B0     		sub	sp, sp, #16	@,,
 834              	.LCFI39:
 835              		.cfi_def_cfa_offset 24
 836 038e 00AF     		add	r7, sp, #0	@,,
 837              	.LCFI40:
 838              		.cfi_def_cfa_register 7
 839 0390 7860     		str	r0, [r7, #4]	@ string, string
 840 0392 3960     		str	r1, [r7]	@ string_len, string_len
 262:parson.c      ****     int len = 0;
 841              		.loc 2 262 0
 842 0394 0023     		movs	r3, #0	@ tmp115,
 843 0396 BB60     		str	r3, [r7, #8]	@ tmp115, len
 263:parson.c      ****     const char *string_end = string + string_len;
 844              		.loc 2 263 0
 845 0398 7A68     		ldr	r2, [r7, #4]	@ tmp117, string
 846 039a 3B68     		ldr	r3, [r7]	@ tmp118, string_len
 847 039c 1344     		add	r3, r3, r2	@ tmp116, tmp117
 848 039e FB60     		str	r3, [r7, #12]	@ tmp116, string_end
 264:parson.c      ****     while (string < string_end) {
 849              		.loc 2 264 0
 850 03a0 0FE0     		b	.L44	@
 851              	.L47:
 265:parson.c      ****         if (!verify_utf8_sequence((const unsigned char *)string, &len)) {
 852              		.loc 2 265 0
 853 03a2 07F10803 		add	r3, r7, #8	@ tmp119,,
 854 03a6 1946     		mov	r1, r3	@, tmp119
 855 03a8 7868     		ldr	r0, [r7, #4]	@, string
 856 03aa FFF729FF 		bl	verify_utf8_sequence	@
 857 03ae 0346     		mov	r3, r0	@ _11,
 858 03b0 002B     		cmp	r3, #0	@ _11,
 859 03b2 01D1     		bne	.L45	@,
 266:parson.c      ****             return 0;
 860              		.loc 2 266 0
 861 03b4 0023     		movs	r3, #0	@ _2,
 862 03b6 09E0     		b	.L48	@
 863              	.L45:
 267:parson.c      ****         }
 268:parson.c      ****         string += len;
 864              		.loc 2 268 0
 865 03b8 BB68     		ldr	r3, [r7, #8]	@ len.2_12, len
 866 03ba 1A46     		mov	r2, r3	@ len.3_13, len.2_12
 867 03bc 7B68     		ldr	r3, [r7, #4]	@ tmp121, string
 868 03be 1344     		add	r3, r3, r2	@ tmp120, len.3_13
 869 03c0 7B60     		str	r3, [r7, #4]	@ tmp120, string
 870              	.L44:
 264:parson.c      ****         if (!verify_utf8_sequence((const unsigned char *)string, &len)) {
 871              		.loc 2 264 0
 872 03c2 7A68     		ldr	r2, [r7, #4]	@ tmp122, string
 873 03c4 FB68     		ldr	r3, [r7, #12]	@ tmp123, string_end
 874 03c6 9A42     		cmp	r2, r3	@ tmp122, tmp123
 875 03c8 EBD3     		bcc	.L47	@,
 269:parson.c      ****     }
 270:parson.c      ****     return 1;
 876              		.loc 2 270 0
 877 03ca 0123     		movs	r3, #1	@ _2,
 878              	.L48:
 271:parson.c      **** }
 879              		.loc 2 271 0 discriminator 1
 880 03cc 1846     		mov	r0, r3	@, <retval>
 881 03ce 1037     		adds	r7, r7, #16	@,,
 882              	.LCFI41:
 883              		.cfi_def_cfa_offset 8
 884 03d0 BD46     		mov	sp, r7	@,
 885              	.LCFI42:
 886              		.cfi_def_cfa_register 13
 887              		@ sp needed	@
 888 03d2 80BD     		pop	{r7, pc}	@
 889              		.cfi_endproc
 890              	.LFE24:
 892              		.section	.rodata
 893              		.align	2
 894              	.LC0:
 895 0000 2D3000   		.ascii	"-0\000"
 896 0003 00       		.align	2
 897              	.LC1:
 898 0004 785800   		.ascii	"xX\000"
 899              		.text
 900              		.align	1
 901              		.syntax unified
 902              		.thumb
 903              		.thumb_func
 904              		.fpu neon
 906              	is_decimal:
 907              	.LFB25:
 272:parson.c      **** 
 273:parson.c      **** static int is_decimal(const char *string, size_t length)
 274:parson.c      **** {
 908              		.loc 2 274 0
 909              		.cfi_startproc
 910              		@ args = 0, pretend = 0, frame = 8
 911              		@ frame_needed = 1, uses_anonymous_args = 0
 912 03d4 80B5     		push	{r7, lr}	@
 913              	.LCFI43:
 914              		.cfi_def_cfa_offset 8
 915              		.cfi_offset 7, -8
 916              		.cfi_offset 14, -4
 917 03d6 82B0     		sub	sp, sp, #8	@,,
 918              	.LCFI44:
 919              		.cfi_def_cfa_offset 16
 920 03d8 00AF     		add	r7, sp, #0	@,,
 921              	.LCFI45:
 922              		.cfi_def_cfa_register 7
 923 03da 7860     		str	r0, [r7, #4]	@ string, string
 924 03dc 3960     		str	r1, [r7]	@ length, length
 275:parson.c      ****     if (length > 1 && string[0] == '0' && string[1] != '.') {
 925              		.loc 2 275 0
 926 03de 3B68     		ldr	r3, [r7]	@ tmp123, length
 927 03e0 012B     		cmp	r3, #1	@ tmp123,
 928 03e2 0AD9     		bls	.L50	@,
 929              		.loc 2 275 0 is_stmt 0 discriminator 1
 930 03e4 7B68     		ldr	r3, [r7, #4]	@ tmp124, string
 931 03e6 1B78     		ldrb	r3, [r3]	@ zero_extendqisi2	@ _6, *string_5(D)
 932 03e8 302B     		cmp	r3, #48	@ _6,
 933 03ea 06D1     		bne	.L50	@,
 934              		.loc 2 275 0 discriminator 2
 935 03ec 7B68     		ldr	r3, [r7, #4]	@ tmp125, string
 936 03ee 0133     		adds	r3, r3, #1	@ _7, tmp125,
 937 03f0 1B78     		ldrb	r3, [r3]	@ zero_extendqisi2	@ _8, *_7
 938 03f2 2E2B     		cmp	r3, #46	@ _8,
 939 03f4 01D0     		beq	.L50	@,
 276:parson.c      ****         return 0;
 940              		.loc 2 276 0 is_stmt 1
 941 03f6 0023     		movs	r3, #0	@ _2,
 942 03f8 2AE0     		b	.L51	@
 943              	.L50:
 277:parson.c      ****     }
 278:parson.c      ****     if (length > 2 && !strncmp(string, "-0", 2) && string[2] != '.') {
 944              		.loc 2 278 0
 945 03fa 3B68     		ldr	r3, [r7]	@ tmp126, length
 946 03fc 022B     		cmp	r3, #2	@ tmp126,
 947 03fe 21D9     		bls	.L53	@,
 948              		.loc 2 278 0 is_stmt 0 discriminator 1
 949 0400 0222     		movs	r2, #2	@,
 950 0402 40F20001 		movw	r1, #:lower16:.LC0	@,
 951 0406 C0F20001 		movt	r1, #:upper16:.LC0	@,
 952 040a 7868     		ldr	r0, [r7, #4]	@, string
 953 040c FFF7FEFF 		bl	strncmp	@
 954 0410 0346     		mov	r3, r0	@ _10,
 955 0412 002B     		cmp	r3, #0	@ _10,
 956 0414 16D1     		bne	.L53	@,
 957              		.loc 2 278 0 discriminator 2
 958 0416 7B68     		ldr	r3, [r7, #4]	@ tmp127, string
 959 0418 0233     		adds	r3, r3, #2	@ _11, tmp127,
 960 041a 1B78     		ldrb	r3, [r3]	@ zero_extendqisi2	@ _12, *_11
 961 041c 2E2B     		cmp	r3, #46	@ _12,
 962 041e 11D0     		beq	.L53	@,
 279:parson.c      ****         return 0;
 963              		.loc 2 279 0 is_stmt 1
 964 0420 0023     		movs	r3, #0	@ _2,
 965 0422 15E0     		b	.L51	@
 966              	.L54:
 280:parson.c      ****     }
 281:parson.c      ****     while (length--) {
 282:parson.c      ****         if (strchr("xX", string[length])) {
 967              		.loc 2 282 0
 968 0424 7A68     		ldr	r2, [r7, #4]	@ tmp128, string
 969 0426 3B68     		ldr	r3, [r7]	@ tmp129, length
 970 0428 1344     		add	r3, r3, r2	@ _16, tmp128
 971 042a 1B78     		ldrb	r3, [r3]	@ zero_extendqisi2	@ _17, *_16
 972 042c 1946     		mov	r1, r3	@, _18
 973 042e 40F20000 		movw	r0, #:lower16:.LC1	@,
 974 0432 C0F20000 		movt	r0, #:upper16:.LC1	@,
 975 0436 FFF7FEFF 		bl	strchr	@
 976 043a 0346     		mov	r3, r0	@ _19,
 977 043c 002B     		cmp	r3, #0	@ _19,
 978 043e 01D0     		beq	.L53	@,
 283:parson.c      ****             return 0;
 979              		.loc 2 283 0
 980 0440 0023     		movs	r3, #0	@ _2,
 981 0442 05E0     		b	.L51	@
 982              	.L53:
 281:parson.c      ****         if (strchr("xX", string[length])) {
 983              		.loc 2 281 0
 984 0444 3B68     		ldr	r3, [r7]	@ length.4_14, length
 985 0446 5A1E     		subs	r2, r3, #1	@ tmp130, length.4_14,
 986 0448 3A60     		str	r2, [r7]	@ tmp130, length
 987 044a 002B     		cmp	r3, #0	@ length.4_14,
 988 044c EAD1     		bne	.L54	@,
 284:parson.c      ****         }
 285:parson.c      ****     }
 286:parson.c      ****     return 1;
 989              		.loc 2 286 0
 990 044e 0123     		movs	r3, #1	@ _2,
 991              	.L51:
 287:parson.c      **** }
 992              		.loc 2 287 0
 993 0450 1846     		mov	r0, r3	@, <retval>
 994 0452 0837     		adds	r7, r7, #8	@,,
 995              	.LCFI46:
 996              		.cfi_def_cfa_offset 8
 997 0454 BD46     		mov	sp, r7	@,
 998              	.LCFI47:
 999              		.cfi_def_cfa_register 13
 1000              		@ sp needed	@
 1001 0456 80BD     		pop	{r7, pc}	@
 1002              		.cfi_endproc
 1003              	.LFE25:
 1005              		.align	1
 1006              		.syntax unified
 1007              		.thumb
 1008              		.thumb_func
 1009              		.fpu neon
 1011              	remove_comments:
 1012              	.LFB26:
 288:parson.c      **** 
 289:parson.c      **** static void remove_comments(char *string, const char *start_token, const char *end_token)
 290:parson.c      **** {
 1013              		.loc 2 290 0
 1014              		.cfi_startproc
 1015              		@ args = 0, pretend = 0, frame = 48
 1016              		@ frame_needed = 1, uses_anonymous_args = 0
 1017 0458 80B5     		push	{r7, lr}	@
 1018              	.LCFI48:
 1019              		.cfi_def_cfa_offset 8
 1020              		.cfi_offset 7, -8
 1021              		.cfi_offset 14, -4
 1022 045a 8CB0     		sub	sp, sp, #48	@,,
 1023              	.LCFI49:
 1024              		.cfi_def_cfa_offset 56
 1025 045c 00AF     		add	r7, sp, #0	@,,
 1026              	.LCFI50:
 1027              		.cfi_def_cfa_register 7
 1028 045e F860     		str	r0, [r7, #12]	@ string, string
 1029 0460 B960     		str	r1, [r7, #8]	@ start_token, start_token
 1030 0462 7A60     		str	r2, [r7, #4]	@ end_token, end_token
 291:parson.c      ****     int in_string = 0, escaped = 0;
 1031              		.loc 2 291 0
 1032 0464 0023     		movs	r3, #0	@ tmp120,
 1033 0466 FB62     		str	r3, [r7, #44]	@ tmp120, in_string
 1034 0468 0023     		movs	r3, #0	@ tmp121,
 1035 046a BB62     		str	r3, [r7, #40]	@ tmp121, escaped
 292:parson.c      ****     size_t i;
 293:parson.c      ****     char *ptr = NULL, current_char;
 1036              		.loc 2 293 0
 1037 046c 0023     		movs	r3, #0	@ tmp122,
 1038 046e 3B62     		str	r3, [r7, #32]	@ tmp122, ptr
 294:parson.c      ****     size_t start_token_len = strlen(start_token);
 1039              		.loc 2 294 0
 1040 0470 B868     		ldr	r0, [r7, #8]	@, start_token
 1041 0472 FFF7FEFF 		bl	strlen	@
 1042 0476 F861     		str	r0, [r7, #28]	@, start_token_len
 295:parson.c      ****     size_t end_token_len = strlen(end_token);
 1043              		.loc 2 295 0
 1044 0478 7868     		ldr	r0, [r7, #4]	@, end_token
 1045 047a FFF7FEFF 		bl	strlen	@
 1046 047e B861     		str	r0, [r7, #24]	@, end_token_len
 296:parson.c      ****     if (start_token_len == 0 || end_token_len == 0) {
 1047              		.loc 2 296 0
 1048 0480 FB69     		ldr	r3, [r7, #28]	@ tmp123, start_token_len
 1049 0482 002B     		cmp	r3, #0	@ tmp123,
 1050 0484 68D0     		beq	.L69	@,
 1051              		.loc 2 296 0 is_stmt 0 discriminator 1
 1052 0486 BB69     		ldr	r3, [r7, #24]	@ tmp124, end_token_len
 1053 0488 002B     		cmp	r3, #0	@ tmp124,
 1054 048a 65D0     		beq	.L69	@,
 297:parson.c      ****         return;
 298:parson.c      ****     }
 299:parson.c      ****     while ((current_char = *string) != '\0') {
 1055              		.loc 2 299 0 is_stmt 1
 1056 048c 5DE0     		b	.L59	@
 1057              	.L68:
 300:parson.c      ****         if (current_char == '\\' && !escaped) {
 1058              		.loc 2 300 0
 1059 048e FB7D     		ldrb	r3, [r7, #23]	@ zero_extendqisi2	@ tmp125, current_char
 1060 0490 5C2B     		cmp	r3, #92	@ tmp125,
 1061 0492 08D1     		bne	.L60	@,
 1062              		.loc 2 300 0 is_stmt 0 discriminator 1
 1063 0494 BB6A     		ldr	r3, [r7, #40]	@ tmp126, escaped
 1064 0496 002B     		cmp	r3, #0	@ tmp126,
 1065 0498 05D1     		bne	.L60	@,
 301:parson.c      ****             escaped = 1;
 1066              		.loc 2 301 0 is_stmt 1
 1067 049a 0123     		movs	r3, #1	@ tmp127,
 1068 049c BB62     		str	r3, [r7, #40]	@ tmp127, escaped
 302:parson.c      ****             string++;
 1069              		.loc 2 302 0
 1070 049e FB68     		ldr	r3, [r7, #12]	@ tmp129, string
 1071 04a0 0133     		adds	r3, r3, #1	@ tmp128, tmp129,
 1072 04a2 FB60     		str	r3, [r7, #12]	@ tmp128, string
 303:parson.c      ****             continue;
 1073              		.loc 2 303 0
 1074 04a4 51E0     		b	.L59	@
 1075              	.L60:
 304:parson.c      ****         } else if (current_char == '\"' && !escaped) {
 1076              		.loc 2 304 0
 1077 04a6 FB7D     		ldrb	r3, [r7, #23]	@ zero_extendqisi2	@ tmp130, current_char
 1078 04a8 222B     		cmp	r3, #34	@ tmp130,
 1079 04aa 0AD1     		bne	.L61	@,
 1080              		.loc 2 304 0 is_stmt 0 discriminator 1
 1081 04ac BB6A     		ldr	r3, [r7, #40]	@ tmp131, escaped
 1082 04ae 002B     		cmp	r3, #0	@ tmp131,
 1083 04b0 07D1     		bne	.L61	@,
 305:parson.c      ****             in_string = !in_string;
 1084              		.loc 2 305 0 is_stmt 1
 1085 04b2 FB6A     		ldr	r3, [r7, #44]	@ tmp133, in_string
 1086 04b4 002B     		cmp	r3, #0	@ tmp133,
 1087 04b6 0CBF     		ite	eq
 1088 04b8 0123     		moveq	r3, #1	@ tmp134,
 1089 04ba 0023     		movne	r3, #0	@ tmp134,
 1090 04bc DBB2     		uxtb	r3, r3	@ _25, tmp132
 1091 04be FB62     		str	r3, [r7, #44]	@ _25, in_string
 1092 04c0 3EE0     		b	.L62	@
 1093              	.L61:
 306:parson.c      ****         } else if (!in_string && strncmp(string, start_token, start_token_len) == 0) {
 1094              		.loc 2 306 0
 1095 04c2 FB6A     		ldr	r3, [r7, #44]	@ tmp135, in_string
 1096 04c4 002B     		cmp	r3, #0	@ tmp135,
 1097 04c6 3BD1     		bne	.L62	@,
 1098              		.loc 2 306 0 is_stmt 0 discriminator 1
 1099 04c8 FA69     		ldr	r2, [r7, #28]	@, start_token_len
 1100 04ca B968     		ldr	r1, [r7, #8]	@, start_token
 1101 04cc F868     		ldr	r0, [r7, #12]	@, string
 1102 04ce FFF7FEFF 		bl	strncmp	@
 1103 04d2 0346     		mov	r3, r0	@ _29,
 1104 04d4 002B     		cmp	r3, #0	@ _29,
 1105 04d6 33D1     		bne	.L62	@,
 307:parson.c      ****             for (i = 0; i < start_token_len; i++) {
 1106              		.loc 2 307 0 is_stmt 1
 1107 04d8 0023     		movs	r3, #0	@ tmp136,
 1108 04da 7B62     		str	r3, [r7, #36]	@ tmp136, i
 1109 04dc 07E0     		b	.L63	@
 1110              	.L64:
 308:parson.c      ****                 string[i] = ' ';
 1111              		.loc 2 308 0 discriminator 3
 1112 04de FA68     		ldr	r2, [r7, #12]	@ tmp137, string
 1113 04e0 7B6A     		ldr	r3, [r7, #36]	@ tmp138, i
 1114 04e2 1344     		add	r3, r3, r2	@ _31, tmp137
 1115 04e4 2022     		movs	r2, #32	@ tmp139,
 1116 04e6 1A70     		strb	r2, [r3]	@ tmp140, *_31
 307:parson.c      ****             for (i = 0; i < start_token_len; i++) {
 1117              		.loc 2 307 0 discriminator 3
 1118 04e8 7B6A     		ldr	r3, [r7, #36]	@ tmp142, i
 1119 04ea 0133     		adds	r3, r3, #1	@ tmp141, tmp142,
 1120 04ec 7B62     		str	r3, [r7, #36]	@ tmp141, i
 1121              	.L63:
 307:parson.c      ****             for (i = 0; i < start_token_len; i++) {
 1122              		.loc 2 307 0 is_stmt 0 discriminator 1
 1123 04ee 7A6A     		ldr	r2, [r7, #36]	@ tmp143, i
 1124 04f0 FB69     		ldr	r3, [r7, #28]	@ tmp144, start_token_len
 1125 04f2 9A42     		cmp	r2, r3	@ tmp143, tmp144
 1126 04f4 F3D3     		bcc	.L64	@,
 309:parson.c      ****             }
 310:parson.c      ****             string = string + start_token_len;
 1127              		.loc 2 310 0 is_stmt 1
 1128 04f6 FA68     		ldr	r2, [r7, #12]	@ tmp146, string
 1129 04f8 FB69     		ldr	r3, [r7, #28]	@ tmp147, start_token_len
 1130 04fa 1344     		add	r3, r3, r2	@ tmp145, tmp146
 1131 04fc FB60     		str	r3, [r7, #12]	@ tmp145, string
 311:parson.c      ****             ptr = strstr(string, end_token);
 1132              		.loc 2 311 0
 1133 04fe 7968     		ldr	r1, [r7, #4]	@, end_token
 1134 0500 F868     		ldr	r0, [r7, #12]	@, string
 1135 0502 FFF7FEFF 		bl	strstr	@
 1136 0506 3862     		str	r0, [r7, #32]	@, ptr
 312:parson.c      ****             if (!ptr) {
 1137              		.loc 2 312 0
 1138 0508 3B6A     		ldr	r3, [r7, #32]	@ tmp148, ptr
 1139 050a 002B     		cmp	r3, #0	@ tmp148,
 1140 050c 26D0     		beq	.L70	@,
 313:parson.c      ****                 return;
 314:parson.c      ****             }
 315:parson.c      ****             for (i = 0; i < ((size_t)(ptr - string) + end_token_len); i++) {
 1141              		.loc 2 315 0
 1142 050e 0023     		movs	r3, #0	@ tmp149,
 1143 0510 7B62     		str	r3, [r7, #36]	@ tmp149, i
 1144 0512 07E0     		b	.L66	@
 1145              	.L67:
 316:parson.c      ****                 string[i] = ' ';
 1146              		.loc 2 316 0 discriminator 3
 1147 0514 FA68     		ldr	r2, [r7, #12]	@ tmp150, string
 1148 0516 7B6A     		ldr	r3, [r7, #36]	@ tmp151, i
 1149 0518 1344     		add	r3, r3, r2	@ _42, tmp150
 1150 051a 2022     		movs	r2, #32	@ tmp152,
 1151 051c 1A70     		strb	r2, [r3]	@ tmp153, *_42
 315:parson.c      ****                 string[i] = ' ';
 1152              		.loc 2 315 0 discriminator 3
 1153 051e 7B6A     		ldr	r3, [r7, #36]	@ tmp155, i
 1154 0520 0133     		adds	r3, r3, #1	@ tmp154, tmp155,
 1155 0522 7B62     		str	r3, [r7, #36]	@ tmp154, i
 1156              	.L66:
 315:parson.c      ****                 string[i] = ' ';
 1157              		.loc 2 315 0 is_stmt 0 discriminator 1
 1158 0524 3A6A     		ldr	r2, [r7, #32]	@ ptr.5_37, ptr
 1159 0526 FB68     		ldr	r3, [r7, #12]	@ string.6_38, string
 1160 0528 D31A     		subs	r3, r2, r3	@ _39, ptr.5_37, string.6_38
 1161 052a 1A46     		mov	r2, r3	@ _40, _39
 1162 052c BB69     		ldr	r3, [r7, #24]	@ tmp156, end_token_len
 1163 052e 1A44     		add	r2, r2, r3	@ _41, tmp156
 1164 0530 7B6A     		ldr	r3, [r7, #36]	@ tmp157, i
 1165 0532 9A42     		cmp	r2, r3	@ _41, tmp157
 1166 0534 EED8     		bhi	.L67	@,
 317:parson.c      ****             }
 318:parson.c      ****             string = ptr + end_token_len - 1;
 1167              		.loc 2 318 0 is_stmt 1
 1168 0536 BB69     		ldr	r3, [r7, #24]	@ tmp158, end_token_len
 1169 0538 013B     		subs	r3, r3, #1	@ _45, tmp158,
 1170 053a 3A6A     		ldr	r2, [r7, #32]	@ tmp160, ptr
 1171 053c 1344     		add	r3, r3, r2	@ tmp159, tmp160
 1172 053e FB60     		str	r3, [r7, #12]	@ tmp159, string
 1173              	.L62:
 319:parson.c      ****         }
 320:parson.c      ****         escaped = 0;
 1174              		.loc 2 320 0
 1175 0540 0023     		movs	r3, #0	@ tmp161,
 1176 0542 BB62     		str	r3, [r7, #40]	@ tmp161, escaped
 321:parson.c      ****         string++;
 1177              		.loc 2 321 0
 1178 0544 FB68     		ldr	r3, [r7, #12]	@ tmp163, string
 1179 0546 0133     		adds	r3, r3, #1	@ tmp162, tmp163,
 1180 0548 FB60     		str	r3, [r7, #12]	@ tmp162, string
 1181              	.L59:
 299:parson.c      ****         if (current_char == '\\' && !escaped) {
 1182              		.loc 2 299 0
 1183 054a FB68     		ldr	r3, [r7, #12]	@ tmp164, string
 1184 054c 1B78     		ldrb	r3, [r3]	@ tmp165, *string_2
 1185 054e FB75     		strb	r3, [r7, #23]	@ tmp165, current_char
 1186 0550 FB7D     		ldrb	r3, [r7, #23]	@ zero_extendqisi2	@ tmp166, current_char
 1187 0552 002B     		cmp	r3, #0	@ tmp166,
 1188 0554 9BD1     		bne	.L68	@,
 1189 0556 02E0     		b	.L55	@
 1190              	.L69:
 297:parson.c      ****     }
 1191              		.loc 2 297 0
 1192 0558 00BF     		nop
 1193 055a 00E0     		b	.L55	@
 1194              	.L70:
 313:parson.c      ****             }
 1195              		.loc 2 313 0
 1196 055c 00BF     		nop
 1197              	.L55:
 322:parson.c      ****     }
 323:parson.c      **** }
 1198              		.loc 2 323 0
 1199 055e 3037     		adds	r7, r7, #48	@,,
 1200              	.LCFI51:
 1201              		.cfi_def_cfa_offset 8
 1202 0560 BD46     		mov	sp, r7	@,
 1203              	.LCFI52:
 1204              		.cfi_def_cfa_register 13
 1205              		@ sp needed	@
 1206 0562 80BD     		pop	{r7, pc}	@
 1207              		.cfi_endproc
 1208              	.LFE26:
 1210              		.align	1
 1211              		.syntax unified
 1212              		.thumb
 1213              		.thumb_func
 1214              		.fpu neon
 1216              	json_object_init:
 1217              	.LFB27:
 324:parson.c      **** 
 325:parson.c      **** /* JSON Object */
 326:parson.c      **** static JSON_Object *json_object_init(JSON_Value *wrapping_value)
 327:parson.c      **** {
 1218              		.loc 2 327 0
 1219              		.cfi_startproc
 1220              		@ args = 0, pretend = 0, frame = 16
 1221              		@ frame_needed = 1, uses_anonymous_args = 0
 1222 0564 80B5     		push	{r7, lr}	@
 1223              	.LCFI53:
 1224              		.cfi_def_cfa_offset 8
 1225              		.cfi_offset 7, -8
 1226              		.cfi_offset 14, -4
 1227 0566 84B0     		sub	sp, sp, #16	@,,
 1228              	.LCFI54:
 1229              		.cfi_def_cfa_offset 24
 1230 0568 00AF     		add	r7, sp, #0	@,,
 1231              	.LCFI55:
 1232              		.cfi_def_cfa_register 7
 1233 056a 7860     		str	r0, [r7, #4]	@ wrapping_value, wrapping_value
 328:parson.c      ****     JSON_Object *new_obj = (JSON_Object *)parson_malloc(sizeof(JSON_Object));
 1234              		.loc 2 328 0
 1235 056c 40F20003 		movw	r3, #:lower16:parson_malloc	@ tmp113,
 1236 0570 C0F20003 		movt	r3, #:upper16:parson_malloc	@ tmp113,
 1237 0574 1B68     		ldr	r3, [r3]	@ parson_malloc.7_4, parson_malloc
 1238 0576 1420     		movs	r0, #20	@,
 1239 0578 9847     		blx	r3	@ parson_malloc.7_4
 1240              	.LVL1:
 1241 057a F860     		str	r0, [r7, #12]	@, new_obj
 329:parson.c      ****     if (new_obj == NULL) {
 1242              		.loc 2 329 0
 1243 057c FB68     		ldr	r3, [r7, #12]	@ tmp114, new_obj
 1244 057e 002B     		cmp	r3, #0	@ tmp114,
 1245 0580 01D1     		bne	.L72	@,
 330:parson.c      ****         return NULL;
 1246              		.loc 2 330 0
 1247 0582 0023     		movs	r3, #0	@ _1,
 1248 0584 0FE0     		b	.L73	@
 1249              	.L72:
 331:parson.c      ****     }
 332:parson.c      ****     new_obj->wrapping_value = wrapping_value;
 1250              		.loc 2 332 0
 1251 0586 FB68     		ldr	r3, [r7, #12]	@ tmp115, new_obj
 1252 0588 7A68     		ldr	r2, [r7, #4]	@ tmp116, wrapping_value
 1253 058a 1A60     		str	r2, [r3]	@ tmp116, new_obj_6->wrapping_value
 333:parson.c      ****     new_obj->names = (char **)NULL;
 1254              		.loc 2 333 0
 1255 058c FB68     		ldr	r3, [r7, #12]	@ tmp117, new_obj
 1256 058e 0022     		movs	r2, #0	@ tmp118,
 1257 0590 5A60     		str	r2, [r3, #4]	@ tmp118, new_obj_6->names
 334:parson.c      ****     new_obj->values = (JSON_Value **)NULL;
 1258              		.loc 2 334 0
 1259 0592 FB68     		ldr	r3, [r7, #12]	@ tmp119, new_obj
 1260 0594 0022     		movs	r2, #0	@ tmp120,
 1261 0596 9A60     		str	r2, [r3, #8]	@ tmp120, new_obj_6->values
 335:parson.c      ****     new_obj->capacity = 0;
 1262              		.loc 2 335 0
 1263 0598 FB68     		ldr	r3, [r7, #12]	@ tmp121, new_obj
 1264 059a 0022     		movs	r2, #0	@ tmp122,
 1265 059c 1A61     		str	r2, [r3, #16]	@ tmp122, new_obj_6->capacity
 336:parson.c      ****     new_obj->count = 0;
 1266              		.loc 2 336 0
 1267 059e FB68     		ldr	r3, [r7, #12]	@ tmp123, new_obj
 1268 05a0 0022     		movs	r2, #0	@ tmp124,
 1269 05a2 DA60     		str	r2, [r3, #12]	@ tmp124, new_obj_6->count
 337:parson.c      ****     return new_obj;
 1270              		.loc 2 337 0
 1271 05a4 FB68     		ldr	r3, [r7, #12]	@ _1, new_obj
 1272              	.L73:
 338:parson.c      **** }
 1273              		.loc 2 338 0
 1274 05a6 1846     		mov	r0, r3	@, <retval>
 1275 05a8 1037     		adds	r7, r7, #16	@,,
 1276              	.LCFI56:
 1277              		.cfi_def_cfa_offset 8
 1278 05aa BD46     		mov	sp, r7	@,
 1279              	.LCFI57:
 1280              		.cfi_def_cfa_register 13
 1281              		@ sp needed	@
 1282 05ac 80BD     		pop	{r7, pc}	@
 1283              		.cfi_endproc
 1284              	.LFE27:
 1286              		.align	1
 1287              		.syntax unified
 1288              		.thumb
 1289              		.thumb_func
 1290              		.fpu neon
 1292              	json_object_add:
 1293              	.LFB28:
 339:parson.c      **** 
 340:parson.c      **** static JSON_Status json_object_add(JSON_Object *object, const char *name, JSON_Value *value)
 341:parson.c      **** {
 1294              		.loc 2 341 0
 1295              		.cfi_startproc
 1296              		@ args = 0, pretend = 0, frame = 16
 1297              		@ frame_needed = 1, uses_anonymous_args = 0
 1298 05ae 80B5     		push	{r7, lr}	@
 1299              	.LCFI58:
 1300              		.cfi_def_cfa_offset 8
 1301              		.cfi_offset 7, -8
 1302              		.cfi_offset 14, -4
 1303 05b0 84B0     		sub	sp, sp, #16	@,,
 1304              	.LCFI59:
 1305              		.cfi_def_cfa_offset 24
 1306 05b2 00AF     		add	r7, sp, #0	@,,
 1307              	.LCFI60:
 1308              		.cfi_def_cfa_register 7
 1309 05b4 F860     		str	r0, [r7, #12]	@ object, object
 1310 05b6 B960     		str	r1, [r7, #8]	@ name, name
 1311 05b8 7A60     		str	r2, [r7, #4]	@ value, value
 342:parson.c      ****     if (name == NULL) {
 1312              		.loc 2 342 0
 1313 05ba BB68     		ldr	r3, [r7, #8]	@ tmp113, name
 1314 05bc 002B     		cmp	r3, #0	@ tmp113,
 1315 05be 02D1     		bne	.L75	@,
 343:parson.c      ****         return JSONFailure;
 1316              		.loc 2 343 0
 1317 05c0 4FF0FF33 		mov	r3, #-1	@ _1,
 1318 05c4 09E0     		b	.L76	@
 1319              	.L75:
 344:parson.c      ****     }
 345:parson.c      ****     return json_object_addn(object, name, strlen(name), value);
 1320              		.loc 2 345 0
 1321 05c6 B868     		ldr	r0, [r7, #8]	@, name
 1322 05c8 FFF7FEFF 		bl	strlen	@
 1323 05cc 0246     		mov	r2, r0	@ _6,
 1324 05ce 7B68     		ldr	r3, [r7, #4]	@, value
 1325 05d0 B968     		ldr	r1, [r7, #8]	@, name
 1326 05d2 F868     		ldr	r0, [r7, #12]	@, object
 1327 05d4 00F005F8 		bl	json_object_addn	@
 1328 05d8 0346     		mov	r3, r0	@ _1,
 1329              	.L76:
 346:parson.c      **** }
 1330              		.loc 2 346 0
 1331 05da 1846     		mov	r0, r3	@, <retval>
 1332 05dc 1037     		adds	r7, r7, #16	@,,
 1333              	.LCFI61:
 1334              		.cfi_def_cfa_offset 8
 1335 05de BD46     		mov	sp, r7	@,
 1336              	.LCFI62:
 1337              		.cfi_def_cfa_register 13
 1338              		@ sp needed	@
 1339 05e0 80BD     		pop	{r7, pc}	@
 1340              		.cfi_endproc
 1341              	.LFE28:
 1343              		.align	1
 1344              		.syntax unified
 1345              		.thumb
 1346              		.thumb_func
 1347              		.fpu neon
 1349              	json_object_addn:
 1350              	.LFB29:
 347:parson.c      **** 
 348:parson.c      **** static JSON_Status json_object_addn(JSON_Object *object, const char *name, size_t name_len,
 349:parson.c      ****                                     JSON_Value *value)
 350:parson.c      **** {
 1351              		.loc 2 350 0
 1352              		.cfi_startproc
 1353              		@ args = 0, pretend = 0, frame = 24
 1354              		@ frame_needed = 1, uses_anonymous_args = 0
 1355 05e2 90B5     		push	{r4, r7, lr}	@
 1356              	.LCFI63:
 1357              		.cfi_def_cfa_offset 12
 1358              		.cfi_offset 4, -12
 1359              		.cfi_offset 7, -8
 1360              		.cfi_offset 14, -4
 1361 05e4 87B0     		sub	sp, sp, #28	@,,
 1362              	.LCFI64:
 1363              		.cfi_def_cfa_offset 40
 1364 05e6 00AF     		add	r7, sp, #0	@,,
 1365              	.LCFI65:
 1366              		.cfi_def_cfa_register 7
 1367 05e8 F860     		str	r0, [r7, #12]	@ object, object
 1368 05ea B960     		str	r1, [r7, #8]	@ name, name
 1369 05ec 7A60     		str	r2, [r7, #4]	@ name_len, name_len
 1370 05ee 3B60     		str	r3, [r7]	@ value, value
 351:parson.c      ****     size_t index = 0;
 1371              		.loc 2 351 0
 1372 05f0 0023     		movs	r3, #0	@ tmp132,
 1373 05f2 7B61     		str	r3, [r7, #20]	@ tmp132, index
 352:parson.c      ****     if (object == NULL || name == NULL || value == NULL) {
 1374              		.loc 2 352 0
 1375 05f4 FB68     		ldr	r3, [r7, #12]	@ tmp133, object
 1376 05f6 002B     		cmp	r3, #0	@ tmp133,
 1377 05f8 05D0     		beq	.L78	@,
 1378              		.loc 2 352 0 is_stmt 0 discriminator 1
 1379 05fa BB68     		ldr	r3, [r7, #8]	@ tmp134, name
 1380 05fc 002B     		cmp	r3, #0	@ tmp134,
 1381 05fe 02D0     		beq	.L78	@,
 1382              		.loc 2 352 0 discriminator 2
 1383 0600 3B68     		ldr	r3, [r7]	@ tmp135, value
 1384 0602 002B     		cmp	r3, #0	@ tmp135,
 1385 0604 02D1     		bne	.L79	@,
 1386              	.L78:
 353:parson.c      ****         return JSONFailure;
 1387              		.loc 2 353 0 is_stmt 1
 1388 0606 4FF0FF33 		mov	r3, #-1	@ _1,
 1389 060a 4EE0     		b	.L80	@
 1390              	.L79:
 354:parson.c      ****     }
 355:parson.c      ****     if (json_object_getn_value(object, name, name_len) != NULL) {
 1391              		.loc 2 355 0
 1392 060c 7A68     		ldr	r2, [r7, #4]	@, name_len
 1393 060e B968     		ldr	r1, [r7, #8]	@, name
 1394 0610 F868     		ldr	r0, [r7, #12]	@, object
 1395 0612 00F0D2F8 		bl	json_object_getn_value	@
 1396 0616 0346     		mov	r3, r0	@ _11,
 1397 0618 002B     		cmp	r3, #0	@ _11,
 1398 061a 02D0     		beq	.L81	@,
 356:parson.c      ****         return JSONFailure;
 1399              		.loc 2 356 0
 1400 061c 4FF0FF33 		mov	r3, #-1	@ _1,
 1401 0620 43E0     		b	.L80	@
 1402              	.L81:
 357:parson.c      ****     }
 358:parson.c      ****     if (object->count >= object->capacity) {
 1403              		.loc 2 358 0
 1404 0622 FB68     		ldr	r3, [r7, #12]	@ tmp136, object
 1405 0624 DA68     		ldr	r2, [r3, #12]	@ _13, object_5(D)->count
 1406 0626 FB68     		ldr	r3, [r7, #12]	@ tmp137, object
 1407 0628 1B69     		ldr	r3, [r3, #16]	@ _14, object_5(D)->capacity
 1408 062a 9A42     		cmp	r2, r3	@ _13, _14
 1409 062c 11D3     		bcc	.L82	@,
 1410              	.LBB2:
 359:parson.c      ****         size_t new_capacity = MAX(object->capacity * 2, STARTING_CAPACITY);
 1411              		.loc 2 359 0
 1412 062e FB68     		ldr	r3, [r7, #12]	@ tmp138, object
 1413 0630 1B69     		ldr	r3, [r3, #16]	@ _15, object_5(D)->capacity
 1414 0632 5B00     		lsls	r3, r3, #1	@ _16, _15,
 1415 0634 102B     		cmp	r3, #16	@ _16,
 1416 0636 38BF     		it	cc
 1417 0638 1023     		movcc	r3, #16	@ tmp139,
 1418 063a 3B61     		str	r3, [r7, #16]	@ tmp139, new_capacity
 360:parson.c      ****         if (json_object_resize(object, new_capacity) == JSONFailure) {
 1419              		.loc 2 360 0
 1420 063c 3969     		ldr	r1, [r7, #16]	@, new_capacity
 1421 063e F868     		ldr	r0, [r7, #12]	@, object
 1422 0640 00F037F8 		bl	json_object_resize	@
 1423 0644 0346     		mov	r3, r0	@ _19,
 1424 0646 B3F1FF3F 		cmp	r3, #-1	@ _19,
 1425 064a 02D1     		bne	.L82	@,
 361:parson.c      ****             return JSONFailure;
 1426              		.loc 2 361 0
 1427 064c 4FF0FF33 		mov	r3, #-1	@ _1,
 1428 0650 2BE0     		b	.L80	@
 1429              	.L82:
 1430              	.LBE2:
 362:parson.c      ****         }
 363:parson.c      ****     }
 364:parson.c      ****     index = object->count;
 1431              		.loc 2 364 0
 1432 0652 FB68     		ldr	r3, [r7, #12]	@ tmp140, object
 1433 0654 DB68     		ldr	r3, [r3, #12]	@ tmp141, object_5(D)->count
 1434 0656 7B61     		str	r3, [r7, #20]	@ tmp141, index
 365:parson.c      ****     object->names[index] = parson_strndup(name, name_len);
 1435              		.loc 2 365 0
 1436 0658 FB68     		ldr	r3, [r7, #12]	@ tmp142, object
 1437 065a 5A68     		ldr	r2, [r3, #4]	@ _22, object_5(D)->names
 1438 065c 7B69     		ldr	r3, [r7, #20]	@ tmp143, index
 1439 065e 9B00     		lsls	r3, r3, #2	@ _23, tmp143,
 1440 0660 D418     		adds	r4, r2, r3	@ _24, _22, _23
 1441 0662 7968     		ldr	r1, [r7, #4]	@, name_len
 1442 0664 B868     		ldr	r0, [r7, #8]	@, name
 1443 0666 FFF7DFFC 		bl	parson_strndup	@
 1444 066a 0346     		mov	r3, r0	@ _26,
 1445 066c 2360     		str	r3, [r4]	@ _26, *_24
 366:parson.c      ****     if (object->names[index] == NULL) {
 1446              		.loc 2 366 0
 1447 066e FB68     		ldr	r3, [r7, #12]	@ tmp144, object
 1448 0670 5A68     		ldr	r2, [r3, #4]	@ _28, object_5(D)->names
 1449 0672 7B69     		ldr	r3, [r7, #20]	@ tmp145, index
 1450 0674 9B00     		lsls	r3, r3, #2	@ _29, tmp145,
 1451 0676 1344     		add	r3, r3, r2	@ _30, _28
 1452 0678 1B68     		ldr	r3, [r3]	@ _31, *_30
 1453 067a 002B     		cmp	r3, #0	@ _31,
 1454 067c 02D1     		bne	.L83	@,
 367:parson.c      ****         return JSONFailure;
 1455              		.loc 2 367 0
 1456 067e 4FF0FF33 		mov	r3, #-1	@ _1,
 1457 0682 12E0     		b	.L80	@
 1458              	.L83:
 368:parson.c      ****     }
 369:parson.c      ****     value->parent = json_object_get_wrapping_value(object);
 1459              		.loc 2 369 0
 1460 0684 F868     		ldr	r0, [r7, #12]	@, object
 1461 0686 FFF7FEFF 		bl	json_object_get_wrapping_value	@
 1462 068a 0246     		mov	r2, r0	@ _34,
 1463 068c 3B68     		ldr	r3, [r7]	@ tmp146, value
 1464 068e 1A60     		str	r2, [r3]	@ _34, value_7(D)->parent
 370:parson.c      ****     object->values[index] = value;
 1465              		.loc 2 370 0
 1466 0690 FB68     		ldr	r3, [r7, #12]	@ tmp147, object
 1467 0692 9A68     		ldr	r2, [r3, #8]	@ _36, object_5(D)->values
 1468 0694 7B69     		ldr	r3, [r7, #20]	@ tmp148, index
 1469 0696 9B00     		lsls	r3, r3, #2	@ _37, tmp148,
 1470 0698 1344     		add	r3, r3, r2	@ _38, _36
 1471 069a 3A68     		ldr	r2, [r7]	@ tmp149, value
 1472 069c 1A60     		str	r2, [r3]	@ tmp149, *_38
 371:parson.c      ****     object->count++;
 1473              		.loc 2 371 0
 1474 069e FB68     		ldr	r3, [r7, #12]	@ tmp150, object
 1475 06a0 DB68     		ldr	r3, [r3, #12]	@ _40, object_5(D)->count
 1476 06a2 5A1C     		adds	r2, r3, #1	@ _41, _40,
 1477 06a4 FB68     		ldr	r3, [r7, #12]	@ tmp151, object
 1478 06a6 DA60     		str	r2, [r3, #12]	@ _41, object_5(D)->count
 372:parson.c      ****     return JSONSuccess;
 1479              		.loc 2 372 0
 1480 06a8 0023     		movs	r3, #0	@ _1,
 1481              	.L80:
 373:parson.c      **** }
 1482              		.loc 2 373 0
 1483 06aa 1846     		mov	r0, r3	@, <retval>
 1484 06ac 1C37     		adds	r7, r7, #28	@,,
 1485              	.LCFI66:
 1486              		.cfi_def_cfa_offset 12
 1487 06ae BD46     		mov	sp, r7	@,
 1488              	.LCFI67:
 1489              		.cfi_def_cfa_register 13
 1490              		@ sp needed	@
 1491 06b0 90BD     		pop	{r4, r7, pc}	@
 1492              		.cfi_endproc
 1493              	.LFE29:
 1495              		.align	1
 1496              		.syntax unified
 1497              		.thumb
 1498              		.thumb_func
 1499              		.fpu neon
 1501              	json_object_resize:
 1502              	.LFB30:
 374:parson.c      **** 
 375:parson.c      **** static JSON_Status json_object_resize(JSON_Object *object, size_t new_capacity)
 376:parson.c      **** {
 1503              		.loc 2 376 0
 1504              		.cfi_startproc
 1505              		@ args = 0, pretend = 0, frame = 16
 1506              		@ frame_needed = 1, uses_anonymous_args = 0
 1507 06b2 80B5     		push	{r7, lr}	@
 1508              	.LCFI68:
 1509              		.cfi_def_cfa_offset 8
 1510              		.cfi_offset 7, -8
 1511              		.cfi_offset 14, -4
 1512 06b4 84B0     		sub	sp, sp, #16	@,,
 1513              	.LCFI69:
 1514              		.cfi_def_cfa_offset 24
 1515 06b6 00AF     		add	r7, sp, #0	@,,
 1516              	.LCFI70:
 1517              		.cfi_def_cfa_register 7
 1518 06b8 7860     		str	r0, [r7, #4]	@ object, object
 1519 06ba 3960     		str	r1, [r7]	@ new_capacity, new_capacity
 377:parson.c      ****     char **temp_names = NULL;
 1520              		.loc 2 377 0
 1521 06bc 0023     		movs	r3, #0	@ tmp134,
 1522 06be FB60     		str	r3, [r7, #12]	@ tmp134, temp_names
 378:parson.c      ****     JSON_Value **temp_values = NULL;
 1523              		.loc 2 378 0
 1524 06c0 0023     		movs	r3, #0	@ tmp135,
 1525 06c2 BB60     		str	r3, [r7, #8]	@ tmp135, temp_values
 379:parson.c      **** 
 380:parson.c      ****     if ((object->names == NULL && object->values != NULL) ||
 1526              		.loc 2 380 0
 1527 06c4 7B68     		ldr	r3, [r7, #4]	@ tmp136, object
 1528 06c6 5B68     		ldr	r3, [r3, #4]	@ _8, object_7(D)->names
 1529 06c8 002B     		cmp	r3, #0	@ _8,
 1530 06ca 03D1     		bne	.L85	@,
 1531              		.loc 2 380 0 is_stmt 0 discriminator 1
 1532 06cc 7B68     		ldr	r3, [r7, #4]	@ tmp137, object
 1533 06ce 9B68     		ldr	r3, [r3, #8]	@ _9, object_7(D)->values
 1534 06d0 002B     		cmp	r3, #0	@ _9,
 1535 06d2 0AD1     		bne	.L86	@,
 1536              	.L85:
 381:parson.c      ****         (object->names != NULL && object->values == NULL) || new_capacity == 0) {
 1537              		.loc 2 381 0 is_stmt 1 discriminator 3
 1538 06d4 7B68     		ldr	r3, [r7, #4]	@ tmp138, object
 1539 06d6 5B68     		ldr	r3, [r3, #4]	@ _10, object_7(D)->names
 380:parson.c      ****         (object->names != NULL && object->values == NULL) || new_capacity == 0) {
 1540              		.loc 2 380 0 discriminator 3
 1541 06d8 002B     		cmp	r3, #0	@ _10,
 1542 06da 03D0     		beq	.L87	@,
 1543              		.loc 2 381 0
 1544 06dc 7B68     		ldr	r3, [r7, #4]	@ tmp139, object
 1545 06de 9B68     		ldr	r3, [r3, #8]	@ _11, object_7(D)->values
 1546 06e0 002B     		cmp	r3, #0	@ _11,
 1547 06e2 02D0     		beq	.L86	@,
 1548              	.L87:
 1549              		.loc 2 381 0 is_stmt 0 discriminator 1
 1550 06e4 3B68     		ldr	r3, [r7]	@ tmp140, new_capacity
 1551 06e6 002B     		cmp	r3, #0	@ tmp140,
 1552 06e8 02D1     		bne	.L88	@,
 1553              	.L86:
 382:parson.c      ****         return JSONFailure; /* Shouldn't happen */
 1554              		.loc 2 382 0 is_stmt 1
 1555 06ea 4FF0FF33 		mov	r3, #-1	@ _1,
 1556 06ee 60E0     		b	.L89	@
 1557              	.L88:
 383:parson.c      ****     }
 384:parson.c      ****     temp_names = (char **)parson_malloc(new_capacity * sizeof(char *));
 1558              		.loc 2 384 0
 1559 06f0 40F20003 		movw	r3, #:lower16:parson_malloc	@ tmp141,
 1560 06f4 C0F20003 		movt	r3, #:upper16:parson_malloc	@ tmp141,
 1561 06f8 1B68     		ldr	r3, [r3]	@ parson_malloc.8_13, parson_malloc
 1562 06fa 3A68     		ldr	r2, [r7]	@ tmp142, new_capacity
 1563 06fc 9200     		lsls	r2, r2, #2	@ _14, tmp142,
 1564 06fe 1046     		mov	r0, r2	@, _14
 1565 0700 9847     		blx	r3	@ parson_malloc.8_13
 1566              	.LVL2:
 1567 0702 F860     		str	r0, [r7, #12]	@, temp_names
 385:parson.c      ****     if (temp_names == NULL) {
 1568              		.loc 2 385 0
 1569 0704 FB68     		ldr	r3, [r7, #12]	@ tmp143, temp_names
 1570 0706 002B     		cmp	r3, #0	@ tmp143,
 1571 0708 02D1     		bne	.L90	@,
 386:parson.c      ****         return JSONFailure;
 1572              		.loc 2 386 0
 1573 070a 4FF0FF33 		mov	r3, #-1	@ _1,
 1574 070e 50E0     		b	.L89	@
 1575              	.L90:
 387:parson.c      ****     }
 388:parson.c      ****     temp_values = (JSON_Value **)parson_malloc(new_capacity * sizeof(JSON_Value *));
 1576              		.loc 2 388 0
 1577 0710 40F20003 		movw	r3, #:lower16:parson_malloc	@ tmp144,
 1578 0714 C0F20003 		movt	r3, #:upper16:parson_malloc	@ tmp144,
 1579 0718 1B68     		ldr	r3, [r3]	@ parson_malloc.9_18, parson_malloc
 1580 071a 3A68     		ldr	r2, [r7]	@ tmp145, new_capacity
 1581 071c 9200     		lsls	r2, r2, #2	@ _19, tmp145,
 1582 071e 1046     		mov	r0, r2	@, _19
 1583 0720 9847     		blx	r3	@ parson_malloc.9_18
 1584              	.LVL3:
 1585 0722 B860     		str	r0, [r7, #8]	@, temp_values
 389:parson.c      ****     if (temp_values == NULL) {
 1586              		.loc 2 389 0
 1587 0724 BB68     		ldr	r3, [r7, #8]	@ tmp146, temp_values
 1588 0726 002B     		cmp	r3, #0	@ tmp146,
 1589 0728 09D1     		bne	.L91	@,
 390:parson.c      ****         parson_free(temp_names);
 1590              		.loc 2 390 0
 1591 072a 40F20003 		movw	r3, #:lower16:parson_free	@ tmp147,
 1592 072e C0F20003 		movt	r3, #:upper16:parson_free	@ tmp147,
 1593 0732 1B68     		ldr	r3, [r3]	@ parson_free.10_22, parson_free
 1594 0734 F868     		ldr	r0, [r7, #12]	@, temp_names
 1595 0736 9847     		blx	r3	@ parson_free.10_22
 1596              	.LVL4:
 391:parson.c      ****         return JSONFailure;
 1597              		.loc 2 391 0
 1598 0738 4FF0FF33 		mov	r3, #-1	@ _1,
 1599 073c 39E0     		b	.L89	@
 1600              	.L91:
 392:parson.c      ****     }
 393:parson.c      ****     if (object->names != NULL && object->values != NULL && object->count > 0) {
 1601              		.loc 2 393 0
 1602 073e 7B68     		ldr	r3, [r7, #4]	@ tmp148, object
 1603 0740 5B68     		ldr	r3, [r3, #4]	@ _25, object_7(D)->names
 1604 0742 002B     		cmp	r3, #0	@ _25,
 1605 0744 19D0     		beq	.L92	@,
 1606              		.loc 2 393 0 is_stmt 0 discriminator 1
 1607 0746 7B68     		ldr	r3, [r7, #4]	@ tmp149, object
 1608 0748 9B68     		ldr	r3, [r3, #8]	@ _26, object_7(D)->values
 1609 074a 002B     		cmp	r3, #0	@ _26,
 1610 074c 15D0     		beq	.L92	@,
 1611              		.loc 2 393 0 discriminator 2
 1612 074e 7B68     		ldr	r3, [r7, #4]	@ tmp150, object
 1613 0750 DB68     		ldr	r3, [r3, #12]	@ _27, object_7(D)->count
 1614 0752 002B     		cmp	r3, #0	@ _27,
 1615 0754 11D0     		beq	.L92	@,
 394:parson.c      ****         memcpy(temp_names, object->names, object->count * sizeof(char *));
 1616              		.loc 2 394 0 is_stmt 1
 1617 0756 7B68     		ldr	r3, [r7, #4]	@ tmp151, object
 1618 0758 5968     		ldr	r1, [r3, #4]	@ _28, object_7(D)->names
 1619 075a 7B68     		ldr	r3, [r7, #4]	@ tmp152, object
 1620 075c DB68     		ldr	r3, [r3, #12]	@ _29, object_7(D)->count
 1621 075e 9B00     		lsls	r3, r3, #2	@ _30, _29,
 1622 0760 1A46     		mov	r2, r3	@, _30
 1623 0762 F868     		ldr	r0, [r7, #12]	@, temp_names
 1624 0764 FFF7FEFF 		bl	memcpy	@
 395:parson.c      ****         memcpy(temp_values, object->values, object->count * sizeof(JSON_Value *));
 1625              		.loc 2 395 0
 1626 0768 7B68     		ldr	r3, [r7, #4]	@ tmp153, object
 1627 076a 9968     		ldr	r1, [r3, #8]	@ _32, object_7(D)->values
 1628 076c 7B68     		ldr	r3, [r7, #4]	@ tmp154, object
 1629 076e DB68     		ldr	r3, [r3, #12]	@ _33, object_7(D)->count
 1630 0770 9B00     		lsls	r3, r3, #2	@ _34, _33,
 1631 0772 1A46     		mov	r2, r3	@, _34
 1632 0774 B868     		ldr	r0, [r7, #8]	@, temp_values
 1633 0776 FFF7FEFF 		bl	memcpy	@
 1634              	.L92:
 396:parson.c      ****     }
 397:parson.c      ****     parson_free(object->names);
 1635              		.loc 2 397 0
 1636 077a 40F20003 		movw	r3, #:lower16:parson_free	@ tmp155,
 1637 077e C0F20003 		movt	r3, #:upper16:parson_free	@ tmp155,
 1638 0782 1B68     		ldr	r3, [r3]	@ parson_free.11_36, parson_free
 1639 0784 7A68     		ldr	r2, [r7, #4]	@ tmp156, object
 1640 0786 5268     		ldr	r2, [r2, #4]	@ _37, object_7(D)->names
 1641 0788 1046     		mov	r0, r2	@, _37
 1642 078a 9847     		blx	r3	@ parson_free.11_36
 1643              	.LVL5:
 398:parson.c      ****     parson_free(object->values);
 1644              		.loc 2 398 0
 1645 078c 40F20003 		movw	r3, #:lower16:parson_free	@ tmp157,
 1646 0790 C0F20003 		movt	r3, #:upper16:parson_free	@ tmp157,
 1647 0794 1B68     		ldr	r3, [r3]	@ parson_free.12_39, parson_free
 1648 0796 7A68     		ldr	r2, [r7, #4]	@ tmp158, object
 1649 0798 9268     		ldr	r2, [r2, #8]	@ _40, object_7(D)->values
 1650 079a 1046     		mov	r0, r2	@, _40
 1651 079c 9847     		blx	r3	@ parson_free.12_39
 1652              	.LVL6:
 399:parson.c      ****     object->names = temp_names;
 1653              		.loc 2 399 0
 1654 079e 7B68     		ldr	r3, [r7, #4]	@ tmp159, object
 1655 07a0 FA68     		ldr	r2, [r7, #12]	@ tmp160, temp_names
 1656 07a2 5A60     		str	r2, [r3, #4]	@ tmp160, object_7(D)->names
 400:parson.c      ****     object->values = temp_values;
 1657              		.loc 2 400 0
 1658 07a4 7B68     		ldr	r3, [r7, #4]	@ tmp161, object
 1659 07a6 BA68     		ldr	r2, [r7, #8]	@ tmp162, temp_values
 1660 07a8 9A60     		str	r2, [r3, #8]	@ tmp162, object_7(D)->values
 401:parson.c      ****     object->capacity = new_capacity;
 1661              		.loc 2 401 0
 1662 07aa 7B68     		ldr	r3, [r7, #4]	@ tmp163, object
 1663 07ac 3A68     		ldr	r2, [r7]	@ tmp164, new_capacity
 1664 07ae 1A61     		str	r2, [r3, #16]	@ tmp164, object_7(D)->capacity
 402:parson.c      ****     return JSONSuccess;
 1665              		.loc 2 402 0
 1666 07b0 0023     		movs	r3, #0	@ _1,
 1667              	.L89:
 403:parson.c      **** }
 1668              		.loc 2 403 0
 1669 07b2 1846     		mov	r0, r3	@, <retval>
 1670 07b4 1037     		adds	r7, r7, #16	@,,
 1671              	.LCFI71:
 1672              		.cfi_def_cfa_offset 8
 1673 07b6 BD46     		mov	sp, r7	@,
 1674              	.LCFI72:
 1675              		.cfi_def_cfa_register 13
 1676              		@ sp needed	@
 1677 07b8 80BD     		pop	{r7, pc}	@
 1678              		.cfi_endproc
 1679              	.LFE30:
 1681              		.align	1
 1682              		.syntax unified
 1683              		.thumb
 1684              		.thumb_func
 1685              		.fpu neon
 1687              	json_object_getn_value:
 1688              	.LFB31:
 404:parson.c      **** 
 405:parson.c      **** static JSON_Value *json_object_getn_value(const JSON_Object *object, const char *name,
 406:parson.c      ****                                           size_t name_len)
 407:parson.c      **** {
 1689              		.loc 2 407 0
 1690              		.cfi_startproc
 1691              		@ args = 0, pretend = 0, frame = 24
 1692              		@ frame_needed = 1, uses_anonymous_args = 0
 1693 07ba 80B5     		push	{r7, lr}	@
 1694              	.LCFI73:
 1695              		.cfi_def_cfa_offset 8
 1696              		.cfi_offset 7, -8
 1697              		.cfi_offset 14, -4
 1698 07bc 86B0     		sub	sp, sp, #24	@,,
 1699              	.LCFI74:
 1700              		.cfi_def_cfa_offset 32
 1701 07be 00AF     		add	r7, sp, #0	@,,
 1702              	.LCFI75:
 1703              		.cfi_def_cfa_register 7
 1704 07c0 F860     		str	r0, [r7, #12]	@ object, object
 1705 07c2 B960     		str	r1, [r7, #8]	@ name, name
 1706 07c4 7A60     		str	r2, [r7, #4]	@ name_len, name_len
 408:parson.c      ****     size_t i, name_length;
 409:parson.c      ****     for (i = 0; i < json_object_get_count(object); i++) {
 1707              		.loc 2 409 0
 1708 07c6 0023     		movs	r3, #0	@ tmp125,
 1709 07c8 7B61     		str	r3, [r7, #20]	@ tmp125, i
 1710 07ca 26E0     		b	.L94	@
 1711              	.L98:
 410:parson.c      ****         name_length = strlen(object->names[i]);
 1712              		.loc 2 410 0
 1713 07cc FB68     		ldr	r3, [r7, #12]	@ tmp126, object
 1714 07ce 5A68     		ldr	r2, [r3, #4]	@ _9, object_6(D)->names
 1715 07d0 7B69     		ldr	r3, [r7, #20]	@ tmp127, i
 1716 07d2 9B00     		lsls	r3, r3, #2	@ _10, tmp127,
 1717 07d4 1344     		add	r3, r3, r2	@ _11, _9
 1718 07d6 1B68     		ldr	r3, [r3]	@ _12, *_11
 1719 07d8 1846     		mov	r0, r3	@, _12
 1720 07da FFF7FEFF 		bl	strlen	@
 1721 07de 3861     		str	r0, [r7, #16]	@, name_length
 411:parson.c      ****         if (name_length != name_len) {
 1722              		.loc 2 411 0
 1723 07e0 3A69     		ldr	r2, [r7, #16]	@ tmp128, name_length
 1724 07e2 7B68     		ldr	r3, [r7, #4]	@ tmp129, name_len
 1725 07e4 9A42     		cmp	r2, r3	@ tmp128, tmp129
 1726 07e6 14D1     		bne	.L99	@,
 412:parson.c      ****             continue;
 413:parson.c      ****         }
 414:parson.c      ****         if (strncmp(object->names[i], name, name_len) == 0) {
 1727              		.loc 2 414 0
 1728 07e8 FB68     		ldr	r3, [r7, #12]	@ tmp130, object
 1729 07ea 5A68     		ldr	r2, [r3, #4]	@ _16, object_6(D)->names
 1730 07ec 7B69     		ldr	r3, [r7, #20]	@ tmp131, i
 1731 07ee 9B00     		lsls	r3, r3, #2	@ _17, tmp131,
 1732 07f0 1344     		add	r3, r3, r2	@ _18, _16
 1733 07f2 1B68     		ldr	r3, [r3]	@ _19, *_18
 1734 07f4 7A68     		ldr	r2, [r7, #4]	@, name_len
 1735 07f6 B968     		ldr	r1, [r7, #8]	@, name
 1736 07f8 1846     		mov	r0, r3	@, _19
 1737 07fa FFF7FEFF 		bl	strncmp	@
 1738 07fe 0346     		mov	r3, r0	@ _21,
 1739 0800 002B     		cmp	r3, #0	@ _21,
 1740 0802 07D1     		bne	.L96	@,
 415:parson.c      ****             return object->values[i];
 1741              		.loc 2 415 0
 1742 0804 FB68     		ldr	r3, [r7, #12]	@ tmp132, object
 1743 0806 9A68     		ldr	r2, [r3, #8]	@ _22, object_6(D)->values
 1744 0808 7B69     		ldr	r3, [r7, #20]	@ tmp133, i
 1745 080a 9B00     		lsls	r3, r3, #2	@ _23, tmp133,
 1746 080c 1344     		add	r3, r3, r2	@ _24, _22
 1747 080e 1B68     		ldr	r3, [r3]	@ _2, *_24
 1748 0810 0BE0     		b	.L97	@
 1749              	.L99:
 412:parson.c      ****             continue;
 1750              		.loc 2 412 0
 1751 0812 00BF     		nop
 1752              	.L96:
 409:parson.c      ****         name_length = strlen(object->names[i]);
 1753              		.loc 2 409 0 discriminator 2
 1754 0814 7B69     		ldr	r3, [r7, #20]	@ tmp135, i
 1755 0816 0133     		adds	r3, r3, #1	@ tmp134, tmp135,
 1756 0818 7B61     		str	r3, [r7, #20]	@ tmp134, i
 1757              	.L94:
 409:parson.c      ****         name_length = strlen(object->names[i]);
 1758              		.loc 2 409 0 is_stmt 0 discriminator 1
 1759 081a F868     		ldr	r0, [r7, #12]	@, object
 1760 081c FFF7FEFF 		bl	json_object_get_count	@
 1761 0820 0246     		mov	r2, r0	@ _8,
 1762 0822 7B69     		ldr	r3, [r7, #20]	@ tmp136, i
 1763 0824 9A42     		cmp	r2, r3	@ _8, tmp136
 1764 0826 D1D8     		bhi	.L98	@,
 416:parson.c      ****         }
 417:parson.c      ****     }
 418:parson.c      ****     return NULL;
 1765              		.loc 2 418 0 is_stmt 1
 1766 0828 0023     		movs	r3, #0	@ _2,
 1767              	.L97:
 419:parson.c      **** }
 1768              		.loc 2 419 0
 1769 082a 1846     		mov	r0, r3	@, <retval>
 1770 082c 1837     		adds	r7, r7, #24	@,,
 1771              	.LCFI76:
 1772              		.cfi_def_cfa_offset 8
 1773 082e BD46     		mov	sp, r7	@,
 1774              	.LCFI77:
 1775              		.cfi_def_cfa_register 13
 1776              		@ sp needed	@
 1777 0830 80BD     		pop	{r7, pc}	@
 1778              		.cfi_endproc
 1779              	.LFE31:
 1781              		.align	1
 1782              		.syntax unified
 1783              		.thumb
 1784              		.thumb_func
 1785              		.fpu neon
 1787              	json_object_remove_internal:
 1788              	.LFB32:
 420:parson.c      **** 
 421:parson.c      **** static JSON_Status json_object_remove_internal(JSON_Object *object, const char *name,
 422:parson.c      ****                                                int free_value)
 423:parson.c      **** {
 1789              		.loc 2 423 0
 1790              		.cfi_startproc
 1791              		@ args = 0, pretend = 0, frame = 24
 1792              		@ frame_needed = 1, uses_anonymous_args = 0
 1793 0832 80B5     		push	{r7, lr}	@
 1794              	.LCFI78:
 1795              		.cfi_def_cfa_offset 8
 1796              		.cfi_offset 7, -8
 1797              		.cfi_offset 14, -4
 1798 0834 86B0     		sub	sp, sp, #24	@,,
 1799              	.LCFI79:
 1800              		.cfi_def_cfa_offset 32
 1801 0836 00AF     		add	r7, sp, #0	@,,
 1802              	.LCFI80:
 1803              		.cfi_def_cfa_register 7
 1804 0838 F860     		str	r0, [r7, #12]	@ object, object
 1805 083a B960     		str	r1, [r7, #8]	@ name, name
 1806 083c 7A60     		str	r2, [r7, #4]	@ free_value, free_value
 424:parson.c      ****     size_t i = 0, last_item_index = 0;
 1807              		.loc 2 424 0
 1808 083e 0023     		movs	r3, #0	@ tmp145,
 1809 0840 7B61     		str	r3, [r7, #20]	@ tmp145, i
 1810 0842 0023     		movs	r3, #0	@ tmp146,
 1811 0844 3B61     		str	r3, [r7, #16]	@ tmp146, last_item_index
 425:parson.c      ****     if (object == NULL || json_object_get_value(object, name) == NULL) {
 1812              		.loc 2 425 0
 1813 0846 FB68     		ldr	r3, [r7, #12]	@ tmp147, object
 1814 0848 002B     		cmp	r3, #0	@ tmp147,
 1815 084a 06D0     		beq	.L101	@,
 1816              		.loc 2 425 0 is_stmt 0 discriminator 1
 1817 084c B968     		ldr	r1, [r7, #8]	@, name
 1818 084e F868     		ldr	r0, [r7, #12]	@, object
 1819 0850 FFF7FEFF 		bl	json_object_get_value	@
 1820 0854 0346     		mov	r3, r0	@ _14,
 1821 0856 002B     		cmp	r3, #0	@ _14,
 1822 0858 02D1     		bne	.L102	@,
 1823              	.L101:
 426:parson.c      ****         return JSONFailure;
 1824              		.loc 2 426 0 is_stmt 1
 1825 085a 4FF0FF33 		mov	r3, #-1	@ _2,
 1826 085e 5DE0     		b	.L103	@
 1827              	.L102:
 427:parson.c      ****     }
 428:parson.c      ****     last_item_index = json_object_get_count(object) - 1;
 1828              		.loc 2 428 0
 1829 0860 F868     		ldr	r0, [r7, #12]	@, object
 1830 0862 FFF7FEFF 		bl	json_object_get_count	@
 1831 0866 0346     		mov	r3, r0	@ _16,
 1832 0868 013B     		subs	r3, r3, #1	@ tmp148, _16,
 1833 086a 3B61     		str	r3, [r7, #16]	@ tmp148, last_item_index
 429:parson.c      ****     for (i = 0; i < json_object_get_count(object); i++) {
 1834              		.loc 2 429 0
 1835 086c 0023     		movs	r3, #0	@ tmp149,
 1836 086e 7B61     		str	r3, [r7, #20]	@ tmp149, i
 1837 0870 4BE0     		b	.L104	@
 1838              	.L108:
 430:parson.c      ****         if (strcmp(object->names[i], name) == 0) {
 1839              		.loc 2 430 0
 1840 0872 FB68     		ldr	r3, [r7, #12]	@ tmp150, object
 1841 0874 5A68     		ldr	r2, [r3, #4]	@ _21, object_10(D)->names
 1842 0876 7B69     		ldr	r3, [r7, #20]	@ tmp151, i
 1843 0878 9B00     		lsls	r3, r3, #2	@ _22, tmp151,
 1844 087a 1344     		add	r3, r3, r2	@ _23, _21
 1845 087c 1B68     		ldr	r3, [r3]	@ _24, *_23
 1846 087e B968     		ldr	r1, [r7, #8]	@, name
 1847 0880 1846     		mov	r0, r3	@, _24
 1848 0882 FFF7FEFF 		bl	strcmp	@
 1849 0886 0346     		mov	r3, r0	@ _25,
 1850 0888 002B     		cmp	r3, #0	@ _25,
 1851 088a 3BD1     		bne	.L105	@,
 431:parson.c      ****             parson_free(object->names[i]);
 1852              		.loc 2 431 0
 1853 088c 40F20003 		movw	r3, #:lower16:parson_free	@ tmp152,
 1854 0890 C0F20003 		movt	r3, #:upper16:parson_free	@ tmp152,
 1855 0894 1B68     		ldr	r3, [r3]	@ parson_free.13_27, parson_free
 1856 0896 FA68     		ldr	r2, [r7, #12]	@ tmp153, object
 1857 0898 5168     		ldr	r1, [r2, #4]	@ _28, object_10(D)->names
 1858 089a 7A69     		ldr	r2, [r7, #20]	@ tmp154, i
 1859 089c 9200     		lsls	r2, r2, #2	@ _29, tmp154,
 1860 089e 0A44     		add	r2, r2, r1	@ _30, _28
 1861 08a0 1268     		ldr	r2, [r2]	@ _31, *_30
 1862 08a2 1046     		mov	r0, r2	@, _31
 1863 08a4 9847     		blx	r3	@ parson_free.13_27
 1864              	.LVL7:
 432:parson.c      ****             if (free_value) {
 1865              		.loc 2 432 0
 1866 08a6 7B68     		ldr	r3, [r7, #4]	@ tmp155, free_value
 1867 08a8 002B     		cmp	r3, #0	@ tmp155,
 1868 08aa 08D0     		beq	.L106	@,
 433:parson.c      ****                 json_value_free(object->values[i]);
 1869              		.loc 2 433 0
 1870 08ac FB68     		ldr	r3, [r7, #12]	@ tmp156, object
 1871 08ae 9A68     		ldr	r2, [r3, #8]	@ _34, object_10(D)->values
 1872 08b0 7B69     		ldr	r3, [r7, #20]	@ tmp157, i
 1873 08b2 9B00     		lsls	r3, r3, #2	@ _35, tmp157,
 1874 08b4 1344     		add	r3, r3, r2	@ _36, _34
 1875 08b6 1B68     		ldr	r3, [r3]	@ _37, *_36
 1876 08b8 1846     		mov	r0, r3	@, _37
 1877 08ba FFF7FEFF 		bl	json_value_free	@
 1878              	.L106:
 434:parson.c      ****             }
 435:parson.c      ****             if (i != last_item_index) { /* Replace key value pair with one from the end */
 1879              		.loc 2 435 0
 1880 08be 7A69     		ldr	r2, [r7, #20]	@ tmp158, i
 1881 08c0 3B69     		ldr	r3, [r7, #16]	@ tmp159, last_item_index
 1882 08c2 9A42     		cmp	r2, r3	@ tmp158, tmp159
 1883 08c4 17D0     		beq	.L107	@,
 436:parson.c      ****                 object->names[i] = object->names[last_item_index];
 1884              		.loc 2 436 0
 1885 08c6 FB68     		ldr	r3, [r7, #12]	@ tmp160, object
 1886 08c8 5A68     		ldr	r2, [r3, #4]	@ _39, object_10(D)->names
 1887 08ca 7B69     		ldr	r3, [r7, #20]	@ tmp161, i
 1888 08cc 9B00     		lsls	r3, r3, #2	@ _40, tmp161,
 1889 08ce 1344     		add	r3, r3, r2	@ _41, _39
 1890 08d0 FA68     		ldr	r2, [r7, #12]	@ tmp162, object
 1891 08d2 5168     		ldr	r1, [r2, #4]	@ _42, object_10(D)->names
 1892 08d4 3A69     		ldr	r2, [r7, #16]	@ tmp163, last_item_index
 1893 08d6 9200     		lsls	r2, r2, #2	@ _43, tmp163,
 1894 08d8 0A44     		add	r2, r2, r1	@ _44, _42
 1895 08da 1268     		ldr	r2, [r2]	@ _45, *_44
 1896 08dc 1A60     		str	r2, [r3]	@ _45, *_41
 437:parson.c      ****                 object->values[i] = object->values[last_item_index];
 1897              		.loc 2 437 0
 1898 08de FB68     		ldr	r3, [r7, #12]	@ tmp164, object
 1899 08e0 9A68     		ldr	r2, [r3, #8]	@ _47, object_10(D)->values
 1900 08e2 7B69     		ldr	r3, [r7, #20]	@ tmp165, i
 1901 08e4 9B00     		lsls	r3, r3, #2	@ _48, tmp165,
 1902 08e6 1344     		add	r3, r3, r2	@ _49, _47
 1903 08e8 FA68     		ldr	r2, [r7, #12]	@ tmp166, object
 1904 08ea 9168     		ldr	r1, [r2, #8]	@ _50, object_10(D)->values
 1905 08ec 3A69     		ldr	r2, [r7, #16]	@ tmp167, last_item_index
 1906 08ee 9200     		lsls	r2, r2, #2	@ _51, tmp167,
 1907 08f0 0A44     		add	r2, r2, r1	@ _52, _50
 1908 08f2 1268     		ldr	r2, [r2]	@ _53, *_52
 1909 08f4 1A60     		str	r2, [r3]	@ _53, *_49
 1910              	.L107:
 438:parson.c      ****             }
 439:parson.c      ****             object->count -= 1;
 1911              		.loc 2 439 0
 1912 08f6 FB68     		ldr	r3, [r7, #12]	@ tmp168, object
 1913 08f8 DB68     		ldr	r3, [r3, #12]	@ _55, object_10(D)->count
 1914 08fa 5A1E     		subs	r2, r3, #1	@ _56, _55,
 1915 08fc FB68     		ldr	r3, [r7, #12]	@ tmp169, object
 1916 08fe DA60     		str	r2, [r3, #12]	@ _56, object_10(D)->count
 440:parson.c      ****             return JSONSuccess;
 1917              		.loc 2 440 0
 1918 0900 0023     		movs	r3, #0	@ _2,
 1919 0902 0BE0     		b	.L103	@
 1920              	.L105:
 429:parson.c      ****         if (strcmp(object->names[i], name) == 0) {
 1921              		.loc 2 429 0 discriminator 2
 1922 0904 7B69     		ldr	r3, [r7, #20]	@ tmp171, i
 1923 0906 0133     		adds	r3, r3, #1	@ tmp170, tmp171,
 1924 0908 7B61     		str	r3, [r7, #20]	@ tmp170, i
 1925              	.L104:
 429:parson.c      ****         if (strcmp(object->names[i], name) == 0) {
 1926              		.loc 2 429 0 is_stmt 0 discriminator 1
 1927 090a F868     		ldr	r0, [r7, #12]	@, object
 1928 090c FFF7FEFF 		bl	json_object_get_count	@
 1929 0910 0246     		mov	r2, r0	@ _20,
 1930 0912 7B69     		ldr	r3, [r7, #20]	@ tmp172, i
 1931 0914 9A42     		cmp	r2, r3	@ _20, tmp172
 1932 0916 ACD8     		bhi	.L108	@,
 441:parson.c      ****         }
 442:parson.c      ****     }
 443:parson.c      ****     return JSONFailure; /* No execution path should end here */
 1933              		.loc 2 443 0 is_stmt 1
 1934 0918 4FF0FF33 		mov	r3, #-1	@ _2,
 1935              	.L103:
 444:parson.c      **** }
 1936              		.loc 2 444 0
 1937 091c 1846     		mov	r0, r3	@, <retval>
 1938 091e 1837     		adds	r7, r7, #24	@,,
 1939              	.LCFI81:
 1940              		.cfi_def_cfa_offset 8
 1941 0920 BD46     		mov	sp, r7	@,
 1942              	.LCFI82:
 1943              		.cfi_def_cfa_register 13
 1944              		@ sp needed	@
 1945 0922 80BD     		pop	{r7, pc}	@
 1946              		.cfi_endproc
 1947              	.LFE32:
 1949              		.align	1
 1950              		.syntax unified
 1951              		.thumb
 1952              		.thumb_func
 1953              		.fpu neon
 1955              	json_object_dotremove_internal:
 1956              	.LFB33:
 445:parson.c      **** 
 446:parson.c      **** static JSON_Status json_object_dotremove_internal(JSON_Object *object, const char *name,
 447:parson.c      ****                                                   int free_value)
 448:parson.c      **** {
 1957              		.loc 2 448 0
 1958              		.cfi_startproc
 1959              		@ args = 0, pretend = 0, frame = 32
 1960              		@ frame_needed = 1, uses_anonymous_args = 0
 1961 0924 80B5     		push	{r7, lr}	@
 1962              	.LCFI83:
 1963              		.cfi_def_cfa_offset 8
 1964              		.cfi_offset 7, -8
 1965              		.cfi_offset 14, -4
 1966 0926 88B0     		sub	sp, sp, #32	@,,
 1967              	.LCFI84:
 1968              		.cfi_def_cfa_offset 40
 1969 0928 00AF     		add	r7, sp, #0	@,,
 1970              	.LCFI85:
 1971              		.cfi_def_cfa_register 7
 1972 092a F860     		str	r0, [r7, #12]	@ object, object
 1973 092c B960     		str	r1, [r7, #8]	@ name, name
 1974 092e 7A60     		str	r2, [r7, #4]	@ free_value, free_value
 449:parson.c      ****     JSON_Value *temp_value = NULL;
 1975              		.loc 2 449 0
 1976 0930 0023     		movs	r3, #0	@ tmp118,
 1977 0932 FB61     		str	r3, [r7, #28]	@ tmp118, temp_value
 450:parson.c      ****     JSON_Object *temp_object = NULL;
 1978              		.loc 2 450 0
 1979 0934 0023     		movs	r3, #0	@ tmp119,
 1980 0936 BB61     		str	r3, [r7, #24]	@ tmp119, temp_object
 451:parson.c      ****     const char *dot_pos = strchr(name, '.');
 1981              		.loc 2 451 0
 1982 0938 2E21     		movs	r1, #46	@,
 1983 093a B868     		ldr	r0, [r7, #8]	@, name
 1984 093c FFF7FEFF 		bl	strchr	@
 1985 0940 7861     		str	r0, [r7, #20]	@, dot_pos
 452:parson.c      ****     if (dot_pos == NULL) {
 1986              		.loc 2 452 0
 1987 0942 7B69     		ldr	r3, [r7, #20]	@ tmp120, dot_pos
 1988 0944 002B     		cmp	r3, #0	@ tmp120,
 1989 0946 06D1     		bne	.L110	@,
 453:parson.c      ****         return json_object_remove_internal(object, name, free_value);
 1990              		.loc 2 453 0
 1991 0948 7A68     		ldr	r2, [r7, #4]	@, free_value
 1992 094a B968     		ldr	r1, [r7, #8]	@, name
 1993 094c F868     		ldr	r0, [r7, #12]	@, object
 1994 094e FFF770FF 		bl	json_object_remove_internal	@
 1995 0952 0346     		mov	r3, r0	@ _1,
 1996 0954 1DE0     		b	.L111	@
 1997              	.L110:
 454:parson.c      ****     }
 455:parson.c      ****     temp_value = json_object_getn_value(object, name, (size_t)(dot_pos - name));
 1998              		.loc 2 455 0
 1999 0956 7A69     		ldr	r2, [r7, #20]	@ dot_pos.14_12, dot_pos
 2000 0958 BB68     		ldr	r3, [r7, #8]	@ name.15_13, name
 2001 095a D31A     		subs	r3, r2, r3	@ _14, dot_pos.14_12, name.15_13
 2002 095c 1A46     		mov	r2, r3	@, _15
 2003 095e B968     		ldr	r1, [r7, #8]	@, name
 2004 0960 F868     		ldr	r0, [r7, #12]	@, object
 2005 0962 FFF72AFF 		bl	json_object_getn_value	@
 2006 0966 F861     		str	r0, [r7, #28]	@, temp_value
 456:parson.c      ****     if (json_value_get_type(temp_value) != JSONObject) {
 2007              		.loc 2 456 0
 2008 0968 F869     		ldr	r0, [r7, #28]	@, temp_value
 2009 096a FFF7FEFF 		bl	json_value_get_type	@
 2010 096e 0346     		mov	r3, r0	@ _19,
 2011 0970 042B     		cmp	r3, #4	@ _19,
 2012 0972 02D0     		beq	.L112	@,
 457:parson.c      ****         return JSONFailure;
 2013              		.loc 2 457 0
 2014 0974 4FF0FF33 		mov	r3, #-1	@ _1,
 2015 0978 0BE0     		b	.L111	@
 2016              	.L112:
 458:parson.c      ****     }
 459:parson.c      ****     temp_object = json_value_get_object(temp_value);
 2017              		.loc 2 459 0
 2018 097a F869     		ldr	r0, [r7, #28]	@, temp_value
 2019 097c FFF7FEFF 		bl	json_value_get_object	@
 2020 0980 B861     		str	r0, [r7, #24]	@, temp_object
 460:parson.c      ****     return json_object_dotremove_internal(temp_object, dot_pos + 1, free_value);
 2021              		.loc 2 460 0
 2022 0982 7B69     		ldr	r3, [r7, #20]	@ tmp121, dot_pos
 2023 0984 0133     		adds	r3, r3, #1	@ _23, tmp121,
 2024 0986 7A68     		ldr	r2, [r7, #4]	@, free_value
 2025 0988 1946     		mov	r1, r3	@, _23
 2026 098a B869     		ldr	r0, [r7, #24]	@, temp_object
 2027 098c FFF7CAFF 		bl	json_object_dotremove_internal	@
 2028 0990 0346     		mov	r3, r0	@ _1,
 2029              	.L111:
 461:parson.c      **** }
 2030              		.loc 2 461 0
 2031 0992 1846     		mov	r0, r3	@, <retval>
 2032 0994 2037     		adds	r7, r7, #32	@,,
 2033              	.LCFI86:
 2034              		.cfi_def_cfa_offset 8
 2035 0996 BD46     		mov	sp, r7	@,
 2036              	.LCFI87:
 2037              		.cfi_def_cfa_register 13
 2038              		@ sp needed	@
 2039 0998 80BD     		pop	{r7, pc}	@
 2040              		.cfi_endproc
 2041              	.LFE33:
 2043              		.align	1
 2044              		.syntax unified
 2045              		.thumb
 2046              		.thumb_func
 2047              		.fpu neon
 2049              	json_object_free:
 2050              	.LFB34:
 462:parson.c      **** 
 463:parson.c      **** static void json_object_free(JSON_Object *object)
 464:parson.c      **** {
 2051              		.loc 2 464 0
 2052              		.cfi_startproc
 2053              		@ args = 0, pretend = 0, frame = 16
 2054              		@ frame_needed = 1, uses_anonymous_args = 0
 2055 099a 80B5     		push	{r7, lr}	@
 2056              	.LCFI88:
 2057              		.cfi_def_cfa_offset 8
 2058              		.cfi_offset 7, -8
 2059              		.cfi_offset 14, -4
 2060 099c 84B0     		sub	sp, sp, #16	@,,
 2061              	.LCFI89:
 2062              		.cfi_def_cfa_offset 24
 2063 099e 00AF     		add	r7, sp, #0	@,,
 2064              	.LCFI90:
 2065              		.cfi_def_cfa_register 7
 2066 09a0 7860     		str	r0, [r7, #4]	@ object, object
 465:parson.c      ****     size_t i;
 466:parson.c      ****     for (i = 0; i < object->count; i++) {
 2067              		.loc 2 466 0
 2068 09a2 0023     		movs	r3, #0	@ tmp125,
 2069 09a4 FB60     		str	r3, [r7, #12]	@ tmp125, i
 2070 09a6 18E0     		b	.L114	@
 2071              	.L115:
 467:parson.c      ****         parson_free(object->names[i]);
 2072              		.loc 2 467 0 discriminator 3
 2073 09a8 40F20003 		movw	r3, #:lower16:parson_free	@ tmp126,
 2074 09ac C0F20003 		movt	r3, #:upper16:parson_free	@ tmp126,
 2075 09b0 1B68     		ldr	r3, [r3]	@ parson_free.16_7, parson_free
 2076 09b2 7A68     		ldr	r2, [r7, #4]	@ tmp127, object
 2077 09b4 5168     		ldr	r1, [r2, #4]	@ _8, object_5(D)->names
 2078 09b6 FA68     		ldr	r2, [r7, #12]	@ tmp128, i
 2079 09b8 9200     		lsls	r2, r2, #2	@ _9, tmp128,
 2080 09ba 0A44     		add	r2, r2, r1	@ _10, _8
 2081 09bc 1268     		ldr	r2, [r2]	@ _11, *_10
 2082 09be 1046     		mov	r0, r2	@, _11
 2083 09c0 9847     		blx	r3	@ parson_free.16_7
 2084              	.LVL8:
 468:parson.c      ****         json_value_free(object->values[i]);
 2085              		.loc 2 468 0 discriminator 3
 2086 09c2 7B68     		ldr	r3, [r7, #4]	@ tmp129, object
 2087 09c4 9A68     		ldr	r2, [r3, #8]	@ _13, object_5(D)->values
 2088 09c6 FB68     		ldr	r3, [r7, #12]	@ tmp130, i
 2089 09c8 9B00     		lsls	r3, r3, #2	@ _14, tmp130,
 2090 09ca 1344     		add	r3, r3, r2	@ _15, _13
 2091 09cc 1B68     		ldr	r3, [r3]	@ _16, *_15
 2092 09ce 1846     		mov	r0, r3	@, _16
 2093 09d0 FFF7FEFF 		bl	json_value_free	@
 466:parson.c      ****         parson_free(object->names[i]);
 2094              		.loc 2 466 0 discriminator 3
 2095 09d4 FB68     		ldr	r3, [r7, #12]	@ tmp132, i
 2096 09d6 0133     		adds	r3, r3, #1	@ tmp131, tmp132,
 2097 09d8 FB60     		str	r3, [r7, #12]	@ tmp131, i
 2098              	.L114:
 466:parson.c      ****         parson_free(object->names[i]);
 2099              		.loc 2 466 0 is_stmt 0 discriminator 1
 2100 09da 7B68     		ldr	r3, [r7, #4]	@ tmp133, object
 2101 09dc DA68     		ldr	r2, [r3, #12]	@ _6, object_5(D)->count
 2102 09de FB68     		ldr	r3, [r7, #12]	@ tmp134, i
 2103 09e0 9A42     		cmp	r2, r3	@ _6, tmp134
 2104 09e2 E1D8     		bhi	.L115	@,
 469:parson.c      ****     }
 470:parson.c      ****     parson_free(object->names);
 2105              		.loc 2 470 0 is_stmt 1
 2106 09e4 40F20003 		movw	r3, #:lower16:parson_free	@ tmp135,
 2107 09e8 C0F20003 		movt	r3, #:upper16:parson_free	@ tmp135,
 2108 09ec 1B68     		ldr	r3, [r3]	@ parson_free.17_19, parson_free
 2109 09ee 7A68     		ldr	r2, [r7, #4]	@ tmp136, object
 2110 09f0 5268     		ldr	r2, [r2, #4]	@ _20, object_5(D)->names
 2111 09f2 1046     		mov	r0, r2	@, _20
 2112 09f4 9847     		blx	r3	@ parson_free.17_19
 2113              	.LVL9:
 471:parson.c      ****     parson_free(object->values);
 2114              		.loc 2 471 0
 2115 09f6 40F20003 		movw	r3, #:lower16:parson_free	@ tmp137,
 2116 09fa C0F20003 		movt	r3, #:upper16:parson_free	@ tmp137,
 2117 09fe 1B68     		ldr	r3, [r3]	@ parson_free.18_22, parson_free
 2118 0a00 7A68     		ldr	r2, [r7, #4]	@ tmp138, object
 2119 0a02 9268     		ldr	r2, [r2, #8]	@ _23, object_5(D)->values
 2120 0a04 1046     		mov	r0, r2	@, _23
 2121 0a06 9847     		blx	r3	@ parson_free.18_22
 2122              	.LVL10:
 472:parson.c      ****     parson_free(object);
 2123              		.loc 2 472 0
 2124 0a08 40F20003 		movw	r3, #:lower16:parson_free	@ tmp139,
 2125 0a0c C0F20003 		movt	r3, #:upper16:parson_free	@ tmp139,
 2126 0a10 1B68     		ldr	r3, [r3]	@ parson_free.19_25, parson_free
 2127 0a12 7868     		ldr	r0, [r7, #4]	@, object
 2128 0a14 9847     		blx	r3	@ parson_free.19_25
 2129              	.LVL11:
 473:parson.c      **** }
 2130              		.loc 2 473 0
 2131 0a16 00BF     		nop
 2132 0a18 1037     		adds	r7, r7, #16	@,,
 2133              	.LCFI91:
 2134              		.cfi_def_cfa_offset 8
 2135 0a1a BD46     		mov	sp, r7	@,
 2136              	.LCFI92:
 2137              		.cfi_def_cfa_register 13
 2138              		@ sp needed	@
 2139 0a1c 80BD     		pop	{r7, pc}	@
 2140              		.cfi_endproc
 2141              	.LFE34:
 2143              		.align	1
 2144              		.syntax unified
 2145              		.thumb
 2146              		.thumb_func
 2147              		.fpu neon
 2149              	json_array_init:
 2150              	.LFB35:
 474:parson.c      **** 
 475:parson.c      **** /* JSON Array */
 476:parson.c      **** static JSON_Array *json_array_init(JSON_Value *wrapping_value)
 477:parson.c      **** {
 2151              		.loc 2 477 0
 2152              		.cfi_startproc
 2153              		@ args = 0, pretend = 0, frame = 16
 2154              		@ frame_needed = 1, uses_anonymous_args = 0
 2155 0a1e 80B5     		push	{r7, lr}	@
 2156              	.LCFI93:
 2157              		.cfi_def_cfa_offset 8
 2158              		.cfi_offset 7, -8
 2159              		.cfi_offset 14, -4
 2160 0a20 84B0     		sub	sp, sp, #16	@,,
 2161              	.LCFI94:
 2162              		.cfi_def_cfa_offset 24
 2163 0a22 00AF     		add	r7, sp, #0	@,,
 2164              	.LCFI95:
 2165              		.cfi_def_cfa_register 7
 2166 0a24 7860     		str	r0, [r7, #4]	@ wrapping_value, wrapping_value
 478:parson.c      ****     JSON_Array *new_array = (JSON_Array *)parson_malloc(sizeof(JSON_Array));
 2167              		.loc 2 478 0
 2168 0a26 40F20003 		movw	r3, #:lower16:parson_malloc	@ tmp113,
 2169 0a2a C0F20003 		movt	r3, #:upper16:parson_malloc	@ tmp113,
 2170 0a2e 1B68     		ldr	r3, [r3]	@ parson_malloc.20_4, parson_malloc
 2171 0a30 1020     		movs	r0, #16	@,
 2172 0a32 9847     		blx	r3	@ parson_malloc.20_4
 2173              	.LVL12:
 2174 0a34 F860     		str	r0, [r7, #12]	@, new_array
 479:parson.c      ****     if (new_array == NULL) {
 2175              		.loc 2 479 0
 2176 0a36 FB68     		ldr	r3, [r7, #12]	@ tmp114, new_array
 2177 0a38 002B     		cmp	r3, #0	@ tmp114,
 2178 0a3a 01D1     		bne	.L117	@,
 480:parson.c      ****         return NULL;
 2179              		.loc 2 480 0
 2180 0a3c 0023     		movs	r3, #0	@ _1,
 2181 0a3e 0CE0     		b	.L118	@
 2182              	.L117:
 481:parson.c      ****     }
 482:parson.c      ****     new_array->wrapping_value = wrapping_value;
 2183              		.loc 2 482 0
 2184 0a40 FB68     		ldr	r3, [r7, #12]	@ tmp115, new_array
 2185 0a42 7A68     		ldr	r2, [r7, #4]	@ tmp116, wrapping_value
 2186 0a44 1A60     		str	r2, [r3]	@ tmp116, new_array_6->wrapping_value
 483:parson.c      ****     new_array->items = (JSON_Value **)NULL;
 2187              		.loc 2 483 0
 2188 0a46 FB68     		ldr	r3, [r7, #12]	@ tmp117, new_array
 2189 0a48 0022     		movs	r2, #0	@ tmp118,
 2190 0a4a 5A60     		str	r2, [r3, #4]	@ tmp118, new_array_6->items
 484:parson.c      ****     new_array->capacity = 0;
 2191              		.loc 2 484 0
 2192 0a4c FB68     		ldr	r3, [r7, #12]	@ tmp119, new_array
 2193 0a4e 0022     		movs	r2, #0	@ tmp120,
 2194 0a50 DA60     		str	r2, [r3, #12]	@ tmp120, new_array_6->capacity
 485:parson.c      ****     new_array->count = 0;
 2195              		.loc 2 485 0
 2196 0a52 FB68     		ldr	r3, [r7, #12]	@ tmp121, new_array
 2197 0a54 0022     		movs	r2, #0	@ tmp122,
 2198 0a56 9A60     		str	r2, [r3, #8]	@ tmp122, new_array_6->count
 486:parson.c      ****     return new_array;
 2199              		.loc 2 486 0
 2200 0a58 FB68     		ldr	r3, [r7, #12]	@ _1, new_array
 2201              	.L118:
 487:parson.c      **** }
 2202              		.loc 2 487 0
 2203 0a5a 1846     		mov	r0, r3	@, <retval>
 2204 0a5c 1037     		adds	r7, r7, #16	@,,
 2205              	.LCFI96:
 2206              		.cfi_def_cfa_offset 8
 2207 0a5e BD46     		mov	sp, r7	@,
 2208              	.LCFI97:
 2209              		.cfi_def_cfa_register 13
 2210              		@ sp needed	@
 2211 0a60 80BD     		pop	{r7, pc}	@
 2212              		.cfi_endproc
 2213              	.LFE35:
 2215              		.align	1
 2216              		.syntax unified
 2217              		.thumb
 2218              		.thumb_func
 2219              		.fpu neon
 2221              	json_array_add:
 2222              	.LFB36:
 488:parson.c      **** 
 489:parson.c      **** static JSON_Status json_array_add(JSON_Array *array, JSON_Value *value)
 490:parson.c      **** {
 2223              		.loc 2 490 0
 2224              		.cfi_startproc
 2225              		@ args = 0, pretend = 0, frame = 16
 2226              		@ frame_needed = 1, uses_anonymous_args = 0
 2227 0a62 80B5     		push	{r7, lr}	@
 2228              	.LCFI98:
 2229              		.cfi_def_cfa_offset 8
 2230              		.cfi_offset 7, -8
 2231              		.cfi_offset 14, -4
 2232 0a64 84B0     		sub	sp, sp, #16	@,,
 2233              	.LCFI99:
 2234              		.cfi_def_cfa_offset 24
 2235 0a66 00AF     		add	r7, sp, #0	@,,
 2236              	.LCFI100:
 2237              		.cfi_def_cfa_register 7
 2238 0a68 7860     		str	r0, [r7, #4]	@ array, array
 2239 0a6a 3960     		str	r1, [r7]	@ value, value
 491:parson.c      ****     if (array->count >= array->capacity) {
 2240              		.loc 2 491 0
 2241 0a6c 7B68     		ldr	r3, [r7, #4]	@ tmp124, array
 2242 0a6e 9A68     		ldr	r2, [r3, #8]	@ _6, array_5(D)->count
 2243 0a70 7B68     		ldr	r3, [r7, #4]	@ tmp125, array
 2244 0a72 DB68     		ldr	r3, [r3, #12]	@ _7, array_5(D)->capacity
 2245 0a74 9A42     		cmp	r2, r3	@ _6, _7
 2246 0a76 11D3     		bcc	.L120	@,
 2247              	.LBB3:
 492:parson.c      ****         size_t new_capacity = MAX(array->capacity * 2, STARTING_CAPACITY);
 2248              		.loc 2 492 0
 2249 0a78 7B68     		ldr	r3, [r7, #4]	@ tmp126, array
 2250 0a7a DB68     		ldr	r3, [r3, #12]	@ _8, array_5(D)->capacity
 2251 0a7c 5B00     		lsls	r3, r3, #1	@ _9, _8,
 2252 0a7e 102B     		cmp	r3, #16	@ _9,
 2253 0a80 38BF     		it	cc
 2254 0a82 1023     		movcc	r3, #16	@ tmp127,
 2255 0a84 FB60     		str	r3, [r7, #12]	@ tmp127, new_capacity
 493:parson.c      ****         if (json_array_resize(array, new_capacity) == JSONFailure) {
 2256              		.loc 2 493 0
 2257 0a86 F968     		ldr	r1, [r7, #12]	@, new_capacity
 2258 0a88 7868     		ldr	r0, [r7, #4]	@, array
 2259 0a8a 00F01FF8 		bl	json_array_resize	@
 2260 0a8e 0346     		mov	r3, r0	@ _12,
 2261 0a90 B3F1FF3F 		cmp	r3, #-1	@ _12,
 2262 0a94 02D1     		bne	.L120	@,
 494:parson.c      ****             return JSONFailure;
 2263              		.loc 2 494 0
 2264 0a96 4FF0FF33 		mov	r3, #-1	@ _1,
 2265 0a9a 13E0     		b	.L121	@
 2266              	.L120:
 2267              	.LBE3:
 495:parson.c      ****         }
 496:parson.c      ****     }
 497:parson.c      ****     value->parent = json_array_get_wrapping_value(array);
 2268              		.loc 2 497 0
 2269 0a9c 7868     		ldr	r0, [r7, #4]	@, array
 2270 0a9e FFF7FEFF 		bl	json_array_get_wrapping_value	@
 2271 0aa2 0246     		mov	r2, r0	@ _15,
 2272 0aa4 3B68     		ldr	r3, [r7]	@ tmp128, value
 2273 0aa6 1A60     		str	r2, [r3]	@ _15, value_16(D)->parent
 498:parson.c      ****     array->items[array->count] = value;
 2274              		.loc 2 498 0
 2275 0aa8 7B68     		ldr	r3, [r7, #4]	@ tmp129, array
 2276 0aaa 5A68     		ldr	r2, [r3, #4]	@ _18, array_5(D)->items
 2277 0aac 7B68     		ldr	r3, [r7, #4]	@ tmp130, array
 2278 0aae 9B68     		ldr	r3, [r3, #8]	@ _19, array_5(D)->count
 2279 0ab0 9B00     		lsls	r3, r3, #2	@ _20, _19,
 2280 0ab2 1344     		add	r3, r3, r2	@ _21, _18
 2281 0ab4 3A68     		ldr	r2, [r7]	@ tmp131, value
 2282 0ab6 1A60     		str	r2, [r3]	@ tmp131, *_21
 499:parson.c      ****     array->count++;
 2283              		.loc 2 499 0
 2284 0ab8 7B68     		ldr	r3, [r7, #4]	@ tmp132, array
 2285 0aba 9B68     		ldr	r3, [r3, #8]	@ _23, array_5(D)->count
 2286 0abc 5A1C     		adds	r2, r3, #1	@ _24, _23,
 2287 0abe 7B68     		ldr	r3, [r7, #4]	@ tmp133, array
 2288 0ac0 9A60     		str	r2, [r3, #8]	@ _24, array_5(D)->count
 500:parson.c      ****     return JSONSuccess;
 2289              		.loc 2 500 0
 2290 0ac2 0023     		movs	r3, #0	@ _1,
 2291              	.L121:
 501:parson.c      **** }
 2292              		.loc 2 501 0
 2293 0ac4 1846     		mov	r0, r3	@, <retval>
 2294 0ac6 1037     		adds	r7, r7, #16	@,,
 2295              	.LCFI101:
 2296              		.cfi_def_cfa_offset 8
 2297 0ac8 BD46     		mov	sp, r7	@,
 2298              	.LCFI102:
 2299              		.cfi_def_cfa_register 13
 2300              		@ sp needed	@
 2301 0aca 80BD     		pop	{r7, pc}	@
 2302              		.cfi_endproc
 2303              	.LFE36:
 2305              		.align	1
 2306              		.syntax unified
 2307              		.thumb
 2308              		.thumb_func
 2309              		.fpu neon
 2311              	json_array_resize:
 2312              	.LFB37:
 502:parson.c      **** 
 503:parson.c      **** static JSON_Status json_array_resize(JSON_Array *array, size_t new_capacity)
 504:parson.c      **** {
 2313              		.loc 2 504 0
 2314              		.cfi_startproc
 2315              		@ args = 0, pretend = 0, frame = 16
 2316              		@ frame_needed = 1, uses_anonymous_args = 0
 2317 0acc 80B5     		push	{r7, lr}	@
 2318              	.LCFI103:
 2319              		.cfi_def_cfa_offset 8
 2320              		.cfi_offset 7, -8
 2321              		.cfi_offset 14, -4
 2322 0ace 84B0     		sub	sp, sp, #16	@,,
 2323              	.LCFI104:
 2324              		.cfi_def_cfa_offset 24
 2325 0ad0 00AF     		add	r7, sp, #0	@,,
 2326              	.LCFI105:
 2327              		.cfi_def_cfa_register 7
 2328 0ad2 7860     		str	r0, [r7, #4]	@ array, array
 2329 0ad4 3960     		str	r1, [r7]	@ new_capacity, new_capacity
 505:parson.c      ****     JSON_Value **new_items = NULL;
 2330              		.loc 2 505 0
 2331 0ad6 0023     		movs	r3, #0	@ tmp121,
 2332 0ad8 FB60     		str	r3, [r7, #12]	@ tmp121, new_items
 506:parson.c      ****     if (new_capacity == 0) {
 2333              		.loc 2 506 0
 2334 0ada 3B68     		ldr	r3, [r7]	@ tmp122, new_capacity
 2335 0adc 002B     		cmp	r3, #0	@ tmp122,
 2336 0ade 02D1     		bne	.L123	@,
 507:parson.c      ****         return JSONFailure;
 2337              		.loc 2 507 0
 2338 0ae0 4FF0FF33 		mov	r3, #-1	@ _1,
 2339 0ae4 30E0     		b	.L124	@
 2340              	.L123:
 508:parson.c      ****     }
 509:parson.c      ****     new_items = (JSON_Value **)parson_malloc(new_capacity * sizeof(JSON_Value *));
 2341              		.loc 2 509 0
 2342 0ae6 40F20003 		movw	r3, #:lower16:parson_malloc	@ tmp123,
 2343 0aea C0F20003 		movt	r3, #:upper16:parson_malloc	@ tmp123,
 2344 0aee 1B68     		ldr	r3, [r3]	@ parson_malloc.21_8, parson_malloc
 2345 0af0 3A68     		ldr	r2, [r7]	@ tmp124, new_capacity
 2346 0af2 9200     		lsls	r2, r2, #2	@ _9, tmp124,
 2347 0af4 1046     		mov	r0, r2	@, _9
 2348 0af6 9847     		blx	r3	@ parson_malloc.21_8
 2349              	.LVL13:
 2350 0af8 F860     		str	r0, [r7, #12]	@, new_items
 510:parson.c      ****     if (new_items == NULL) {
 2351              		.loc 2 510 0
 2352 0afa FB68     		ldr	r3, [r7, #12]	@ tmp125, new_items
 2353 0afc 002B     		cmp	r3, #0	@ tmp125,
 2354 0afe 02D1     		bne	.L125	@,
 511:parson.c      ****         return JSONFailure;
 2355              		.loc 2 511 0
 2356 0b00 4FF0FF33 		mov	r3, #-1	@ _1,
 2357 0b04 20E0     		b	.L124	@
 2358              	.L125:
 512:parson.c      ****     }
 513:parson.c      ****     if (array->items != NULL && array->count > 0) {
 2359              		.loc 2 513 0
 2360 0b06 7B68     		ldr	r3, [r7, #4]	@ tmp126, array
 2361 0b08 5B68     		ldr	r3, [r3, #4]	@ _14, array_13(D)->items
 2362 0b0a 002B     		cmp	r3, #0	@ _14,
 2363 0b0c 0CD0     		beq	.L126	@,
 2364              		.loc 2 513 0 is_stmt 0 discriminator 1
 2365 0b0e 7B68     		ldr	r3, [r7, #4]	@ tmp127, array
 2366 0b10 9B68     		ldr	r3, [r3, #8]	@ _15, array_13(D)->count
 2367 0b12 002B     		cmp	r3, #0	@ _15,
 2368 0b14 08D0     		beq	.L126	@,
 514:parson.c      ****         memcpy(new_items, array->items, array->count * sizeof(JSON_Value *));
 2369              		.loc 2 514 0 is_stmt 1
 2370 0b16 7B68     		ldr	r3, [r7, #4]	@ tmp128, array
 2371 0b18 5968     		ldr	r1, [r3, #4]	@ _16, array_13(D)->items
 2372 0b1a 7B68     		ldr	r3, [r7, #4]	@ tmp129, array
 2373 0b1c 9B68     		ldr	r3, [r3, #8]	@ _17, array_13(D)->count
 2374 0b1e 9B00     		lsls	r3, r3, #2	@ _18, _17,
 2375 0b20 1A46     		mov	r2, r3	@, _18
 2376 0b22 F868     		ldr	r0, [r7, #12]	@, new_items
 2377 0b24 FFF7FEFF 		bl	memcpy	@
 2378              	.L126:
 515:parson.c      ****     }
 516:parson.c      ****     parson_free(array->items);
 2379              		.loc 2 516 0
 2380 0b28 40F20003 		movw	r3, #:lower16:parson_free	@ tmp130,
 2381 0b2c C0F20003 		movt	r3, #:upper16:parson_free	@ tmp130,
 2382 0b30 1B68     		ldr	r3, [r3]	@ parson_free.22_20, parson_free
 2383 0b32 7A68     		ldr	r2, [r7, #4]	@ tmp131, array
 2384 0b34 5268     		ldr	r2, [r2, #4]	@ _21, array_13(D)->items
 2385 0b36 1046     		mov	r0, r2	@, _21
 2386 0b38 9847     		blx	r3	@ parson_free.22_20
 2387              	.LVL14:
 517:parson.c      ****     array->items = new_items;
 2388              		.loc 2 517 0
 2389 0b3a 7B68     		ldr	r3, [r7, #4]	@ tmp132, array
 2390 0b3c FA68     		ldr	r2, [r7, #12]	@ tmp133, new_items
 2391 0b3e 5A60     		str	r2, [r3, #4]	@ tmp133, array_13(D)->items
 518:parson.c      ****     array->capacity = new_capacity;
 2392              		.loc 2 518 0
 2393 0b40 7B68     		ldr	r3, [r7, #4]	@ tmp134, array
 2394 0b42 3A68     		ldr	r2, [r7]	@ tmp135, new_capacity
 2395 0b44 DA60     		str	r2, [r3, #12]	@ tmp135, array_13(D)->capacity
 519:parson.c      ****     return JSONSuccess;
 2396              		.loc 2 519 0
 2397 0b46 0023     		movs	r3, #0	@ _1,
 2398              	.L124:
 520:parson.c      **** }
 2399              		.loc 2 520 0
 2400 0b48 1846     		mov	r0, r3	@, <retval>
 2401 0b4a 1037     		adds	r7, r7, #16	@,,
 2402              	.LCFI106:
 2403              		.cfi_def_cfa_offset 8
 2404 0b4c BD46     		mov	sp, r7	@,
 2405              	.LCFI107:
 2406              		.cfi_def_cfa_register 13
 2407              		@ sp needed	@
 2408 0b4e 80BD     		pop	{r7, pc}	@
 2409              		.cfi_endproc
 2410              	.LFE37:
 2412              		.align	1
 2413              		.syntax unified
 2414              		.thumb
 2415              		.thumb_func
 2416              		.fpu neon
 2418              	json_array_free:
 2419              	.LFB38:
 521:parson.c      **** 
 522:parson.c      **** static void json_array_free(JSON_Array *array)
 523:parson.c      **** {
 2420              		.loc 2 523 0
 2421              		.cfi_startproc
 2422              		@ args = 0, pretend = 0, frame = 16
 2423              		@ frame_needed = 1, uses_anonymous_args = 0
 2424 0b50 80B5     		push	{r7, lr}	@
 2425              	.LCFI108:
 2426              		.cfi_def_cfa_offset 8
 2427              		.cfi_offset 7, -8
 2428              		.cfi_offset 14, -4
 2429 0b52 84B0     		sub	sp, sp, #16	@,,
 2430              	.LCFI109:
 2431              		.cfi_def_cfa_offset 24
 2432 0b54 00AF     		add	r7, sp, #0	@,,
 2433              	.LCFI110:
 2434              		.cfi_def_cfa_register 7
 2435 0b56 7860     		str	r0, [r7, #4]	@ array, array
 524:parson.c      ****     size_t i;
 525:parson.c      ****     for (i = 0; i < array->count; i++) {
 2436              		.loc 2 525 0
 2437 0b58 0023     		movs	r3, #0	@ tmp118,
 2438 0b5a FB60     		str	r3, [r7, #12]	@ tmp118, i
 2439 0b5c 0BE0     		b	.L128	@
 2440              	.L129:
 526:parson.c      ****         json_value_free(array->items[i]);
 2441              		.loc 2 526 0 discriminator 3
 2442 0b5e 7B68     		ldr	r3, [r7, #4]	@ tmp119, array
 2443 0b60 5A68     		ldr	r2, [r3, #4]	@ _7, array_5(D)->items
 2444 0b62 FB68     		ldr	r3, [r7, #12]	@ tmp120, i
 2445 0b64 9B00     		lsls	r3, r3, #2	@ _8, tmp120,
 2446 0b66 1344     		add	r3, r3, r2	@ _9, _7
 2447 0b68 1B68     		ldr	r3, [r3]	@ _10, *_9
 2448 0b6a 1846     		mov	r0, r3	@, _10
 2449 0b6c FFF7FEFF 		bl	json_value_free	@
 525:parson.c      ****         json_value_free(array->items[i]);
 2450              		.loc 2 525 0 discriminator 3
 2451 0b70 FB68     		ldr	r3, [r7, #12]	@ tmp122, i
 2452 0b72 0133     		adds	r3, r3, #1	@ tmp121, tmp122,
 2453 0b74 FB60     		str	r3, [r7, #12]	@ tmp121, i
 2454              	.L128:
 525:parson.c      ****         json_value_free(array->items[i]);
 2455              		.loc 2 525 0 is_stmt 0 discriminator 1
 2456 0b76 7B68     		ldr	r3, [r7, #4]	@ tmp123, array
 2457 0b78 9A68     		ldr	r2, [r3, #8]	@ _6, array_5(D)->count
 2458 0b7a FB68     		ldr	r3, [r7, #12]	@ tmp124, i
 2459 0b7c 9A42     		cmp	r2, r3	@ _6, tmp124
 2460 0b7e EED8     		bhi	.L129	@,
 527:parson.c      ****     }
 528:parson.c      ****     parson_free(array->items);
 2461              		.loc 2 528 0 is_stmt 1
 2462 0b80 40F20003 		movw	r3, #:lower16:parson_free	@ tmp125,
 2463 0b84 C0F20003 		movt	r3, #:upper16:parson_free	@ tmp125,
 2464 0b88 1B68     		ldr	r3, [r3]	@ parson_free.23_13, parson_free
 2465 0b8a 7A68     		ldr	r2, [r7, #4]	@ tmp126, array
 2466 0b8c 5268     		ldr	r2, [r2, #4]	@ _14, array_5(D)->items
 2467 0b8e 1046     		mov	r0, r2	@, _14
 2468 0b90 9847     		blx	r3	@ parson_free.23_13
 2469              	.LVL15:
 529:parson.c      ****     parson_free(array);
 2470              		.loc 2 529 0
 2471 0b92 40F20003 		movw	r3, #:lower16:parson_free	@ tmp127,
 2472 0b96 C0F20003 		movt	r3, #:upper16:parson_free	@ tmp127,
 2473 0b9a 1B68     		ldr	r3, [r3]	@ parson_free.24_16, parson_free
 2474 0b9c 7868     		ldr	r0, [r7, #4]	@, array
 2475 0b9e 9847     		blx	r3	@ parson_free.24_16
 2476              	.LVL16:
 530:parson.c      **** }
 2477              		.loc 2 530 0
 2478 0ba0 00BF     		nop
 2479 0ba2 1037     		adds	r7, r7, #16	@,,
 2480              	.LCFI111:
 2481              		.cfi_def_cfa_offset 8
 2482 0ba4 BD46     		mov	sp, r7	@,
 2483              	.LCFI112:
 2484              		.cfi_def_cfa_register 13
 2485              		@ sp needed	@
 2486 0ba6 80BD     		pop	{r7, pc}	@
 2487              		.cfi_endproc
 2488              	.LFE38:
 2490              		.align	1
 2491              		.syntax unified
 2492              		.thumb
 2493              		.thumb_func
 2494              		.fpu neon
 2496              	json_value_init_string_no_copy:
 2497              	.LFB39:
 531:parson.c      **** 
 532:parson.c      **** /* JSON Value */
 533:parson.c      **** static JSON_Value *json_value_init_string_no_copy(char *string)
 534:parson.c      **** {
 2498              		.loc 2 534 0
 2499              		.cfi_startproc
 2500              		@ args = 0, pretend = 0, frame = 16
 2501              		@ frame_needed = 1, uses_anonymous_args = 0
 2502 0ba8 80B5     		push	{r7, lr}	@
 2503              	.LCFI113:
 2504              		.cfi_def_cfa_offset 8
 2505              		.cfi_offset 7, -8
 2506              		.cfi_offset 14, -4
 2507 0baa 84B0     		sub	sp, sp, #16	@,,
 2508              	.LCFI114:
 2509              		.cfi_def_cfa_offset 24
 2510 0bac 00AF     		add	r7, sp, #0	@,,
 2511              	.LCFI115:
 2512              		.cfi_def_cfa_register 7
 2513 0bae 7860     		str	r0, [r7, #4]	@ string, string
 535:parson.c      ****     JSON_Value *new_value = (JSON_Value *)parson_malloc(sizeof(JSON_Value));
 2514              		.loc 2 535 0
 2515 0bb0 40F20003 		movw	r3, #:lower16:parson_malloc	@ tmp113,
 2516 0bb4 C0F20003 		movt	r3, #:upper16:parson_malloc	@ tmp113,
 2517 0bb8 1B68     		ldr	r3, [r3]	@ parson_malloc.25_4, parson_malloc
 2518 0bba 1020     		movs	r0, #16	@,
 2519 0bbc 9847     		blx	r3	@ parson_malloc.25_4
 2520              	.LVL17:
 2521 0bbe F860     		str	r0, [r7, #12]	@, new_value
 536:parson.c      ****     if (!new_value) {
 2522              		.loc 2 536 0
 2523 0bc0 FB68     		ldr	r3, [r7, #12]	@ tmp114, new_value
 2524 0bc2 002B     		cmp	r3, #0	@ tmp114,
 2525 0bc4 01D1     		bne	.L131	@,
 537:parson.c      ****         return NULL;
 2526              		.loc 2 537 0
 2527 0bc6 0023     		movs	r3, #0	@ _1,
 2528 0bc8 09E0     		b	.L132	@
 2529              	.L131:
 538:parson.c      ****     }
 539:parson.c      ****     new_value->parent = NULL;
 2530              		.loc 2 539 0
 2531 0bca FB68     		ldr	r3, [r7, #12]	@ tmp115, new_value
 2532 0bcc 0022     		movs	r2, #0	@ tmp116,
 2533 0bce 1A60     		str	r2, [r3]	@ tmp116, new_value_6->parent
 540:parson.c      ****     new_value->type = JSONString;
 2534              		.loc 2 540 0
 2535 0bd0 FB68     		ldr	r3, [r7, #12]	@ tmp117, new_value
 2536 0bd2 0222     		movs	r2, #2	@ tmp118,
 2537 0bd4 5A60     		str	r2, [r3, #4]	@ tmp118, new_value_6->type
 541:parson.c      ****     new_value->value.string = string;
 2538              		.loc 2 541 0
 2539 0bd6 FB68     		ldr	r3, [r7, #12]	@ tmp119, new_value
 2540 0bd8 7A68     		ldr	r2, [r7, #4]	@ tmp120, string
 2541 0bda 9A60     		str	r2, [r3, #8]	@ tmp120, new_value_6->value.string
 542:parson.c      ****     return new_value;
 2542              		.loc 2 542 0
 2543 0bdc FB68     		ldr	r3, [r7, #12]	@ _1, new_value
 2544              	.L132:
 543:parson.c      **** }
 2545              		.loc 2 543 0
 2546 0bde 1846     		mov	r0, r3	@, <retval>
 2547 0be0 1037     		adds	r7, r7, #16	@,,
 2548              	.LCFI116:
 2549              		.cfi_def_cfa_offset 8
 2550 0be2 BD46     		mov	sp, r7	@,
 2551              	.LCFI117:
 2552              		.cfi_def_cfa_register 13
 2553              		@ sp needed	@
 2554 0be4 80BD     		pop	{r7, pc}	@
 2555              		.cfi_endproc
 2556              	.LFE39:
 2558              		.align	1
 2559              		.syntax unified
 2560              		.thumb
 2561              		.thumb_func
 2562              		.fpu neon
 2564              	skip_quotes:
 2565              	.LFB40:
 544:parson.c      **** 
 545:parson.c      **** /* Parser */
 546:parson.c      **** static JSON_Status skip_quotes(const char **string)
 547:parson.c      **** {
 2566              		.loc 2 547 0
 2567              		.cfi_startproc
 2568              		@ args = 0, pretend = 0, frame = 8
 2569              		@ frame_needed = 1, uses_anonymous_args = 0
 2570              		@ link register save eliminated.
 2571 0be6 80B4     		push	{r7}	@
 2572              	.LCFI118:
 2573              		.cfi_def_cfa_offset 4
 2574              		.cfi_offset 7, -4
 2575 0be8 83B0     		sub	sp, sp, #12	@,,
 2576              	.LCFI119:
 2577              		.cfi_def_cfa_offset 16
 2578 0bea 00AF     		add	r7, sp, #0	@,,
 2579              	.LCFI120:
 2580              		.cfi_def_cfa_register 7
 2581 0bec 7860     		str	r0, [r7, #4]	@ string, string
 548:parson.c      ****     if (**string != '\"') {
 2582              		.loc 2 548 0
 2583 0bee 7B68     		ldr	r3, [r7, #4]	@ tmp130, string
 2584 0bf0 1B68     		ldr	r3, [r3]	@ _7, *string_6(D)
 2585 0bf2 1B78     		ldrb	r3, [r3]	@ zero_extendqisi2	@ _8, *_7
 2586 0bf4 222B     		cmp	r3, #34	@ _8,
 2587 0bf6 02D0     		beq	.L134	@,
 549:parson.c      ****         return JSONFailure;
 2588              		.loc 2 549 0
 2589 0bf8 4FF0FF33 		mov	r3, #-1	@ _1,
 2590 0bfc 2FE0     		b	.L135	@
 2591              	.L134:
 550:parson.c      ****     }
 551:parson.c      ****     SKIP_CHAR(string);
 2592              		.loc 2 551 0
 2593 0bfe 7B68     		ldr	r3, [r7, #4]	@ tmp131, string
 2594 0c00 1B68     		ldr	r3, [r3]	@ _10, *string_6(D)
 2595 0c02 5A1C     		adds	r2, r3, #1	@ _11, _10,
 2596 0c04 7B68     		ldr	r3, [r7, #4]	@ tmp132, string
 2597 0c06 1A60     		str	r2, [r3]	@ _11, *string_6(D)
 552:parson.c      ****     while (**string != '\"') {
 2598              		.loc 2 552 0
 2599 0c08 1EE0     		b	.L136	@
 2600              	.L139:
 553:parson.c      ****         if (**string == '\0') {
 2601              		.loc 2 553 0
 2602 0c0a 7B68     		ldr	r3, [r7, #4]	@ tmp133, string
 2603 0c0c 1B68     		ldr	r3, [r3]	@ _15, *string_6(D)
 2604 0c0e 1B78     		ldrb	r3, [r3]	@ zero_extendqisi2	@ _16, *_15
 2605 0c10 002B     		cmp	r3, #0	@ _16,
 2606 0c12 02D1     		bne	.L137	@,
 554:parson.c      ****             return JSONFailure;
 2607              		.loc 2 554 0
 2608 0c14 4FF0FF33 		mov	r3, #-1	@ _1,
 2609 0c18 21E0     		b	.L135	@
 2610              	.L137:
 555:parson.c      ****         } else if (**string == '\\') {
 2611              		.loc 2 555 0
 2612 0c1a 7B68     		ldr	r3, [r7, #4]	@ tmp134, string
 2613 0c1c 1B68     		ldr	r3, [r3]	@ _17, *string_6(D)
 2614 0c1e 1B78     		ldrb	r3, [r3]	@ zero_extendqisi2	@ _18, *_17
 2615 0c20 5C2B     		cmp	r3, #92	@ _18,
 2616 0c22 0CD1     		bne	.L138	@,
 556:parson.c      ****             SKIP_CHAR(string);
 2617              		.loc 2 556 0
 2618 0c24 7B68     		ldr	r3, [r7, #4]	@ tmp135, string
 2619 0c26 1B68     		ldr	r3, [r3]	@ _19, *string_6(D)
 2620 0c28 5A1C     		adds	r2, r3, #1	@ _20, _19,
 2621 0c2a 7B68     		ldr	r3, [r7, #4]	@ tmp136, string
 2622 0c2c 1A60     		str	r2, [r3]	@ _20, *string_6(D)
 557:parson.c      ****             if (**string == '\0') {
 2623              		.loc 2 557 0
 2624 0c2e 7B68     		ldr	r3, [r7, #4]	@ tmp137, string
 2625 0c30 1B68     		ldr	r3, [r3]	@ _22, *string_6(D)
 2626 0c32 1B78     		ldrb	r3, [r3]	@ zero_extendqisi2	@ _23, *_22
 2627 0c34 002B     		cmp	r3, #0	@ _23,
 2628 0c36 02D1     		bne	.L138	@,
 558:parson.c      ****                 return JSONFailure;
 2629              		.loc 2 558 0
 2630 0c38 4FF0FF33 		mov	r3, #-1	@ _1,
 2631 0c3c 0FE0     		b	.L135	@
 2632              	.L138:
 559:parson.c      ****             }
 560:parson.c      ****         }
 561:parson.c      ****         SKIP_CHAR(string);
 2633              		.loc 2 561 0
 2634 0c3e 7B68     		ldr	r3, [r7, #4]	@ tmp138, string
 2635 0c40 1B68     		ldr	r3, [r3]	@ _25, *string_6(D)
 2636 0c42 5A1C     		adds	r2, r3, #1	@ _26, _25,
 2637 0c44 7B68     		ldr	r3, [r7, #4]	@ tmp139, string
 2638 0c46 1A60     		str	r2, [r3]	@ _26, *string_6(D)
 2639              	.L136:
 552:parson.c      ****         if (**string == '\0') {
 2640              		.loc 2 552 0
 2641 0c48 7B68     		ldr	r3, [r7, #4]	@ tmp140, string
 2642 0c4a 1B68     		ldr	r3, [r3]	@ _13, *string_6(D)
 2643 0c4c 1B78     		ldrb	r3, [r3]	@ zero_extendqisi2	@ _14, *_13
 2644 0c4e 222B     		cmp	r3, #34	@ _14,
 2645 0c50 DBD1     		bne	.L139	@,
 562:parson.c      ****     }
 563:parson.c      ****     SKIP_CHAR(string);
 2646              		.loc 2 563 0
 2647 0c52 7B68     		ldr	r3, [r7, #4]	@ tmp141, string
 2648 0c54 1B68     		ldr	r3, [r3]	@ _29, *string_6(D)
 2649 0c56 5A1C     		adds	r2, r3, #1	@ _30, _29,
 2650 0c58 7B68     		ldr	r3, [r7, #4]	@ tmp142, string
 2651 0c5a 1A60     		str	r2, [r3]	@ _30, *string_6(D)
 564:parson.c      ****     return JSONSuccess;
 2652              		.loc 2 564 0
 2653 0c5c 0023     		movs	r3, #0	@ _1,
 2654              	.L135:
 565:parson.c      **** }
 2655              		.loc 2 565 0
 2656 0c5e 1846     		mov	r0, r3	@, <retval>
 2657 0c60 0C37     		adds	r7, r7, #12	@,,
 2658              	.LCFI121:
 2659              		.cfi_def_cfa_offset 4
 2660 0c62 BD46     		mov	sp, r7	@,
 2661              	.LCFI122:
 2662              		.cfi_def_cfa_register 13
 2663              		@ sp needed	@
 2664 0c64 5DF8047B 		ldr	r7, [sp], #4	@,
 2665              	.LCFI123:
 2666              		.cfi_restore 7
 2667              		.cfi_def_cfa_offset 0
 2668 0c68 7047     		bx	lr	@
 2669              		.cfi_endproc
 2670              	.LFE40:
 2672              		.align	1
 2673              		.syntax unified
 2674              		.thumb
 2675              		.thumb_func
 2676              		.fpu neon
 2678              	parse_utf16:
 2679              	.LFB41:
 566:parson.c      **** 
 567:parson.c      **** static int parse_utf16(const char **unprocessed, char **processed)
 568:parson.c      **** {
 2680              		.loc 2 568 0
 2681              		.cfi_startproc
 2682              		@ args = 0, pretend = 0, frame = 32
 2683              		@ frame_needed = 1, uses_anonymous_args = 0
 2684 0c6a 80B5     		push	{r7, lr}	@
 2685              	.LCFI124:
 2686              		.cfi_def_cfa_offset 8
 2687              		.cfi_offset 7, -8
 2688              		.cfi_offset 14, -4
 2689 0c6c 88B0     		sub	sp, sp, #32	@,,
 2690              	.LCFI125:
 2691              		.cfi_def_cfa_offset 40
 2692 0c6e 00AF     		add	r7, sp, #0	@,,
 2693              	.LCFI126:
 2694              		.cfi_def_cfa_register 7
 2695 0c70 7860     		str	r0, [r7, #4]	@ unprocessed, unprocessed
 2696 0c72 3960     		str	r1, [r7]	@ processed, processed
 569:parson.c      ****     unsigned int cp, lead, trail;
 570:parson.c      ****     int parse_succeeded = 0;
 2697              		.loc 2 570 0
 2698 0c74 0023     		movs	r3, #0	@ tmp180,
 2699 0c76 7B61     		str	r3, [r7, #20]	@ tmp180, parse_succeeded
 571:parson.c      ****     char *processed_ptr = *processed;
 2700              		.loc 2 571 0
 2701 0c78 3B68     		ldr	r3, [r7]	@ tmp181, processed
 2702 0c7a 1B68     		ldr	r3, [r3]	@ tmp182, *processed_8(D)
 2703 0c7c FB61     		str	r3, [r7, #28]	@ tmp182, processed_ptr
 572:parson.c      ****     const char *unprocessed_ptr = *unprocessed;
 2704              		.loc 2 572 0
 2705 0c7e 7B68     		ldr	r3, [r7, #4]	@ tmp183, unprocessed
 2706 0c80 1B68     		ldr	r3, [r3]	@ tmp184, *unprocessed_10(D)
 2707 0c82 BB61     		str	r3, [r7, #24]	@ tmp184, unprocessed_ptr
 573:parson.c      ****     unprocessed_ptr++; /* skips u */
 2708              		.loc 2 573 0
 2709 0c84 BB69     		ldr	r3, [r7, #24]	@ tmp186, unprocessed_ptr
 2710 0c86 0133     		adds	r3, r3, #1	@ tmp185, tmp186,
 2711 0c88 BB61     		str	r3, [r7, #24]	@ tmp185, unprocessed_ptr
 574:parson.c      ****     parse_succeeded = parse_utf16_hex(unprocessed_ptr, &cp);
 2712              		.loc 2 574 0
 2713 0c8a 07F10C03 		add	r3, r7, #12	@ tmp187,,
 2714 0c8e 1946     		mov	r1, r3	@, tmp187
 2715 0c90 B869     		ldr	r0, [r7, #24]	@, unprocessed_ptr
 2716 0c92 FFF725FA 		bl	parse_utf16_hex	@
 2717 0c96 7861     		str	r0, [r7, #20]	@, parse_succeeded
 575:parson.c      ****     if (!parse_succeeded) {
 2718              		.loc 2 575 0
 2719 0c98 7B69     		ldr	r3, [r7, #20]	@ tmp188, parse_succeeded
 2720 0c9a 002B     		cmp	r3, #0	@ tmp188,
 2721 0c9c 02D1     		bne	.L141	@,
 576:parson.c      ****         return JSONFailure;
 2722              		.loc 2 576 0
 2723 0c9e 4FF0FF33 		mov	r3, #-1	@ _3,
 2724 0ca2 D1E0     		b	.L153	@
 2725              	.L141:
 577:parson.c      ****     }
 578:parson.c      ****     if (cp < 0x80) {
 2726              		.loc 2 578 0
 2727 0ca4 FB68     		ldr	r3, [r7, #12]	@ cp.26_16, cp
 2728 0ca6 7F2B     		cmp	r3, #127	@ cp.26_16,
 2729 0ca8 04D8     		bhi	.L143	@,
 579:parson.c      ****         processed_ptr[0] = (char)cp; /* 0xxxxxxx */
 2730              		.loc 2 579 0
 2731 0caa FB68     		ldr	r3, [r7, #12]	@ cp.27_104, cp
 2732 0cac DAB2     		uxtb	r2, r3	@ _105, cp.27_104
 2733 0cae FB69     		ldr	r3, [r7, #28]	@ tmp189, processed_ptr
 2734 0cb0 1A70     		strb	r2, [r3]	@ tmp190, *processed_ptr_9
 2735 0cb2 BFE0     		b	.L144	@
 2736              	.L143:
 580:parson.c      ****     } else if (cp < 0x800) {
 2737              		.loc 2 580 0
 2738 0cb4 FB68     		ldr	r3, [r7, #12]	@ cp.28_17, cp
 2739 0cb6 B3F5006F 		cmp	r3, #2048	@ cp.28_17,
 2740 0cba 19D2     		bcs	.L145	@,
 581:parson.c      ****         processed_ptr[0] = (char)(((cp >> 6) & 0x1F) | 0xC0); /* 110xxxxx */
 2741              		.loc 2 581 0
 2742 0cbc FB68     		ldr	r3, [r7, #12]	@ cp.29_91, cp
 2743 0cbe 9B09     		lsrs	r3, r3, #6	@ _92, cp.29_91,
 2744 0cc0 DBB2     		uxtb	r3, r3	@ _93, _92
 2745 0cc2 03F01F03 		and	r3, r3, #31	@ tmp191, _93,
 2746 0cc6 DBB2     		uxtb	r3, r3	@ _94, tmp191
 2747 0cc8 63F03F03 		orn	r3, r3, #63	@ tmp192, _94,
 2748 0ccc DAB2     		uxtb	r2, r3	@ _95, tmp192
 2749 0cce FB69     		ldr	r3, [r7, #28]	@ tmp193, processed_ptr
 2750 0cd0 1A70     		strb	r2, [r3]	@ tmp194, *processed_ptr_9
 582:parson.c      ****         processed_ptr[1] = (char)(((cp)&0x3F) | 0x80);        /* 10xxxxxx */
 2751              		.loc 2 582 0
 2752 0cd2 FB69     		ldr	r3, [r7, #28]	@ tmp195, processed_ptr
 2753 0cd4 0133     		adds	r3, r3, #1	@ _97, tmp195,
 2754 0cd6 FA68     		ldr	r2, [r7, #12]	@ cp.30_98, cp
 2755 0cd8 D2B2     		uxtb	r2, r2	@ _99, cp.30_98
 2756 0cda 02F03F02 		and	r2, r2, #63	@ tmp196, _99,
 2757 0cde D2B2     		uxtb	r2, r2	@ _100, tmp196
 2758 0ce0 62F07F02 		orn	r2, r2, #127	@ tmp197, _100,
 2759 0ce4 D2B2     		uxtb	r2, r2	@ _101, tmp197
 2760 0ce6 1A70     		strb	r2, [r3]	@ tmp198, *_97
 583:parson.c      ****         processed_ptr += 1;
 2761              		.loc 2 583 0
 2762 0ce8 FB69     		ldr	r3, [r7, #28]	@ tmp200, processed_ptr
 2763 0cea 0133     		adds	r3, r3, #1	@ tmp199, tmp200,
 2764 0cec FB61     		str	r3, [r7, #28]	@ tmp199, processed_ptr
 2765 0cee A1E0     		b	.L144	@
 2766              	.L145:
 584:parson.c      ****     } else if (cp < 0xD800 || cp > 0xDFFF) {
 2767              		.loc 2 584 0
 2768 0cf0 FB68     		ldr	r3, [r7, #12]	@ cp.31_18, cp
 2769 0cf2 B3F5584F 		cmp	r3, #55296	@ cp.31_18,
 2770 0cf6 03D3     		bcc	.L146	@,
 2771              		.loc 2 584 0 is_stmt 0 discriminator 1
 2772 0cf8 FB68     		ldr	r3, [r7, #12]	@ cp.32_19, cp
 2773 0cfa B3F5604F 		cmp	r3, #57344	@ cp.32_19,
 2774 0cfe 25D3     		bcc	.L147	@,
 2775              	.L146:
 585:parson.c      ****         processed_ptr[0] = (char)(((cp >> 12) & 0x0F) | 0xE0); /* 1110xxxx */
 2776              		.loc 2 585 0 is_stmt 1
 2777 0d00 FB68     		ldr	r3, [r7, #12]	@ cp.33_71, cp
 2778 0d02 1B0B     		lsrs	r3, r3, #12	@ _72, cp.33_71,
 2779 0d04 DBB2     		uxtb	r3, r3	@ _73, _72
 2780 0d06 03F00F03 		and	r3, r3, #15	@ tmp201, _73,
 2781 0d0a DBB2     		uxtb	r3, r3	@ _74, tmp201
 2782 0d0c 63F01F03 		orn	r3, r3, #31	@ tmp202, _74,
 2783 0d10 DAB2     		uxtb	r2, r3	@ _75, tmp202
 2784 0d12 FB69     		ldr	r3, [r7, #28]	@ tmp203, processed_ptr
 2785 0d14 1A70     		strb	r2, [r3]	@ tmp204, *processed_ptr_9
 586:parson.c      ****         processed_ptr[1] = (char)(((cp >> 6) & 0x3F) | 0x80);  /* 10xxxxxx */
 2786              		.loc 2 586 0
 2787 0d16 FB69     		ldr	r3, [r7, #28]	@ tmp205, processed_ptr
 2788 0d18 0133     		adds	r3, r3, #1	@ _77, tmp205,
 2789 0d1a FA68     		ldr	r2, [r7, #12]	@ cp.34_78, cp
 2790 0d1c 9209     		lsrs	r2, r2, #6	@ _79, cp.34_78,
 2791 0d1e D2B2     		uxtb	r2, r2	@ _80, _79
 2792 0d20 02F03F02 		and	r2, r2, #63	@ tmp206, _80,
 2793 0d24 D2B2     		uxtb	r2, r2	@ _81, tmp206
 2794 0d26 62F07F02 		orn	r2, r2, #127	@ tmp207, _81,
 2795 0d2a D2B2     		uxtb	r2, r2	@ _82, tmp207
 2796 0d2c 1A70     		strb	r2, [r3]	@ tmp208, *_77
 587:parson.c      ****         processed_ptr[2] = (char)(((cp)&0x3F) | 0x80);         /* 10xxxxxx */
 2797              		.loc 2 587 0
 2798 0d2e FB69     		ldr	r3, [r7, #28]	@ tmp209, processed_ptr
 2799 0d30 0233     		adds	r3, r3, #2	@ _84, tmp209,
 2800 0d32 FA68     		ldr	r2, [r7, #12]	@ cp.35_85, cp
 2801 0d34 D2B2     		uxtb	r2, r2	@ _86, cp.35_85
 2802 0d36 02F03F02 		and	r2, r2, #63	@ tmp210, _86,
 2803 0d3a D2B2     		uxtb	r2, r2	@ _87, tmp210
 2804 0d3c 62F07F02 		orn	r2, r2, #127	@ tmp211, _87,
 2805 0d40 D2B2     		uxtb	r2, r2	@ _88, tmp211
 2806 0d42 1A70     		strb	r2, [r3]	@ tmp212, *_84
 588:parson.c      ****         processed_ptr += 2;
 2807              		.loc 2 588 0
 2808 0d44 FB69     		ldr	r3, [r7, #28]	@ tmp214, processed_ptr
 2809 0d46 0233     		adds	r3, r3, #2	@ tmp213, tmp214,
 2810 0d48 FB61     		str	r3, [r7, #28]	@ tmp213, processed_ptr
 2811 0d4a 73E0     		b	.L144	@
 2812              	.L147:
 589:parson.c      ****     } else if (cp >= 0xD800 && cp <= 0xDBFF) { /* lead surrogate (0xD800..0xDBFF) */
 2813              		.loc 2 589 0
 2814 0d4c FB68     		ldr	r3, [r7, #12]	@ cp.36_20, cp
 2815 0d4e B3F5584F 		cmp	r3, #55296	@ cp.36_20,
 2816 0d52 6CD3     		bcc	.L148	@,
 2817              		.loc 2 589 0 is_stmt 0 discriminator 1
 2818 0d54 FB68     		ldr	r3, [r7, #12]	@ cp.37_21, cp
 2819 0d56 B3F55C4F 		cmp	r3, #56320	@ cp.37_21,
 2820 0d5a 68D2     		bcs	.L148	@,
 590:parson.c      ****         lead = cp;
 2821              		.loc 2 590 0 is_stmt 1
 2822 0d5c FB68     		ldr	r3, [r7, #12]	@ tmp215, cp
 2823 0d5e 3B61     		str	r3, [r7, #16]	@ tmp215, lead
 591:parson.c      ****         unprocessed_ptr +=
 2824              		.loc 2 591 0
 2825 0d60 BB69     		ldr	r3, [r7, #24]	@ tmp217, unprocessed_ptr
 2826 0d62 0433     		adds	r3, r3, #4	@ tmp216, tmp217,
 2827 0d64 BB61     		str	r3, [r7, #24]	@ tmp216, unprocessed_ptr
 592:parson.c      ****             4; /* should always be within the buffer, otherwise previous sscanf would fail */
 593:parson.c      ****         if (*unprocessed_ptr++ != '\\' || *unprocessed_ptr++ != 'u') {
 2828              		.loc 2 593 0
 2829 0d66 BB69     		ldr	r3, [r7, #24]	@ unprocessed_ptr.38_24, unprocessed_ptr
 2830 0d68 5A1C     		adds	r2, r3, #1	@ tmp218, unprocessed_ptr.38_24,
 2831 0d6a BA61     		str	r2, [r7, #24]	@ tmp218, unprocessed_ptr
 2832 0d6c 1B78     		ldrb	r3, [r3]	@ zero_extendqisi2	@ _26, *unprocessed_ptr.38_24
 2833 0d6e 5C2B     		cmp	r3, #92	@ _26,
 2834 0d70 05D1     		bne	.L149	@,
 2835              		.loc 2 593 0 is_stmt 0 discriminator 1
 2836 0d72 BB69     		ldr	r3, [r7, #24]	@ unprocessed_ptr.39_27, unprocessed_ptr
 2837 0d74 5A1C     		adds	r2, r3, #1	@ tmp219, unprocessed_ptr.39_27,
 2838 0d76 BA61     		str	r2, [r7, #24]	@ tmp219, unprocessed_ptr
 2839 0d78 1B78     		ldrb	r3, [r3]	@ zero_extendqisi2	@ _29, *unprocessed_ptr.39_27
 2840 0d7a 752B     		cmp	r3, #117	@ _29,
 2841 0d7c 02D0     		beq	.L150	@,
 2842              	.L149:
 594:parson.c      ****             return JSONFailure;
 2843              		.loc 2 594 0 is_stmt 1
 2844 0d7e 4FF0FF33 		mov	r3, #-1	@ _3,
 2845 0d82 61E0     		b	.L153	@
 2846              	.L150:
 595:parson.c      ****         }
 596:parson.c      ****         parse_succeeded = parse_utf16_hex(unprocessed_ptr, &trail);
 2847              		.loc 2 596 0
 2848 0d84 07F10803 		add	r3, r7, #8	@ tmp220,,
 2849 0d88 1946     		mov	r1, r3	@, tmp220
 2850 0d8a B869     		ldr	r0, [r7, #24]	@, unprocessed_ptr
 2851 0d8c FFF7A8F9 		bl	parse_utf16_hex	@
 2852 0d90 7861     		str	r0, [r7, #20]	@, parse_succeeded
 597:parson.c      ****         if (!parse_succeeded || trail < 0xDC00 ||
 2853              		.loc 2 597 0
 2854 0d92 7B69     		ldr	r3, [r7, #20]	@ tmp221, parse_succeeded
 2855 0d94 002B     		cmp	r3, #0	@ tmp221,
 2856 0d96 07D0     		beq	.L151	@,
 2857              		.loc 2 597 0 is_stmt 0 discriminator 1
 2858 0d98 BB68     		ldr	r3, [r7, #8]	@ trail.40_32, trail
 2859 0d9a B3F55C4F 		cmp	r3, #56320	@ trail.40_32,
 2860 0d9e 03D3     		bcc	.L151	@,
 598:parson.c      ****             trail > 0xDFFF) { /* valid trail surrogate? (0xDC00..0xDFFF) */
 2861              		.loc 2 598 0 is_stmt 1 discriminator 2
 2862 0da0 BB68     		ldr	r3, [r7, #8]	@ trail.41_33, trail
 597:parson.c      ****         if (!parse_succeeded || trail < 0xDC00 ||
 2863              		.loc 2 597 0 discriminator 2
 2864 0da2 B3F5604F 		cmp	r3, #57344	@ trail.41_33,
 2865 0da6 02D3     		bcc	.L152	@,
 2866              	.L151:
 599:parson.c      ****             return JSONFailure;
 2867              		.loc 2 599 0
 2868 0da8 4FF0FF33 		mov	r3, #-1	@ _3,
 2869 0dac 4CE0     		b	.L153	@
 2870              	.L152:
 600:parson.c      ****         }
 601:parson.c      ****         cp = ((((lead - 0xD800) & 0x3FF) << 10) | ((trail - 0xDC00) & 0x3FF)) + 0x010000;
 2871              		.loc 2 601 0
 2872 0dae 3B69     		ldr	r3, [r7, #16]	@ tmp222, lead
 2873 0db0 9A02     		lsls	r2, r3, #10	@ _34, tmp222,
 2874 0db2 4FF47C43 		mov	r3, #64512	@ _35,
 2875 0db6 C0F20F03 		movt	r3, 15	@ _35,
 2876 0dba 1340     		ands	r3, r3, r2	@, _35, _35, _34
 2877 0dbc BA68     		ldr	r2, [r7, #8]	@ trail.42_36, trail
 2878 0dbe C2F30902 		ubfx	r2, r2, #0, #10	@ _37, trail.42_36,,
 2879 0dc2 1343     		orrs	r3, r3, r2	@, _38, _35, _37
 2880 0dc4 03F58033 		add	r3, r3, #65536	@ cp.43_39, _38,
 2881 0dc8 FB60     		str	r3, [r7, #12]	@ cp.43_39, cp
 602:parson.c      ****         processed_ptr[0] = (char)((((cp >> 18) & 0x07) | 0xF0)); /* 11110xxx */
 2882              		.loc 2 602 0
 2883 0dca FB68     		ldr	r3, [r7, #12]	@ cp.44_41, cp
 2884 0dcc 9B0C     		lsrs	r3, r3, #18	@ _42, cp.44_41,
 2885 0dce DBB2     		uxtb	r3, r3	@ _43, _42
 2886 0dd0 03F00703 		and	r3, r3, #7	@ tmp223, _43,
 2887 0dd4 DBB2     		uxtb	r3, r3	@ _44, tmp223
 2888 0dd6 63F00F03 		orn	r3, r3, #15	@ tmp224, _44,
 2889 0dda DAB2     		uxtb	r2, r3	@ _45, tmp224
 2890 0ddc FB69     		ldr	r3, [r7, #28]	@ tmp225, processed_ptr
 2891 0dde 1A70     		strb	r2, [r3]	@ tmp226, *processed_ptr_9
 603:parson.c      ****         processed_ptr[1] = (char)((((cp >> 12) & 0x3F) | 0x80)); /* 10xxxxxx */
 2892              		.loc 2 603 0
 2893 0de0 FB69     		ldr	r3, [r7, #28]	@ tmp227, processed_ptr
 2894 0de2 0133     		adds	r3, r3, #1	@ _47, tmp227,
 2895 0de4 FA68     		ldr	r2, [r7, #12]	@ cp.45_48, cp
 2896 0de6 120B     		lsrs	r2, r2, #12	@ _49, cp.45_48,
 2897 0de8 D2B2     		uxtb	r2, r2	@ _50, _49
 2898 0dea 02F03F02 		and	r2, r2, #63	@ tmp228, _50,
 2899 0dee D2B2     		uxtb	r2, r2	@ _51, tmp228
 2900 0df0 62F07F02 		orn	r2, r2, #127	@ tmp229, _51,
 2901 0df4 D2B2     		uxtb	r2, r2	@ _52, tmp229
 2902 0df6 1A70     		strb	r2, [r3]	@ tmp230, *_47
 604:parson.c      ****         processed_ptr[2] = (char)((((cp >> 6) & 0x3F) | 0x80));  /* 10xxxxxx */
 2903              		.loc 2 604 0
 2904 0df8 FB69     		ldr	r3, [r7, #28]	@ tmp231, processed_ptr
 2905 0dfa 0233     		adds	r3, r3, #2	@ _54, tmp231,
 2906 0dfc FA68     		ldr	r2, [r7, #12]	@ cp.46_55, cp
 2907 0dfe 9209     		lsrs	r2, r2, #6	@ _56, cp.46_55,
 2908 0e00 D2B2     		uxtb	r2, r2	@ _57, _56
 2909 0e02 02F03F02 		and	r2, r2, #63	@ tmp232, _57,
 2910 0e06 D2B2     		uxtb	r2, r2	@ _58, tmp232
 2911 0e08 62F07F02 		orn	r2, r2, #127	@ tmp233, _58,
 2912 0e0c D2B2     		uxtb	r2, r2	@ _59, tmp233
 2913 0e0e 1A70     		strb	r2, [r3]	@ tmp234, *_54
 605:parson.c      ****         processed_ptr[3] = (char)((((cp)&0x3F) | 0x80));         /* 10xxxxxx */
 2914              		.loc 2 605 0
 2915 0e10 FB69     		ldr	r3, [r7, #28]	@ tmp235, processed_ptr
 2916 0e12 0333     		adds	r3, r3, #3	@ _61, tmp235,
 2917 0e14 FA68     		ldr	r2, [r7, #12]	@ cp.47_62, cp
 2918 0e16 D2B2     		uxtb	r2, r2	@ _63, cp.47_62
 2919 0e18 02F03F02 		and	r2, r2, #63	@ tmp236, _63,
 2920 0e1c D2B2     		uxtb	r2, r2	@ _64, tmp236
 2921 0e1e 62F07F02 		orn	r2, r2, #127	@ tmp237, _64,
 2922 0e22 D2B2     		uxtb	r2, r2	@ _65, tmp237
 2923 0e24 1A70     		strb	r2, [r3]	@ tmp238, *_61
 606:parson.c      ****         processed_ptr += 3;
 2924              		.loc 2 606 0
 2925 0e26 FB69     		ldr	r3, [r7, #28]	@ tmp240, processed_ptr
 2926 0e28 0333     		adds	r3, r3, #3	@ tmp239, tmp240,
 2927 0e2a FB61     		str	r3, [r7, #28]	@ tmp239, processed_ptr
 2928 0e2c 02E0     		b	.L144	@
 2929              	.L148:
 607:parson.c      ****     } else { /* trail surrogate before lead surrogate */
 608:parson.c      ****         return JSONFailure;
 2930              		.loc 2 608 0
 2931 0e2e 4FF0FF33 		mov	r3, #-1	@ _3,
 2932 0e32 09E0     		b	.L153	@
 2933              	.L144:
 609:parson.c      ****     }
 610:parson.c      ****     unprocessed_ptr += 3;
 2934              		.loc 2 610 0
 2935 0e34 BB69     		ldr	r3, [r7, #24]	@ tmp242, unprocessed_ptr
 2936 0e36 0333     		adds	r3, r3, #3	@ tmp241, tmp242,
 2937 0e38 BB61     		str	r3, [r7, #24]	@ tmp241, unprocessed_ptr
 611:parson.c      ****     *processed = processed_ptr;
 2938              		.loc 2 611 0
 2939 0e3a 3B68     		ldr	r3, [r7]	@ tmp243, processed
 2940 0e3c FA69     		ldr	r2, [r7, #28]	@ tmp244, processed_ptr
 2941 0e3e 1A60     		str	r2, [r3]	@ tmp244, *processed_8(D)
 612:parson.c      ****     *unprocessed = unprocessed_ptr;
 2942              		.loc 2 612 0
 2943 0e40 7B68     		ldr	r3, [r7, #4]	@ tmp245, unprocessed
 2944 0e42 BA69     		ldr	r2, [r7, #24]	@ tmp246, unprocessed_ptr
 2945 0e44 1A60     		str	r2, [r3]	@ tmp246, *unprocessed_10(D)
 613:parson.c      ****     return JSONSuccess;
 2946              		.loc 2 613 0
 2947 0e46 0023     		movs	r3, #0	@ _3,
 2948              	.L153:
 614:parson.c      **** }
 2949              		.loc 2 614 0 discriminator 1
 2950 0e48 1846     		mov	r0, r3	@, <retval>
 2951 0e4a 2037     		adds	r7, r7, #32	@,,
 2952              	.LCFI127:
 2953              		.cfi_def_cfa_offset 8
 2954 0e4c BD46     		mov	sp, r7	@,
 2955              	.LCFI128:
 2956              		.cfi_def_cfa_register 13
 2957              		@ sp needed	@
 2958 0e4e 80BD     		pop	{r7, pc}	@
 2959              		.cfi_endproc
 2960              	.LFE41:
 2962              		.align	1
 2963              		.syntax unified
 2964              		.thumb
 2965              		.thumb_func
 2966              		.fpu neon
 2968              	process_string:
 2969              	.LFB42:
 615:parson.c      **** 
 616:parson.c      **** /* Copies and processes passed string up to supplied length.
 617:parson.c      **** Example: "\u006Corem ipsum" -> lorem ipsum */
 618:parson.c      **** static char *process_string(const char *input, size_t len)
 619:parson.c      **** {
 2970              		.loc 2 619 0
 2971              		.cfi_startproc
 2972              		@ args = 0, pretend = 0, frame = 32
 2973              		@ frame_needed = 1, uses_anonymous_args = 0
 2974 0e50 80B5     		push	{r7, lr}	@
 2975              	.LCFI129:
 2976              		.cfi_def_cfa_offset 8
 2977              		.cfi_offset 7, -8
 2978              		.cfi_offset 14, -4
 2979 0e52 88B0     		sub	sp, sp, #32	@,,
 2980              	.LCFI130:
 2981              		.cfi_def_cfa_offset 40
 2982 0e54 00AF     		add	r7, sp, #0	@,,
 2983              	.LCFI131:
 2984              		.cfi_def_cfa_register 7
 2985 0e56 7860     		str	r0, [r7, #4]	@ input, input
 2986 0e58 3960     		str	r1, [r7]	@ len, len
 620:parson.c      ****     const char *input_ptr = input;
 2987              		.loc 2 620 0
 2988 0e5a 7B68     		ldr	r3, [r7, #4]	@ tmp154, input
 2989 0e5c FB60     		str	r3, [r7, #12]	@ tmp154, input_ptr
 621:parson.c      ****     size_t initial_size = (len + 1) * sizeof(char);
 2990              		.loc 2 621 0
 2991 0e5e 3B68     		ldr	r3, [r7]	@ tmp156, len
 2992 0e60 0133     		adds	r3, r3, #1	@ tmp155, tmp156,
 2993 0e62 FB61     		str	r3, [r7, #28]	@ tmp155, initial_size
 622:parson.c      ****     size_t final_size = 0;
 2994              		.loc 2 622 0
 2995 0e64 0023     		movs	r3, #0	@ tmp157,
 2996 0e66 BB61     		str	r3, [r7, #24]	@ tmp157, final_size
 623:parson.c      ****     char *output = NULL, *output_ptr = NULL, *resized_output = NULL;
 2997              		.loc 2 623 0
 2998 0e68 0023     		movs	r3, #0	@ tmp158,
 2999 0e6a 7B61     		str	r3, [r7, #20]	@ tmp158, output
 3000 0e6c 0023     		movs	r3, #0	@ tmp159,
 3001 0e6e BB60     		str	r3, [r7, #8]	@ tmp159, output_ptr
 3002 0e70 0023     		movs	r3, #0	@ tmp160,
 3003 0e72 3B61     		str	r3, [r7, #16]	@ tmp160, resized_output
 624:parson.c      ****     output = (char *)parson_malloc(initial_size);
 3004              		.loc 2 624 0
 3005 0e74 40F20003 		movw	r3, #:lower16:parson_malloc	@ tmp161,
 3006 0e78 C0F20003 		movt	r3, #:upper16:parson_malloc	@ tmp161,
 3007 0e7c 1B68     		ldr	r3, [r3]	@ parson_malloc.48_16, parson_malloc
 3008 0e7e F869     		ldr	r0, [r7, #28]	@, initial_size
 3009 0e80 9847     		blx	r3	@ parson_malloc.48_16
 3010              	.LVL18:
 3011 0e82 7861     		str	r0, [r7, #20]	@, output
 625:parson.c      ****     if (output == NULL) {
 3012              		.loc 2 625 0
 3013 0e84 7B69     		ldr	r3, [r7, #20]	@ tmp162, output
 3014 0e86 002B     		cmp	r3, #0	@ tmp162,
 3015 0e88 00F02881 		beq	.L179	@,
 626:parson.c      ****         goto error;
 627:parson.c      ****     }
 628:parson.c      ****     output_ptr = output;
 3016              		.loc 2 628 0
 3017 0e8c 7B69     		ldr	r3, [r7, #20]	@ tmp163, output
 3018 0e8e BB60     		str	r3, [r7, #8]	@ tmp163, output_ptr
 629:parson.c      ****     while ((*input_ptr != '\0') && (size_t)(input_ptr - input) < len) {
 3019              		.loc 2 629 0
 3020 0e90 F5E0     		b	.L157	@
 3021              	.L175:
 630:parson.c      ****         if (*input_ptr == '\\') {
 3022              		.loc 2 630 0
 3023 0e92 FB68     		ldr	r3, [r7, #12]	@ input_ptr.49_27, input_ptr
 3024 0e94 1B78     		ldrb	r3, [r3]	@ zero_extendqisi2	@ _28, *input_ptr.49_27
 3025 0e96 5C2B     		cmp	r3, #92	@ _28,
 3026 0e98 40F0E180 		bne	.L158	@,
 631:parson.c      ****             input_ptr++;
 3027              		.loc 2 631 0
 3028 0e9c FB68     		ldr	r3, [r7, #12]	@ input_ptr.50_29, input_ptr
 3029 0e9e 0133     		adds	r3, r3, #1	@ input_ptr.51_30, input_ptr.50_29,
 3030 0ea0 FB60     		str	r3, [r7, #12]	@ input_ptr.51_30, input_ptr
 632:parson.c      ****             switch (*input_ptr) {
 3031              		.loc 2 632 0
 3032 0ea2 FB68     		ldr	r3, [r7, #12]	@ input_ptr.52_32, input_ptr
 3033 0ea4 1B78     		ldrb	r3, [r3]	@ zero_extendqisi2	@ _33, *input_ptr.52_32
 3034 0ea6 223B     		subs	r3, r3, #34	@ tmp164, _34,
 3035 0ea8 532B     		cmp	r3, #83	@ tmp164,
 3036 0eaa 00F21981 		bhi	.L180	@
 3037 0eae 01A2     		adr	r2, .L161	@ tmp193,
 3038 0eb0 52F823F0 		ldr	pc, [r2, r3, lsl #2]	@ tmp193, tmp164
 3039              		.p2align 2
 3040              	.L161:
 3041 0eb4 05100000 		.word	.L160+1
 3042 0eb8 E1100000 		.word	.L180+1
 3043 0ebc E1100000 		.word	.L180+1
 3044 0ec0 E1100000 		.word	.L180+1
 3045 0ec4 E1100000 		.word	.L180+1
 3046 0ec8 E1100000 		.word	.L180+1
 3047 0ecc E1100000 		.word	.L180+1
 3048 0ed0 E1100000 		.word	.L180+1
 3049 0ed4 E1100000 		.word	.L180+1
 3050 0ed8 E1100000 		.word	.L180+1
 3051 0edc E1100000 		.word	.L180+1
 3052 0ee0 E1100000 		.word	.L180+1
 3053 0ee4 E1100000 		.word	.L180+1
 3054 0ee8 15100000 		.word	.L162+1
 3055 0eec E1100000 		.word	.L180+1
 3056 0ef0 E1100000 		.word	.L180+1
 3057 0ef4 E1100000 		.word	.L180+1
 3058 0ef8 E1100000 		.word	.L180+1
 3059 0efc E1100000 		.word	.L180+1
 3060 0f00 E1100000 		.word	.L180+1
 3061 0f04 E1100000 		.word	.L180+1
 3062 0f08 E1100000 		.word	.L180+1
 3063 0f0c E1100000 		.word	.L180+1
 3064 0f10 E1100000 		.word	.L180+1
 3065 0f14 E1100000 		.word	.L180+1
 3066 0f18 E1100000 		.word	.L180+1
 3067 0f1c E1100000 		.word	.L180+1
 3068 0f20 E1100000 		.word	.L180+1
 3069 0f24 E1100000 		.word	.L180+1
 3070 0f28 E1100000 		.word	.L180+1
 3071 0f2c E1100000 		.word	.L180+1
 3072 0f30 E1100000 		.word	.L180+1
 3073 0f34 E1100000 		.word	.L180+1
 3074 0f38 E1100000 		.word	.L180+1
 3075 0f3c E1100000 		.word	.L180+1
 3076 0f40 E1100000 		.word	.L180+1
 3077 0f44 E1100000 		.word	.L180+1
 3078 0f48 E1100000 		.word	.L180+1
 3079 0f4c E1100000 		.word	.L180+1
 3080 0f50 E1100000 		.word	.L180+1
 3081 0f54 E1100000 		.word	.L180+1
 3082 0f58 E1100000 		.word	.L180+1
 3083 0f5c E1100000 		.word	.L180+1
 3084 0f60 E1100000 		.word	.L180+1
 3085 0f64 E1100000 		.word	.L180+1
 3086 0f68 E1100000 		.word	.L180+1
 3087 0f6c E1100000 		.word	.L180+1
 3088 0f70 E1100000 		.word	.L180+1
 3089 0f74 E1100000 		.word	.L180+1
 3090 0f78 E1100000 		.word	.L180+1
 3091 0f7c E1100000 		.word	.L180+1
 3092 0f80 E1100000 		.word	.L180+1
 3093 0f84 E1100000 		.word	.L180+1
 3094 0f88 E1100000 		.word	.L180+1
 3095 0f8c E1100000 		.word	.L180+1
 3096 0f90 E1100000 		.word	.L180+1
 3097 0f94 E1100000 		.word	.L180+1
 3098 0f98 E1100000 		.word	.L180+1
 3099 0f9c 0D100000 		.word	.L163+1
 3100 0fa0 E1100000 		.word	.L180+1
 3101 0fa4 E1100000 		.word	.L180+1
 3102 0fa8 E1100000 		.word	.L180+1
 3103 0fac E1100000 		.word	.L180+1
 3104 0fb0 E1100000 		.word	.L180+1
 3105 0fb4 1D100000 		.word	.L164+1
 3106 0fb8 E1100000 		.word	.L180+1
 3107 0fbc E1100000 		.word	.L180+1
 3108 0fc0 E1100000 		.word	.L180+1
 3109 0fc4 25100000 		.word	.L165+1
 3110 0fc8 E1100000 		.word	.L180+1
 3111 0fcc E1100000 		.word	.L180+1
 3112 0fd0 E1100000 		.word	.L180+1
 3113 0fd4 E1100000 		.word	.L180+1
 3114 0fd8 E1100000 		.word	.L180+1
 3115 0fdc E1100000 		.word	.L180+1
 3116 0fe0 E1100000 		.word	.L180+1
 3117 0fe4 2D100000 		.word	.L166+1
 3118 0fe8 E1100000 		.word	.L180+1
 3119 0fec E1100000 		.word	.L180+1
 3120 0ff0 E1100000 		.word	.L180+1
 3121 0ff4 35100000 		.word	.L167+1
 3122 0ff8 E1100000 		.word	.L180+1
 3123 0ffc 3D100000 		.word	.L168+1
 3124 1000 45100000 		.word	.L169+1
 3125              		.p2align 1
 3126              	.L160:
 633:parson.c      ****             case '\"':
 634:parson.c      ****                 *output_ptr = '\"';
 3127              		.loc 2 634 0
 3128 1004 BB68     		ldr	r3, [r7, #8]	@ output_ptr.53_35, output_ptr
 3129 1006 2222     		movs	r2, #34	@ tmp165,
 3130 1008 1A70     		strb	r2, [r3]	@ tmp166, *output_ptr.53_35
 635:parson.c      ****                 break;
 3131              		.loc 2 635 0
 3132 100a 32E0     		b	.L172	@
 3133              	.L163:
 636:parson.c      ****             case '\\':
 637:parson.c      ****                 *output_ptr = '\\';
 3134              		.loc 2 637 0
 3135 100c BB68     		ldr	r3, [r7, #8]	@ output_ptr.54_37, output_ptr
 3136 100e 5C22     		movs	r2, #92	@ tmp167,
 3137 1010 1A70     		strb	r2, [r3]	@ tmp168, *output_ptr.54_37
 638:parson.c      ****                 break;
 3138              		.loc 2 638 0
 3139 1012 2EE0     		b	.L172	@
 3140              	.L162:
 639:parson.c      ****             case '/':
 640:parson.c      ****                 *output_ptr = '/';
 3141              		.loc 2 640 0
 3142 1014 BB68     		ldr	r3, [r7, #8]	@ output_ptr.55_39, output_ptr
 3143 1016 2F22     		movs	r2, #47	@ tmp169,
 3144 1018 1A70     		strb	r2, [r3]	@ tmp170, *output_ptr.55_39
 641:parson.c      ****                 break;
 3145              		.loc 2 641 0
 3146 101a 2AE0     		b	.L172	@
 3147              	.L164:
 642:parson.c      ****             case 'b':
 643:parson.c      ****                 *output_ptr = '\b';
 3148              		.loc 2 643 0
 3149 101c BB68     		ldr	r3, [r7, #8]	@ output_ptr.56_41, output_ptr
 3150 101e 0822     		movs	r2, #8	@ tmp171,
 3151 1020 1A70     		strb	r2, [r3]	@ tmp172, *output_ptr.56_41
 644:parson.c      ****                 break;
 3152              		.loc 2 644 0
 3153 1022 26E0     		b	.L172	@
 3154              	.L165:
 645:parson.c      ****             case 'f':
 646:parson.c      ****                 *output_ptr = '\f';
 3155              		.loc 2 646 0
 3156 1024 BB68     		ldr	r3, [r7, #8]	@ output_ptr.57_43, output_ptr
 3157 1026 0C22     		movs	r2, #12	@ tmp173,
 3158 1028 1A70     		strb	r2, [r3]	@ tmp174, *output_ptr.57_43
 647:parson.c      ****                 break;
 3159              		.loc 2 647 0
 3160 102a 22E0     		b	.L172	@
 3161              	.L166:
 648:parson.c      ****             case 'n':
 649:parson.c      ****                 *output_ptr = '\n';
 3162              		.loc 2 649 0
 3163 102c BB68     		ldr	r3, [r7, #8]	@ output_ptr.58_45, output_ptr
 3164 102e 0A22     		movs	r2, #10	@ tmp175,
 3165 1030 1A70     		strb	r2, [r3]	@ tmp176, *output_ptr.58_45
 650:parson.c      ****                 break;
 3166              		.loc 2 650 0
 3167 1032 1EE0     		b	.L172	@
 3168              	.L167:
 651:parson.c      ****             case 'r':
 652:parson.c      ****                 *output_ptr = '\r';
 3169              		.loc 2 652 0
 3170 1034 BB68     		ldr	r3, [r7, #8]	@ output_ptr.59_47, output_ptr
 3171 1036 0D22     		movs	r2, #13	@ tmp177,
 3172 1038 1A70     		strb	r2, [r3]	@ tmp178, *output_ptr.59_47
 653:parson.c      ****                 break;
 3173              		.loc 2 653 0
 3174 103a 1AE0     		b	.L172	@
 3175              	.L168:
 654:parson.c      ****             case 't':
 655:parson.c      ****                 *output_ptr = '\t';
 3176              		.loc 2 655 0
 3177 103c BB68     		ldr	r3, [r7, #8]	@ output_ptr.60_49, output_ptr
 3178 103e 0922     		movs	r2, #9	@ tmp179,
 3179 1040 1A70     		strb	r2, [r3]	@ tmp180, *output_ptr.60_49
 656:parson.c      ****                 break;
 3180              		.loc 2 656 0
 3181 1042 16E0     		b	.L172	@
 3182              	.L169:
 657:parson.c      ****             case 'u':
 658:parson.c      ****                 if (parse_utf16(&input_ptr, &output_ptr) == JSONFailure) {
 3183              		.loc 2 658 0
 3184 1044 07F10802 		add	r2, r7, #8	@ tmp181,,
 3185 1048 07F10C03 		add	r3, r7, #12	@ tmp182,,
 3186 104c 1146     		mov	r1, r2	@, tmp181
 3187 104e 1846     		mov	r0, r3	@, tmp182
 3188 1050 FFF70BFE 		bl	parse_utf16	@
 3189 1054 0346     		mov	r3, r0	@ _52,
 3190 1056 B3F1FF3F 		cmp	r3, #-1	@ _52,
 3191 105a 09D1     		bne	.L181	@,
 659:parson.c      ****                     goto error;
 3192              		.loc 2 659 0
 3193 105c 45E0     		b	.L156	@
 3194              	.L158:
 660:parson.c      ****                 }
 661:parson.c      ****                 break;
 662:parson.c      ****             default:
 663:parson.c      ****                 goto error;
 664:parson.c      ****             }
 665:parson.c      ****         } else if ((unsigned char)*input_ptr < 0x20) {
 3195              		.loc 2 665 0
 3196 105e FB68     		ldr	r3, [r7, #12]	@ input_ptr.61_53, input_ptr
 3197 1060 1B78     		ldrb	r3, [r3]	@ zero_extendqisi2	@ _54, *input_ptr.61_53
 3198 1062 1F2B     		cmp	r3, #31	@ _54,
 3199 1064 3ED9     		bls	.L182	@,
 666:parson.c      ****             goto error; /* 0x00-0x19 are invalid characters for json string
 667:parson.c      ****                            (http://www.ietf.org/rfc/rfc4627.txt) */
 668:parson.c      ****         } else {
 669:parson.c      ****             *output_ptr = *input_ptr;
 3200              		.loc 2 669 0
 3201 1066 BB68     		ldr	r3, [r7, #8]	@ output_ptr.62_55, output_ptr
 3202 1068 FA68     		ldr	r2, [r7, #12]	@ input_ptr.63_56, input_ptr
 3203 106a 1278     		ldrb	r2, [r2]	@ zero_extendqisi2	@ _57, *input_ptr.63_56
 3204 106c 1A70     		strb	r2, [r3]	@ tmp183, *output_ptr.62_55
 3205 106e 00E0     		b	.L172	@
 3206              	.L181:
 661:parson.c      ****             default:
 3207              		.loc 2 661 0
 3208 1070 00BF     		nop
 3209              	.L172:
 670:parson.c      ****         }
 671:parson.c      ****         output_ptr++;
 3210              		.loc 2 671 0
 3211 1072 BB68     		ldr	r3, [r7, #8]	@ output_ptr.64_59, output_ptr
 3212 1074 0133     		adds	r3, r3, #1	@ output_ptr.65_60, output_ptr.64_59,
 3213 1076 BB60     		str	r3, [r7, #8]	@ output_ptr.65_60, output_ptr
 672:parson.c      ****         input_ptr++;
 3214              		.loc 2 672 0
 3215 1078 FB68     		ldr	r3, [r7, #12]	@ input_ptr.66_62, input_ptr
 3216 107a 0133     		adds	r3, r3, #1	@ input_ptr.67_63, input_ptr.66_62,
 3217 107c FB60     		str	r3, [r7, #12]	@ input_ptr.67_63, input_ptr
 3218              	.L157:
 629:parson.c      ****         if (*input_ptr == '\\') {
 3219              		.loc 2 629 0
 3220 107e FB68     		ldr	r3, [r7, #12]	@ input_ptr.68_20, input_ptr
 3221 1080 1B78     		ldrb	r3, [r3]	@ zero_extendqisi2	@ _21, *input_ptr.68_20
 3222 1082 002B     		cmp	r3, #0	@ _21,
 3223 1084 08D0     		beq	.L174	@,
 629:parson.c      ****         if (*input_ptr == '\\') {
 3224              		.loc 2 629 0 is_stmt 0 discriminator 1
 3225 1086 FB68     		ldr	r3, [r7, #12]	@ input_ptr.69_22, input_ptr
 3226 1088 1A46     		mov	r2, r3	@ input_ptr.70_23, input_ptr.69_22
 3227 108a 7B68     		ldr	r3, [r7, #4]	@ input.71_24, input
 3228 108c D31A     		subs	r3, r2, r3	@ _25, input_ptr.70_23, input.71_24
 3229 108e 1A46     		mov	r2, r3	@ _26, _25
 3230 1090 3B68     		ldr	r3, [r7]	@ tmp184, len
 3231 1092 9A42     		cmp	r2, r3	@ _26, tmp184
 3232 1094 FFF4FDAE 		bcc	.L175	@,
 3233              	.L174:
 673:parson.c      ****     }
 674:parson.c      ****     *output_ptr = '\0';
 3234              		.loc 2 674 0 is_stmt 1
 3235 1098 BB68     		ldr	r3, [r7, #8]	@ output_ptr.72_65, output_ptr
 3236 109a 0022     		movs	r2, #0	@ tmp185,
 3237 109c 1A70     		strb	r2, [r3]	@ tmp186, *output_ptr.72_65
 675:parson.c      ****     /* resize to new length */
 676:parson.c      ****     final_size = (size_t)(output_ptr - output) + 1;
 3238              		.loc 2 676 0
 3239 109e BB68     		ldr	r3, [r7, #8]	@ output_ptr.73_67, output_ptr
 3240 10a0 1A46     		mov	r2, r3	@ output_ptr.74_68, output_ptr.73_67
 3241 10a2 7B69     		ldr	r3, [r7, #20]	@ output.75_69, output
 3242 10a4 D31A     		subs	r3, r2, r3	@ _70, output_ptr.74_68, output.75_69
 3243 10a6 0133     		adds	r3, r3, #1	@ tmp187, _71,
 3244 10a8 BB61     		str	r3, [r7, #24]	@ tmp187, final_size
 677:parson.c      ****     /* todo: don't resize if final_size == initial_size */
 678:parson.c      ****     resized_output = (char *)parson_malloc(final_size);
 3245              		.loc 2 678 0
 3246 10aa 40F20003 		movw	r3, #:lower16:parson_malloc	@ tmp188,
 3247 10ae C0F20003 		movt	r3, #:upper16:parson_malloc	@ tmp188,
 3248 10b2 1B68     		ldr	r3, [r3]	@ parson_malloc.76_73, parson_malloc
 3249 10b4 B869     		ldr	r0, [r7, #24]	@, final_size
 3250 10b6 9847     		blx	r3	@ parson_malloc.76_73
 3251              	.LVL19:
 3252 10b8 3861     		str	r0, [r7, #16]	@, resized_output
 679:parson.c      ****     if (resized_output == NULL) {
 3253              		.loc 2 679 0
 3254 10ba 3B69     		ldr	r3, [r7, #16]	@ tmp189, resized_output
 3255 10bc 002B     		cmp	r3, #0	@ tmp189,
 3256 10be 13D0     		beq	.L183	@,
 680:parson.c      ****         goto error;
 681:parson.c      ****     }
 682:parson.c      ****     memcpy(resized_output, output, final_size);
 3257              		.loc 2 682 0
 3258 10c0 BA69     		ldr	r2, [r7, #24]	@, final_size
 3259 10c2 7969     		ldr	r1, [r7, #20]	@, output
 3260 10c4 3869     		ldr	r0, [r7, #16]	@, resized_output
 3261 10c6 FFF7FEFF 		bl	memcpy	@
 683:parson.c      ****     parson_free(output);
 3262              		.loc 2 683 0
 3263 10ca 40F20003 		movw	r3, #:lower16:parson_free	@ tmp190,
 3264 10ce C0F20003 		movt	r3, #:upper16:parson_free	@ tmp190,
 3265 10d2 1B68     		ldr	r3, [r3]	@ parson_free.77_77, parson_free
 3266 10d4 7869     		ldr	r0, [r7, #20]	@, output
 3267 10d6 9847     		blx	r3	@ parson_free.77_77
 3268              	.LVL20:
 684:parson.c      ****     return resized_output;
 3269              		.loc 2 684 0
 3270 10d8 3B69     		ldr	r3, [r7, #16]	@ _1, resized_output
 3271 10da 0EE0     		b	.L178	@
 3272              	.L179:
 626:parson.c      ****     }
 3273              		.loc 2 626 0
 3274 10dc 00BF     		nop
 3275 10de 04E0     		b	.L156	@
 3276              	.L180:
 663:parson.c      ****             }
 3277              		.loc 2 663 0
 3278 10e0 00BF     		nop
 3279 10e2 02E0     		b	.L156	@
 3280              	.L182:
 666:parson.c      ****                            (http://www.ietf.org/rfc/rfc4627.txt) */
 3281              		.loc 2 666 0
 3282 10e4 00BF     		nop
 3283 10e6 00E0     		b	.L156	@
 3284              	.L183:
 680:parson.c      ****     }
 3285              		.loc 2 680 0
 3286 10e8 00BF     		nop
 3287              	.L156:
 685:parson.c      **** error:
 686:parson.c      ****     parson_free(output);
 3288              		.loc 2 686 0
 3289 10ea 40F20003 		movw	r3, #:lower16:parson_free	@ tmp191,
 3290 10ee C0F20003 		movt	r3, #:upper16:parson_free	@ tmp191,
 3291 10f2 1B68     		ldr	r3, [r3]	@ parson_free.78_80, parson_free
 3292 10f4 7869     		ldr	r0, [r7, #20]	@, output
 3293 10f6 9847     		blx	r3	@ parson_free.78_80
 3294              	.LVL21:
 687:parson.c      ****     return NULL;
 3295              		.loc 2 687 0
 3296 10f8 0023     		movs	r3, #0	@ _1,
 3297              	.L178:
 688:parson.c      **** }
 3298              		.loc 2 688 0 discriminator 2
 3299 10fa 1846     		mov	r0, r3	@, <retval>
 3300 10fc 2037     		adds	r7, r7, #32	@,,
 3301              	.LCFI132:
 3302              		.cfi_def_cfa_offset 8
 3303 10fe BD46     		mov	sp, r7	@,
 3304              	.LCFI133:
 3305              		.cfi_def_cfa_register 13
 3306              		@ sp needed	@
 3307 1100 80BD     		pop	{r7, pc}	@
 3308              		.cfi_endproc
 3309              	.LFE42:
 3311              		.align	1
 3312              		.syntax unified
 3313              		.thumb
 3314              		.thumb_func
 3315              		.fpu neon
 3317              	get_quoted_string:
 3318              	.LFB43:
 689:parson.c      **** 
 690:parson.c      **** /* Return processed contents of a string between quotes and
 691:parson.c      ****    skips passed argument to a matching quote. */
 692:parson.c      **** static char *get_quoted_string(const char **string)
 693:parson.c      **** {
 3319              		.loc 2 693 0
 3320              		.cfi_startproc
 3321              		@ args = 0, pretend = 0, frame = 24
 3322              		@ frame_needed = 1, uses_anonymous_args = 0
 3323 1102 80B5     		push	{r7, lr}	@
 3324              	.LCFI134:
 3325              		.cfi_def_cfa_offset 8
 3326              		.cfi_offset 7, -8
 3327              		.cfi_offset 14, -4
 3328 1104 86B0     		sub	sp, sp, #24	@,,
 3329              	.LCFI135:
 3330              		.cfi_def_cfa_offset 32
 3331 1106 00AF     		add	r7, sp, #0	@,,
 3332              	.LCFI136:
 3333              		.cfi_def_cfa_register 7
 3334 1108 7860     		str	r0, [r7, #4]	@ string, string
 694:parson.c      ****     const char *string_start = *string;
 3335              		.loc 2 694 0
 3336 110a 7B68     		ldr	r3, [r7, #4]	@ tmp118, string
 3337 110c 1B68     		ldr	r3, [r3]	@ tmp119, *string_4(D)
 3338 110e 7B61     		str	r3, [r7, #20]	@ tmp119, string_start
 695:parson.c      ****     size_t string_len = 0;
 3339              		.loc 2 695 0
 3340 1110 0023     		movs	r3, #0	@ tmp120,
 3341 1112 3B61     		str	r3, [r7, #16]	@ tmp120, string_len
 696:parson.c      ****     JSON_Status status = skip_quotes(string);
 3342              		.loc 2 696 0
 3343 1114 7868     		ldr	r0, [r7, #4]	@, string
 3344 1116 FFF766FD 		bl	skip_quotes	@
 3345 111a F860     		str	r0, [r7, #12]	@, status
 697:parson.c      ****     if (status != JSONSuccess) {
 3346              		.loc 2 697 0
 3347 111c FB68     		ldr	r3, [r7, #12]	@ tmp121, status
 3348 111e 002B     		cmp	r3, #0	@ tmp121,
 3349 1120 01D0     		beq	.L185	@,
 698:parson.c      ****         return NULL;
 3350              		.loc 2 698 0
 3351 1122 0023     		movs	r3, #0	@ _1,
 3352 1124 0DE0     		b	.L186	@
 3353              	.L185:
 699:parson.c      ****     }
 700:parson.c      ****     string_len = (size_t)(*string - string_start - 2); /* length without quotes */
 3354              		.loc 2 700 0
 3355 1126 7B68     		ldr	r3, [r7, #4]	@ tmp122, string
 3356 1128 1B68     		ldr	r3, [r3]	@ _10, *string_4(D)
 3357 112a 1A46     		mov	r2, r3	@ _11, _10
 3358 112c 7B69     		ldr	r3, [r7, #20]	@ string_start.79_12, string_start
 3359 112e D31A     		subs	r3, r2, r3	@ _13, _11, string_start.79_12
 3360 1130 023B     		subs	r3, r3, #2	@ _14, _13,
 3361 1132 3B61     		str	r3, [r7, #16]	@ _14, string_len
 701:parson.c      ****     return process_string(string_start + 1, string_len);
 3362              		.loc 2 701 0
 3363 1134 7B69     		ldr	r3, [r7, #20]	@ tmp123, string_start
 3364 1136 0133     		adds	r3, r3, #1	@ _16, tmp123,
 3365 1138 3969     		ldr	r1, [r7, #16]	@, string_len
 3366 113a 1846     		mov	r0, r3	@, _16
 3367 113c FFF788FE 		bl	process_string	@
 3368 1140 0346     		mov	r3, r0	@ _1,
 3369              	.L186:
 702:parson.c      **** }
 3370              		.loc 2 702 0
 3371 1142 1846     		mov	r0, r3	@, <retval>
 3372 1144 1837     		adds	r7, r7, #24	@,,
 3373              	.LCFI137:
 3374              		.cfi_def_cfa_offset 8
 3375 1146 BD46     		mov	sp, r7	@,
 3376              	.LCFI138:
 3377              		.cfi_def_cfa_register 13
 3378              		@ sp needed	@
 3379 1148 80BD     		pop	{r7, pc}	@
 3380              		.cfi_endproc
 3381              	.LFE43:
 3383              		.align	1
 3384              		.syntax unified
 3385              		.thumb
 3386              		.thumb_func
 3387              		.fpu neon
 3389              	parse_value:
 3390              	.LFB44:
 703:parson.c      **** 
 704:parson.c      **** static JSON_Value *parse_value(const char **string, size_t nesting)
 705:parson.c      **** {
 3391              		.loc 2 705 0
 3392              		.cfi_startproc
 3393              		@ args = 0, pretend = 0, frame = 8
 3394              		@ frame_needed = 1, uses_anonymous_args = 0
 3395 114a 80B5     		push	{r7, lr}	@
 3396              	.LCFI139:
 3397              		.cfi_def_cfa_offset 8
 3398              		.cfi_offset 7, -8
 3399              		.cfi_offset 14, -4
 3400 114c 82B0     		sub	sp, sp, #8	@,,
 3401              	.LCFI140:
 3402              		.cfi_def_cfa_offset 16
 3403 114e 00AF     		add	r7, sp, #0	@,,
 3404              	.LCFI141:
 3405              		.cfi_def_cfa_register 7
 3406 1150 7860     		str	r0, [r7, #4]	@ string, string
 3407 1152 3960     		str	r1, [r7]	@ nesting, nesting
 706:parson.c      ****     if (nesting > MAX_NESTING) {
 3408              		.loc 2 706 0
 3409 1154 3B68     		ldr	r3, [r7]	@ tmp123, nesting
 3410 1156 B3F5006F 		cmp	r3, #2048	@ tmp123,
 3411 115a 06D9     		bls	.L190	@,
 707:parson.c      ****         return NULL;
 3412              		.loc 2 707 0
 3413 115c 0023     		movs	r3, #0	@ _1,
 3414 115e F0E0     		b	.L189	@
 3415              	.L191:
 708:parson.c      ****     }
 709:parson.c      ****     SKIP_WHITESPACES(string);
 3416              		.loc 2 709 0 discriminator 2
 3417 1160 7B68     		ldr	r3, [r7, #4]	@ tmp124, string
 3418 1162 1B68     		ldr	r3, [r3]	@ _13, *string_7(D)
 3419 1164 5A1C     		adds	r2, r3, #1	@ _14, _13,
 3420 1166 7B68     		ldr	r3, [r7, #4]	@ tmp125, string
 3421 1168 1A60     		str	r2, [r3]	@ _14, *string_7(D)
 3422              	.L190:
 3423              		.loc 2 709 0 is_stmt 0 discriminator 1
 3424 116a 7B68     		ldr	r3, [r7, #4]	@ tmp126, string
 3425 116c 1B68     		ldr	r3, [r3]	@ _8, *string_7(D)
 3426 116e 1B78     		ldrb	r3, [r3]	@ zero_extendqisi2	@ _9, *_8
 3427 1170 1846     		mov	r0, r3	@, _10
 3428 1172 FEF745FF 		bl	__isspace	@
 3429 1176 0346     		mov	r3, r0	@ _12,
 3430 1178 002B     		cmp	r3, #0	@ _12,
 3431 117a F1D1     		bne	.L191	@,
 710:parson.c      ****     switch (**string) {
 3432              		.loc 2 710 0 is_stmt 1
 3433 117c 7B68     		ldr	r3, [r7, #4]	@ tmp127, string
 3434 117e 1B68     		ldr	r3, [r3]	@ _16, *string_7(D)
 3435 1180 1B78     		ldrb	r3, [r3]	@ zero_extendqisi2	@ _17, *_16
 3436 1182 223B     		subs	r3, r3, #34	@ tmp128, _18,
 3437 1184 592B     		cmp	r3, #89	@ tmp128,
 3438 1186 00F2DB80 		bhi	.L192	@
 3439 118a 01A2     		adr	r2, .L194	@ tmp132,
 3440 118c 52F823F0 		ldr	pc, [r2, r3, lsl #2]	@ tmp132, tmp128
 3441              		.p2align 2
 3442              	.L194:
 3443 1190 19130000 		.word	.L193+1
 3444 1194 41130000 		.word	.L192+1
 3445 1198 41130000 		.word	.L192+1
 3446 119c 41130000 		.word	.L192+1
 3447 11a0 41130000 		.word	.L192+1
 3448 11a4 41130000 		.word	.L192+1
 3449 11a8 41130000 		.word	.L192+1
 3450 11ac 41130000 		.word	.L192+1
 3451 11b0 41130000 		.word	.L192+1
 3452 11b4 41130000 		.word	.L192+1
 3453 11b8 41130000 		.word	.L192+1
 3454 11bc 2D130000 		.word	.L195+1
 3455 11c0 41130000 		.word	.L192+1
 3456 11c4 41130000 		.word	.L192+1
 3457 11c8 2D130000 		.word	.L195+1
 3458 11cc 2D130000 		.word	.L195+1
 3459 11d0 2D130000 		.word	.L195+1
 3460 11d4 2D130000 		.word	.L195+1
 3461 11d8 2D130000 		.word	.L195+1
 3462 11dc 2D130000 		.word	.L195+1
 3463 11e0 2D130000 		.word	.L195+1
 3464 11e4 2D130000 		.word	.L195+1
 3465 11e8 2D130000 		.word	.L195+1
 3466 11ec 2D130000 		.word	.L195+1
 3467 11f0 41130000 		.word	.L192+1
 3468 11f4 41130000 		.word	.L192+1
 3469 11f8 41130000 		.word	.L192+1
 3470 11fc 41130000 		.word	.L192+1
 3471 1200 41130000 		.word	.L192+1
 3472 1204 41130000 		.word	.L192+1
 3473 1208 41130000 		.word	.L192+1
 3474 120c 41130000 		.word	.L192+1
 3475 1210 41130000 		.word	.L192+1
 3476 1214 41130000 		.word	.L192+1
 3477 1218 41130000 		.word	.L192+1
 3478 121c 41130000 		.word	.L192+1
 3479 1220 41130000 		.word	.L192+1
 3480 1224 41130000 		.word	.L192+1
 3481 1228 41130000 		.word	.L192+1
 3482 122c 41130000 		.word	.L192+1
 3483 1230 41130000 		.word	.L192+1
 3484 1234 41130000 		.word	.L192+1
 3485 1238 41130000 		.word	.L192+1
 3486 123c 41130000 		.word	.L192+1
 3487 1240 41130000 		.word	.L192+1
 3488 1244 41130000 		.word	.L192+1
 3489 1248 41130000 		.word	.L192+1
 3490 124c 41130000 		.word	.L192+1
 3491 1250 41130000 		.word	.L192+1
 3492 1254 41130000 		.word	.L192+1
 3493 1258 41130000 		.word	.L192+1
 3494 125c 41130000 		.word	.L192+1
 3495 1260 41130000 		.word	.L192+1
 3496 1264 41130000 		.word	.L192+1
 3497 1268 41130000 		.word	.L192+1
 3498 126c 41130000 		.word	.L192+1
 3499 1270 41130000 		.word	.L192+1
 3500 1274 09130000 		.word	.L196+1
 3501 1278 41130000 		.word	.L192+1
 3502 127c 41130000 		.word	.L192+1
 3503 1280 41130000 		.word	.L192+1
 3504 1284 41130000 		.word	.L192+1
 3505 1288 41130000 		.word	.L192+1
 3506 128c 41130000 		.word	.L192+1
 3507 1290 41130000 		.word	.L192+1
 3508 1294 41130000 		.word	.L192+1
 3509 1298 41130000 		.word	.L192+1
 3510 129c 41130000 		.word	.L192+1
 3511 12a0 23130000 		.word	.L197+1
 3512 12a4 41130000 		.word	.L192+1
 3513 12a8 41130000 		.word	.L192+1
 3514 12ac 41130000 		.word	.L192+1
 3515 12b0 41130000 		.word	.L192+1
 3516 12b4 41130000 		.word	.L192+1
 3517 12b8 41130000 		.word	.L192+1
 3518 12bc 41130000 		.word	.L192+1
 3519 12c0 37130000 		.word	.L198+1
 3520 12c4 41130000 		.word	.L192+1
 3521 12c8 41130000 		.word	.L192+1
 3522 12cc 41130000 		.word	.L192+1
 3523 12d0 41130000 		.word	.L192+1
 3524 12d4 41130000 		.word	.L192+1
 3525 12d8 23130000 		.word	.L197+1
 3526 12dc 41130000 		.word	.L192+1
 3527 12e0 41130000 		.word	.L192+1
 3528 12e4 41130000 		.word	.L192+1
 3529 12e8 41130000 		.word	.L192+1
 3530 12ec 41130000 		.word	.L192+1
 3531 12f0 41130000 		.word	.L192+1
 3532 12f4 F9120000 		.word	.L199+1
 3533              		.p2align 1
 3534              	.L199:
 711:parson.c      ****     case '{':
 712:parson.c      ****         return parse_object_value(string, nesting + 1);
 3535              		.loc 2 712 0
 3536 12f8 3B68     		ldr	r3, [r7]	@ tmp129, nesting
 3537 12fa 0133     		adds	r3, r3, #1	@ _19, tmp129,
 3538 12fc 1946     		mov	r1, r3	@, _19
 3539 12fe 7868     		ldr	r0, [r7, #4]	@, string
 3540 1300 00F023F8 		bl	parse_object_value	@
 3541 1304 0346     		mov	r3, r0	@ _1,
 3542 1306 1CE0     		b	.L189	@
 3543              	.L196:
 713:parson.c      ****     case '[':
 714:parson.c      ****         return parse_array_value(string, nesting + 1);
 3544              		.loc 2 714 0
 3545 1308 3B68     		ldr	r3, [r7]	@ tmp130, nesting
 3546 130a 0133     		adds	r3, r3, #1	@ _22, tmp130,
 3547 130c 1946     		mov	r1, r3	@, _22
 3548 130e 7868     		ldr	r0, [r7, #4]	@, string
 3549 1310 00F021F9 		bl	parse_array_value	@
 3550 1314 0346     		mov	r3, r0	@ _1,
 3551 1316 14E0     		b	.L189	@
 3552              	.L193:
 715:parson.c      ****     case '\"':
 716:parson.c      ****         return parse_string_value(string);
 3553              		.loc 2 716 0
 3554 1318 7868     		ldr	r0, [r7, #4]	@, string
 3555 131a 00F0D7F9 		bl	parse_string_value	@
 3556 131e 0346     		mov	r3, r0	@ _1,
 3557 1320 0FE0     		b	.L189	@
 3558              	.L197:
 717:parson.c      ****     case 'f':
 718:parson.c      ****     case 't':
 719:parson.c      ****         return parse_boolean_value(string);
 3559              		.loc 2 719 0
 3560 1322 7868     		ldr	r0, [r7, #4]	@, string
 3561 1324 00F0F6F9 		bl	parse_boolean_value	@
 3562 1328 0346     		mov	r3, r0	@ _1,
 3563 132a 0AE0     		b	.L189	@
 3564              	.L195:
 720:parson.c      ****     case '-':
 721:parson.c      ****     case '0':
 722:parson.c      ****     case '1':
 723:parson.c      ****     case '2':
 724:parson.c      ****     case '3':
 725:parson.c      ****     case '4':
 726:parson.c      ****     case '5':
 727:parson.c      ****     case '6':
 728:parson.c      ****     case '7':
 729:parson.c      ****     case '8':
 730:parson.c      ****     case '9':
 731:parson.c      ****         return parse_number_value(string);
 3565              		.loc 2 731 0
 3566 132c 7868     		ldr	r0, [r7, #4]	@, string
 3567 132e 00F02EFA 		bl	parse_number_value	@
 3568 1332 0346     		mov	r3, r0	@ _1,
 3569 1334 05E0     		b	.L189	@
 3570              	.L198:
 732:parson.c      ****     case 'n':
 733:parson.c      ****         return parse_null_value(string);
 3571              		.loc 2 733 0
 3572 1336 7868     		ldr	r0, [r7, #4]	@, string
 3573 1338 00F064FA 		bl	parse_null_value	@
 3574 133c 0346     		mov	r3, r0	@ _1,
 3575 133e 00E0     		b	.L189	@
 3576              	.L192:
 734:parson.c      ****     default:
 735:parson.c      ****         return NULL;
 3577              		.loc 2 735 0
 3578 1340 0023     		movs	r3, #0	@ _1,
 3579              	.L189:
 736:parson.c      ****     }
 737:parson.c      **** }
 3580              		.loc 2 737 0
 3581 1342 1846     		mov	r0, r3	@, <retval>
 3582 1344 0837     		adds	r7, r7, #8	@,,
 3583              	.LCFI142:
 3584              		.cfi_def_cfa_offset 8
 3585 1346 BD46     		mov	sp, r7	@,
 3586              	.LCFI143:
 3587              		.cfi_def_cfa_register 13
 3588              		@ sp needed	@
 3589 1348 80BD     		pop	{r7, pc}	@
 3590              		.cfi_endproc
 3591              	.LFE44:
 3593              		.align	1
 3594              		.syntax unified
 3595              		.thumb
 3596              		.thumb_func
 3597              		.fpu neon
 3599              	parse_object_value:
 3600              	.LFB45:
 738:parson.c      **** 
 739:parson.c      **** static JSON_Value *parse_object_value(const char **string, size_t nesting)
 740:parson.c      **** {
 3601              		.loc 2 740 0
 3602              		.cfi_startproc
 3603              		@ args = 0, pretend = 0, frame = 24
 3604              		@ frame_needed = 1, uses_anonymous_args = 0
 3605 134a 80B5     		push	{r7, lr}	@
 3606              	.LCFI144:
 3607              		.cfi_def_cfa_offset 8
 3608              		.cfi_offset 7, -8
 3609              		.cfi_offset 14, -4
 3610 134c 86B0     		sub	sp, sp, #24	@,,
 3611              	.LCFI145:
 3612              		.cfi_def_cfa_offset 32
 3613 134e 00AF     		add	r7, sp, #0	@,,
 3614              	.LCFI146:
 3615              		.cfi_def_cfa_register 7
 3616 1350 7860     		str	r0, [r7, #4]	@ string, string
 3617 1352 3960     		str	r1, [r7]	@ nesting, nesting
 741:parson.c      ****     JSON_Value *output_value = NULL, *new_value = NULL;
 3618              		.loc 2 741 0
 3619 1354 0023     		movs	r3, #0	@ tmp171,
 3620 1356 7B61     		str	r3, [r7, #20]	@ tmp171, output_value
 3621 1358 0023     		movs	r3, #0	@ tmp172,
 3622 135a 3B61     		str	r3, [r7, #16]	@ tmp172, new_value
 742:parson.c      ****     JSON_Object *output_object = NULL;
 3623              		.loc 2 742 0
 3624 135c 0023     		movs	r3, #0	@ tmp173,
 3625 135e FB60     		str	r3, [r7, #12]	@ tmp173, output_object
 743:parson.c      ****     char *new_key = NULL;
 3626              		.loc 2 743 0
 3627 1360 0023     		movs	r3, #0	@ tmp174,
 3628 1362 BB60     		str	r3, [r7, #8]	@ tmp174, new_key
 744:parson.c      ****     output_value = json_value_init_object();
 3629              		.loc 2 744 0
 3630 1364 FFF7FEFF 		bl	json_value_init_object	@
 3631 1368 7861     		str	r0, [r7, #20]	@, output_value
 745:parson.c      ****     if (output_value == NULL) {
 3632              		.loc 2 745 0
 3633 136a 7B69     		ldr	r3, [r7, #20]	@ tmp175, output_value
 3634 136c 002B     		cmp	r3, #0	@ tmp175,
 3635 136e 01D1     		bne	.L201	@,
 746:parson.c      ****         return NULL;
 3636              		.loc 2 746 0
 3637 1370 0023     		movs	r3, #0	@ _1,
 3638 1372 ECE0     		b	.L202	@
 3639              	.L201:
 747:parson.c      ****     }
 748:parson.c      ****     if (**string != '{') {
 3640              		.loc 2 748 0
 3641 1374 7B68     		ldr	r3, [r7, #4]	@ tmp176, string
 3642 1376 1B68     		ldr	r3, [r3]	@ _20, *string_19(D)
 3643 1378 1B78     		ldrb	r3, [r3]	@ zero_extendqisi2	@ _21, *_20
 3644 137a 7B2B     		cmp	r3, #123	@ _21,
 3645 137c 04D0     		beq	.L203	@,
 749:parson.c      ****         json_value_free(output_value);
 3646              		.loc 2 749 0
 3647 137e 7869     		ldr	r0, [r7, #20]	@, output_value
 3648 1380 FFF7FEFF 		bl	json_value_free	@
 750:parson.c      ****         return NULL;
 3649              		.loc 2 750 0
 3650 1384 0023     		movs	r3, #0	@ _1,
 3651 1386 E2E0     		b	.L202	@
 3652              	.L203:
 751:parson.c      ****     }
 752:parson.c      ****     output_object = json_value_get_object(output_value);
 3653              		.loc 2 752 0
 3654 1388 7869     		ldr	r0, [r7, #20]	@, output_value
 3655 138a FFF7FEFF 		bl	json_value_get_object	@
 3656 138e F860     		str	r0, [r7, #12]	@, output_object
 753:parson.c      ****     SKIP_CHAR(string);
 3657              		.loc 2 753 0
 3658 1390 7B68     		ldr	r3, [r7, #4]	@ tmp177, string
 3659 1392 1B68     		ldr	r3, [r3]	@ _26, *string_19(D)
 3660 1394 5A1C     		adds	r2, r3, #1	@ _27, _26,
 3661 1396 7B68     		ldr	r3, [r7, #4]	@ tmp178, string
 3662 1398 1A60     		str	r2, [r3]	@ _27, *string_19(D)
 754:parson.c      ****     SKIP_WHITESPACES(string);
 3663              		.loc 2 754 0
 3664 139a 04E0     		b	.L204	@
 3665              	.L205:
 3666              		.loc 2 754 0 is_stmt 0 discriminator 2
 3667 139c 7B68     		ldr	r3, [r7, #4]	@ tmp179, string
 3668 139e 1B68     		ldr	r3, [r3]	@ _34, *string_19(D)
 3669 13a0 5A1C     		adds	r2, r3, #1	@ _35, _34,
 3670 13a2 7B68     		ldr	r3, [r7, #4]	@ tmp180, string
 3671 13a4 1A60     		str	r2, [r3]	@ _35, *string_19(D)
 3672              	.L204:
 3673              		.loc 2 754 0 discriminator 1
 3674 13a6 7B68     		ldr	r3, [r7, #4]	@ tmp181, string
 3675 13a8 1B68     		ldr	r3, [r3]	@ _29, *string_19(D)
 3676 13aa 1B78     		ldrb	r3, [r3]	@ zero_extendqisi2	@ _30, *_29
 3677 13ac 1846     		mov	r0, r3	@, _31
 3678 13ae FEF727FE 		bl	__isspace	@
 3679 13b2 0346     		mov	r3, r0	@ _33,
 3680 13b4 002B     		cmp	r3, #0	@ _33,
 3681 13b6 F1D1     		bne	.L205	@,
 755:parson.c      ****     if (**string == '}') { /* empty object */
 3682              		.loc 2 755 0 is_stmt 1
 3683 13b8 7B68     		ldr	r3, [r7, #4]	@ tmp182, string
 3684 13ba 1B68     		ldr	r3, [r3]	@ _37, *string_19(D)
 3685 13bc 1B78     		ldrb	r3, [r3]	@ zero_extendqisi2	@ _38, *_37
 3686 13be 7D2B     		cmp	r3, #125	@ _38,
 3687 13c0 40F09280 		bne	.L207	@,
 756:parson.c      ****         SKIP_CHAR(string);
 3688              		.loc 2 756 0
 3689 13c4 7B68     		ldr	r3, [r7, #4]	@ tmp183, string
 3690 13c6 1B68     		ldr	r3, [r3]	@ _39, *string_19(D)
 3691 13c8 5A1C     		adds	r2, r3, #1	@ _40, _39,
 3692 13ca 7B68     		ldr	r3, [r7, #4]	@ tmp184, string
 3693 13cc 1A60     		str	r2, [r3]	@ _40, *string_19(D)
 757:parson.c      ****         return output_value;
 3694              		.loc 2 757 0
 3695 13ce 7B69     		ldr	r3, [r7, #20]	@ _1, output_value
 3696 13d0 BDE0     		b	.L202	@
 3697              	.L220:
 758:parson.c      ****     }
 759:parson.c      ****     while (**string != '\0') {
 760:parson.c      ****         new_key = get_quoted_string(string);
 3698              		.loc 2 760 0
 3699 13d2 7868     		ldr	r0, [r7, #4]	@, string
 3700 13d4 FFF795FE 		bl	get_quoted_string	@
 3701 13d8 B860     		str	r0, [r7, #8]	@, new_key
 761:parson.c      ****         if (new_key == NULL) {
 3702              		.loc 2 761 0
 3703 13da BB68     		ldr	r3, [r7, #8]	@ tmp185, new_key
 3704 13dc 002B     		cmp	r3, #0	@ tmp185,
 3705 13de 09D1     		bne	.L209	@,
 762:parson.c      ****             json_value_free(output_value);
 3706              		.loc 2 762 0
 3707 13e0 7869     		ldr	r0, [r7, #20]	@, output_value
 3708 13e2 FFF7FEFF 		bl	json_value_free	@
 763:parson.c      ****             return NULL;
 3709              		.loc 2 763 0
 3710 13e6 0023     		movs	r3, #0	@ _1,
 3711 13e8 B1E0     		b	.L202	@
 3712              	.L210:
 764:parson.c      ****         }
 765:parson.c      ****         SKIP_WHITESPACES(string);
 3713              		.loc 2 765 0 discriminator 2
 3714 13ea 7B68     		ldr	r3, [r7, #4]	@ tmp186, string
 3715 13ec 1B68     		ldr	r3, [r3]	@ _52, *string_19(D)
 3716 13ee 5A1C     		adds	r2, r3, #1	@ _53, _52,
 3717 13f0 7B68     		ldr	r3, [r7, #4]	@ tmp187, string
 3718 13f2 1A60     		str	r2, [r3]	@ _53, *string_19(D)
 3719              	.L209:
 3720              		.loc 2 765 0 is_stmt 0 discriminator 1
 3721 13f4 7B68     		ldr	r3, [r7, #4]	@ tmp188, string
 3722 13f6 1B68     		ldr	r3, [r3]	@ _47, *string_19(D)
 3723 13f8 1B78     		ldrb	r3, [r3]	@ zero_extendqisi2	@ _48, *_47
 3724 13fa 1846     		mov	r0, r3	@, _49
 3725 13fc FEF700FE 		bl	__isspace	@
 3726 1400 0346     		mov	r3, r0	@ _51,
 3727 1402 002B     		cmp	r3, #0	@ _51,
 3728 1404 F1D1     		bne	.L210	@,
 766:parson.c      ****         if (**string != ':') {
 3729              		.loc 2 766 0 is_stmt 1
 3730 1406 7B68     		ldr	r3, [r7, #4]	@ tmp189, string
 3731 1408 1B68     		ldr	r3, [r3]	@ _55, *string_19(D)
 3732 140a 1B78     		ldrb	r3, [r3]	@ zero_extendqisi2	@ _56, *_55
 3733 140c 3A2B     		cmp	r3, #58	@ _56,
 3734 140e 0BD0     		beq	.L211	@,
 767:parson.c      ****             parson_free(new_key);
 3735              		.loc 2 767 0
 3736 1410 40F20003 		movw	r3, #:lower16:parson_free	@ tmp190,
 3737 1414 C0F20003 		movt	r3, #:upper16:parson_free	@ tmp190,
 3738 1418 1B68     		ldr	r3, [r3]	@ parson_free.82_97, parson_free
 3739 141a B868     		ldr	r0, [r7, #8]	@, new_key
 3740 141c 9847     		blx	r3	@ parson_free.82_97
 3741              	.LVL22:
 768:parson.c      ****             json_value_free(output_value);
 3742              		.loc 2 768 0
 3743 141e 7869     		ldr	r0, [r7, #20]	@, output_value
 3744 1420 FFF7FEFF 		bl	json_value_free	@
 769:parson.c      ****             return NULL;
 3745              		.loc 2 769 0
 3746 1424 0023     		movs	r3, #0	@ _1,
 3747 1426 92E0     		b	.L202	@
 3748              	.L211:
 770:parson.c      ****         }
 771:parson.c      ****         SKIP_CHAR(string);
 3749              		.loc 2 771 0
 3750 1428 7B68     		ldr	r3, [r7, #4]	@ tmp191, string
 3751 142a 1B68     		ldr	r3, [r3]	@ _57, *string_19(D)
 3752 142c 5A1C     		adds	r2, r3, #1	@ _58, _57,
 3753 142e 7B68     		ldr	r3, [r7, #4]	@ tmp192, string
 3754 1430 1A60     		str	r2, [r3]	@ _58, *string_19(D)
 772:parson.c      ****         new_value = parse_value(string, nesting);
 3755              		.loc 2 772 0
 3756 1432 3968     		ldr	r1, [r7]	@, nesting
 3757 1434 7868     		ldr	r0, [r7, #4]	@, string
 3758 1436 FFF788FE 		bl	parse_value	@
 3759 143a 3861     		str	r0, [r7, #16]	@, new_value
 773:parson.c      ****         if (new_value == NULL) {
 3760              		.loc 2 773 0
 3761 143c 3B69     		ldr	r3, [r7, #16]	@ tmp193, new_value
 3762 143e 002B     		cmp	r3, #0	@ tmp193,
 3763 1440 0BD1     		bne	.L212	@,
 774:parson.c      ****             parson_free(new_key);
 3764              		.loc 2 774 0
 3765 1442 40F20003 		movw	r3, #:lower16:parson_free	@ tmp194,
 3766 1446 C0F20003 		movt	r3, #:upper16:parson_free	@ tmp194,
 3767 144a 1B68     		ldr	r3, [r3]	@ parson_free.83_93, parson_free
 3768 144c B868     		ldr	r0, [r7, #8]	@, new_key
 3769 144e 9847     		blx	r3	@ parson_free.83_93
 3770              	.LVL23:
 775:parson.c      ****             json_value_free(output_value);
 3771              		.loc 2 775 0
 3772 1450 7869     		ldr	r0, [r7, #20]	@, output_value
 3773 1452 FFF7FEFF 		bl	json_value_free	@
 776:parson.c      ****             return NULL;
 3774              		.loc 2 776 0
 3775 1456 0023     		movs	r3, #0	@ _1,
 3776 1458 79E0     		b	.L202	@
 3777              	.L212:
 777:parson.c      ****         }
 778:parson.c      ****         if (json_object_add(output_object, new_key, new_value) == JSONFailure) {
 3778              		.loc 2 778 0
 3779 145a 3A69     		ldr	r2, [r7, #16]	@, new_value
 3780 145c B968     		ldr	r1, [r7, #8]	@, new_key
 3781 145e F868     		ldr	r0, [r7, #12]	@, output_object
 3782 1460 FFF7A5F8 		bl	json_object_add	@
 3783 1464 0346     		mov	r3, r0	@ _64,
 3784 1466 B3F1FF3F 		cmp	r3, #-1	@ _64,
 3785 146a 0ED1     		bne	.L213	@,
 779:parson.c      ****             parson_free(new_key);
 3786              		.loc 2 779 0
 3787 146c 40F20003 		movw	r3, #:lower16:parson_free	@ tmp195,
 3788 1470 C0F20003 		movt	r3, #:upper16:parson_free	@ tmp195,
 3789 1474 1B68     		ldr	r3, [r3]	@ parson_free.84_88, parson_free
 3790 1476 B868     		ldr	r0, [r7, #8]	@, new_key
 3791 1478 9847     		blx	r3	@ parson_free.84_88
 3792              	.LVL24:
 780:parson.c      ****             json_value_free(new_value);
 3793              		.loc 2 780 0
 3794 147a 3869     		ldr	r0, [r7, #16]	@, new_value
 3795 147c FFF7FEFF 		bl	json_value_free	@
 781:parson.c      ****             json_value_free(output_value);
 3796              		.loc 2 781 0
 3797 1480 7869     		ldr	r0, [r7, #20]	@, output_value
 3798 1482 FFF7FEFF 		bl	json_value_free	@
 782:parson.c      ****             return NULL;
 3799              		.loc 2 782 0
 3800 1486 0023     		movs	r3, #0	@ _1,
 3801 1488 61E0     		b	.L202	@
 3802              	.L213:
 783:parson.c      ****         }
 784:parson.c      ****         parson_free(new_key);
 3803              		.loc 2 784 0
 3804 148a 40F20003 		movw	r3, #:lower16:parson_free	@ tmp196,
 3805 148e C0F20003 		movt	r3, #:upper16:parson_free	@ tmp196,
 3806 1492 1B68     		ldr	r3, [r3]	@ parson_free.85_65, parson_free
 3807 1494 B868     		ldr	r0, [r7, #8]	@, new_key
 3808 1496 9847     		blx	r3	@ parson_free.85_65
 3809              	.LVL25:
 785:parson.c      ****         SKIP_WHITESPACES(string);
 3810              		.loc 2 785 0
 3811 1498 04E0     		b	.L214	@
 3812              	.L215:
 3813              		.loc 2 785 0 is_stmt 0 discriminator 2
 3814 149a 7B68     		ldr	r3, [r7, #4]	@ tmp197, string
 3815 149c 1B68     		ldr	r3, [r3]	@ _72, *string_19(D)
 3816 149e 5A1C     		adds	r2, r3, #1	@ _73, _72,
 3817 14a0 7B68     		ldr	r3, [r7, #4]	@ tmp198, string
 3818 14a2 1A60     		str	r2, [r3]	@ _73, *string_19(D)
 3819              	.L214:
 3820              		.loc 2 785 0 discriminator 1
 3821 14a4 7B68     		ldr	r3, [r7, #4]	@ tmp199, string
 3822 14a6 1B68     		ldr	r3, [r3]	@ _67, *string_19(D)
 3823 14a8 1B78     		ldrb	r3, [r3]	@ zero_extendqisi2	@ _68, *_67
 3824 14aa 1846     		mov	r0, r3	@, _69
 3825 14ac FEF7A8FD 		bl	__isspace	@
 3826 14b0 0346     		mov	r3, r0	@ _71,
 3827 14b2 002B     		cmp	r3, #0	@ _71,
 3828 14b4 F1D1     		bne	.L215	@,
 786:parson.c      ****         if (**string != ',') {
 3829              		.loc 2 786 0 is_stmt 1
 3830 14b6 7B68     		ldr	r3, [r7, #4]	@ tmp200, string
 3831 14b8 1B68     		ldr	r3, [r3]	@ _75, *string_19(D)
 3832 14ba 1B78     		ldrb	r3, [r3]	@ zero_extendqisi2	@ _76, *_75
 3833 14bc 2C2B     		cmp	r3, #44	@ _76,
 3834 14be 1AD1     		bne	.L225	@,
 787:parson.c      ****             break;
 788:parson.c      ****         }
 789:parson.c      ****         SKIP_CHAR(string);
 3835              		.loc 2 789 0
 3836 14c0 7B68     		ldr	r3, [r7, #4]	@ tmp201, string
 3837 14c2 1B68     		ldr	r3, [r3]	@ _77, *string_19(D)
 3838 14c4 5A1C     		adds	r2, r3, #1	@ _78, _77,
 3839 14c6 7B68     		ldr	r3, [r7, #4]	@ tmp202, string
 3840 14c8 1A60     		str	r2, [r3]	@ _78, *string_19(D)
 790:parson.c      ****         SKIP_WHITESPACES(string);
 3841              		.loc 2 790 0
 3842 14ca 04E0     		b	.L218	@
 3843              	.L219:
 3844              		.loc 2 790 0 is_stmt 0 discriminator 2
 3845 14cc 7B68     		ldr	r3, [r7, #4]	@ tmp203, string
 3846 14ce 1B68     		ldr	r3, [r3]	@ _85, *string_19(D)
 3847 14d0 5A1C     		adds	r2, r3, #1	@ _86, _85,
 3848 14d2 7B68     		ldr	r3, [r7, #4]	@ tmp204, string
 3849 14d4 1A60     		str	r2, [r3]	@ _86, *string_19(D)
 3850              	.L218:
 3851              		.loc 2 790 0 discriminator 1
 3852 14d6 7B68     		ldr	r3, [r7, #4]	@ tmp205, string
 3853 14d8 1B68     		ldr	r3, [r3]	@ _80, *string_19(D)
 3854 14da 1B78     		ldrb	r3, [r3]	@ zero_extendqisi2	@ _81, *_80
 3855 14dc 1846     		mov	r0, r3	@, _82
 3856 14de FEF78FFD 		bl	__isspace	@
 3857 14e2 0346     		mov	r3, r0	@ _84,
 3858 14e4 002B     		cmp	r3, #0	@ _84,
 3859 14e6 F1D1     		bne	.L219	@,
 3860              	.L207:
 759:parson.c      ****         new_key = get_quoted_string(string);
 3861              		.loc 2 759 0 is_stmt 1
 3862 14e8 7B68     		ldr	r3, [r7, #4]	@ tmp206, string
 3863 14ea 1B68     		ldr	r3, [r3]	@ _43, *string_19(D)
 3864 14ec 1B78     		ldrb	r3, [r3]	@ zero_extendqisi2	@ _44, *_43
 3865 14ee 002B     		cmp	r3, #0	@ _44,
 3866 14f0 7FF46FAF 		bne	.L220	@,
 3867 14f4 06E0     		b	.L221	@
 3868              	.L225:
 787:parson.c      ****             break;
 3869              		.loc 2 787 0
 3870 14f6 00BF     		nop
 791:parson.c      ****     }
 792:parson.c      ****     SKIP_WHITESPACES(string);
 3871              		.loc 2 792 0
 3872 14f8 04E0     		b	.L221	@
 3873              	.L222:
 3874              		.loc 2 792 0 is_stmt 0 discriminator 2
 3875 14fa 7B68     		ldr	r3, [r7, #4]	@ tmp207, string
 3876 14fc 1B68     		ldr	r3, [r3]	@ _108, *string_19(D)
 3877 14fe 5A1C     		adds	r2, r3, #1	@ _109, _108,
 3878 1500 7B68     		ldr	r3, [r7, #4]	@ tmp208, string
 3879 1502 1A60     		str	r2, [r3]	@ _109, *string_19(D)
 3880              	.L221:
 3881              		.loc 2 792 0 discriminator 1
 3882 1504 7B68     		ldr	r3, [r7, #4]	@ tmp209, string
 3883 1506 1B68     		ldr	r3, [r3]	@ _103, *string_19(D)
 3884 1508 1B78     		ldrb	r3, [r3]	@ zero_extendqisi2	@ _104, *_103
 3885 150a 1846     		mov	r0, r3	@, _105
 3886 150c FEF778FD 		bl	__isspace	@
 3887 1510 0346     		mov	r3, r0	@ _107,
 3888 1512 002B     		cmp	r3, #0	@ _107,
 3889 1514 F1D1     		bne	.L222	@,
 793:parson.c      ****     if (**string != '}' || /* Trim object after parsing is over */
 3890              		.loc 2 793 0 is_stmt 1
 3891 1516 7B68     		ldr	r3, [r7, #4]	@ tmp210, string
 3892 1518 1B68     		ldr	r3, [r3]	@ _111, *string_19(D)
 3893 151a 1B78     		ldrb	r3, [r3]	@ zero_extendqisi2	@ _112, *_111
 3894 151c 7D2B     		cmp	r3, #125	@ _112,
 3895 151e 0BD1     		bne	.L223	@,
 794:parson.c      ****         json_object_resize(output_object, json_object_get_count(output_object)) == JSONFailure) {
 3896              		.loc 2 794 0 discriminator 1
 3897 1520 F868     		ldr	r0, [r7, #12]	@, output_object
 3898 1522 FFF7FEFF 		bl	json_object_get_count	@
 3899 1526 0346     		mov	r3, r0	@ _114,
 3900 1528 1946     		mov	r1, r3	@, _114
 3901 152a F868     		ldr	r0, [r7, #12]	@, output_object
 3902 152c FFF7C1F8 		bl	json_object_resize	@
 3903 1530 0346     		mov	r3, r0	@ _116,
 793:parson.c      ****     if (**string != '}' || /* Trim object after parsing is over */
 3904              		.loc 2 793 0 discriminator 1
 3905 1532 B3F1FF3F 		cmp	r3, #-1	@ _116,
 3906 1536 04D1     		bne	.L224	@,
 3907              	.L223:
 795:parson.c      ****         json_value_free(output_value);
 3908              		.loc 2 795 0
 3909 1538 7869     		ldr	r0, [r7, #20]	@, output_value
 3910 153a FFF7FEFF 		bl	json_value_free	@
 796:parson.c      ****         return NULL;
 3911              		.loc 2 796 0
 3912 153e 0023     		movs	r3, #0	@ _1,
 3913 1540 05E0     		b	.L202	@
 3914              	.L224:
 797:parson.c      ****     }
 798:parson.c      ****     SKIP_CHAR(string);
 3915              		.loc 2 798 0
 3916 1542 7B68     		ldr	r3, [r7, #4]	@ tmp211, string
 3917 1544 1B68     		ldr	r3, [r3]	@ _117, *string_19(D)
 3918 1546 5A1C     		adds	r2, r3, #1	@ _118, _117,
 3919 1548 7B68     		ldr	r3, [r7, #4]	@ tmp212, string
 3920 154a 1A60     		str	r2, [r3]	@ _118, *string_19(D)
 799:parson.c      ****     return output_value;
 3921              		.loc 2 799 0
 3922 154c 7B69     		ldr	r3, [r7, #20]	@ _1, output_value
 3923              	.L202:
 800:parson.c      **** }
 3924              		.loc 2 800 0
 3925 154e 1846     		mov	r0, r3	@, <retval>
 3926 1550 1837     		adds	r7, r7, #24	@,,
 3927              	.LCFI147:
 3928              		.cfi_def_cfa_offset 8
 3929 1552 BD46     		mov	sp, r7	@,
 3930              	.LCFI148:
 3931              		.cfi_def_cfa_register 13
 3932              		@ sp needed	@
 3933 1554 80BD     		pop	{r7, pc}	@
 3934              		.cfi_endproc
 3935              	.LFE45:
 3937              		.align	1
 3938              		.syntax unified
 3939              		.thumb
 3940              		.thumb_func
 3941              		.fpu neon
 3943              	parse_array_value:
 3944              	.LFB46:
 801:parson.c      **** 
 802:parson.c      **** static JSON_Value *parse_array_value(const char **string, size_t nesting)
 803:parson.c      **** {
 3945              		.loc 2 803 0
 3946              		.cfi_startproc
 3947              		@ args = 0, pretend = 0, frame = 24
 3948              		@ frame_needed = 1, uses_anonymous_args = 0
 3949 1556 80B5     		push	{r7, lr}	@
 3950              	.LCFI149:
 3951              		.cfi_def_cfa_offset 8
 3952              		.cfi_offset 7, -8
 3953              		.cfi_offset 14, -4
 3954 1558 86B0     		sub	sp, sp, #24	@,,
 3955              	.LCFI150:
 3956              		.cfi_def_cfa_offset 32
 3957 155a 00AF     		add	r7, sp, #0	@,,
 3958              	.LCFI151:
 3959              		.cfi_def_cfa_register 7
 3960 155c 7860     		str	r0, [r7, #4]	@ string, string
 3961 155e 3960     		str	r1, [r7]	@ nesting, nesting
 804:parson.c      ****     JSON_Value *output_value = NULL, *new_array_value = NULL;
 3962              		.loc 2 804 0
 3963 1560 0023     		movs	r3, #0	@ tmp157,
 3964 1562 7B61     		str	r3, [r7, #20]	@ tmp157, output_value
 3965 1564 0023     		movs	r3, #0	@ tmp158,
 3966 1566 3B61     		str	r3, [r7, #16]	@ tmp158, new_array_value
 805:parson.c      ****     JSON_Array *output_array = NULL;
 3967              		.loc 2 805 0
 3968 1568 0023     		movs	r3, #0	@ tmp159,
 3969 156a FB60     		str	r3, [r7, #12]	@ tmp159, output_array
 806:parson.c      ****     output_value = json_value_init_array();
 3970              		.loc 2 806 0
 3971 156c FFF7FEFF 		bl	json_value_init_array	@
 3972 1570 7861     		str	r0, [r7, #20]	@, output_value
 807:parson.c      ****     if (output_value == NULL) {
 3973              		.loc 2 807 0
 3974 1572 7B69     		ldr	r3, [r7, #20]	@ tmp160, output_value
 3975 1574 002B     		cmp	r3, #0	@ tmp160,
 3976 1576 01D1     		bne	.L227	@,
 808:parson.c      ****         return NULL;
 3977              		.loc 2 808 0
 3978 1578 0023     		movs	r3, #0	@ _1,
 3979 157a A3E0     		b	.L228	@
 3980              	.L227:
 809:parson.c      ****     }
 810:parson.c      ****     if (**string != '[') {
 3981              		.loc 2 810 0
 3982 157c 7B68     		ldr	r3, [r7, #4]	@ tmp161, string
 3983 157e 1B68     		ldr	r3, [r3]	@ _18, *string_17(D)
 3984 1580 1B78     		ldrb	r3, [r3]	@ zero_extendqisi2	@ _19, *_18
 3985 1582 5B2B     		cmp	r3, #91	@ _19,
 3986 1584 04D0     		beq	.L229	@,
 811:parson.c      ****         json_value_free(output_value);
 3987              		.loc 2 811 0
 3988 1586 7869     		ldr	r0, [r7, #20]	@, output_value
 3989 1588 FFF7FEFF 		bl	json_value_free	@
 812:parson.c      ****         return NULL;
 3990              		.loc 2 812 0
 3991 158c 0023     		movs	r3, #0	@ _1,
 3992 158e 99E0     		b	.L228	@
 3993              	.L229:
 813:parson.c      ****     }
 814:parson.c      ****     output_array = json_value_get_array(output_value);
 3994              		.loc 2 814 0
 3995 1590 7869     		ldr	r0, [r7, #20]	@, output_value
 3996 1592 FFF7FEFF 		bl	json_value_get_array	@
 3997 1596 F860     		str	r0, [r7, #12]	@, output_array
 815:parson.c      ****     SKIP_CHAR(string);
 3998              		.loc 2 815 0
 3999 1598 7B68     		ldr	r3, [r7, #4]	@ tmp162, string
 4000 159a 1B68     		ldr	r3, [r3]	@ _24, *string_17(D)
 4001 159c 5A1C     		adds	r2, r3, #1	@ _25, _24,
 4002 159e 7B68     		ldr	r3, [r7, #4]	@ tmp163, string
 4003 15a0 1A60     		str	r2, [r3]	@ _25, *string_17(D)
 816:parson.c      ****     SKIP_WHITESPACES(string);
 4004              		.loc 2 816 0
 4005 15a2 04E0     		b	.L230	@
 4006              	.L231:
 4007              		.loc 2 816 0 is_stmt 0 discriminator 2
 4008 15a4 7B68     		ldr	r3, [r7, #4]	@ tmp164, string
 4009 15a6 1B68     		ldr	r3, [r3]	@ _32, *string_17(D)
 4010 15a8 5A1C     		adds	r2, r3, #1	@ _33, _32,
 4011 15aa 7B68     		ldr	r3, [r7, #4]	@ tmp165, string
 4012 15ac 1A60     		str	r2, [r3]	@ _33, *string_17(D)
 4013              	.L230:
 4014              		.loc 2 816 0 discriminator 1
 4015 15ae 7B68     		ldr	r3, [r7, #4]	@ tmp166, string
 4016 15b0 1B68     		ldr	r3, [r3]	@ _27, *string_17(D)
 4017 15b2 1B78     		ldrb	r3, [r3]	@ zero_extendqisi2	@ _28, *_27
 4018 15b4 1846     		mov	r0, r3	@, _29
 4019 15b6 FEF723FD 		bl	__isspace	@
 4020 15ba 0346     		mov	r3, r0	@ _31,
 4021 15bc 002B     		cmp	r3, #0	@ _31,
 4022 15be F1D1     		bne	.L231	@,
 817:parson.c      ****     if (**string == ']') { /* empty array */
 4023              		.loc 2 817 0 is_stmt 1
 4024 15c0 7B68     		ldr	r3, [r7, #4]	@ tmp167, string
 4025 15c2 1B68     		ldr	r3, [r3]	@ _35, *string_17(D)
 4026 15c4 1B78     		ldrb	r3, [r3]	@ zero_extendqisi2	@ _36, *_35
 4027 15c6 5D2B     		cmp	r3, #93	@ _36,
 4028 15c8 4AD1     		bne	.L233	@,
 818:parson.c      ****         SKIP_CHAR(string);
 4029              		.loc 2 818 0
 4030 15ca 7B68     		ldr	r3, [r7, #4]	@ tmp168, string
 4031 15cc 1B68     		ldr	r3, [r3]	@ _37, *string_17(D)
 4032 15ce 5A1C     		adds	r2, r3, #1	@ _38, _37,
 4033 15d0 7B68     		ldr	r3, [r7, #4]	@ tmp169, string
 4034 15d2 1A60     		str	r2, [r3]	@ _38, *string_17(D)
 819:parson.c      ****         return output_value;
 4035              		.loc 2 819 0
 4036 15d4 7B69     		ldr	r3, [r7, #20]	@ _1, output_value
 4037 15d6 75E0     		b	.L228	@
 4038              	.L242:
 820:parson.c      ****     }
 821:parson.c      ****     while (**string != '\0') {
 822:parson.c      ****         new_array_value = parse_value(string, nesting);
 4039              		.loc 2 822 0
 4040 15d8 3968     		ldr	r1, [r7]	@, nesting
 4041 15da 7868     		ldr	r0, [r7, #4]	@, string
 4042 15dc FFF7B5FD 		bl	parse_value	@
 4043 15e0 3861     		str	r0, [r7, #16]	@, new_array_value
 823:parson.c      ****         if (new_array_value == NULL) {
 4044              		.loc 2 823 0
 4045 15e2 3B69     		ldr	r3, [r7, #16]	@ tmp170, new_array_value
 4046 15e4 002B     		cmp	r3, #0	@ tmp170,
 4047 15e6 04D1     		bne	.L234	@,
 824:parson.c      ****             json_value_free(output_value);
 4048              		.loc 2 824 0
 4049 15e8 7869     		ldr	r0, [r7, #20]	@, output_value
 4050 15ea FFF7FEFF 		bl	json_value_free	@
 825:parson.c      ****             return NULL;
 4051              		.loc 2 825 0
 4052 15ee 0023     		movs	r3, #0	@ _1,
 4053 15f0 68E0     		b	.L228	@
 4054              	.L234:
 826:parson.c      ****         }
 827:parson.c      ****         if (json_array_add(output_array, new_array_value) == JSONFailure) {
 4055              		.loc 2 827 0
 4056 15f2 3969     		ldr	r1, [r7, #16]	@, new_array_value
 4057 15f4 F868     		ldr	r0, [r7, #12]	@, output_array
 4058 15f6 FFF734FA 		bl	json_array_add	@
 4059 15fa 0346     		mov	r3, r0	@ _47,
 4060 15fc B3F1FF3F 		cmp	r3, #-1	@ _47,
 4061 1600 0CD1     		bne	.L236	@,
 828:parson.c      ****             json_value_free(new_array_value);
 4062              		.loc 2 828 0
 4063 1602 3869     		ldr	r0, [r7, #16]	@, new_array_value
 4064 1604 FFF7FEFF 		bl	json_value_free	@
 829:parson.c      ****             json_value_free(output_value);
 4065              		.loc 2 829 0
 4066 1608 7869     		ldr	r0, [r7, #20]	@, output_value
 4067 160a FFF7FEFF 		bl	json_value_free	@
 830:parson.c      ****             return NULL;
 4068              		.loc 2 830 0
 4069 160e 0023     		movs	r3, #0	@ _1,
 4070 1610 58E0     		b	.L228	@
 4071              	.L237:
 831:parson.c      ****         }
 832:parson.c      ****         SKIP_WHITESPACES(string);
 4072              		.loc 2 832 0 discriminator 2
 4073 1612 7B68     		ldr	r3, [r7, #4]	@ tmp171, string
 4074 1614 1B68     		ldr	r3, [r3]	@ _53, *string_17(D)
 4075 1616 5A1C     		adds	r2, r3, #1	@ _54, _53,
 4076 1618 7B68     		ldr	r3, [r7, #4]	@ tmp172, string
 4077 161a 1A60     		str	r2, [r3]	@ _54, *string_17(D)
 4078              	.L236:
 4079              		.loc 2 832 0 is_stmt 0 discriminator 1
 4080 161c 7B68     		ldr	r3, [r7, #4]	@ tmp173, string
 4081 161e 1B68     		ldr	r3, [r3]	@ _48, *string_17(D)
 4082 1620 1B78     		ldrb	r3, [r3]	@ zero_extendqisi2	@ _49, *_48
 4083 1622 1846     		mov	r0, r3	@, _50
 4084 1624 FEF7ECFC 		bl	__isspace	@
 4085 1628 0346     		mov	r3, r0	@ _52,
 4086 162a 002B     		cmp	r3, #0	@ _52,
 4087 162c F1D1     		bne	.L237	@,
 833:parson.c      ****         if (**string != ',') {
 4088              		.loc 2 833 0 is_stmt 1
 4089 162e 7B68     		ldr	r3, [r7, #4]	@ tmp174, string
 4090 1630 1B68     		ldr	r3, [r3]	@ _56, *string_17(D)
 4091 1632 1B78     		ldrb	r3, [r3]	@ zero_extendqisi2	@ _57, *_56
 4092 1634 2C2B     		cmp	r3, #44	@ _57,
 4093 1636 19D1     		bne	.L247	@,
 834:parson.c      ****             break;
 835:parson.c      ****         }
 836:parson.c      ****         SKIP_CHAR(string);
 4094              		.loc 2 836 0
 4095 1638 7B68     		ldr	r3, [r7, #4]	@ tmp175, string
 4096 163a 1B68     		ldr	r3, [r3]	@ _58, *string_17(D)
 4097 163c 5A1C     		adds	r2, r3, #1	@ _59, _58,
 4098 163e 7B68     		ldr	r3, [r7, #4]	@ tmp176, string
 4099 1640 1A60     		str	r2, [r3]	@ _59, *string_17(D)
 837:parson.c      ****         SKIP_WHITESPACES(string);
 4100              		.loc 2 837 0
 4101 1642 04E0     		b	.L240	@
 4102              	.L241:
 4103              		.loc 2 837 0 is_stmt 0 discriminator 2
 4104 1644 7B68     		ldr	r3, [r7, #4]	@ tmp177, string
 4105 1646 1B68     		ldr	r3, [r3]	@ _66, *string_17(D)
 4106 1648 5A1C     		adds	r2, r3, #1	@ _67, _66,
 4107 164a 7B68     		ldr	r3, [r7, #4]	@ tmp178, string
 4108 164c 1A60     		str	r2, [r3]	@ _67, *string_17(D)
 4109              	.L240:
 4110              		.loc 2 837 0 discriminator 1
 4111 164e 7B68     		ldr	r3, [r7, #4]	@ tmp179, string
 4112 1650 1B68     		ldr	r3, [r3]	@ _61, *string_17(D)
 4113 1652 1B78     		ldrb	r3, [r3]	@ zero_extendqisi2	@ _62, *_61
 4114 1654 1846     		mov	r0, r3	@, _63
 4115 1656 FEF7D3FC 		bl	__isspace	@
 4116 165a 0346     		mov	r3, r0	@ _65,
 4117 165c 002B     		cmp	r3, #0	@ _65,
 4118 165e F1D1     		bne	.L241	@,
 4119              	.L233:
 821:parson.c      ****         new_array_value = parse_value(string, nesting);
 4120              		.loc 2 821 0 is_stmt 1
 4121 1660 7B68     		ldr	r3, [r7, #4]	@ tmp180, string
 4122 1662 1B68     		ldr	r3, [r3]	@ _41, *string_17(D)
 4123 1664 1B78     		ldrb	r3, [r3]	@ zero_extendqisi2	@ _42, *_41
 4124 1666 002B     		cmp	r3, #0	@ _42,
 4125 1668 B6D1     		bne	.L242	@,
 4126 166a 06E0     		b	.L243	@
 4127              	.L247:
 834:parson.c      ****             break;
 4128              		.loc 2 834 0
 4129 166c 00BF     		nop
 838:parson.c      ****     }
 839:parson.c      ****     SKIP_WHITESPACES(string);
 4130              		.loc 2 839 0
 4131 166e 04E0     		b	.L243	@
 4132              	.L244:
 4133              		.loc 2 839 0 is_stmt 0 discriminator 2
 4134 1670 7B68     		ldr	r3, [r7, #4]	@ tmp181, string
 4135 1672 1B68     		ldr	r3, [r3]	@ _79, *string_17(D)
 4136 1674 5A1C     		adds	r2, r3, #1	@ _80, _79,
 4137 1676 7B68     		ldr	r3, [r7, #4]	@ tmp182, string
 4138 1678 1A60     		str	r2, [r3]	@ _80, *string_17(D)
 4139              	.L243:
 4140              		.loc 2 839 0 discriminator 1
 4141 167a 7B68     		ldr	r3, [r7, #4]	@ tmp183, string
 4142 167c 1B68     		ldr	r3, [r3]	@ _74, *string_17(D)
 4143 167e 1B78     		ldrb	r3, [r3]	@ zero_extendqisi2	@ _75, *_74
 4144 1680 1846     		mov	r0, r3	@, _76
 4145 1682 FEF7BDFC 		bl	__isspace	@
 4146 1686 0346     		mov	r3, r0	@ _78,
 4147 1688 002B     		cmp	r3, #0	@ _78,
 4148 168a F1D1     		bne	.L244	@,
 840:parson.c      ****     if (**string != ']' || /* Trim array after parsing is over */
 4149              		.loc 2 840 0 is_stmt 1
 4150 168c 7B68     		ldr	r3, [r7, #4]	@ tmp184, string
 4151 168e 1B68     		ldr	r3, [r3]	@ _82, *string_17(D)
 4152 1690 1B78     		ldrb	r3, [r3]	@ zero_extendqisi2	@ _83, *_82
 4153 1692 5D2B     		cmp	r3, #93	@ _83,
 4154 1694 0BD1     		bne	.L245	@,
 841:parson.c      ****         json_array_resize(output_array, json_array_get_count(output_array)) == JSONFailure) {
 4155              		.loc 2 841 0 discriminator 1
 4156 1696 F868     		ldr	r0, [r7, #12]	@, output_array
 4157 1698 FFF7FEFF 		bl	json_array_get_count	@
 4158 169c 0346     		mov	r3, r0	@ _85,
 4159 169e 1946     		mov	r1, r3	@, _85
 4160 16a0 F868     		ldr	r0, [r7, #12]	@, output_array
 4161 16a2 FFF713FA 		bl	json_array_resize	@
 4162 16a6 0346     		mov	r3, r0	@ _87,
 840:parson.c      ****     if (**string != ']' || /* Trim array after parsing is over */
 4163              		.loc 2 840 0 discriminator 1
 4164 16a8 B3F1FF3F 		cmp	r3, #-1	@ _87,
 4165 16ac 04D1     		bne	.L246	@,
 4166              	.L245:
 842:parson.c      ****         json_value_free(output_value);
 4167              		.loc 2 842 0
 4168 16ae 7869     		ldr	r0, [r7, #20]	@, output_value
 4169 16b0 FFF7FEFF 		bl	json_value_free	@
 843:parson.c      ****         return NULL;
 4170              		.loc 2 843 0
 4171 16b4 0023     		movs	r3, #0	@ _1,
 4172 16b6 05E0     		b	.L228	@
 4173              	.L246:
 844:parson.c      ****     }
 845:parson.c      ****     SKIP_CHAR(string);
 4174              		.loc 2 845 0
 4175 16b8 7B68     		ldr	r3, [r7, #4]	@ tmp185, string
 4176 16ba 1B68     		ldr	r3, [r3]	@ _88, *string_17(D)
 4177 16bc 5A1C     		adds	r2, r3, #1	@ _89, _88,
 4178 16be 7B68     		ldr	r3, [r7, #4]	@ tmp186, string
 4179 16c0 1A60     		str	r2, [r3]	@ _89, *string_17(D)
 846:parson.c      ****     return output_value;
 4180              		.loc 2 846 0
 4181 16c2 7B69     		ldr	r3, [r7, #20]	@ _1, output_value
 4182              	.L228:
 847:parson.c      **** }
 4183              		.loc 2 847 0
 4184 16c4 1846     		mov	r0, r3	@, <retval>
 4185 16c6 1837     		adds	r7, r7, #24	@,,
 4186              	.LCFI152:
 4187              		.cfi_def_cfa_offset 8
 4188 16c8 BD46     		mov	sp, r7	@,
 4189              	.LCFI153:
 4190              		.cfi_def_cfa_register 13
 4191              		@ sp needed	@
 4192 16ca 80BD     		pop	{r7, pc}	@
 4193              		.cfi_endproc
 4194              	.LFE46:
 4196              		.align	1
 4197              		.syntax unified
 4198              		.thumb
 4199              		.thumb_func
 4200              		.fpu neon
 4202              	parse_string_value:
 4203              	.LFB47:
 848:parson.c      **** 
 849:parson.c      **** static JSON_Value *parse_string_value(const char **string)
 850:parson.c      **** {
 4204              		.loc 2 850 0
 4205              		.cfi_startproc
 4206              		@ args = 0, pretend = 0, frame = 16
 4207              		@ frame_needed = 1, uses_anonymous_args = 0
 4208 16cc 80B5     		push	{r7, lr}	@
 4209              	.LCFI154:
 4210              		.cfi_def_cfa_offset 8
 4211              		.cfi_offset 7, -8
 4212              		.cfi_offset 14, -4
 4213 16ce 84B0     		sub	sp, sp, #16	@,,
 4214              	.LCFI155:
 4215              		.cfi_def_cfa_offset 24
 4216 16d0 00AF     		add	r7, sp, #0	@,,
 4217              	.LCFI156:
 4218              		.cfi_def_cfa_register 7
 4219 16d2 7860     		str	r0, [r7, #4]	@ string, string
 851:parson.c      ****     JSON_Value *value = NULL;
 4220              		.loc 2 851 0
 4221 16d4 0023     		movs	r3, #0	@ tmp113,
 4222 16d6 FB60     		str	r3, [r7, #12]	@ tmp113, value
 852:parson.c      ****     char *new_string = get_quoted_string(string);
 4223              		.loc 2 852 0
 4224 16d8 7868     		ldr	r0, [r7, #4]	@, string
 4225 16da FFF712FD 		bl	get_quoted_string	@
 4226 16de B860     		str	r0, [r7, #8]	@, new_string
 853:parson.c      ****     if (new_string == NULL) {
 4227              		.loc 2 853 0
 4228 16e0 BB68     		ldr	r3, [r7, #8]	@ tmp114, new_string
 4229 16e2 002B     		cmp	r3, #0	@ tmp114,
 4230 16e4 01D1     		bne	.L249	@,
 854:parson.c      ****         return NULL;
 4231              		.loc 2 854 0
 4232 16e6 0023     		movs	r3, #0	@ _1,
 4233 16e8 10E0     		b	.L250	@
 4234              	.L249:
 855:parson.c      ****     }
 856:parson.c      ****     value = json_value_init_string_no_copy(new_string);
 4235              		.loc 2 856 0
 4236 16ea B868     		ldr	r0, [r7, #8]	@, new_string
 4237 16ec FFF75CFA 		bl	json_value_init_string_no_copy	@
 4238 16f0 F860     		str	r0, [r7, #12]	@, value
 857:parson.c      ****     if (value == NULL) {
 4239              		.loc 2 857 0
 4240 16f2 FB68     		ldr	r3, [r7, #12]	@ tmp115, value
 4241 16f4 002B     		cmp	r3, #0	@ tmp115,
 4242 16f6 08D1     		bne	.L251	@,
 858:parson.c      ****         parson_free(new_string);
 4243              		.loc 2 858 0
 4244 16f8 40F20003 		movw	r3, #:lower16:parson_free	@ tmp116,
 4245 16fc C0F20003 		movt	r3, #:upper16:parson_free	@ tmp116,
 4246 1700 1B68     		ldr	r3, [r3]	@ parson_free.86_11, parson_free
 4247 1702 B868     		ldr	r0, [r7, #8]	@, new_string
 4248 1704 9847     		blx	r3	@ parson_free.86_11
 4249              	.LVL26:
 859:parson.c      ****         return NULL;
 4250              		.loc 2 859 0
 4251 1706 0023     		movs	r3, #0	@ _1,
 4252 1708 00E0     		b	.L250	@
 4253              	.L251:
 860:parson.c      ****     }
 861:parson.c      ****     return value;
 4254              		.loc 2 861 0
 4255 170a FB68     		ldr	r3, [r7, #12]	@ _1, value
 4256              	.L250:
 862:parson.c      **** }
 4257              		.loc 2 862 0
 4258 170c 1846     		mov	r0, r3	@, <retval>
 4259 170e 1037     		adds	r7, r7, #16	@,,
 4260              	.LCFI157:
 4261              		.cfi_def_cfa_offset 8
 4262 1710 BD46     		mov	sp, r7	@,
 4263              	.LCFI158:
 4264              		.cfi_def_cfa_register 13
 4265              		@ sp needed	@
 4266 1712 80BD     		pop	{r7, pc}	@
 4267              		.cfi_endproc
 4268              	.LFE47:
 4270              		.section	.rodata
 4271 0007 00       		.align	2
 4272              	.LC2:
 4273 0008 74727565 		.ascii	"true\000"
 4273      00
 4274 000d 000000   		.align	2
 4275              	.LC3:
 4276 0010 66616C73 		.ascii	"false\000"
 4276      6500
 4277              		.text
 4278              		.align	1
 4279              		.syntax unified
 4280              		.thumb
 4281              		.thumb_func
 4282              		.fpu neon
 4284              	parse_boolean_value:
 4285              	.LFB48:
 863:parson.c      **** 
 864:parson.c      **** static JSON_Value *parse_boolean_value(const char **string)
 865:parson.c      **** {
 4286              		.loc 2 865 0
 4287              		.cfi_startproc
 4288              		@ args = 0, pretend = 0, frame = 16
 4289              		@ frame_needed = 1, uses_anonymous_args = 0
 4290 1714 80B5     		push	{r7, lr}	@
 4291              	.LCFI159:
 4292              		.cfi_def_cfa_offset 8
 4293              		.cfi_offset 7, -8
 4294              		.cfi_offset 14, -4
 4295 1716 84B0     		sub	sp, sp, #16	@,,
 4296              	.LCFI160:
 4297              		.cfi_def_cfa_offset 24
 4298 1718 00AF     		add	r7, sp, #0	@,,
 4299              	.LCFI161:
 4300              		.cfi_def_cfa_register 7
 4301 171a 7860     		str	r0, [r7, #4]	@ string, string
 866:parson.c      ****     size_t true_token_size = SIZEOF_TOKEN("true");
 4302              		.loc 2 866 0
 4303 171c 0423     		movs	r3, #4	@ tmp120,
 4304 171e FB60     		str	r3, [r7, #12]	@ tmp120, true_token_size
 867:parson.c      ****     size_t false_token_size = SIZEOF_TOKEN("false");
 4305              		.loc 2 867 0
 4306 1720 0523     		movs	r3, #5	@ tmp121,
 4307 1722 BB60     		str	r3, [r7, #8]	@ tmp121, false_token_size
 868:parson.c      ****     if (strncmp("true", *string, true_token_size) == 0) {
 4308              		.loc 2 868 0
 4309 1724 7B68     		ldr	r3, [r7, #4]	@ tmp122, string
 4310 1726 1B68     		ldr	r3, [r3]	@ _7, *string_6(D)
 4311 1728 FA68     		ldr	r2, [r7, #12]	@, true_token_size
 4312 172a 1946     		mov	r1, r3	@, _7
 4313 172c 40F20000 		movw	r0, #:lower16:.LC2	@,
 4314 1730 C0F20000 		movt	r0, #:upper16:.LC2	@,
 4315 1734 FFF7FEFF 		bl	strncmp	@
 4316 1738 0346     		mov	r3, r0	@ _8,
 4317 173a 002B     		cmp	r3, #0	@ _8,
 4318 173c 0AD1     		bne	.L253	@,
 869:parson.c      ****         *string += true_token_size;
 4319              		.loc 2 869 0
 4320 173e 7B68     		ldr	r3, [r7, #4]	@ tmp123, string
 4321 1740 1A68     		ldr	r2, [r3]	@ _9, *string_6(D)
 4322 1742 FB68     		ldr	r3, [r7, #12]	@ tmp124, true_token_size
 4323 1744 1A44     		add	r2, r2, r3	@ _10, tmp124
 4324 1746 7B68     		ldr	r3, [r7, #4]	@ tmp125, string
 4325 1748 1A60     		str	r2, [r3]	@ _10, *string_6(D)
 870:parson.c      ****         return json_value_init_boolean(1);
 4326              		.loc 2 870 0
 4327 174a 0120     		movs	r0, #1	@,
 4328 174c FFF7FEFF 		bl	json_value_init_boolean	@
 4329 1750 0346     		mov	r3, r0	@ _1,
 4330 1752 18E0     		b	.L254	@
 4331              	.L253:
 871:parson.c      ****     } else if (strncmp("false", *string, false_token_size) == 0) {
 4332              		.loc 2 871 0
 4333 1754 7B68     		ldr	r3, [r7, #4]	@ tmp126, string
 4334 1756 1B68     		ldr	r3, [r3]	@ _14, *string_6(D)
 4335 1758 BA68     		ldr	r2, [r7, #8]	@, false_token_size
 4336 175a 1946     		mov	r1, r3	@, _14
 4337 175c 40F20000 		movw	r0, #:lower16:.LC3	@,
 4338 1760 C0F20000 		movt	r0, #:upper16:.LC3	@,
 4339 1764 FFF7FEFF 		bl	strncmp	@
 4340 1768 0346     		mov	r3, r0	@ _15,
 4341 176a 002B     		cmp	r3, #0	@ _15,
 4342 176c 0AD1     		bne	.L255	@,
 872:parson.c      ****         *string += false_token_size;
 4343              		.loc 2 872 0
 4344 176e 7B68     		ldr	r3, [r7, #4]	@ tmp127, string
 4345 1770 1A68     		ldr	r2, [r3]	@ _16, *string_6(D)
 4346 1772 BB68     		ldr	r3, [r7, #8]	@ tmp128, false_token_size
 4347 1774 1A44     		add	r2, r2, r3	@ _17, tmp128
 4348 1776 7B68     		ldr	r3, [r7, #4]	@ tmp129, string
 4349 1778 1A60     		str	r2, [r3]	@ _17, *string_6(D)
 873:parson.c      ****         return json_value_init_boolean(0);
 4350              		.loc 2 873 0
 4351 177a 0020     		movs	r0, #0	@,
 4352 177c FFF7FEFF 		bl	json_value_init_boolean	@
 4353 1780 0346     		mov	r3, r0	@ _1,
 4354 1782 00E0     		b	.L254	@
 4355              	.L255:
 874:parson.c      ****     }
 875:parson.c      ****     return NULL;
 4356              		.loc 2 875 0
 4357 1784 0023     		movs	r3, #0	@ _1,
 4358              	.L254:
 876:parson.c      **** }
 4359              		.loc 2 876 0
 4360 1786 1846     		mov	r0, r3	@, <retval>
 4361 1788 1037     		adds	r7, r7, #16	@,,
 4362              	.LCFI162:
 4363              		.cfi_def_cfa_offset 8
 4364 178a BD46     		mov	sp, r7	@,
 4365              	.LCFI163:
 4366              		.cfi_def_cfa_register 13
 4367              		@ sp needed	@
 4368 178c 80BD     		pop	{r7, pc}	@
 4369              		.cfi_endproc
 4370              	.LFE48:
 4372              		.align	1
 4373              		.syntax unified
 4374              		.thumb
 4375              		.thumb_func
 4376              		.fpu neon
 4378              	parse_number_value:
 4379              	.LFB49:
 877:parson.c      **** 
 878:parson.c      **** static JSON_Value *parse_number_value(const char **string)
 879:parson.c      **** {
 4380              		.loc 2 879 0
 4381              		.cfi_startproc
 4382              		@ args = 0, pretend = 0, frame = 24
 4383              		@ frame_needed = 1, uses_anonymous_args = 0
 4384 178e 90B5     		push	{r4, r7, lr}	@
 4385              	.LCFI164:
 4386              		.cfi_def_cfa_offset 12
 4387              		.cfi_offset 4, -12
 4388              		.cfi_offset 7, -8
 4389              		.cfi_offset 14, -4
 4390 1790 87B0     		sub	sp, sp, #28	@,,
 4391              	.LCFI165:
 4392              		.cfi_def_cfa_offset 40
 4393 1792 00AF     		add	r7, sp, #0	@,,
 4394              	.LCFI166:
 4395              		.cfi_def_cfa_register 7
 4396 1794 7860     		str	r0, [r7, #4]	@ string, string
 880:parson.c      ****     char *end;
 881:parson.c      ****     double number = 0;
 4397              		.loc 2 881 0
 4398 1796 4FF00003 		mov	r3, #0	@ tmp125,
 4399 179a 4FF00004 		mov	r4, #0	@,
 4400 179e C7E90434 		strd	r3, [r7, #16]	@ tmp125,,
 882:parson.c      ****     errno = 0;
 4401              		.loc 2 882 0
 4402 17a2 FFF7FEFF 		bl	__errno_location	@
 4403 17a6 0246     		mov	r2, r0	@ _7,
 4404 17a8 0023     		movs	r3, #0	@ tmp126,
 4405 17aa 1360     		str	r3, [r2]	@ tmp126, *_7
 883:parson.c      ****     number = strtod(*string, &end);
 4406              		.loc 2 883 0
 4407 17ac 7B68     		ldr	r3, [r7, #4]	@ tmp127, string
 4408 17ae 1B68     		ldr	r3, [r3]	@ _10, *string_9(D)
 4409 17b0 07F10C02 		add	r2, r7, #12	@ tmp128,,
 4410 17b4 1146     		mov	r1, r2	@, tmp128
 4411 17b6 1846     		mov	r0, r3	@, _10
 4412 17b8 FFF7FEFF 		bl	strtod	@
 4413 17bc 87ED040B 		vstr.64	d0, [r7, #16]	@, number
 884:parson.c      ****     if (errno || !is_decimal(*string, (size_t)(end - *string))) {
 4414              		.loc 2 884 0
 4415 17c0 FFF7FEFF 		bl	__errno_location	@
 4416 17c4 0346     		mov	r3, r0	@ _14,
 4417 17c6 1B68     		ldr	r3, [r3]	@ _15, *_14
 4418 17c8 002B     		cmp	r3, #0	@ _15,
 4419 17ca 0DD1     		bne	.L257	@,
 4420              		.loc 2 884 0 is_stmt 0 discriminator 1
 4421 17cc 7B68     		ldr	r3, [r7, #4]	@ tmp129, string
 4422 17ce 1A68     		ldr	r2, [r3]	@ _16, *string_9(D)
 4423 17d0 FB68     		ldr	r3, [r7, #12]	@ end.87_17, end
 4424 17d2 1946     		mov	r1, r3	@ end.88_18, end.87_17
 4425 17d4 7B68     		ldr	r3, [r7, #4]	@ tmp130, string
 4426 17d6 1B68     		ldr	r3, [r3]	@ _19, *string_9(D)
 4427 17d8 CB1A     		subs	r3, r1, r3	@ _21, end.88_18, _20
 4428 17da 1946     		mov	r1, r3	@, _22
 4429 17dc 1046     		mov	r0, r2	@, _16
 4430 17de FEF7F9FD 		bl	is_decimal	@
 4431 17e2 0346     		mov	r3, r0	@ _24,
 4432 17e4 002B     		cmp	r3, #0	@ _24,
 4433 17e6 01D1     		bne	.L258	@,
 4434              	.L257:
 885:parson.c      ****         return NULL;
 4435              		.loc 2 885 0 is_stmt 1
 4436 17e8 0023     		movs	r3, #0	@ _1,
 4437 17ea 07E0     		b	.L260	@
 4438              	.L258:
 886:parson.c      ****     }
 887:parson.c      ****     *string = end;
 4439              		.loc 2 887 0
 4440 17ec FA68     		ldr	r2, [r7, #12]	@ end.89_25, end
 4441 17ee 7B68     		ldr	r3, [r7, #4]	@ tmp131, string
 4442 17f0 1A60     		str	r2, [r3]	@ end.89_25, *string_9(D)
 888:parson.c      ****     return json_value_init_number(number);
 4443              		.loc 2 888 0
 4444 17f2 97ED040B 		vldr.64	d0, [r7, #16]	@, number
 4445 17f6 FFF7FEFF 		bl	json_value_init_number	@
 4446 17fa 0346     		mov	r3, r0	@ _1,
 4447              	.L260:
 889:parson.c      **** }
 4448              		.loc 2 889 0 discriminator 1
 4449 17fc 1846     		mov	r0, r3	@, <retval>
 4450 17fe 1C37     		adds	r7, r7, #28	@,,
 4451              	.LCFI167:
 4452              		.cfi_def_cfa_offset 12
 4453 1800 BD46     		mov	sp, r7	@,
 4454              	.LCFI168:
 4455              		.cfi_def_cfa_register 13
 4456              		@ sp needed	@
 4457 1802 90BD     		pop	{r4, r7, pc}	@
 4458              		.cfi_endproc
 4459              	.LFE49:
 4461              		.section	.rodata
 4462 0016 0000     		.align	2
 4463              	.LC4:
 4464 0018 6E756C6C 		.ascii	"null\000"
 4464      00
 4465              		.text
 4466              		.align	1
 4467              		.syntax unified
 4468              		.thumb
 4469              		.thumb_func
 4470              		.fpu neon
 4472              	parse_null_value:
 4473              	.LFB50:
 890:parson.c      **** 
 891:parson.c      **** static JSON_Value *parse_null_value(const char **string)
 892:parson.c      **** {
 4474              		.loc 2 892 0
 4475              		.cfi_startproc
 4476              		@ args = 0, pretend = 0, frame = 16
 4477              		@ frame_needed = 1, uses_anonymous_args = 0
 4478 1804 80B5     		push	{r7, lr}	@
 4479              	.LCFI169:
 4480              		.cfi_def_cfa_offset 8
 4481              		.cfi_offset 7, -8
 4482              		.cfi_offset 14, -4
 4483 1806 84B0     		sub	sp, sp, #16	@,,
 4484              	.LCFI170:
 4485              		.cfi_def_cfa_offset 24
 4486 1808 00AF     		add	r7, sp, #0	@,,
 4487              	.LCFI171:
 4488              		.cfi_def_cfa_register 7
 4489 180a 7860     		str	r0, [r7, #4]	@ string, string
 893:parson.c      ****     size_t token_size = SIZEOF_TOKEN("null");
 4490              		.loc 2 893 0
 4491 180c 0423     		movs	r3, #4	@ tmp116,
 4492 180e FB60     		str	r3, [r7, #12]	@ tmp116, token_size
 894:parson.c      ****     if (strncmp("null", *string, token_size) == 0) {
 4493              		.loc 2 894 0
 4494 1810 7B68     		ldr	r3, [r7, #4]	@ tmp117, string
 4495 1812 1B68     		ldr	r3, [r3]	@ _6, *string_5(D)
 4496 1814 FA68     		ldr	r2, [r7, #12]	@, token_size
 4497 1816 1946     		mov	r1, r3	@, _6
 4498 1818 40F20000 		movw	r0, #:lower16:.LC4	@,
 4499 181c C0F20000 		movt	r0, #:upper16:.LC4	@,
 4500 1820 FFF7FEFF 		bl	strncmp	@
 4501 1824 0346     		mov	r3, r0	@ _7,
 4502 1826 002B     		cmp	r3, #0	@ _7,
 4503 1828 09D1     		bne	.L262	@,
 895:parson.c      ****         *string += token_size;
 4504              		.loc 2 895 0
 4505 182a 7B68     		ldr	r3, [r7, #4]	@ tmp118, string
 4506 182c 1A68     		ldr	r2, [r3]	@ _8, *string_5(D)
 4507 182e FB68     		ldr	r3, [r7, #12]	@ tmp119, token_size
 4508 1830 1A44     		add	r2, r2, r3	@ _9, tmp119
 4509 1832 7B68     		ldr	r3, [r7, #4]	@ tmp120, string
 4510 1834 1A60     		str	r2, [r3]	@ _9, *string_5(D)
 896:parson.c      ****         return json_value_init_null();
 4511              		.loc 2 896 0
 4512 1836 FFF7FEFF 		bl	json_value_init_null	@
 4513 183a 0346     		mov	r3, r0	@ _1,
 4514 183c 00E0     		b	.L263	@
 4515              	.L262:
 897:parson.c      ****     }
 898:parson.c      ****     return NULL;
 4516              		.loc 2 898 0
 4517 183e 0023     		movs	r3, #0	@ _1,
 4518              	.L263:
 899:parson.c      **** }
 4519              		.loc 2 899 0
 4520 1840 1846     		mov	r0, r3	@, <retval>
 4521 1842 1037     		adds	r7, r7, #16	@,,
 4522              	.LCFI172:
 4523              		.cfi_def_cfa_offset 8
 4524 1844 BD46     		mov	sp, r7	@,
 4525              	.LCFI173:
 4526              		.cfi_def_cfa_register 13
 4527              		@ sp needed	@
 4528 1846 80BD     		pop	{r7, pc}	@
 4529              		.cfi_endproc
 4530              	.LFE50:
 4532              		.section	.rodata
 4533 001d 000000   		.align	2
 4534              	.LC5:
 4535 0020 5B00     		.ascii	"[\000"
 4536 0022 0000     		.align	2
 4537              	.LC6:
 4538 0024 0A00     		.ascii	"\012\000"
 4539 0026 0000     		.align	2
 4540              	.LC7:
 4541 0028 2C00     		.ascii	",\000"
 4542 002a 0000     		.align	2
 4543              	.LC8:
 4544 002c 5D00     		.ascii	"]\000"
 4545 002e 0000     		.align	2
 4546              	.LC9:
 4547 0030 7B00     		.ascii	"{\000"
 4548 0032 0000     		.align	2
 4549              	.LC10:
 4550 0034 3A00     		.ascii	":\000"
 4551 0036 0000     		.align	2
 4552              	.LC11:
 4553 0038 2000     		.ascii	" \000"
 4554 003a 0000     		.align	2
 4555              	.LC12:
 4556 003c 7D00     		.ascii	"}\000"
 4557 003e 0000     		.align	2
 4558              	.LC13:
 4559 0040 25312E31 		.ascii	"%1.17g\000"
 4559      376700
 4560              		.text
 4561              		.align	1
 4562              		.syntax unified
 4563              		.thumb
 4564              		.thumb_func
 4565              		.fpu neon
 4567              	json_serialize_to_buffer_r:
 4568              	.LFB51:
 900:parson.c      **** 
 901:parson.c      **** /* Serialization */
 902:parson.c      **** #define APPEND_STRING(str)                   \
 903:parson.c      ****     do {                                     \
 904:parson.c      ****         written = append_string(buf, (str)); \
 905:parson.c      ****         if (written < 0) {                   \
 906:parson.c      ****             return -1;                       \
 907:parson.c      ****         }                                    \
 908:parson.c      ****         if (buf != NULL) {                   \
 909:parson.c      ****             buf += written;                  \
 910:parson.c      ****         }                                    \
 911:parson.c      ****         written_total += written;            \
 912:parson.c      ****     } while (0)
 913:parson.c      **** 
 914:parson.c      **** #define APPEND_INDENT(level)                   \
 915:parson.c      ****     do {                                       \
 916:parson.c      ****         written = append_indent(buf, (level)); \
 917:parson.c      ****         if (written < 0) {                     \
 918:parson.c      ****             return -1;                         \
 919:parson.c      ****         }                                      \
 920:parson.c      ****         if (buf != NULL) {                     \
 921:parson.c      ****             buf += written;                    \
 922:parson.c      ****         }                                      \
 923:parson.c      ****         written_total += written;              \
 924:parson.c      ****     } while (0)
 925:parson.c      **** 
 926:parson.c      **** static int json_serialize_to_buffer_r(const JSON_Value *value, char *buf, int level, int is_pretty,
 927:parson.c      ****                                       char *num_buf)
 928:parson.c      **** {
 4569              		.loc 2 928 0
 4570              		.cfi_startproc
 4571              		@ args = 4, pretend = 0, frame = 64
 4572              		@ frame_needed = 1, uses_anonymous_args = 0
 4573 1848 90B5     		push	{r4, r7, lr}	@
 4574              	.LCFI174:
 4575              		.cfi_def_cfa_offset 12
 4576              		.cfi_offset 4, -12
 4577              		.cfi_offset 7, -8
 4578              		.cfi_offset 14, -4
 4579 184a 93B0     		sub	sp, sp, #76	@,,
 4580              	.LCFI175:
 4581              		.cfi_def_cfa_offset 88
 4582 184c 02AF     		add	r7, sp, #8	@,,
 4583              	.LCFI176:
 4584              		.cfi_def_cfa 7, 80
 4585 184e F860     		str	r0, [r7, #12]	@ value, value
 4586 1850 B960     		str	r1, [r7, #8]	@ buf, buf
 4587 1852 7A60     		str	r2, [r7, #4]	@ level, level
 4588 1854 3B60     		str	r3, [r7]	@ is_pretty, is_pretty
 929:parson.c      ****     const char *key = NULL, *string = NULL;
 4589              		.loc 2 929 0
 4590 1856 0023     		movs	r3, #0	@ tmp144,
 4591 1858 7B63     		str	r3, [r7, #52]	@ tmp144, key
 4592 185a 0023     		movs	r3, #0	@ tmp145,
 4593 185c 3B63     		str	r3, [r7, #48]	@ tmp145, string
 930:parson.c      ****     JSON_Value *temp_value = NULL;
 4594              		.loc 2 930 0
 4595 185e 0023     		movs	r3, #0	@ tmp146,
 4596 1860 FB62     		str	r3, [r7, #44]	@ tmp146, temp_value
 931:parson.c      ****     JSON_Array *array = NULL;
 4597              		.loc 2 931 0
 4598 1862 0023     		movs	r3, #0	@ tmp147,
 4599 1864 BB62     		str	r3, [r7, #40]	@ tmp147, array
 932:parson.c      ****     JSON_Object *object = NULL;
 4600              		.loc 2 932 0
 4601 1866 0023     		movs	r3, #0	@ tmp148,
 4602 1868 7B62     		str	r3, [r7, #36]	@ tmp148, object
 933:parson.c      ****     size_t i = 0, count = 0;
 4603              		.loc 2 933 0
 4604 186a 0023     		movs	r3, #0	@ tmp149,
 4605 186c FB63     		str	r3, [r7, #60]	@ tmp149, i
 4606 186e 0023     		movs	r3, #0	@ tmp150,
 4607 1870 3B62     		str	r3, [r7, #32]	@ tmp150, count
 934:parson.c      ****     double num = 0.0;
 4608              		.loc 2 934 0
 4609 1872 4FF00003 		mov	r3, #0	@ tmp151,
 4610 1876 4FF00004 		mov	r4, #0	@,
 4611 187a C7E90634 		strd	r3, [r7, #24]	@ tmp151,,
 935:parson.c      ****     int written = -1, written_total = 0;
 4612              		.loc 2 935 0
 4613 187e 4FF0FF33 		mov	r3, #-1	@ tmp152,
 4614 1882 7B61     		str	r3, [r7, #20]	@ tmp152, written
 4615 1884 0023     		movs	r3, #0	@ tmp153,
 4616 1886 BB63     		str	r3, [r7, #56]	@ tmp153, written_total
 936:parson.c      **** 
 937:parson.c      ****     switch (json_value_get_type(value)) {
 4617              		.loc 2 937 0
 4618 1888 F868     		ldr	r0, [r7, #12]	@, value
 4619 188a FFF7FEFF 		bl	json_value_get_type	@
 4620 188e 0346     		mov	r3, r0	@ _77,
 4621 1890 0133     		adds	r3, r3, #1	@ tmp154, _77,
 4622 1892 072B     		cmp	r3, #7	@ tmp154,
 4623 1894 00F2F982 		bhi	.L265	@
 4624 1898 01A2     		adr	r2, .L267	@ tmp361,
 4625 189a 52F823F0 		ldr	pc, [r2, r3, lsl #2]	@ tmp361, tmp154
 4626 189e 00BF     		.p2align 2
 4627              	.L267:
 4628 18a0 851E0000 		.word	.L266+1
 4629 18a4 8B1E0000 		.word	.L265+1
 4630 18a8 4F1E0000 		.word	.L268+1
 4631 18ac 471D0000 		.word	.L269+1
 4632 18b0 011E0000 		.word	.L270+1
 4633 18b4 AD1A0000 		.word	.L271+1
 4634 18b8 C1180000 		.word	.L272+1
 4635 18bc 8B1D0000 		.word	.L273+1
 4636              		.p2align 1
 4637              	.L272:
 938:parson.c      ****     case JSONArray:
 939:parson.c      ****         array = json_value_get_array(value);
 4638              		.loc 2 939 0
 4639 18c0 F868     		ldr	r0, [r7, #12]	@, value
 4640 18c2 FFF7FEFF 		bl	json_value_get_array	@
 4641 18c6 B862     		str	r0, [r7, #40]	@, array
 940:parson.c      ****         count = json_array_get_count(array);
 4642              		.loc 2 940 0
 4643 18c8 B86A     		ldr	r0, [r7, #40]	@, array
 4644 18ca FFF7FEFF 		bl	json_array_get_count	@
 4645 18ce 3862     		str	r0, [r7, #32]	@, count
 941:parson.c      ****         APPEND_STRING("[");
 4646              		.loc 2 941 0
 4647 18d0 40F20001 		movw	r1, #:lower16:.LC5	@,
 4648 18d4 C0F20001 		movt	r1, #:upper16:.LC5	@,
 4649 18d8 B868     		ldr	r0, [r7, #8]	@, buf
 4650 18da 00F0C6FF 		bl	append_string	@
 4651 18de 7861     		str	r0, [r7, #20]	@, written
 4652 18e0 7B69     		ldr	r3, [r7, #20]	@ tmp155, written
 4653 18e2 002B     		cmp	r3, #0	@ tmp155,
 4654 18e4 02DA     		bge	.L274	@,
 4655              		.loc 2 941 0 is_stmt 0 discriminator 1
 4656 18e6 4FF0FF33 		mov	r3, #-1	@ _48,
 4657 18ea D0E2     		b	.L275	@
 4658              	.L274:
 4659              		.loc 2 941 0 discriminator 2
 4660 18ec BB68     		ldr	r3, [r7, #8]	@ tmp156, buf
 4661 18ee 002B     		cmp	r3, #0	@ tmp156,
 4662 18f0 03D0     		beq	.L276	@,
 4663              		.loc 2 941 0 discriminator 3
 4664 18f2 7B69     		ldr	r3, [r7, #20]	@ written.90_86, written
 4665 18f4 BA68     		ldr	r2, [r7, #8]	@ tmp158, buf
 4666 18f6 1344     		add	r3, r3, r2	@ tmp157, tmp158
 4667 18f8 BB60     		str	r3, [r7, #8]	@ tmp157, buf
 4668              	.L276:
 4669              		.loc 2 941 0 discriminator 5
 4670 18fa BA6B     		ldr	r2, [r7, #56]	@ tmp160, written_total
 4671 18fc 7B69     		ldr	r3, [r7, #20]	@ tmp161, written
 4672 18fe 1344     		add	r3, r3, r2	@ tmp159, tmp160
 4673 1900 BB63     		str	r3, [r7, #56]	@ tmp159, written_total
 942:parson.c      ****         if (count > 0 && is_pretty) {
 4674              		.loc 2 942 0 is_stmt 1 discriminator 5
 4675 1902 3B6A     		ldr	r3, [r7, #32]	@ tmp162, count
 4676 1904 002B     		cmp	r3, #0	@ tmp162,
 4677 1906 1BD0     		beq	.L277	@,
 4678              		.loc 2 942 0 is_stmt 0 discriminator 1
 4679 1908 3B68     		ldr	r3, [r7]	@ tmp163, is_pretty
 4680 190a 002B     		cmp	r3, #0	@ tmp163,
 4681 190c 18D0     		beq	.L277	@,
 943:parson.c      ****             APPEND_STRING("\n");
 4682              		.loc 2 943 0 is_stmt 1
 4683 190e 40F20001 		movw	r1, #:lower16:.LC6	@,
 4684 1912 C0F20001 		movt	r1, #:upper16:.LC6	@,
 4685 1916 B868     		ldr	r0, [r7, #8]	@, buf
 4686 1918 00F0A7FF 		bl	append_string	@
 4687 191c 7861     		str	r0, [r7, #20]	@, written
 4688 191e 7B69     		ldr	r3, [r7, #20]	@ tmp164, written
 4689 1920 002B     		cmp	r3, #0	@ tmp164,
 4690 1922 02DA     		bge	.L278	@,
 4691              		.loc 2 943 0 is_stmt 0 discriminator 1
 4692 1924 4FF0FF33 		mov	r3, #-1	@ _48,
 4693 1928 B1E2     		b	.L275	@
 4694              	.L278:
 4695              		.loc 2 943 0 discriminator 2
 4696 192a BB68     		ldr	r3, [r7, #8]	@ tmp165, buf
 4697 192c 002B     		cmp	r3, #0	@ tmp165,
 4698 192e 03D0     		beq	.L279	@,
 4699              		.loc 2 943 0 discriminator 3
 4700 1930 7B69     		ldr	r3, [r7, #20]	@ written.91_93, written
 4701 1932 BA68     		ldr	r2, [r7, #8]	@ tmp167, buf
 4702 1934 1344     		add	r3, r3, r2	@ tmp166, tmp167
 4703 1936 BB60     		str	r3, [r7, #8]	@ tmp166, buf
 4704              	.L279:
 4705              		.loc 2 943 0 discriminator 5
 4706 1938 BA6B     		ldr	r2, [r7, #56]	@ tmp169, written_total
 4707 193a 7B69     		ldr	r3, [r7, #20]	@ tmp170, written
 4708 193c 1344     		add	r3, r3, r2	@ tmp168, tmp169
 4709 193e BB63     		str	r3, [r7, #56]	@ tmp168, written_total
 4710              	.L277:
 944:parson.c      ****         }
 945:parson.c      ****         for (i = 0; i < count; i++) {
 4711              		.loc 2 945 0 is_stmt 1
 4712 1940 0023     		movs	r3, #0	@ tmp171,
 4713 1942 FB63     		str	r3, [r7, #60]	@ tmp171, i
 4714 1944 77E0     		b	.L280	@
 4715              	.L292:
 946:parson.c      ****             if (is_pretty) {
 4716              		.loc 2 946 0
 4717 1946 3B68     		ldr	r3, [r7]	@ tmp172, is_pretty
 4718 1948 002B     		cmp	r3, #0	@ tmp172,
 4719 194a 17D0     		beq	.L281	@,
 947:parson.c      ****                 APPEND_INDENT(level + 1);
 4720              		.loc 2 947 0
 4721 194c 7B68     		ldr	r3, [r7, #4]	@ tmp173, level
 4722 194e 0133     		adds	r3, r3, #1	@ _122, tmp173,
 4723 1950 1946     		mov	r1, r3	@, _122
 4724 1952 B868     		ldr	r0, [r7, #8]	@, buf
 4725 1954 00F057FF 		bl	append_indent	@
 4726 1958 7861     		str	r0, [r7, #20]	@, written
 4727 195a 7B69     		ldr	r3, [r7, #20]	@ tmp174, written
 4728 195c 002B     		cmp	r3, #0	@ tmp174,
 4729 195e 02DA     		bge	.L282	@,
 4730              		.loc 2 947 0 is_stmt 0 discriminator 1
 4731 1960 4FF0FF33 		mov	r3, #-1	@ _48,
 4732 1964 93E2     		b	.L275	@
 4733              	.L282:
 4734              		.loc 2 947 0 discriminator 2
 4735 1966 BB68     		ldr	r3, [r7, #8]	@ tmp175, buf
 4736 1968 002B     		cmp	r3, #0	@ tmp175,
 4737 196a 03D0     		beq	.L283	@,
 4738              		.loc 2 947 0 discriminator 3
 4739 196c 7B69     		ldr	r3, [r7, #20]	@ written.92_125, written
 4740 196e BA68     		ldr	r2, [r7, #8]	@ tmp177, buf
 4741 1970 1344     		add	r3, r3, r2	@ tmp176, tmp177
 4742 1972 BB60     		str	r3, [r7, #8]	@ tmp176, buf
 4743              	.L283:
 4744              		.loc 2 947 0 discriminator 5
 4745 1974 BA6B     		ldr	r2, [r7, #56]	@ tmp179, written_total
 4746 1976 7B69     		ldr	r3, [r7, #20]	@ tmp180, written
 4747 1978 1344     		add	r3, r3, r2	@ tmp178, tmp179
 4748 197a BB63     		str	r3, [r7, #56]	@ tmp178, written_total
 4749              	.L281:
 948:parson.c      ****             }
 949:parson.c      ****             temp_value = json_array_get_value(array, i);
 4750              		.loc 2 949 0 is_stmt 1
 4751 197c F96B     		ldr	r1, [r7, #60]	@, i
 4752 197e B86A     		ldr	r0, [r7, #40]	@, array
 4753 1980 FFF7FEFF 		bl	json_array_get_value	@
 4754 1984 F862     		str	r0, [r7, #44]	@, temp_value
 950:parson.c      ****             written = json_serialize_to_buffer_r(temp_value, buf, level + 1, is_pretty, num_buf);
 4755              		.loc 2 950 0
 4756 1986 7B68     		ldr	r3, [r7, #4]	@ tmp181, level
 4757 1988 5A1C     		adds	r2, r3, #1	@ _100, tmp181,
 4758 198a 3B6D     		ldr	r3, [r7, #80]	@ tmp182, num_buf
 4759 198c 0093     		str	r3, [sp]	@ tmp182,
 4760 198e 3B68     		ldr	r3, [r7]	@, is_pretty
 4761 1990 B968     		ldr	r1, [r7, #8]	@, buf
 4762 1992 F86A     		ldr	r0, [r7, #44]	@, temp_value
 4763 1994 FFF758FF 		bl	json_serialize_to_buffer_r	@
 4764 1998 7861     		str	r0, [r7, #20]	@, written
 951:parson.c      ****             if (written < 0) {
 4765              		.loc 2 951 0
 4766 199a 7B69     		ldr	r3, [r7, #20]	@ tmp183, written
 4767 199c 002B     		cmp	r3, #0	@ tmp183,
 4768 199e 02DA     		bge	.L284	@,
 952:parson.c      ****                 return -1;
 4769              		.loc 2 952 0
 4770 19a0 4FF0FF33 		mov	r3, #-1	@ _48,
 4771 19a4 73E2     		b	.L275	@
 4772              	.L284:
 953:parson.c      ****             }
 954:parson.c      ****             if (buf != NULL) {
 4773              		.loc 2 954 0
 4774 19a6 BB68     		ldr	r3, [r7, #8]	@ tmp184, buf
 4775 19a8 002B     		cmp	r3, #0	@ tmp184,
 4776 19aa 03D0     		beq	.L285	@,
 955:parson.c      ****                 buf += written;
 4777              		.loc 2 955 0
 4778 19ac 7B69     		ldr	r3, [r7, #20]	@ written.93_104, written
 4779 19ae BA68     		ldr	r2, [r7, #8]	@ tmp186, buf
 4780 19b0 1344     		add	r3, r3, r2	@ tmp185, tmp186
 4781 19b2 BB60     		str	r3, [r7, #8]	@ tmp185, buf
 4782              	.L285:
 956:parson.c      ****             }
 957:parson.c      ****             written_total += written;
 4783              		.loc 2 957 0
 4784 19b4 BA6B     		ldr	r2, [r7, #56]	@ tmp188, written_total
 4785 19b6 7B69     		ldr	r3, [r7, #20]	@ tmp189, written
 4786 19b8 1344     		add	r3, r3, r2	@ tmp187, tmp188
 4787 19ba BB63     		str	r3, [r7, #56]	@ tmp187, written_total
 958:parson.c      ****             if (i < (count - 1)) {
 4788              		.loc 2 958 0
 4789 19bc 3B6A     		ldr	r3, [r7, #32]	@ tmp190, count
 4790 19be 5A1E     		subs	r2, r3, #1	@ _107, tmp190,
 4791 19c0 FB6B     		ldr	r3, [r7, #60]	@ tmp191, i
 4792 19c2 9A42     		cmp	r2, r3	@ _107, tmp191
 4793 19c4 18D9     		bls	.L286	@,
 959:parson.c      ****                 APPEND_STRING(",");
 4794              		.loc 2 959 0
 4795 19c6 40F20001 		movw	r1, #:lower16:.LC7	@,
 4796 19ca C0F20001 		movt	r1, #:upper16:.LC7	@,
 4797 19ce B868     		ldr	r0, [r7, #8]	@, buf
 4798 19d0 00F04BFF 		bl	append_string	@
 4799 19d4 7861     		str	r0, [r7, #20]	@, written
 4800 19d6 7B69     		ldr	r3, [r7, #20]	@ tmp192, written
 4801 19d8 002B     		cmp	r3, #0	@ tmp192,
 4802 19da 02DA     		bge	.L287	@,
 4803              		.loc 2 959 0 is_stmt 0 discriminator 1
 4804 19dc 4FF0FF33 		mov	r3, #-1	@ _48,
 4805 19e0 55E2     		b	.L275	@
 4806              	.L287:
 4807              		.loc 2 959 0 discriminator 2
 4808 19e2 BB68     		ldr	r3, [r7, #8]	@ tmp193, buf
 4809 19e4 002B     		cmp	r3, #0	@ tmp193,
 4810 19e6 03D0     		beq	.L288	@,
 4811              		.loc 2 959 0 discriminator 3
 4812 19e8 7B69     		ldr	r3, [r7, #20]	@ written.94_110, written
 4813 19ea BA68     		ldr	r2, [r7, #8]	@ tmp195, buf
 4814 19ec 1344     		add	r3, r3, r2	@ tmp194, tmp195
 4815 19ee BB60     		str	r3, [r7, #8]	@ tmp194, buf
 4816              	.L288:
 4817              		.loc 2 959 0 discriminator 5
 4818 19f0 BA6B     		ldr	r2, [r7, #56]	@ tmp197, written_total
 4819 19f2 7B69     		ldr	r3, [r7, #20]	@ tmp198, written
 4820 19f4 1344     		add	r3, r3, r2	@ tmp196, tmp197
 4821 19f6 BB63     		str	r3, [r7, #56]	@ tmp196, written_total
 4822              	.L286:
 960:parson.c      ****             }
 961:parson.c      ****             if (is_pretty) {
 4823              		.loc 2 961 0 is_stmt 1
 4824 19f8 3B68     		ldr	r3, [r7]	@ tmp199, is_pretty
 4825 19fa 002B     		cmp	r3, #0	@ tmp199,
 4826 19fc 18D0     		beq	.L289	@,
 962:parson.c      ****                 APPEND_STRING("\n");
 4827              		.loc 2 962 0
 4828 19fe 40F20001 		movw	r1, #:lower16:.LC6	@,
 4829 1a02 C0F20001 		movt	r1, #:upper16:.LC6	@,
 4830 1a06 B868     		ldr	r0, [r7, #8]	@, buf
 4831 1a08 00F02FFF 		bl	append_string	@
 4832 1a0c 7861     		str	r0, [r7, #20]	@, written
 4833 1a0e 7B69     		ldr	r3, [r7, #20]	@ tmp200, written
 4834 1a10 002B     		cmp	r3, #0	@ tmp200,
 4835 1a12 02DA     		bge	.L290	@,
 4836              		.loc 2 962 0 is_stmt 0 discriminator 1
 4837 1a14 4FF0FF33 		mov	r3, #-1	@ _48,
 4838 1a18 39E2     		b	.L275	@
 4839              	.L290:
 4840              		.loc 2 962 0 discriminator 2
 4841 1a1a BB68     		ldr	r3, [r7, #8]	@ tmp201, buf
 4842 1a1c 002B     		cmp	r3, #0	@ tmp201,
 4843 1a1e 03D0     		beq	.L291	@,
 4844              		.loc 2 962 0 discriminator 3
 4845 1a20 7B69     		ldr	r3, [r7, #20]	@ written.95_116, written
 4846 1a22 BA68     		ldr	r2, [r7, #8]	@ tmp203, buf
 4847 1a24 1344     		add	r3, r3, r2	@ tmp202, tmp203
 4848 1a26 BB60     		str	r3, [r7, #8]	@ tmp202, buf
 4849              	.L291:
 4850              		.loc 2 962 0 discriminator 5
 4851 1a28 BA6B     		ldr	r2, [r7, #56]	@ tmp205, written_total
 4852 1a2a 7B69     		ldr	r3, [r7, #20]	@ tmp206, written
 4853 1a2c 1344     		add	r3, r3, r2	@ tmp204, tmp205
 4854 1a2e BB63     		str	r3, [r7, #56]	@ tmp204, written_total
 4855              	.L289:
 945:parson.c      ****             if (is_pretty) {
 4856              		.loc 2 945 0 is_stmt 1 discriminator 2
 4857 1a30 FB6B     		ldr	r3, [r7, #60]	@ tmp208, i
 4858 1a32 0133     		adds	r3, r3, #1	@ tmp207, tmp208,
 4859 1a34 FB63     		str	r3, [r7, #60]	@ tmp207, i
 4860              	.L280:
 945:parson.c      ****             if (is_pretty) {
 4861              		.loc 2 945 0 is_stmt 0 discriminator 1
 4862 1a36 FA6B     		ldr	r2, [r7, #60]	@ tmp209, i
 4863 1a38 3B6A     		ldr	r3, [r7, #32]	@ tmp210, count
 4864 1a3a 9A42     		cmp	r2, r3	@ tmp209, tmp210
 4865 1a3c 83D3     		bcc	.L292	@,
 963:parson.c      ****             }
 964:parson.c      ****         }
 965:parson.c      ****         if (count > 0 && is_pretty) {
 4866              		.loc 2 965 0 is_stmt 1
 4867 1a3e 3B6A     		ldr	r3, [r7, #32]	@ tmp211, count
 4868 1a40 002B     		cmp	r3, #0	@ tmp211,
 4869 1a42 18D0     		beq	.L293	@,
 4870              		.loc 2 965 0 is_stmt 0 discriminator 1
 4871 1a44 3B68     		ldr	r3, [r7]	@ tmp212, is_pretty
 4872 1a46 002B     		cmp	r3, #0	@ tmp212,
 4873 1a48 15D0     		beq	.L293	@,
 966:parson.c      ****             APPEND_INDENT(level);
 4874              		.loc 2 966 0 is_stmt 1
 4875 1a4a 7968     		ldr	r1, [r7, #4]	@, level
 4876 1a4c B868     		ldr	r0, [r7, #8]	@, buf
 4877 1a4e 00F0DAFE 		bl	append_indent	@
 4878 1a52 7861     		str	r0, [r7, #20]	@, written
 4879 1a54 7B69     		ldr	r3, [r7, #20]	@ tmp213, written
 4880 1a56 002B     		cmp	r3, #0	@ tmp213,
 4881 1a58 02DA     		bge	.L294	@,
 4882              		.loc 2 966 0 is_stmt 0 discriminator 1
 4883 1a5a 4FF0FF33 		mov	r3, #-1	@ _48,
 4884 1a5e 16E2     		b	.L275	@
 4885              	.L294:
 4886              		.loc 2 966 0 discriminator 2
 4887 1a60 BB68     		ldr	r3, [r7, #8]	@ tmp214, buf
 4888 1a62 002B     		cmp	r3, #0	@ tmp214,
 4889 1a64 03D0     		beq	.L295	@,
 4890              		.loc 2 966 0 discriminator 3
 4891 1a66 7B69     		ldr	r3, [r7, #20]	@ written.96_132, written
 4892 1a68 BA68     		ldr	r2, [r7, #8]	@ tmp216, buf
 4893 1a6a 1344     		add	r3, r3, r2	@ tmp215, tmp216
 4894 1a6c BB60     		str	r3, [r7, #8]	@ tmp215, buf
 4895              	.L295:
 4896              		.loc 2 966 0 discriminator 5
 4897 1a6e BA6B     		ldr	r2, [r7, #56]	@ tmp218, written_total
 4898 1a70 7B69     		ldr	r3, [r7, #20]	@ tmp219, written
 4899 1a72 1344     		add	r3, r3, r2	@ tmp217, tmp218
 4900 1a74 BB63     		str	r3, [r7, #56]	@ tmp217, written_total
 4901              	.L293:
 967:parson.c      ****         }
 968:parson.c      ****         APPEND_STRING("]");
 4902              		.loc 2 968 0 is_stmt 1
 4903 1a76 40F20001 		movw	r1, #:lower16:.LC8	@,
 4904 1a7a C0F20001 		movt	r1, #:upper16:.LC8	@,
 4905 1a7e B868     		ldr	r0, [r7, #8]	@, buf
 4906 1a80 00F0F3FE 		bl	append_string	@
 4907 1a84 7861     		str	r0, [r7, #20]	@, written
 4908 1a86 7B69     		ldr	r3, [r7, #20]	@ tmp220, written
 4909 1a88 002B     		cmp	r3, #0	@ tmp220,
 4910 1a8a 02DA     		bge	.L296	@,
 4911              		.loc 2 968 0 is_stmt 0 discriminator 1
 4912 1a8c 4FF0FF33 		mov	r3, #-1	@ _48,
 4913 1a90 FDE1     		b	.L275	@
 4914              	.L296:
 4915              		.loc 2 968 0 discriminator 2
 4916 1a92 BB68     		ldr	r3, [r7, #8]	@ tmp221, buf
 4917 1a94 002B     		cmp	r3, #0	@ tmp221,
 4918 1a96 03D0     		beq	.L297	@,
 4919              		.loc 2 968 0 discriminator 3
 4920 1a98 7B69     		ldr	r3, [r7, #20]	@ written.97_138, written
 4921 1a9a BA68     		ldr	r2, [r7, #8]	@ tmp223, buf
 4922 1a9c 1344     		add	r3, r3, r2	@ tmp222, tmp223
 4923 1a9e BB60     		str	r3, [r7, #8]	@ tmp222, buf
 4924              	.L297:
 4925              		.loc 2 968 0 discriminator 5
 4926 1aa0 BA6B     		ldr	r2, [r7, #56]	@ tmp225, written_total
 4927 1aa2 7B69     		ldr	r3, [r7, #20]	@ tmp226, written
 4928 1aa4 1344     		add	r3, r3, r2	@ tmp224, tmp225
 4929 1aa6 BB63     		str	r3, [r7, #56]	@ tmp224, written_total
 969:parson.c      ****         return written_total;
 4930              		.loc 2 969 0 is_stmt 1 discriminator 5
 4931 1aa8 BB6B     		ldr	r3, [r7, #56]	@ _48, written_total
 4932 1aaa F0E1     		b	.L275	@
 4933              	.L271:
 970:parson.c      ****     case JSONObject:
 971:parson.c      ****         object = json_value_get_object(value);
 4934              		.loc 2 971 0
 4935 1aac F868     		ldr	r0, [r7, #12]	@, value
 4936 1aae FFF7FEFF 		bl	json_value_get_object	@
 4937 1ab2 7862     		str	r0, [r7, #36]	@, object
 972:parson.c      ****         count = json_object_get_count(object);
 4938              		.loc 2 972 0
 4939 1ab4 786A     		ldr	r0, [r7, #36]	@, object
 4940 1ab6 FFF7FEFF 		bl	json_object_get_count	@
 4941 1aba 3862     		str	r0, [r7, #32]	@, count
 973:parson.c      ****         APPEND_STRING("{");
 4942              		.loc 2 973 0
 4943 1abc 40F20001 		movw	r1, #:lower16:.LC9	@,
 4944 1ac0 C0F20001 		movt	r1, #:upper16:.LC9	@,
 4945 1ac4 B868     		ldr	r0, [r7, #8]	@, buf
 4946 1ac6 00F0D0FE 		bl	append_string	@
 4947 1aca 7861     		str	r0, [r7, #20]	@, written
 4948 1acc 7B69     		ldr	r3, [r7, #20]	@ tmp227, written
 4949 1ace 002B     		cmp	r3, #0	@ tmp227,
 4950 1ad0 02DA     		bge	.L298	@,
 4951              		.loc 2 973 0 is_stmt 0 discriminator 1
 4952 1ad2 4FF0FF33 		mov	r3, #-1	@ _48,
 4953 1ad6 DAE1     		b	.L275	@
 4954              	.L298:
 4955              		.loc 2 973 0 discriminator 2
 4956 1ad8 BB68     		ldr	r3, [r7, #8]	@ tmp228, buf
 4957 1ada 002B     		cmp	r3, #0	@ tmp228,
 4958 1adc 03D0     		beq	.L299	@,
 4959              		.loc 2 973 0 discriminator 3
 4960 1ade 7B69     		ldr	r3, [r7, #20]	@ written.98_149, written
 4961 1ae0 BA68     		ldr	r2, [r7, #8]	@ tmp230, buf
 4962 1ae2 1344     		add	r3, r3, r2	@ tmp229, tmp230
 4963 1ae4 BB60     		str	r3, [r7, #8]	@ tmp229, buf
 4964              	.L299:
 4965              		.loc 2 973 0 discriminator 5
 4966 1ae6 BA6B     		ldr	r2, [r7, #56]	@ tmp232, written_total
 4967 1ae8 7B69     		ldr	r3, [r7, #20]	@ tmp233, written
 4968 1aea 1344     		add	r3, r3, r2	@ tmp231, tmp232
 4969 1aec BB63     		str	r3, [r7, #56]	@ tmp231, written_total
 974:parson.c      ****         if (count > 0 && is_pretty) {
 4970              		.loc 2 974 0 is_stmt 1 discriminator 5
 4971 1aee 3B6A     		ldr	r3, [r7, #32]	@ tmp234, count
 4972 1af0 002B     		cmp	r3, #0	@ tmp234,
 4973 1af2 1BD0     		beq	.L300	@,
 4974              		.loc 2 974 0 is_stmt 0 discriminator 1
 4975 1af4 3B68     		ldr	r3, [r7]	@ tmp235, is_pretty
 4976 1af6 002B     		cmp	r3, #0	@ tmp235,
 4977 1af8 18D0     		beq	.L300	@,
 975:parson.c      ****             APPEND_STRING("\n");
 4978              		.loc 2 975 0 is_stmt 1
 4979 1afa 40F20001 		movw	r1, #:lower16:.LC6	@,
 4980 1afe C0F20001 		movt	r1, #:upper16:.LC6	@,
 4981 1b02 B868     		ldr	r0, [r7, #8]	@, buf
 4982 1b04 00F0B1FE 		bl	append_string	@
 4983 1b08 7861     		str	r0, [r7, #20]	@, written
 4984 1b0a 7B69     		ldr	r3, [r7, #20]	@ tmp236, written
 4985 1b0c 002B     		cmp	r3, #0	@ tmp236,
 4986 1b0e 02DA     		bge	.L301	@,
 4987              		.loc 2 975 0 is_stmt 0 discriminator 1
 4988 1b10 4FF0FF33 		mov	r3, #-1	@ _48,
 4989 1b14 BBE1     		b	.L275	@
 4990              	.L301:
 4991              		.loc 2 975 0 discriminator 2
 4992 1b16 BB68     		ldr	r3, [r7, #8]	@ tmp237, buf
 4993 1b18 002B     		cmp	r3, #0	@ tmp237,
 4994 1b1a 03D0     		beq	.L302	@,
 4995              		.loc 2 975 0 discriminator 3
 4996 1b1c 7B69     		ldr	r3, [r7, #20]	@ written.99_155, written
 4997 1b1e BA68     		ldr	r2, [r7, #8]	@ tmp239, buf
 4998 1b20 1344     		add	r3, r3, r2	@ tmp238, tmp239
 4999 1b22 BB60     		str	r3, [r7, #8]	@ tmp238, buf
 5000              	.L302:
 5001              		.loc 2 975 0 discriminator 5
 5002 1b24 BA6B     		ldr	r2, [r7, #56]	@ tmp241, written_total
 5003 1b26 7B69     		ldr	r3, [r7, #20]	@ tmp242, written
 5004 1b28 1344     		add	r3, r3, r2	@ tmp240, tmp241
 5005 1b2a BB63     		str	r3, [r7, #56]	@ tmp240, written_total
 5006              	.L300:
 976:parson.c      ****         }
 977:parson.c      ****         for (i = 0; i < count; i++) {
 5007              		.loc 2 977 0 is_stmt 1
 5008 1b2c 0023     		movs	r3, #0	@ tmp243,
 5009 1b2e FB63     		str	r3, [r7, #60]	@ tmp243, i
 5010 1b30 CDE0     		b	.L303	@
 5011              	.L323:
 978:parson.c      ****             key = json_object_get_name(object, i);
 5012              		.loc 2 978 0
 5013 1b32 F96B     		ldr	r1, [r7, #60]	@, i
 5014 1b34 786A     		ldr	r0, [r7, #36]	@, object
 5015 1b36 FFF7FEFF 		bl	json_object_get_name	@
 5016 1b3a 7863     		str	r0, [r7, #52]	@, key
 979:parson.c      ****             if (key == NULL) {
 5017              		.loc 2 979 0
 5018 1b3c 7B6B     		ldr	r3, [r7, #52]	@ tmp244, key
 5019 1b3e 002B     		cmp	r3, #0	@ tmp244,
 5020 1b40 02D1     		bne	.L304	@,
 980:parson.c      ****                 return -1;
 5021              		.loc 2 980 0
 5022 1b42 4FF0FF33 		mov	r3, #-1	@ _48,
 5023 1b46 A2E1     		b	.L275	@
 5024              	.L304:
 981:parson.c      ****             }
 982:parson.c      ****             if (is_pretty) {
 5025              		.loc 2 982 0
 5026 1b48 3B68     		ldr	r3, [r7]	@ tmp245, is_pretty
 5027 1b4a 002B     		cmp	r3, #0	@ tmp245,
 5028 1b4c 17D0     		beq	.L305	@,
 983:parson.c      ****                 APPEND_INDENT(level + 1);
 5029              		.loc 2 983 0
 5030 1b4e 7B68     		ldr	r3, [r7, #4]	@ tmp246, level
 5031 1b50 0133     		adds	r3, r3, #1	@ _161, tmp246,
 5032 1b52 1946     		mov	r1, r3	@, _161
 5033 1b54 B868     		ldr	r0, [r7, #8]	@, buf
 5034 1b56 00F056FE 		bl	append_indent	@
 5035 1b5a 7861     		str	r0, [r7, #20]	@, written
 5036 1b5c 7B69     		ldr	r3, [r7, #20]	@ tmp247, written
 5037 1b5e 002B     		cmp	r3, #0	@ tmp247,
 5038 1b60 02DA     		bge	.L306	@,
 5039              		.loc 2 983 0 is_stmt 0 discriminator 1
 5040 1b62 4FF0FF33 		mov	r3, #-1	@ _48,
 5041 1b66 92E1     		b	.L275	@
 5042              	.L306:
 5043              		.loc 2 983 0 discriminator 2
 5044 1b68 BB68     		ldr	r3, [r7, #8]	@ tmp248, buf
 5045 1b6a 002B     		cmp	r3, #0	@ tmp248,
 5046 1b6c 03D0     		beq	.L307	@,
 5047              		.loc 2 983 0 discriminator 3
 5048 1b6e 7B69     		ldr	r3, [r7, #20]	@ written.100_164, written
 5049 1b70 BA68     		ldr	r2, [r7, #8]	@ tmp250, buf
 5050 1b72 1344     		add	r3, r3, r2	@ tmp249, tmp250
 5051 1b74 BB60     		str	r3, [r7, #8]	@ tmp249, buf
 5052              	.L307:
 5053              		.loc 2 983 0 discriminator 5
 5054 1b76 BA6B     		ldr	r2, [r7, #56]	@ tmp252, written_total
 5055 1b78 7B69     		ldr	r3, [r7, #20]	@ tmp253, written
 5056 1b7a 1344     		add	r3, r3, r2	@ tmp251, tmp252
 5057 1b7c BB63     		str	r3, [r7, #56]	@ tmp251, written_total
 5058              	.L305:
 984:parson.c      ****             }
 985:parson.c      ****             written = json_serialize_string(key, buf);
 5059              		.loc 2 985 0 is_stmt 1
 5060 1b7e B968     		ldr	r1, [r7, #8]	@, buf
 5061 1b80 786B     		ldr	r0, [r7, #52]	@, key
 5062 1b82 00F088F9 		bl	json_serialize_string	@
 5063 1b86 7861     		str	r0, [r7, #20]	@, written
 986:parson.c      ****             if (written < 0) {
 5064              		.loc 2 986 0
 5065 1b88 7B69     		ldr	r3, [r7, #20]	@ tmp254, written
 5066 1b8a 002B     		cmp	r3, #0	@ tmp254,
 5067 1b8c 02DA     		bge	.L308	@,
 987:parson.c      ****                 return -1;
 5068              		.loc 2 987 0
 5069 1b8e 4FF0FF33 		mov	r3, #-1	@ _48,
 5070 1b92 7CE1     		b	.L275	@
 5071              	.L308:
 988:parson.c      ****             }
 989:parson.c      ****             if (buf != NULL) {
 5072              		.loc 2 989 0
 5073 1b94 BB68     		ldr	r3, [r7, #8]	@ tmp255, buf
 5074 1b96 002B     		cmp	r3, #0	@ tmp255,
 5075 1b98 03D0     		beq	.L309	@,
 990:parson.c      ****                 buf += written;
 5076              		.loc 2 990 0
 5077 1b9a 7B69     		ldr	r3, [r7, #20]	@ written.101_170, written
 5078 1b9c BA68     		ldr	r2, [r7, #8]	@ tmp257, buf
 5079 1b9e 1344     		add	r3, r3, r2	@ tmp256, tmp257
 5080 1ba0 BB60     		str	r3, [r7, #8]	@ tmp256, buf
 5081              	.L309:
 991:parson.c      ****             }
 992:parson.c      ****             written_total += written;
 5082              		.loc 2 992 0
 5083 1ba2 BA6B     		ldr	r2, [r7, #56]	@ tmp259, written_total
 5084 1ba4 7B69     		ldr	r3, [r7, #20]	@ tmp260, written
 5085 1ba6 1344     		add	r3, r3, r2	@ tmp258, tmp259
 5086 1ba8 BB63     		str	r3, [r7, #56]	@ tmp258, written_total
 993:parson.c      ****             APPEND_STRING(":");
 5087              		.loc 2 993 0
 5088 1baa 40F20001 		movw	r1, #:lower16:.LC10	@,
 5089 1bae C0F20001 		movt	r1, #:upper16:.LC10	@,
 5090 1bb2 B868     		ldr	r0, [r7, #8]	@, buf
 5091 1bb4 00F059FE 		bl	append_string	@
 5092 1bb8 7861     		str	r0, [r7, #20]	@, written
 5093 1bba 7B69     		ldr	r3, [r7, #20]	@ tmp261, written
 5094 1bbc 002B     		cmp	r3, #0	@ tmp261,
 5095 1bbe 02DA     		bge	.L310	@,
 5096              		.loc 2 993 0 is_stmt 0 discriminator 1
 5097 1bc0 4FF0FF33 		mov	r3, #-1	@ _48,
 5098 1bc4 63E1     		b	.L275	@
 5099              	.L310:
 5100              		.loc 2 993 0 discriminator 2
 5101 1bc6 BB68     		ldr	r3, [r7, #8]	@ tmp262, buf
 5102 1bc8 002B     		cmp	r3, #0	@ tmp262,
 5103 1bca 03D0     		beq	.L311	@,
 5104              		.loc 2 993 0 discriminator 3
 5105 1bcc 7B69     		ldr	r3, [r7, #20]	@ written.102_175, written
 5106 1bce BA68     		ldr	r2, [r7, #8]	@ tmp264, buf
 5107 1bd0 1344     		add	r3, r3, r2	@ tmp263, tmp264
 5108 1bd2 BB60     		str	r3, [r7, #8]	@ tmp263, buf
 5109              	.L311:
 5110              		.loc 2 993 0 discriminator 5
 5111 1bd4 BA6B     		ldr	r2, [r7, #56]	@ tmp266, written_total
 5112 1bd6 7B69     		ldr	r3, [r7, #20]	@ tmp267, written
 5113 1bd8 1344     		add	r3, r3, r2	@ tmp265, tmp266
 5114 1bda BB63     		str	r3, [r7, #56]	@ tmp265, written_total
 994:parson.c      ****             if (is_pretty) {
 5115              		.loc 2 994 0 is_stmt 1 discriminator 5
 5116 1bdc 3B68     		ldr	r3, [r7]	@ tmp268, is_pretty
 5117 1bde 002B     		cmp	r3, #0	@ tmp268,
 5118 1be0 18D0     		beq	.L312	@,
 995:parson.c      ****                 APPEND_STRING(" ");
 5119              		.loc 2 995 0
 5120 1be2 40F20001 		movw	r1, #:lower16:.LC11	@,
 5121 1be6 C0F20001 		movt	r1, #:upper16:.LC11	@,
 5122 1bea B868     		ldr	r0, [r7, #8]	@, buf
 5123 1bec 00F03DFE 		bl	append_string	@
 5124 1bf0 7861     		str	r0, [r7, #20]	@, written
 5125 1bf2 7B69     		ldr	r3, [r7, #20]	@ tmp269, written
 5126 1bf4 002B     		cmp	r3, #0	@ tmp269,
 5127 1bf6 02DA     		bge	.L313	@,
 5128              		.loc 2 995 0 is_stmt 0 discriminator 1
 5129 1bf8 4FF0FF33 		mov	r3, #-1	@ _48,
 5130 1bfc 47E1     		b	.L275	@
 5131              	.L313:
 5132              		.loc 2 995 0 discriminator 2
 5133 1bfe BB68     		ldr	r3, [r7, #8]	@ tmp270, buf
 5134 1c00 002B     		cmp	r3, #0	@ tmp270,
 5135 1c02 03D0     		beq	.L314	@,
 5136              		.loc 2 995 0 discriminator 3
 5137 1c04 7B69     		ldr	r3, [r7, #20]	@ written.103_180, written
 5138 1c06 BA68     		ldr	r2, [r7, #8]	@ tmp272, buf
 5139 1c08 1344     		add	r3, r3, r2	@ tmp271, tmp272
 5140 1c0a BB60     		str	r3, [r7, #8]	@ tmp271, buf
 5141              	.L314:
 5142              		.loc 2 995 0 discriminator 5
 5143 1c0c BA6B     		ldr	r2, [r7, #56]	@ tmp274, written_total
 5144 1c0e 7B69     		ldr	r3, [r7, #20]	@ tmp275, written
 5145 1c10 1344     		add	r3, r3, r2	@ tmp273, tmp274
 5146 1c12 BB63     		str	r3, [r7, #56]	@ tmp273, written_total
 5147              	.L312:
 996:parson.c      ****             }
 997:parson.c      ****             temp_value = json_object_get_value(object, key);
 5148              		.loc 2 997 0 is_stmt 1
 5149 1c14 796B     		ldr	r1, [r7, #52]	@, key
 5150 1c16 786A     		ldr	r0, [r7, #36]	@, object
 5151 1c18 FFF7FEFF 		bl	json_object_get_value	@
 5152 1c1c F862     		str	r0, [r7, #44]	@, temp_value
 998:parson.c      ****             written = json_serialize_to_buffer_r(temp_value, buf, level + 1, is_pretty, num_buf);
 5153              		.loc 2 998 0
 5154 1c1e 7B68     		ldr	r3, [r7, #4]	@ tmp276, level
 5155 1c20 5A1C     		adds	r2, r3, #1	@ _186, tmp276,
 5156 1c22 3B6D     		ldr	r3, [r7, #80]	@ tmp277, num_buf
 5157 1c24 0093     		str	r3, [sp]	@ tmp277,
 5158 1c26 3B68     		ldr	r3, [r7]	@, is_pretty
 5159 1c28 B968     		ldr	r1, [r7, #8]	@, buf
 5160 1c2a F86A     		ldr	r0, [r7, #44]	@, temp_value
 5161 1c2c FFF70CFE 		bl	json_serialize_to_buffer_r	@
 5162 1c30 7861     		str	r0, [r7, #20]	@, written
 999:parson.c      ****             if (written < 0) {
 5163              		.loc 2 999 0
 5164 1c32 7B69     		ldr	r3, [r7, #20]	@ tmp278, written
 5165 1c34 002B     		cmp	r3, #0	@ tmp278,
 5166 1c36 02DA     		bge	.L315	@,
1000:parson.c      ****                 return -1;
 5167              		.loc 2 1000 0
 5168 1c38 4FF0FF33 		mov	r3, #-1	@ _48,
 5169 1c3c 27E1     		b	.L275	@
 5170              	.L315:
1001:parson.c      ****             }
1002:parson.c      ****             if (buf != NULL) {
 5171              		.loc 2 1002 0
 5172 1c3e BB68     		ldr	r3, [r7, #8]	@ tmp279, buf
 5173 1c40 002B     		cmp	r3, #0	@ tmp279,
 5174 1c42 03D0     		beq	.L316	@,
1003:parson.c      ****                 buf += written;
 5175              		.loc 2 1003 0
 5176 1c44 7B69     		ldr	r3, [r7, #20]	@ written.104_189, written
 5177 1c46 BA68     		ldr	r2, [r7, #8]	@ tmp281, buf
 5178 1c48 1344     		add	r3, r3, r2	@ tmp280, tmp281
 5179 1c4a BB60     		str	r3, [r7, #8]	@ tmp280, buf
 5180              	.L316:
1004:parson.c      ****             }
1005:parson.c      ****             written_total += written;
 5181              		.loc 2 1005 0
 5182 1c4c BA6B     		ldr	r2, [r7, #56]	@ tmp283, written_total
 5183 1c4e 7B69     		ldr	r3, [r7, #20]	@ tmp284, written
 5184 1c50 1344     		add	r3, r3, r2	@ tmp282, tmp283
 5185 1c52 BB63     		str	r3, [r7, #56]	@ tmp282, written_total
1006:parson.c      ****             if (i < (count - 1)) {
 5186              		.loc 2 1006 0
 5187 1c54 3B6A     		ldr	r3, [r7, #32]	@ tmp285, count
 5188 1c56 5A1E     		subs	r2, r3, #1	@ _192, tmp285,
 5189 1c58 FB6B     		ldr	r3, [r7, #60]	@ tmp286, i
 5190 1c5a 9A42     		cmp	r2, r3	@ _192, tmp286
 5191 1c5c 18D9     		bls	.L317	@,
1007:parson.c      ****                 APPEND_STRING(",");
 5192              		.loc 2 1007 0
 5193 1c5e 40F20001 		movw	r1, #:lower16:.LC7	@,
 5194 1c62 C0F20001 		movt	r1, #:upper16:.LC7	@,
 5195 1c66 B868     		ldr	r0, [r7, #8]	@, buf
 5196 1c68 00F0FFFD 		bl	append_string	@
 5197 1c6c 7861     		str	r0, [r7, #20]	@, written
 5198 1c6e 7B69     		ldr	r3, [r7, #20]	@ tmp287, written
 5199 1c70 002B     		cmp	r3, #0	@ tmp287,
 5200 1c72 02DA     		bge	.L318	@,
 5201              		.loc 2 1007 0 is_stmt 0 discriminator 1
 5202 1c74 4FF0FF33 		mov	r3, #-1	@ _48,
 5203 1c78 09E1     		b	.L275	@
 5204              	.L318:
 5205              		.loc 2 1007 0 discriminator 2
 5206 1c7a BB68     		ldr	r3, [r7, #8]	@ tmp288, buf
 5207 1c7c 002B     		cmp	r3, #0	@ tmp288,
 5208 1c7e 03D0     		beq	.L319	@,
 5209              		.loc 2 1007 0 discriminator 3
 5210 1c80 7B69     		ldr	r3, [r7, #20]	@ written.105_195, written
 5211 1c82 BA68     		ldr	r2, [r7, #8]	@ tmp290, buf
 5212 1c84 1344     		add	r3, r3, r2	@ tmp289, tmp290
 5213 1c86 BB60     		str	r3, [r7, #8]	@ tmp289, buf
 5214              	.L319:
 5215              		.loc 2 1007 0 discriminator 5
 5216 1c88 BA6B     		ldr	r2, [r7, #56]	@ tmp292, written_total
 5217 1c8a 7B69     		ldr	r3, [r7, #20]	@ tmp293, written
 5218 1c8c 1344     		add	r3, r3, r2	@ tmp291, tmp292
 5219 1c8e BB63     		str	r3, [r7, #56]	@ tmp291, written_total
 5220              	.L317:
1008:parson.c      ****             }
1009:parson.c      ****             if (is_pretty) {
 5221              		.loc 2 1009 0 is_stmt 1
 5222 1c90 3B68     		ldr	r3, [r7]	@ tmp294, is_pretty
 5223 1c92 002B     		cmp	r3, #0	@ tmp294,
 5224 1c94 18D0     		beq	.L320	@,
1010:parson.c      ****                 APPEND_STRING("\n");
 5225              		.loc 2 1010 0
 5226 1c96 40F20001 		movw	r1, #:lower16:.LC6	@,
 5227 1c9a C0F20001 		movt	r1, #:upper16:.LC6	@,
 5228 1c9e B868     		ldr	r0, [r7, #8]	@, buf
 5229 1ca0 00F0E3FD 		bl	append_string	@
 5230 1ca4 7861     		str	r0, [r7, #20]	@, written
 5231 1ca6 7B69     		ldr	r3, [r7, #20]	@ tmp295, written
 5232 1ca8 002B     		cmp	r3, #0	@ tmp295,
 5233 1caa 02DA     		bge	.L321	@,
 5234              		.loc 2 1010 0 is_stmt 0 discriminator 1
 5235 1cac 4FF0FF33 		mov	r3, #-1	@ _48,
 5236 1cb0 EDE0     		b	.L275	@
 5237              	.L321:
 5238              		.loc 2 1010 0 discriminator 2
 5239 1cb2 BB68     		ldr	r3, [r7, #8]	@ tmp296, buf
 5240 1cb4 002B     		cmp	r3, #0	@ tmp296,
 5241 1cb6 03D0     		beq	.L322	@,
 5242              		.loc 2 1010 0 discriminator 3
 5243 1cb8 7B69     		ldr	r3, [r7, #20]	@ written.106_201, written
 5244 1cba BA68     		ldr	r2, [r7, #8]	@ tmp298, buf
 5245 1cbc 1344     		add	r3, r3, r2	@ tmp297, tmp298
 5246 1cbe BB60     		str	r3, [r7, #8]	@ tmp297, buf
 5247              	.L322:
 5248              		.loc 2 1010 0 discriminator 5
 5249 1cc0 BA6B     		ldr	r2, [r7, #56]	@ tmp300, written_total
 5250 1cc2 7B69     		ldr	r3, [r7, #20]	@ tmp301, written
 5251 1cc4 1344     		add	r3, r3, r2	@ tmp299, tmp300
 5252 1cc6 BB63     		str	r3, [r7, #56]	@ tmp299, written_total
 5253              	.L320:
 977:parson.c      ****             key = json_object_get_name(object, i);
 5254              		.loc 2 977 0 is_stmt 1 discriminator 2
 5255 1cc8 FB6B     		ldr	r3, [r7, #60]	@ tmp303, i
 5256 1cca 0133     		adds	r3, r3, #1	@ tmp302, tmp303,
 5257 1ccc FB63     		str	r3, [r7, #60]	@ tmp302, i
 5258              	.L303:
 977:parson.c      ****             key = json_object_get_name(object, i);
 5259              		.loc 2 977 0 is_stmt 0 discriminator 1
 5260 1cce FA6B     		ldr	r2, [r7, #60]	@ tmp304, i
 5261 1cd0 3B6A     		ldr	r3, [r7, #32]	@ tmp305, count
 5262 1cd2 9A42     		cmp	r2, r3	@ tmp304, tmp305
 5263 1cd4 FFF42DAF 		bcc	.L323	@,
1011:parson.c      ****             }
1012:parson.c      ****         }
1013:parson.c      ****         if (count > 0 && is_pretty) {
 5264              		.loc 2 1013 0 is_stmt 1
 5265 1cd8 3B6A     		ldr	r3, [r7, #32]	@ tmp306, count
 5266 1cda 002B     		cmp	r3, #0	@ tmp306,
 5267 1cdc 18D0     		beq	.L324	@,
 5268              		.loc 2 1013 0 is_stmt 0 discriminator 1
 5269 1cde 3B68     		ldr	r3, [r7]	@ tmp307, is_pretty
 5270 1ce0 002B     		cmp	r3, #0	@ tmp307,
 5271 1ce2 15D0     		beq	.L324	@,
1014:parson.c      ****             APPEND_INDENT(level);
 5272              		.loc 2 1014 0 is_stmt 1
 5273 1ce4 7968     		ldr	r1, [r7, #4]	@, level
 5274 1ce6 B868     		ldr	r0, [r7, #8]	@, buf
 5275 1ce8 00F08DFD 		bl	append_indent	@
 5276 1cec 7861     		str	r0, [r7, #20]	@, written
 5277 1cee 7B69     		ldr	r3, [r7, #20]	@ tmp308, written
 5278 1cf0 002B     		cmp	r3, #0	@ tmp308,
 5279 1cf2 02DA     		bge	.L325	@,
 5280              		.loc 2 1014 0 is_stmt 0 discriminator 1
 5281 1cf4 4FF0FF33 		mov	r3, #-1	@ _48,
 5282 1cf8 C9E0     		b	.L275	@
 5283              	.L325:
 5284              		.loc 2 1014 0 discriminator 2
 5285 1cfa BB68     		ldr	r3, [r7, #8]	@ tmp309, buf
 5286 1cfc 002B     		cmp	r3, #0	@ tmp309,
 5287 1cfe 03D0     		beq	.L326	@,
 5288              		.loc 2 1014 0 discriminator 3
 5289 1d00 7B69     		ldr	r3, [r7, #20]	@ written.107_213, written
 5290 1d02 BA68     		ldr	r2, [r7, #8]	@ tmp311, buf
 5291 1d04 1344     		add	r3, r3, r2	@ tmp310, tmp311
 5292 1d06 BB60     		str	r3, [r7, #8]	@ tmp310, buf
 5293              	.L326:
 5294              		.loc 2 1014 0 discriminator 5
 5295 1d08 BA6B     		ldr	r2, [r7, #56]	@ tmp313, written_total
 5296 1d0a 7B69     		ldr	r3, [r7, #20]	@ tmp314, written
 5297 1d0c 1344     		add	r3, r3, r2	@ tmp312, tmp313
 5298 1d0e BB63     		str	r3, [r7, #56]	@ tmp312, written_total
 5299              	.L324:
1015:parson.c      ****         }
1016:parson.c      ****         APPEND_STRING("}");
 5300              		.loc 2 1016 0 is_stmt 1
 5301 1d10 40F20001 		movw	r1, #:lower16:.LC12	@,
 5302 1d14 C0F20001 		movt	r1, #:upper16:.LC12	@,
 5303 1d18 B868     		ldr	r0, [r7, #8]	@, buf
 5304 1d1a 00F0A6FD 		bl	append_string	@
 5305 1d1e 7861     		str	r0, [r7, #20]	@, written
 5306 1d20 7B69     		ldr	r3, [r7, #20]	@ tmp315, written
 5307 1d22 002B     		cmp	r3, #0	@ tmp315,
 5308 1d24 02DA     		bge	.L327	@,
 5309              		.loc 2 1016 0 is_stmt 0 discriminator 1
 5310 1d26 4FF0FF33 		mov	r3, #-1	@ _48,
 5311 1d2a B0E0     		b	.L275	@
 5312              	.L327:
 5313              		.loc 2 1016 0 discriminator 2
 5314 1d2c BB68     		ldr	r3, [r7, #8]	@ tmp316, buf
 5315 1d2e 002B     		cmp	r3, #0	@ tmp316,
 5316 1d30 03D0     		beq	.L328	@,
 5317              		.loc 2 1016 0 discriminator 3
 5318 1d32 7B69     		ldr	r3, [r7, #20]	@ written.108_219, written
 5319 1d34 BA68     		ldr	r2, [r7, #8]	@ tmp318, buf
 5320 1d36 1344     		add	r3, r3, r2	@ tmp317, tmp318
 5321 1d38 BB60     		str	r3, [r7, #8]	@ tmp317, buf
 5322              	.L328:
 5323              		.loc 2 1016 0 discriminator 5
 5324 1d3a BA6B     		ldr	r2, [r7, #56]	@ tmp320, written_total
 5325 1d3c 7B69     		ldr	r3, [r7, #20]	@ tmp321, written
 5326 1d3e 1344     		add	r3, r3, r2	@ tmp319, tmp320
 5327 1d40 BB63     		str	r3, [r7, #56]	@ tmp319, written_total
1017:parson.c      ****         return written_total;
 5328              		.loc 2 1017 0 is_stmt 1 discriminator 5
 5329 1d42 BB6B     		ldr	r3, [r7, #56]	@ _48, written_total
 5330 1d44 A3E0     		b	.L275	@
 5331              	.L269:
1018:parson.c      ****     case JSONString:
1019:parson.c      ****         string = json_value_get_string(value);
 5332              		.loc 2 1019 0
 5333 1d46 F868     		ldr	r0, [r7, #12]	@, value
 5334 1d48 FFF7FEFF 		bl	json_value_get_string	@
 5335 1d4c 3863     		str	r0, [r7, #48]	@, string
1020:parson.c      ****         if (string == NULL) {
 5336              		.loc 2 1020 0
 5337 1d4e 3B6B     		ldr	r3, [r7, #48]	@ tmp322, string
 5338 1d50 002B     		cmp	r3, #0	@ tmp322,
 5339 1d52 02D1     		bne	.L329	@,
1021:parson.c      ****             return -1;
 5340              		.loc 2 1021 0
 5341 1d54 4FF0FF33 		mov	r3, #-1	@ _48,
 5342 1d58 99E0     		b	.L275	@
 5343              	.L329:
1022:parson.c      ****         }
1023:parson.c      ****         written = json_serialize_string(string, buf);
 5344              		.loc 2 1023 0
 5345 1d5a B968     		ldr	r1, [r7, #8]	@, buf
 5346 1d5c 386B     		ldr	r0, [r7, #48]	@, string
 5347 1d5e 00F09AF8 		bl	json_serialize_string	@
 5348 1d62 7861     		str	r0, [r7, #20]	@, written
1024:parson.c      ****         if (written < 0) {
 5349              		.loc 2 1024 0
 5350 1d64 7B69     		ldr	r3, [r7, #20]	@ tmp323, written
 5351 1d66 002B     		cmp	r3, #0	@ tmp323,
 5352 1d68 02DA     		bge	.L330	@,
1025:parson.c      ****             return -1;
 5353              		.loc 2 1025 0
 5354 1d6a 4FF0FF33 		mov	r3, #-1	@ _48,
 5355 1d6e 8EE0     		b	.L275	@
 5356              	.L330:
1026:parson.c      ****         }
1027:parson.c      ****         if (buf != NULL) {
 5357              		.loc 2 1027 0
 5358 1d70 BB68     		ldr	r3, [r7, #8]	@ tmp324, buf
 5359 1d72 002B     		cmp	r3, #0	@ tmp324,
 5360 1d74 03D0     		beq	.L331	@,
1028:parson.c      ****             buf += written;
 5361              		.loc 2 1028 0
 5362 1d76 7B69     		ldr	r3, [r7, #20]	@ written.109_229, written
 5363 1d78 BA68     		ldr	r2, [r7, #8]	@ tmp326, buf
 5364 1d7a 1344     		add	r3, r3, r2	@ tmp325, tmp326
 5365 1d7c BB60     		str	r3, [r7, #8]	@ tmp325, buf
 5366              	.L331:
1029:parson.c      ****         }
1030:parson.c      ****         written_total += written;
 5367              		.loc 2 1030 0
 5368 1d7e BA6B     		ldr	r2, [r7, #56]	@ tmp328, written_total
 5369 1d80 7B69     		ldr	r3, [r7, #20]	@ tmp329, written
 5370 1d82 1344     		add	r3, r3, r2	@ tmp327, tmp328
 5371 1d84 BB63     		str	r3, [r7, #56]	@ tmp327, written_total
1031:parson.c      ****         return written_total;
 5372              		.loc 2 1031 0
 5373 1d86 BB6B     		ldr	r3, [r7, #56]	@ _48, written_total
 5374 1d88 81E0     		b	.L275	@
 5375              	.L273:
1032:parson.c      ****     case JSONBoolean:
1033:parson.c      ****         if (json_value_get_boolean(value)) {
 5376              		.loc 2 1033 0
 5377 1d8a F868     		ldr	r0, [r7, #12]	@, value
 5378 1d8c FFF7FEFF 		bl	json_value_get_boolean	@
 5379 1d90 0346     		mov	r3, r0	@ _234,
 5380 1d92 002B     		cmp	r3, #0	@ _234,
 5381 1d94 19D0     		beq	.L332	@,
1034:parson.c      ****             APPEND_STRING("true");
 5382              		.loc 2 1034 0
 5383 1d96 40F20001 		movw	r1, #:lower16:.LC2	@,
 5384 1d9a C0F20001 		movt	r1, #:upper16:.LC2	@,
 5385 1d9e B868     		ldr	r0, [r7, #8]	@, buf
 5386 1da0 00F063FD 		bl	append_string	@
 5387 1da4 7861     		str	r0, [r7, #20]	@, written
 5388 1da6 7B69     		ldr	r3, [r7, #20]	@ tmp330, written
 5389 1da8 002B     		cmp	r3, #0	@ tmp330,
 5390 1daa 02DA     		bge	.L333	@,
 5391              		.loc 2 1034 0 is_stmt 0 discriminator 1
 5392 1dac 4FF0FF33 		mov	r3, #-1	@ _48,
 5393 1db0 6DE0     		b	.L275	@
 5394              	.L333:
 5395              		.loc 2 1034 0 discriminator 2
 5396 1db2 BB68     		ldr	r3, [r7, #8]	@ tmp331, buf
 5397 1db4 002B     		cmp	r3, #0	@ tmp331,
 5398 1db6 03D0     		beq	.L334	@,
 5399              		.loc 2 1034 0 discriminator 3
 5400 1db8 7B69     		ldr	r3, [r7, #20]	@ written.110_238, written
 5401 1dba BA68     		ldr	r2, [r7, #8]	@ tmp333, buf
 5402 1dbc 1344     		add	r3, r3, r2	@ tmp332, tmp333
 5403 1dbe BB60     		str	r3, [r7, #8]	@ tmp332, buf
 5404              	.L334:
 5405              		.loc 2 1034 0 discriminator 5
 5406 1dc0 BA6B     		ldr	r2, [r7, #56]	@ tmp335, written_total
 5407 1dc2 7B69     		ldr	r3, [r7, #20]	@ tmp336, written
 5408 1dc4 1344     		add	r3, r3, r2	@ tmp334, tmp335
 5409 1dc6 BB63     		str	r3, [r7, #56]	@ tmp334, written_total
 5410 1dc8 18E0     		b	.L335	@
 5411              	.L332:
1035:parson.c      ****         } else {
1036:parson.c      ****             APPEND_STRING("false");
 5412              		.loc 2 1036 0 is_stmt 1
 5413 1dca 40F20001 		movw	r1, #:lower16:.LC3	@,
 5414 1dce C0F20001 		movt	r1, #:upper16:.LC3	@,
 5415 1dd2 B868     		ldr	r0, [r7, #8]	@, buf
 5416 1dd4 00F049FD 		bl	append_string	@
 5417 1dd8 7861     		str	r0, [r7, #20]	@, written
 5418 1dda 7B69     		ldr	r3, [r7, #20]	@ tmp337, written
 5419 1ddc 002B     		cmp	r3, #0	@ tmp337,
 5420 1dde 02DA     		bge	.L336	@,
 5421              		.loc 2 1036 0 is_stmt 0 discriminator 1
 5422 1de0 4FF0FF33 		mov	r3, #-1	@ _48,
 5423 1de4 53E0     		b	.L275	@
 5424              	.L336:
 5425              		.loc 2 1036 0 discriminator 2
 5426 1de6 BB68     		ldr	r3, [r7, #8]	@ tmp338, buf
 5427 1de8 002B     		cmp	r3, #0	@ tmp338,
 5428 1dea 03D0     		beq	.L337	@,
 5429              		.loc 2 1036 0 discriminator 3
 5430 1dec 7B69     		ldr	r3, [r7, #20]	@ written.111_244, written
 5431 1dee BA68     		ldr	r2, [r7, #8]	@ tmp340, buf
 5432 1df0 1344     		add	r3, r3, r2	@ tmp339, tmp340
 5433 1df2 BB60     		str	r3, [r7, #8]	@ tmp339, buf
 5434              	.L337:
 5435              		.loc 2 1036 0 discriminator 5
 5436 1df4 BA6B     		ldr	r2, [r7, #56]	@ tmp342, written_total
 5437 1df6 7B69     		ldr	r3, [r7, #20]	@ tmp343, written
 5438 1df8 1344     		add	r3, r3, r2	@ tmp341, tmp342
 5439 1dfa BB63     		str	r3, [r7, #56]	@ tmp341, written_total
 5440              	.L335:
1037:parson.c      ****         }
1038:parson.c      ****         return written_total;
 5441              		.loc 2 1038 0 is_stmt 1
 5442 1dfc BB6B     		ldr	r3, [r7, #56]	@ _48, written_total
 5443 1dfe 46E0     		b	.L275	@
 5444              	.L270:
1039:parson.c      ****     case JSONNumber:
1040:parson.c      ****         num = json_value_get_number(value);
 5445              		.loc 2 1040 0
 5446 1e00 F868     		ldr	r0, [r7, #12]	@, value
 5447 1e02 FFF7FEFF 		bl	json_value_get_number	@
 5448 1e06 87ED060B 		vstr.64	d0, [r7, #24]	@, num
1041:parson.c      ****         if (buf != NULL) {
 5449              		.loc 2 1041 0
 5450 1e0a BB68     		ldr	r3, [r7, #8]	@ tmp344, buf
 5451 1e0c 002B     		cmp	r3, #0	@ tmp344,
 5452 1e0e 01D0     		beq	.L338	@,
1042:parson.c      ****             num_buf = buf;
 5453              		.loc 2 1042 0
 5454 1e10 BB68     		ldr	r3, [r7, #8]	@ tmp345, buf
 5455 1e12 3B65     		str	r3, [r7, #80]	@ tmp345, num_buf
 5456              	.L338:
1043:parson.c      ****         }
1044:parson.c      ****         written = sprintf(num_buf, FLOAT_FORMAT, num);
 5457              		.loc 2 1044 0
 5458 1e14 D7E90623 		ldrd	r2, [r7, #24]	@,,
 5459 1e18 40F20001 		movw	r1, #:lower16:.LC13	@,
 5460 1e1c C0F20001 		movt	r1, #:upper16:.LC13	@,
 5461 1e20 386D     		ldr	r0, [r7, #80]	@, num_buf
 5462 1e22 FFF7FEFF 		bl	sprintf	@
 5463 1e26 7861     		str	r0, [r7, #20]	@, written
1045:parson.c      ****         if (written < 0) {
 5464              		.loc 2 1045 0
 5465 1e28 7B69     		ldr	r3, [r7, #20]	@ tmp346, written
 5466 1e2a 002B     		cmp	r3, #0	@ tmp346,
 5467 1e2c 02DA     		bge	.L339	@,
1046:parson.c      ****             return -1;
 5468              		.loc 2 1046 0
 5469 1e2e 4FF0FF33 		mov	r3, #-1	@ _48,
 5470 1e32 2CE0     		b	.L275	@
 5471              	.L339:
1047:parson.c      ****         }
1048:parson.c      ****         if (buf != NULL) {
 5472              		.loc 2 1048 0
 5473 1e34 BB68     		ldr	r3, [r7, #8]	@ tmp347, buf
 5474 1e36 002B     		cmp	r3, #0	@ tmp347,
 5475 1e38 03D0     		beq	.L340	@,
1049:parson.c      ****             buf += written;
 5476              		.loc 2 1049 0
 5477 1e3a 7B69     		ldr	r3, [r7, #20]	@ written.112_254, written
 5478 1e3c BA68     		ldr	r2, [r7, #8]	@ tmp349, buf
 5479 1e3e 1344     		add	r3, r3, r2	@ tmp348, tmp349
 5480 1e40 BB60     		str	r3, [r7, #8]	@ tmp348, buf
 5481              	.L340:
1050:parson.c      ****         }
1051:parson.c      ****         written_total += written;
 5482              		.loc 2 1051 0
 5483 1e42 BA6B     		ldr	r2, [r7, #56]	@ tmp351, written_total
 5484 1e44 7B69     		ldr	r3, [r7, #20]	@ tmp352, written
 5485 1e46 1344     		add	r3, r3, r2	@ tmp350, tmp351
 5486 1e48 BB63     		str	r3, [r7, #56]	@ tmp350, written_total
1052:parson.c      ****         return written_total;
 5487              		.loc 2 1052 0
 5488 1e4a BB6B     		ldr	r3, [r7, #56]	@ _48, written_total
 5489 1e4c 1FE0     		b	.L275	@
 5490              	.L268:
1053:parson.c      ****     case JSONNull:
1054:parson.c      ****         APPEND_STRING("null");
 5491              		.loc 2 1054 0
 5492 1e4e 40F20001 		movw	r1, #:lower16:.LC4	@,
 5493 1e52 C0F20001 		movt	r1, #:upper16:.LC4	@,
 5494 1e56 B868     		ldr	r0, [r7, #8]	@, buf
 5495 1e58 00F007FD 		bl	append_string	@
 5496 1e5c 7861     		str	r0, [r7, #20]	@, written
 5497 1e5e 7B69     		ldr	r3, [r7, #20]	@ tmp353, written
 5498 1e60 002B     		cmp	r3, #0	@ tmp353,
 5499 1e62 02DA     		bge	.L341	@,
 5500              		.loc 2 1054 0 is_stmt 0 discriminator 1
 5501 1e64 4FF0FF33 		mov	r3, #-1	@ _48,
 5502 1e68 11E0     		b	.L275	@
 5503              	.L341:
 5504              		.loc 2 1054 0 discriminator 2
 5505 1e6a BB68     		ldr	r3, [r7, #8]	@ tmp354, buf
 5506 1e6c 002B     		cmp	r3, #0	@ tmp354,
 5507 1e6e 03D0     		beq	.L342	@,
 5508              		.loc 2 1054 0 discriminator 3
 5509 1e70 7B69     		ldr	r3, [r7, #20]	@ written.113_261, written
 5510 1e72 BA68     		ldr	r2, [r7, #8]	@ tmp356, buf
 5511 1e74 1344     		add	r3, r3, r2	@ tmp355, tmp356
 5512 1e76 BB60     		str	r3, [r7, #8]	@ tmp355, buf
 5513              	.L342:
 5514              		.loc 2 1054 0 discriminator 5
 5515 1e78 BA6B     		ldr	r2, [r7, #56]	@ tmp358, written_total
 5516 1e7a 7B69     		ldr	r3, [r7, #20]	@ tmp359, written
 5517 1e7c 1344     		add	r3, r3, r2	@ tmp357, tmp358
 5518 1e7e BB63     		str	r3, [r7, #56]	@ tmp357, written_total
1055:parson.c      ****         return written_total;
 5519              		.loc 2 1055 0 is_stmt 1 discriminator 5
 5520 1e80 BB6B     		ldr	r3, [r7, #56]	@ _48, written_total
 5521 1e82 04E0     		b	.L275	@
 5522              	.L266:
1056:parson.c      ****     case JSONError:
1057:parson.c      ****         return -1;
 5523              		.loc 2 1057 0
 5524 1e84 4FF0FF33 		mov	r3, #-1	@ _48,
 5525 1e88 01E0     		b	.L275	@
 5526              	.L265:
1058:parson.c      ****     default:
1059:parson.c      ****         return -1;
 5527              		.loc 2 1059 0
 5528 1e8a 4FF0FF33 		mov	r3, #-1	@ _48,
 5529              	.L275:
1060:parson.c      ****     }
1061:parson.c      **** }
 5530              		.loc 2 1061 0
 5531 1e8e 1846     		mov	r0, r3	@, <retval>
 5532 1e90 4437     		adds	r7, r7, #68	@,,
 5533              	.LCFI177:
 5534              		.cfi_def_cfa_offset 12
 5535 1e92 BD46     		mov	sp, r7	@,
 5536              	.LCFI178:
 5537              		.cfi_def_cfa_register 13
 5538              		@ sp needed	@
 5539 1e94 90BD     		pop	{r4, r7, pc}	@
 5540              		.cfi_endproc
 5541              	.LFE51:
 5543              		.section	.rodata
 5544 0047 00       		.align	2
 5545              	.LC14:
 5546 0048 2200     		.ascii	"\"\000"
 5547 004a 0000     		.align	2
 5548              	.LC15:
 5549 004c 5C2200   		.ascii	"\\\"\000"
 5550 004f 00       		.align	2
 5551              	.LC16:
 5552 0050 5C5C00   		.ascii	"\\\\\000"
 5553 0053 00       		.align	2
 5554              	.LC17:
 5555 0054 5C2F00   		.ascii	"\\/\000"
 5556 0057 00       		.align	2
 5557              	.LC18:
 5558 0058 5C6200   		.ascii	"\\b\000"
 5559 005b 00       		.align	2
 5560              	.LC19:
 5561 005c 5C6600   		.ascii	"\\f\000"
 5562 005f 00       		.align	2
 5563              	.LC20:
 5564 0060 5C6E00   		.ascii	"\\n\000"
 5565 0063 00       		.align	2
 5566              	.LC21:
 5567 0064 5C7200   		.ascii	"\\r\000"
 5568 0067 00       		.align	2
 5569              	.LC22:
 5570 0068 5C7400   		.ascii	"\\t\000"
 5571 006b 00       		.align	2
 5572              	.LC23:
 5573 006c 5C753030 		.ascii	"\\u0000\000"
 5573      303000
 5574 0073 00       		.align	2
 5575              	.LC24:
 5576 0074 5C753030 		.ascii	"\\u0001\000"
 5576      303100
 5577 007b 00       		.align	2
 5578              	.LC25:
 5579 007c 5C753030 		.ascii	"\\u0002\000"
 5579      303200
 5580 0083 00       		.align	2
 5581              	.LC26:
 5582 0084 5C753030 		.ascii	"\\u0003\000"
 5582      303300
 5583 008b 00       		.align	2
 5584              	.LC27:
 5585 008c 5C753030 		.ascii	"\\u0004\000"
 5585      303400
 5586 0093 00       		.align	2
 5587              	.LC28:
 5588 0094 5C753030 		.ascii	"\\u0005\000"
 5588      303500
 5589 009b 00       		.align	2
 5590              	.LC29:
 5591 009c 5C753030 		.ascii	"\\u0006\000"
 5591      303600
 5592 00a3 00       		.align	2
 5593              	.LC30:
 5594 00a4 5C753030 		.ascii	"\\u0007\000"
 5594      303700
 5595 00ab 00       		.align	2
 5596              	.LC31:
 5597 00ac 5C753030 		.ascii	"\\u000b\000"
 5597      306200
 5598 00b3 00       		.align	2
 5599              	.LC32:
 5600 00b4 5C753030 		.ascii	"\\u000e\000"
 5600      306500
 5601 00bb 00       		.align	2
 5602              	.LC33:
 5603 00bc 5C753030 		.ascii	"\\u000f\000"
 5603      306600
 5604 00c3 00       		.align	2
 5605              	.LC34:
 5606 00c4 5C753030 		.ascii	"\\u0010\000"
 5606      313000
 5607 00cb 00       		.align	2
 5608              	.LC35:
 5609 00cc 5C753030 		.ascii	"\\u0011\000"
 5609      313100
 5610 00d3 00       		.align	2
 5611              	.LC36:
 5612 00d4 5C753030 		.ascii	"\\u0012\000"
 5612      313200
 5613 00db 00       		.align	2
 5614              	.LC37:
 5615 00dc 5C753030 		.ascii	"\\u0013\000"
 5615      313300
 5616 00e3 00       		.align	2
 5617              	.LC38:
 5618 00e4 5C753030 		.ascii	"\\u0014\000"
 5618      313400
 5619 00eb 00       		.align	2
 5620              	.LC39:
 5621 00ec 5C753030 		.ascii	"\\u0015\000"
 5621      313500
 5622 00f3 00       		.align	2
 5623              	.LC40:
 5624 00f4 5C753030 		.ascii	"\\u0016\000"
 5624      313600
 5625 00fb 00       		.align	2
 5626              	.LC41:
 5627 00fc 5C753030 		.ascii	"\\u0017\000"
 5627      313700
 5628 0103 00       		.align	2
 5629              	.LC42:
 5630 0104 5C753030 		.ascii	"\\u0018\000"
 5630      313800
 5631 010b 00       		.align	2
 5632              	.LC43:
 5633 010c 5C753030 		.ascii	"\\u0019\000"
 5633      313900
 5634 0113 00       		.align	2
 5635              	.LC44:
 5636 0114 5C753030 		.ascii	"\\u001a\000"
 5636      316100
 5637 011b 00       		.align	2
 5638              	.LC45:
 5639 011c 5C753030 		.ascii	"\\u001b\000"
 5639      316200
 5640 0123 00       		.align	2
 5641              	.LC46:
 5642 0124 5C753030 		.ascii	"\\u001c\000"
 5642      316300
 5643 012b 00       		.align	2
 5644              	.LC47:
 5645 012c 5C753030 		.ascii	"\\u001d\000"
 5645      316400
 5646 0133 00       		.align	2
 5647              	.LC48:
 5648 0134 5C753030 		.ascii	"\\u001e\000"
 5648      316500
 5649 013b 00       		.align	2
 5650              	.LC49:
 5651 013c 5C753030 		.ascii	"\\u001f\000"
 5651      316600
 5652              		.text
 5653              		.align	1
 5654              		.syntax unified
 5655              		.thumb
 5656              		.thumb_func
 5657              		.fpu neon
 5659              	json_serialize_string:
 5660              	.LFB52:
1062:parson.c      **** 
1063:parson.c      **** static int json_serialize_string(const char *string, char *buf)
1064:parson.c      **** {
 5661              		.loc 2 1064 0
 5662              		.cfi_startproc
 5663              		@ args = 0, pretend = 0, frame = 32
 5664              		@ frame_needed = 1, uses_anonymous_args = 0
 5665 1e96 80B5     		push	{r7, lr}	@
 5666              	.LCFI179:
 5667              		.cfi_def_cfa_offset 8
 5668              		.cfi_offset 7, -8
 5669              		.cfi_offset 14, -4
 5670 1e98 88B0     		sub	sp, sp, #32	@,,
 5671              	.LCFI180:
 5672              		.cfi_def_cfa_offset 40
 5673 1e9a 00AF     		add	r7, sp, #0	@,,
 5674              	.LCFI181:
 5675              		.cfi_def_cfa_register 7
 5676 1e9c 7860     		str	r0, [r7, #4]	@ string, string
 5677 1e9e 3960     		str	r1, [r7]	@ buf, buf
1065:parson.c      ****     size_t i = 0, len = strlen(string);
 5678              		.loc 2 1065 0
 5679 1ea0 0023     		movs	r3, #0	@ tmp151,
 5680 1ea2 FB61     		str	r3, [r7, #28]	@ tmp151, i
 5681 1ea4 7868     		ldr	r0, [r7, #4]	@, string
 5682 1ea6 FFF7FEFF 		bl	strlen	@
 5683 1eaa 7861     		str	r0, [r7, #20]	@, len
1066:parson.c      ****     char c = '\0';
 5684              		.loc 2 1066 0
 5685 1eac 0023     		movs	r3, #0	@ tmp152,
 5686 1eae FB74     		strb	r3, [r7, #19]	@ tmp153, c
1067:parson.c      ****     int written = -1, written_total = 0;
 5687              		.loc 2 1067 0
 5688 1eb0 4FF0FF33 		mov	r3, #-1	@ tmp154,
 5689 1eb4 FB60     		str	r3, [r7, #12]	@ tmp154, written
 5690 1eb6 0023     		movs	r3, #0	@ tmp155,
 5691 1eb8 BB61     		str	r3, [r7, #24]	@ tmp155, written_total
1068:parson.c      ****     APPEND_STRING("\"");
 5692              		.loc 2 1068 0
 5693 1eba 40F20001 		movw	r1, #:lower16:.LC14	@,
 5694 1ebe C0F20001 		movt	r1, #:upper16:.LC14	@,
 5695 1ec2 3868     		ldr	r0, [r7]	@, buf
 5696 1ec4 00F0D1FC 		bl	append_string	@
 5697 1ec8 F860     		str	r0, [r7, #12]	@, written
 5698 1eca FB68     		ldr	r3, [r7, #12]	@ tmp156, written
 5699 1ecc 002B     		cmp	r3, #0	@ tmp156,
 5700 1ece 03DA     		bge	.L344	@,
 5701              		.loc 2 1068 0 is_stmt 0 discriminator 1
 5702 1ed0 4FF0FF33 		mov	r3, #-1	@ _43,
 5703 1ed4 00F093BC 		b	.L345	@
 5704              	.L344:
 5705              		.loc 2 1068 0 discriminator 2
 5706 1ed8 3B68     		ldr	r3, [r7]	@ tmp157, buf
 5707 1eda 002B     		cmp	r3, #0	@ tmp157,
 5708 1edc 03D0     		beq	.L346	@,
 5709              		.loc 2 1068 0 discriminator 3
 5710 1ede FB68     		ldr	r3, [r7, #12]	@ written.114_59, written
 5711 1ee0 3A68     		ldr	r2, [r7]	@ tmp159, buf
 5712 1ee2 1344     		add	r3, r3, r2	@ tmp158, tmp159
 5713 1ee4 3B60     		str	r3, [r7]	@ tmp158, buf
 5714              	.L346:
 5715              		.loc 2 1068 0 discriminator 5
 5716 1ee6 BA69     		ldr	r2, [r7, #24]	@ tmp161, written_total
 5717 1ee8 FB68     		ldr	r3, [r7, #12]	@ tmp162, written
 5718 1eea 1344     		add	r3, r3, r2	@ tmp160, tmp161
 5719 1eec BB61     		str	r3, [r7, #24]	@ tmp160, written_total
1069:parson.c      ****     for (i = 0; i < len; i++) {
 5720              		.loc 2 1069 0 is_stmt 1 discriminator 5
 5721 1eee 0023     		movs	r3, #0	@ tmp163,
 5722 1ef0 FB61     		str	r3, [r7, #28]	@ tmp163, i
 5723 1ef2 00F065BC 		b	.L347	@
 5724              	.L457:
1070:parson.c      ****         c = string[i];
 5725              		.loc 2 1070 0
 5726 1ef6 7A68     		ldr	r2, [r7, #4]	@ tmp164, string
 5727 1ef8 FB69     		ldr	r3, [r7, #28]	@ tmp165, i
 5728 1efa 1344     		add	r3, r3, r2	@ _63, tmp164
 5729 1efc 1B78     		ldrb	r3, [r3]	@ tmp166, *_63
 5730 1efe FB74     		strb	r3, [r7, #19]	@ tmp166, c
1071:parson.c      ****         switch (c) {
 5731              		.loc 2 1071 0
 5732 1f00 FB7C     		ldrb	r3, [r7, #19]	@ zero_extendqisi2	@ _65, c
 5733 1f02 5C2B     		cmp	r3, #92	@ _65,
 5734 1f04 00F24C84 		bhi	.L348	@
 5735 1f08 01A2     		adr	r2, .L350	@ tmp431,
 5736 1f0a 52F823F0 		ldr	pc, [r2, r3, lsl #2]	@ tmp431, _65
 5737 1f0e 00BF     		.p2align 2
 5738              	.L350:
 5739 1f10 25220000 		.word	.L349+1
 5740 1f14 59220000 		.word	.L351+1
 5741 1f18 8D220000 		.word	.L352+1
 5742 1f1c C1220000 		.word	.L353+1
 5743 1f20 F5220000 		.word	.L354+1
 5744 1f24 29230000 		.word	.L355+1
 5745 1f28 5D230000 		.word	.L356+1
 5746 1f2c 91230000 		.word	.L357+1
 5747 1f30 21210000 		.word	.L358+1
 5748 1f34 F1210000 		.word	.L359+1
 5749 1f38 89210000 		.word	.L360+1
 5750 1f3c C5230000 		.word	.L361+1
 5751 1f40 55210000 		.word	.L362+1
 5752 1f44 BD210000 		.word	.L363+1
 5753 1f48 F9230000 		.word	.L364+1
 5754 1f4c 2D240000 		.word	.L365+1
 5755 1f50 61240000 		.word	.L366+1
 5756 1f54 95240000 		.word	.L367+1
 5757 1f58 C9240000 		.word	.L368+1
 5758 1f5c FD240000 		.word	.L369+1
 5759 1f60 31250000 		.word	.L370+1
 5760 1f64 65250000 		.word	.L371+1
 5761 1f68 99250000 		.word	.L372+1
 5762 1f6c CD250000 		.word	.L373+1
 5763 1f70 01260000 		.word	.L374+1
 5764 1f74 35260000 		.word	.L375+1
 5765 1f78 69260000 		.word	.L376+1
 5766 1f7c 9D260000 		.word	.L377+1
 5767 1f80 D1260000 		.word	.L378+1
 5768 1f84 05270000 		.word	.L379+1
 5769 1f88 39270000 		.word	.L380+1
 5770 1f8c 6D270000 		.word	.L381+1
 5771 1f90 A1270000 		.word	.L348+1
 5772 1f94 A1270000 		.word	.L348+1
 5773 1f98 85200000 		.word	.L382+1
 5774 1f9c A1270000 		.word	.L348+1
 5775 1fa0 A1270000 		.word	.L348+1
 5776 1fa4 A1270000 		.word	.L348+1
 5777 1fa8 A1270000 		.word	.L348+1
 5778 1fac A1270000 		.word	.L348+1
 5779 1fb0 A1270000 		.word	.L348+1
 5780 1fb4 A1270000 		.word	.L348+1
 5781 1fb8 A1270000 		.word	.L348+1
 5782 1fbc A1270000 		.word	.L348+1
 5783 1fc0 A1270000 		.word	.L348+1
 5784 1fc4 A1270000 		.word	.L348+1
 5785 1fc8 A1270000 		.word	.L348+1
 5786 1fcc ED200000 		.word	.L383+1
 5787 1fd0 A1270000 		.word	.L348+1
 5788 1fd4 A1270000 		.word	.L348+1
 5789 1fd8 A1270000 		.word	.L348+1
 5790 1fdc A1270000 		.word	.L348+1
 5791 1fe0 A1270000 		.word	.L348+1
 5792 1fe4 A1270000 		.word	.L348+1
 5793 1fe8 A1270000 		.word	.L348+1
 5794 1fec A1270000 		.word	.L348+1
 5795 1ff0 A1270000 		.word	.L348+1
 5796 1ff4 A1270000 		.word	.L348+1
 5797 1ff8 A1270000 		.word	.L348+1
 5798 1ffc A1270000 		.word	.L348+1
 5799 2000 A1270000 		.word	.L348+1
 5800 2004 A1270000 		.word	.L348+1
 5801 2008 A1270000 		.word	.L348+1
 5802 200c A1270000 		.word	.L348+1
 5803 2010 A1270000 		.word	.L348+1
 5804 2014 A1270000 		.word	.L348+1
 5805 2018 A1270000 		.word	.L348+1
 5806 201c A1270000 		.word	.L348+1
 5807 2020 A1270000 		.word	.L348+1
 5808 2024 A1270000 		.word	.L348+1
 5809 2028 A1270000 		.word	.L348+1
 5810 202c A1270000 		.word	.L348+1
 5811 2030 A1270000 		.word	.L348+1
 5812 2034 A1270000 		.word	.L348+1
 5813 2038 A1270000 		.word	.L348+1
 5814 203c A1270000 		.word	.L348+1
 5815 2040 A1270000 		.word	.L348+1
 5816 2044 A1270000 		.word	.L348+1
 5817 2048 A1270000 		.word	.L348+1
 5818 204c A1270000 		.word	.L348+1
 5819 2050 A1270000 		.word	.L348+1
 5820 2054 A1270000 		.word	.L348+1
 5821 2058 A1270000 		.word	.L348+1
 5822 205c A1270000 		.word	.L348+1
 5823 2060 A1270000 		.word	.L348+1
 5824 2064 A1270000 		.word	.L348+1
 5825 2068 A1270000 		.word	.L348+1
 5826 206c A1270000 		.word	.L348+1
 5827 2070 A1270000 		.word	.L348+1
 5828 2074 A1270000 		.word	.L348+1
 5829 2078 A1270000 		.word	.L348+1
 5830 207c A1270000 		.word	.L348+1
 5831 2080 B9200000 		.word	.L384+1
 5832              		.p2align 1
 5833              	.L382:
1072:parson.c      ****         case '\"':
1073:parson.c      ****             APPEND_STRING("\\\"");
 5834              		.loc 2 1073 0
 5835 2084 40F20001 		movw	r1, #:lower16:.LC15	@,
 5836 2088 C0F20001 		movt	r1, #:upper16:.LC15	@,
 5837 208c 3868     		ldr	r0, [r7]	@, buf
 5838 208e 00F0ECFB 		bl	append_string	@
 5839 2092 F860     		str	r0, [r7, #12]	@, written
 5840 2094 FB68     		ldr	r3, [r7, #12]	@ tmp167, written
 5841 2096 002B     		cmp	r3, #0	@ tmp167,
 5842 2098 02DA     		bge	.L385	@,
 5843              		.loc 2 1073 0 is_stmt 0 discriminator 1
 5844 209a 4FF0FF33 		mov	r3, #-1	@ _43,
 5845 209e AEE3     		b	.L345	@
 5846              	.L385:
 5847              		.loc 2 1073 0 discriminator 2
 5848 20a0 3B68     		ldr	r3, [r7]	@ tmp168, buf
 5849 20a2 002B     		cmp	r3, #0	@ tmp168,
 5850 20a4 03D0     		beq	.L386	@,
 5851              		.loc 2 1073 0 discriminator 3
 5852 20a6 FB68     		ldr	r3, [r7, #12]	@ written.115_276, written
 5853 20a8 3A68     		ldr	r2, [r7]	@ tmp170, buf
 5854 20aa 1344     		add	r3, r3, r2	@ tmp169, tmp170
 5855 20ac 3B60     		str	r3, [r7]	@ tmp169, buf
 5856              	.L386:
 5857              		.loc 2 1073 0 discriminator 5
 5858 20ae BA69     		ldr	r2, [r7, #24]	@ tmp172, written_total
 5859 20b0 FB68     		ldr	r3, [r7, #12]	@ tmp173, written
 5860 20b2 1344     		add	r3, r3, r2	@ tmp171, tmp172
 5861 20b4 BB61     		str	r3, [r7, #24]	@ tmp171, written_total
1074:parson.c      ****             break;
 5862              		.loc 2 1074 0 is_stmt 1 discriminator 5
 5863 20b6 80E3     		b	.L387	@
 5864              	.L384:
1075:parson.c      ****         case '\\':
1076:parson.c      ****             APPEND_STRING("\\\\");
 5865              		.loc 2 1076 0
 5866 20b8 40F20001 		movw	r1, #:lower16:.LC16	@,
 5867 20bc C0F20001 		movt	r1, #:upper16:.LC16	@,
 5868 20c0 3868     		ldr	r0, [r7]	@, buf
 5869 20c2 00F0D2FB 		bl	append_string	@
 5870 20c6 F860     		str	r0, [r7, #12]	@, written
 5871 20c8 FB68     		ldr	r3, [r7, #12]	@ tmp174, written
 5872 20ca 002B     		cmp	r3, #0	@ tmp174,
 5873 20cc 02DA     		bge	.L388	@,
 5874              		.loc 2 1076 0 is_stmt 0 discriminator 1
 5875 20ce 4FF0FF33 		mov	r3, #-1	@ _43,
 5876 20d2 94E3     		b	.L345	@
 5877              	.L388:
 5878              		.loc 2 1076 0 discriminator 2
 5879 20d4 3B68     		ldr	r3, [r7]	@ tmp175, buf
 5880 20d6 002B     		cmp	r3, #0	@ tmp175,
 5881 20d8 03D0     		beq	.L389	@,
 5882              		.loc 2 1076 0 discriminator 3
 5883 20da FB68     		ldr	r3, [r7, #12]	@ written.116_68, written
 5884 20dc 3A68     		ldr	r2, [r7]	@ tmp177, buf
 5885 20de 1344     		add	r3, r3, r2	@ tmp176, tmp177
 5886 20e0 3B60     		str	r3, [r7]	@ tmp176, buf
 5887              	.L389:
 5888              		.loc 2 1076 0 discriminator 5
 5889 20e2 BA69     		ldr	r2, [r7, #24]	@ tmp179, written_total
 5890 20e4 FB68     		ldr	r3, [r7, #12]	@ tmp180, written
 5891 20e6 1344     		add	r3, r3, r2	@ tmp178, tmp179
 5892 20e8 BB61     		str	r3, [r7, #24]	@ tmp178, written_total
1077:parson.c      ****             break;
 5893              		.loc 2 1077 0 is_stmt 1 discriminator 5
 5894 20ea 66E3     		b	.L387	@
 5895              	.L383:
1078:parson.c      ****         case '/':
1079:parson.c      ****             APPEND_STRING("\\/");
 5896              		.loc 2 1079 0
 5897 20ec 40F20001 		movw	r1, #:lower16:.LC17	@,
 5898 20f0 C0F20001 		movt	r1, #:upper16:.LC17	@,
 5899 20f4 3868     		ldr	r0, [r7]	@, buf
 5900 20f6 00F0B8FB 		bl	append_string	@
 5901 20fa F860     		str	r0, [r7, #12]	@, written
 5902 20fc FB68     		ldr	r3, [r7, #12]	@ tmp181, written
 5903 20fe 002B     		cmp	r3, #0	@ tmp181,
 5904 2100 02DA     		bge	.L390	@,
 5905              		.loc 2 1079 0 is_stmt 0 discriminator 1
 5906 2102 4FF0FF33 		mov	r3, #-1	@ _43,
 5907 2106 7AE3     		b	.L345	@
 5908              	.L390:
 5909              		.loc 2 1079 0 discriminator 2
 5910 2108 3B68     		ldr	r3, [r7]	@ tmp182, buf
 5911 210a 002B     		cmp	r3, #0	@ tmp182,
 5912 210c 03D0     		beq	.L391	@,
 5913              		.loc 2 1079 0 discriminator 3
 5914 210e FB68     		ldr	r3, [r7, #12]	@ written.117_74, written
 5915 2110 3A68     		ldr	r2, [r7]	@ tmp184, buf
 5916 2112 1344     		add	r3, r3, r2	@ tmp183, tmp184
 5917 2114 3B60     		str	r3, [r7]	@ tmp183, buf
 5918              	.L391:
 5919              		.loc 2 1079 0 discriminator 5
 5920 2116 BA69     		ldr	r2, [r7, #24]	@ tmp186, written_total
 5921 2118 FB68     		ldr	r3, [r7, #12]	@ tmp187, written
 5922 211a 1344     		add	r3, r3, r2	@ tmp185, tmp186
 5923 211c BB61     		str	r3, [r7, #24]	@ tmp185, written_total
1080:parson.c      ****             break; /* to make json embeddable in xml\/html */
 5924              		.loc 2 1080 0 is_stmt 1 discriminator 5
 5925 211e 4CE3     		b	.L387	@
 5926              	.L358:
1081:parson.c      ****         case '\b':
1082:parson.c      ****             APPEND_STRING("\\b");
 5927              		.loc 2 1082 0
 5928 2120 40F20001 		movw	r1, #:lower16:.LC18	@,
 5929 2124 C0F20001 		movt	r1, #:upper16:.LC18	@,
 5930 2128 3868     		ldr	r0, [r7]	@, buf
 5931 212a 00F09EFB 		bl	append_string	@
 5932 212e F860     		str	r0, [r7, #12]	@, written
 5933 2130 FB68     		ldr	r3, [r7, #12]	@ tmp188, written
 5934 2132 002B     		cmp	r3, #0	@ tmp188,
 5935 2134 02DA     		bge	.L392	@,
 5936              		.loc 2 1082 0 is_stmt 0 discriminator 1
 5937 2136 4FF0FF33 		mov	r3, #-1	@ _43,
 5938 213a 60E3     		b	.L345	@
 5939              	.L392:
 5940              		.loc 2 1082 0 discriminator 2
 5941 213c 3B68     		ldr	r3, [r7]	@ tmp189, buf
 5942 213e 002B     		cmp	r3, #0	@ tmp189,
 5943 2140 03D0     		beq	.L393	@,
 5944              		.loc 2 1082 0 discriminator 3
 5945 2142 FB68     		ldr	r3, [r7, #12]	@ written.118_80, written
 5946 2144 3A68     		ldr	r2, [r7]	@ tmp191, buf
 5947 2146 1344     		add	r3, r3, r2	@ tmp190, tmp191
 5948 2148 3B60     		str	r3, [r7]	@ tmp190, buf
 5949              	.L393:
 5950              		.loc 2 1082 0 discriminator 5
 5951 214a BA69     		ldr	r2, [r7, #24]	@ tmp193, written_total
 5952 214c FB68     		ldr	r3, [r7, #12]	@ tmp194, written
 5953 214e 1344     		add	r3, r3, r2	@ tmp192, tmp193
 5954 2150 BB61     		str	r3, [r7, #24]	@ tmp192, written_total
1083:parson.c      ****             break;
 5955              		.loc 2 1083 0 is_stmt 1 discriminator 5
 5956 2152 32E3     		b	.L387	@
 5957              	.L362:
1084:parson.c      ****         case '\f':
1085:parson.c      ****             APPEND_STRING("\\f");
 5958              		.loc 2 1085 0
 5959 2154 40F20001 		movw	r1, #:lower16:.LC19	@,
 5960 2158 C0F20001 		movt	r1, #:upper16:.LC19	@,
 5961 215c 3868     		ldr	r0, [r7]	@, buf
 5962 215e 00F084FB 		bl	append_string	@
 5963 2162 F860     		str	r0, [r7, #12]	@, written
 5964 2164 FB68     		ldr	r3, [r7, #12]	@ tmp195, written
 5965 2166 002B     		cmp	r3, #0	@ tmp195,
 5966 2168 02DA     		bge	.L394	@,
 5967              		.loc 2 1085 0 is_stmt 0 discriminator 1
 5968 216a 4FF0FF33 		mov	r3, #-1	@ _43,
 5969 216e 46E3     		b	.L345	@
 5970              	.L394:
 5971              		.loc 2 1085 0 discriminator 2
 5972 2170 3B68     		ldr	r3, [r7]	@ tmp196, buf
 5973 2172 002B     		cmp	r3, #0	@ tmp196,
 5974 2174 03D0     		beq	.L395	@,
 5975              		.loc 2 1085 0 discriminator 3
 5976 2176 FB68     		ldr	r3, [r7, #12]	@ written.119_86, written
 5977 2178 3A68     		ldr	r2, [r7]	@ tmp198, buf
 5978 217a 1344     		add	r3, r3, r2	@ tmp197, tmp198
 5979 217c 3B60     		str	r3, [r7]	@ tmp197, buf
 5980              	.L395:
 5981              		.loc 2 1085 0 discriminator 5
 5982 217e BA69     		ldr	r2, [r7, #24]	@ tmp200, written_total
 5983 2180 FB68     		ldr	r3, [r7, #12]	@ tmp201, written
 5984 2182 1344     		add	r3, r3, r2	@ tmp199, tmp200
 5985 2184 BB61     		str	r3, [r7, #24]	@ tmp199, written_total
1086:parson.c      ****             break;
 5986              		.loc 2 1086 0 is_stmt 1 discriminator 5
 5987 2186 18E3     		b	.L387	@
 5988              	.L360:
1087:parson.c      ****         case '\n':
1088:parson.c      ****             APPEND_STRING("\\n");
 5989              		.loc 2 1088 0
 5990 2188 40F20001 		movw	r1, #:lower16:.LC20	@,
 5991 218c C0F20001 		movt	r1, #:upper16:.LC20	@,
 5992 2190 3868     		ldr	r0, [r7]	@, buf
 5993 2192 00F06AFB 		bl	append_string	@
 5994 2196 F860     		str	r0, [r7, #12]	@, written
 5995 2198 FB68     		ldr	r3, [r7, #12]	@ tmp202, written
 5996 219a 002B     		cmp	r3, #0	@ tmp202,
 5997 219c 02DA     		bge	.L396	@,
 5998              		.loc 2 1088 0 is_stmt 0 discriminator 1
 5999 219e 4FF0FF33 		mov	r3, #-1	@ _43,
 6000 21a2 2CE3     		b	.L345	@
 6001              	.L396:
 6002              		.loc 2 1088 0 discriminator 2
 6003 21a4 3B68     		ldr	r3, [r7]	@ tmp203, buf
 6004 21a6 002B     		cmp	r3, #0	@ tmp203,
 6005 21a8 03D0     		beq	.L397	@,
 6006              		.loc 2 1088 0 discriminator 3
 6007 21aa FB68     		ldr	r3, [r7, #12]	@ written.120_92, written
 6008 21ac 3A68     		ldr	r2, [r7]	@ tmp205, buf
 6009 21ae 1344     		add	r3, r3, r2	@ tmp204, tmp205
 6010 21b0 3B60     		str	r3, [r7]	@ tmp204, buf
 6011              	.L397:
 6012              		.loc 2 1088 0 discriminator 5
 6013 21b2 BA69     		ldr	r2, [r7, #24]	@ tmp207, written_total
 6014 21b4 FB68     		ldr	r3, [r7, #12]	@ tmp208, written
 6015 21b6 1344     		add	r3, r3, r2	@ tmp206, tmp207
 6016 21b8 BB61     		str	r3, [r7, #24]	@ tmp206, written_total
1089:parson.c      ****             break;
 6017              		.loc 2 1089 0 is_stmt 1 discriminator 5
 6018 21ba FEE2     		b	.L387	@
 6019              	.L363:
1090:parson.c      ****         case '\r':
1091:parson.c      ****             APPEND_STRING("\\r");
 6020              		.loc 2 1091 0
 6021 21bc 40F20001 		movw	r1, #:lower16:.LC21	@,
 6022 21c0 C0F20001 		movt	r1, #:upper16:.LC21	@,
 6023 21c4 3868     		ldr	r0, [r7]	@, buf
 6024 21c6 00F050FB 		bl	append_string	@
 6025 21ca F860     		str	r0, [r7, #12]	@, written
 6026 21cc FB68     		ldr	r3, [r7, #12]	@ tmp209, written
 6027 21ce 002B     		cmp	r3, #0	@ tmp209,
 6028 21d0 02DA     		bge	.L398	@,
 6029              		.loc 2 1091 0 is_stmt 0 discriminator 1
 6030 21d2 4FF0FF33 		mov	r3, #-1	@ _43,
 6031 21d6 12E3     		b	.L345	@
 6032              	.L398:
 6033              		.loc 2 1091 0 discriminator 2
 6034 21d8 3B68     		ldr	r3, [r7]	@ tmp210, buf
 6035 21da 002B     		cmp	r3, #0	@ tmp210,
 6036 21dc 03D0     		beq	.L399	@,
 6037              		.loc 2 1091 0 discriminator 3
 6038 21de FB68     		ldr	r3, [r7, #12]	@ written.121_98, written
 6039 21e0 3A68     		ldr	r2, [r7]	@ tmp212, buf
 6040 21e2 1344     		add	r3, r3, r2	@ tmp211, tmp212
 6041 21e4 3B60     		str	r3, [r7]	@ tmp211, buf
 6042              	.L399:
 6043              		.loc 2 1091 0 discriminator 5
 6044 21e6 BA69     		ldr	r2, [r7, #24]	@ tmp214, written_total
 6045 21e8 FB68     		ldr	r3, [r7, #12]	@ tmp215, written
 6046 21ea 1344     		add	r3, r3, r2	@ tmp213, tmp214
 6047 21ec BB61     		str	r3, [r7, #24]	@ tmp213, written_total
1092:parson.c      ****             break;
 6048              		.loc 2 1092 0 is_stmt 1 discriminator 5
 6049 21ee E4E2     		b	.L387	@
 6050              	.L359:
1093:parson.c      ****         case '\t':
1094:parson.c      ****             APPEND_STRING("\\t");
 6051              		.loc 2 1094 0
 6052 21f0 40F20001 		movw	r1, #:lower16:.LC22	@,
 6053 21f4 C0F20001 		movt	r1, #:upper16:.LC22	@,
 6054 21f8 3868     		ldr	r0, [r7]	@, buf
 6055 21fa 00F036FB 		bl	append_string	@
 6056 21fe F860     		str	r0, [r7, #12]	@, written
 6057 2200 FB68     		ldr	r3, [r7, #12]	@ tmp216, written
 6058 2202 002B     		cmp	r3, #0	@ tmp216,
 6059 2204 02DA     		bge	.L400	@,
 6060              		.loc 2 1094 0 is_stmt 0 discriminator 1
 6061 2206 4FF0FF33 		mov	r3, #-1	@ _43,
 6062 220a F8E2     		b	.L345	@
 6063              	.L400:
 6064              		.loc 2 1094 0 discriminator 2
 6065 220c 3B68     		ldr	r3, [r7]	@ tmp217, buf
 6066 220e 002B     		cmp	r3, #0	@ tmp217,
 6067 2210 03D0     		beq	.L401	@,
 6068              		.loc 2 1094 0 discriminator 3
 6069 2212 FB68     		ldr	r3, [r7, #12]	@ written.122_104, written
 6070 2214 3A68     		ldr	r2, [r7]	@ tmp219, buf
 6071 2216 1344     		add	r3, r3, r2	@ tmp218, tmp219
 6072 2218 3B60     		str	r3, [r7]	@ tmp218, buf
 6073              	.L401:
 6074              		.loc 2 1094 0 discriminator 5
 6075 221a BA69     		ldr	r2, [r7, #24]	@ tmp221, written_total
 6076 221c FB68     		ldr	r3, [r7, #12]	@ tmp222, written
 6077 221e 1344     		add	r3, r3, r2	@ tmp220, tmp221
 6078 2220 BB61     		str	r3, [r7, #24]	@ tmp220, written_total
1095:parson.c      ****             break;
 6079              		.loc 2 1095 0 is_stmt 1 discriminator 5
 6080 2222 CAE2     		b	.L387	@
 6081              	.L349:
1096:parson.c      ****         case '\x00':
1097:parson.c      ****             APPEND_STRING("\\u0000");
 6082              		.loc 2 1097 0
 6083 2224 40F20001 		movw	r1, #:lower16:.LC23	@,
 6084 2228 C0F20001 		movt	r1, #:upper16:.LC23	@,
 6085 222c 3868     		ldr	r0, [r7]	@, buf
 6086 222e 00F01CFB 		bl	append_string	@
 6087 2232 F860     		str	r0, [r7, #12]	@, written
 6088 2234 FB68     		ldr	r3, [r7, #12]	@ tmp223, written
 6089 2236 002B     		cmp	r3, #0	@ tmp223,
 6090 2238 02DA     		bge	.L402	@,
 6091              		.loc 2 1097 0 is_stmt 0 discriminator 1
 6092 223a 4FF0FF33 		mov	r3, #-1	@ _43,
 6093 223e DEE2     		b	.L345	@
 6094              	.L402:
 6095              		.loc 2 1097 0 discriminator 2
 6096 2240 3B68     		ldr	r3, [r7]	@ tmp224, buf
 6097 2242 002B     		cmp	r3, #0	@ tmp224,
 6098 2244 03D0     		beq	.L403	@,
 6099              		.loc 2 1097 0 discriminator 3
 6100 2246 FB68     		ldr	r3, [r7, #12]	@ written.123_110, written
 6101 2248 3A68     		ldr	r2, [r7]	@ tmp226, buf
 6102 224a 1344     		add	r3, r3, r2	@ tmp225, tmp226
 6103 224c 3B60     		str	r3, [r7]	@ tmp225, buf
 6104              	.L403:
 6105              		.loc 2 1097 0 discriminator 5
 6106 224e BA69     		ldr	r2, [r7, #24]	@ tmp228, written_total
 6107 2250 FB68     		ldr	r3, [r7, #12]	@ tmp229, written
 6108 2252 1344     		add	r3, r3, r2	@ tmp227, tmp228
 6109 2254 BB61     		str	r3, [r7, #24]	@ tmp227, written_total
1098:parson.c      ****             break;
 6110              		.loc 2 1098 0 is_stmt 1 discriminator 5
 6111 2256 B0E2     		b	.L387	@
 6112              	.L351:
1099:parson.c      ****         case '\x01':
1100:parson.c      ****             APPEND_STRING("\\u0001");
 6113              		.loc 2 1100 0
 6114 2258 40F20001 		movw	r1, #:lower16:.LC24	@,
 6115 225c C0F20001 		movt	r1, #:upper16:.LC24	@,
 6116 2260 3868     		ldr	r0, [r7]	@, buf
 6117 2262 00F002FB 		bl	append_string	@
 6118 2266 F860     		str	r0, [r7, #12]	@, written
 6119 2268 FB68     		ldr	r3, [r7, #12]	@ tmp230, written
 6120 226a 002B     		cmp	r3, #0	@ tmp230,
 6121 226c 02DA     		bge	.L404	@,
 6122              		.loc 2 1100 0 is_stmt 0 discriminator 1
 6123 226e 4FF0FF33 		mov	r3, #-1	@ _43,
 6124 2272 C4E2     		b	.L345	@
 6125              	.L404:
 6126              		.loc 2 1100 0 discriminator 2
 6127 2274 3B68     		ldr	r3, [r7]	@ tmp231, buf
 6128 2276 002B     		cmp	r3, #0	@ tmp231,
 6129 2278 03D0     		beq	.L405	@,
 6130              		.loc 2 1100 0 discriminator 3
 6131 227a FB68     		ldr	r3, [r7, #12]	@ written.124_116, written
 6132 227c 3A68     		ldr	r2, [r7]	@ tmp233, buf
 6133 227e 1344     		add	r3, r3, r2	@ tmp232, tmp233
 6134 2280 3B60     		str	r3, [r7]	@ tmp232, buf
 6135              	.L405:
 6136              		.loc 2 1100 0 discriminator 5
 6137 2282 BA69     		ldr	r2, [r7, #24]	@ tmp235, written_total
 6138 2284 FB68     		ldr	r3, [r7, #12]	@ tmp236, written
 6139 2286 1344     		add	r3, r3, r2	@ tmp234, tmp235
 6140 2288 BB61     		str	r3, [r7, #24]	@ tmp234, written_total
1101:parson.c      ****             break;
 6141              		.loc 2 1101 0 is_stmt 1 discriminator 5
 6142 228a 96E2     		b	.L387	@
 6143              	.L352:
1102:parson.c      ****         case '\x02':
1103:parson.c      ****             APPEND_STRING("\\u0002");
 6144              		.loc 2 1103 0
 6145 228c 40F20001 		movw	r1, #:lower16:.LC25	@,
 6146 2290 C0F20001 		movt	r1, #:upper16:.LC25	@,
 6147 2294 3868     		ldr	r0, [r7]	@, buf
 6148 2296 00F0E8FA 		bl	append_string	@
 6149 229a F860     		str	r0, [r7, #12]	@, written
 6150 229c FB68     		ldr	r3, [r7, #12]	@ tmp237, written
 6151 229e 002B     		cmp	r3, #0	@ tmp237,
 6152 22a0 02DA     		bge	.L406	@,
 6153              		.loc 2 1103 0 is_stmt 0 discriminator 1
 6154 22a2 4FF0FF33 		mov	r3, #-1	@ _43,
 6155 22a6 AAE2     		b	.L345	@
 6156              	.L406:
 6157              		.loc 2 1103 0 discriminator 2
 6158 22a8 3B68     		ldr	r3, [r7]	@ tmp238, buf
 6159 22aa 002B     		cmp	r3, #0	@ tmp238,
 6160 22ac 03D0     		beq	.L407	@,
 6161              		.loc 2 1103 0 discriminator 3
 6162 22ae FB68     		ldr	r3, [r7, #12]	@ written.125_122, written
 6163 22b0 3A68     		ldr	r2, [r7]	@ tmp240, buf
 6164 22b2 1344     		add	r3, r3, r2	@ tmp239, tmp240
 6165 22b4 3B60     		str	r3, [r7]	@ tmp239, buf
 6166              	.L407:
 6167              		.loc 2 1103 0 discriminator 5
 6168 22b6 BA69     		ldr	r2, [r7, #24]	@ tmp242, written_total
 6169 22b8 FB68     		ldr	r3, [r7, #12]	@ tmp243, written
 6170 22ba 1344     		add	r3, r3, r2	@ tmp241, tmp242
 6171 22bc BB61     		str	r3, [r7, #24]	@ tmp241, written_total
1104:parson.c      ****             break;
 6172              		.loc 2 1104 0 is_stmt 1 discriminator 5
 6173 22be 7CE2     		b	.L387	@
 6174              	.L353:
1105:parson.c      ****         case '\x03':
1106:parson.c      ****             APPEND_STRING("\\u0003");
 6175              		.loc 2 1106 0
 6176 22c0 40F20001 		movw	r1, #:lower16:.LC26	@,
 6177 22c4 C0F20001 		movt	r1, #:upper16:.LC26	@,
 6178 22c8 3868     		ldr	r0, [r7]	@, buf
 6179 22ca 00F0CEFA 		bl	append_string	@
 6180 22ce F860     		str	r0, [r7, #12]	@, written
 6181 22d0 FB68     		ldr	r3, [r7, #12]	@ tmp244, written
 6182 22d2 002B     		cmp	r3, #0	@ tmp244,
 6183 22d4 02DA     		bge	.L408	@,
 6184              		.loc 2 1106 0 is_stmt 0 discriminator 1
 6185 22d6 4FF0FF33 		mov	r3, #-1	@ _43,
 6186 22da 90E2     		b	.L345	@
 6187              	.L408:
 6188              		.loc 2 1106 0 discriminator 2
 6189 22dc 3B68     		ldr	r3, [r7]	@ tmp245, buf
 6190 22de 002B     		cmp	r3, #0	@ tmp245,
 6191 22e0 03D0     		beq	.L409	@,
 6192              		.loc 2 1106 0 discriminator 3
 6193 22e2 FB68     		ldr	r3, [r7, #12]	@ written.126_128, written
 6194 22e4 3A68     		ldr	r2, [r7]	@ tmp247, buf
 6195 22e6 1344     		add	r3, r3, r2	@ tmp246, tmp247
 6196 22e8 3B60     		str	r3, [r7]	@ tmp246, buf
 6197              	.L409:
 6198              		.loc 2 1106 0 discriminator 5
 6199 22ea BA69     		ldr	r2, [r7, #24]	@ tmp249, written_total
 6200 22ec FB68     		ldr	r3, [r7, #12]	@ tmp250, written
 6201 22ee 1344     		add	r3, r3, r2	@ tmp248, tmp249
 6202 22f0 BB61     		str	r3, [r7, #24]	@ tmp248, written_total
1107:parson.c      ****             break;
 6203              		.loc 2 1107 0 is_stmt 1 discriminator 5
 6204 22f2 62E2     		b	.L387	@
 6205              	.L354:
1108:parson.c      ****         case '\x04':
1109:parson.c      ****             APPEND_STRING("\\u0004");
 6206              		.loc 2 1109 0
 6207 22f4 40F20001 		movw	r1, #:lower16:.LC27	@,
 6208 22f8 C0F20001 		movt	r1, #:upper16:.LC27	@,
 6209 22fc 3868     		ldr	r0, [r7]	@, buf
 6210 22fe 00F0B4FA 		bl	append_string	@
 6211 2302 F860     		str	r0, [r7, #12]	@, written
 6212 2304 FB68     		ldr	r3, [r7, #12]	@ tmp251, written
 6213 2306 002B     		cmp	r3, #0	@ tmp251,
 6214 2308 02DA     		bge	.L410	@,
 6215              		.loc 2 1109 0 is_stmt 0 discriminator 1
 6216 230a 4FF0FF33 		mov	r3, #-1	@ _43,
 6217 230e 76E2     		b	.L345	@
 6218              	.L410:
 6219              		.loc 2 1109 0 discriminator 2
 6220 2310 3B68     		ldr	r3, [r7]	@ tmp252, buf
 6221 2312 002B     		cmp	r3, #0	@ tmp252,
 6222 2314 03D0     		beq	.L411	@,
 6223              		.loc 2 1109 0 discriminator 3
 6224 2316 FB68     		ldr	r3, [r7, #12]	@ written.127_134, written
 6225 2318 3A68     		ldr	r2, [r7]	@ tmp254, buf
 6226 231a 1344     		add	r3, r3, r2	@ tmp253, tmp254
 6227 231c 3B60     		str	r3, [r7]	@ tmp253, buf
 6228              	.L411:
 6229              		.loc 2 1109 0 discriminator 5
 6230 231e BA69     		ldr	r2, [r7, #24]	@ tmp256, written_total
 6231 2320 FB68     		ldr	r3, [r7, #12]	@ tmp257, written
 6232 2322 1344     		add	r3, r3, r2	@ tmp255, tmp256
 6233 2324 BB61     		str	r3, [r7, #24]	@ tmp255, written_total
1110:parson.c      ****             break;
 6234              		.loc 2 1110 0 is_stmt 1 discriminator 5
 6235 2326 48E2     		b	.L387	@
 6236              	.L355:
1111:parson.c      ****         case '\x05':
1112:parson.c      ****             APPEND_STRING("\\u0005");
 6237              		.loc 2 1112 0
 6238 2328 40F20001 		movw	r1, #:lower16:.LC28	@,
 6239 232c C0F20001 		movt	r1, #:upper16:.LC28	@,
 6240 2330 3868     		ldr	r0, [r7]	@, buf
 6241 2332 00F09AFA 		bl	append_string	@
 6242 2336 F860     		str	r0, [r7, #12]	@, written
 6243 2338 FB68     		ldr	r3, [r7, #12]	@ tmp258, written
 6244 233a 002B     		cmp	r3, #0	@ tmp258,
 6245 233c 02DA     		bge	.L412	@,
 6246              		.loc 2 1112 0 is_stmt 0 discriminator 1
 6247 233e 4FF0FF33 		mov	r3, #-1	@ _43,
 6248 2342 5CE2     		b	.L345	@
 6249              	.L412:
 6250              		.loc 2 1112 0 discriminator 2
 6251 2344 3B68     		ldr	r3, [r7]	@ tmp259, buf
 6252 2346 002B     		cmp	r3, #0	@ tmp259,
 6253 2348 03D0     		beq	.L413	@,
 6254              		.loc 2 1112 0 discriminator 3
 6255 234a FB68     		ldr	r3, [r7, #12]	@ written.128_140, written
 6256 234c 3A68     		ldr	r2, [r7]	@ tmp261, buf
 6257 234e 1344     		add	r3, r3, r2	@ tmp260, tmp261
 6258 2350 3B60     		str	r3, [r7]	@ tmp260, buf
 6259              	.L413:
 6260              		.loc 2 1112 0 discriminator 5
 6261 2352 BA69     		ldr	r2, [r7, #24]	@ tmp263, written_total
 6262 2354 FB68     		ldr	r3, [r7, #12]	@ tmp264, written
 6263 2356 1344     		add	r3, r3, r2	@ tmp262, tmp263
 6264 2358 BB61     		str	r3, [r7, #24]	@ tmp262, written_total
1113:parson.c      ****             break;
 6265              		.loc 2 1113 0 is_stmt 1 discriminator 5
 6266 235a 2EE2     		b	.L387	@
 6267              	.L356:
1114:parson.c      ****         case '\x06':
1115:parson.c      ****             APPEND_STRING("\\u0006");
 6268              		.loc 2 1115 0
 6269 235c 40F20001 		movw	r1, #:lower16:.LC29	@,
 6270 2360 C0F20001 		movt	r1, #:upper16:.LC29	@,
 6271 2364 3868     		ldr	r0, [r7]	@, buf
 6272 2366 00F080FA 		bl	append_string	@
 6273 236a F860     		str	r0, [r7, #12]	@, written
 6274 236c FB68     		ldr	r3, [r7, #12]	@ tmp265, written
 6275 236e 002B     		cmp	r3, #0	@ tmp265,
 6276 2370 02DA     		bge	.L414	@,
 6277              		.loc 2 1115 0 is_stmt 0 discriminator 1
 6278 2372 4FF0FF33 		mov	r3, #-1	@ _43,
 6279 2376 42E2     		b	.L345	@
 6280              	.L414:
 6281              		.loc 2 1115 0 discriminator 2
 6282 2378 3B68     		ldr	r3, [r7]	@ tmp266, buf
 6283 237a 002B     		cmp	r3, #0	@ tmp266,
 6284 237c 03D0     		beq	.L415	@,
 6285              		.loc 2 1115 0 discriminator 3
 6286 237e FB68     		ldr	r3, [r7, #12]	@ written.129_146, written
 6287 2380 3A68     		ldr	r2, [r7]	@ tmp268, buf
 6288 2382 1344     		add	r3, r3, r2	@ tmp267, tmp268
 6289 2384 3B60     		str	r3, [r7]	@ tmp267, buf
 6290              	.L415:
 6291              		.loc 2 1115 0 discriminator 5
 6292 2386 BA69     		ldr	r2, [r7, #24]	@ tmp270, written_total
 6293 2388 FB68     		ldr	r3, [r7, #12]	@ tmp271, written
 6294 238a 1344     		add	r3, r3, r2	@ tmp269, tmp270
 6295 238c BB61     		str	r3, [r7, #24]	@ tmp269, written_total
1116:parson.c      ****             break;
 6296              		.loc 2 1116 0 is_stmt 1 discriminator 5
 6297 238e 14E2     		b	.L387	@
 6298              	.L357:
1117:parson.c      ****         case '\x07':
1118:parson.c      ****             APPEND_STRING("\\u0007");
 6299              		.loc 2 1118 0
 6300 2390 40F20001 		movw	r1, #:lower16:.LC30	@,
 6301 2394 C0F20001 		movt	r1, #:upper16:.LC30	@,
 6302 2398 3868     		ldr	r0, [r7]	@, buf
 6303 239a 00F066FA 		bl	append_string	@
 6304 239e F860     		str	r0, [r7, #12]	@, written
 6305 23a0 FB68     		ldr	r3, [r7, #12]	@ tmp272, written
 6306 23a2 002B     		cmp	r3, #0	@ tmp272,
 6307 23a4 02DA     		bge	.L416	@,
 6308              		.loc 2 1118 0 is_stmt 0 discriminator 1
 6309 23a6 4FF0FF33 		mov	r3, #-1	@ _43,
 6310 23aa 28E2     		b	.L345	@
 6311              	.L416:
 6312              		.loc 2 1118 0 discriminator 2
 6313 23ac 3B68     		ldr	r3, [r7]	@ tmp273, buf
 6314 23ae 002B     		cmp	r3, #0	@ tmp273,
 6315 23b0 03D0     		beq	.L417	@,
 6316              		.loc 2 1118 0 discriminator 3
 6317 23b2 FB68     		ldr	r3, [r7, #12]	@ written.130_152, written
 6318 23b4 3A68     		ldr	r2, [r7]	@ tmp275, buf
 6319 23b6 1344     		add	r3, r3, r2	@ tmp274, tmp275
 6320 23b8 3B60     		str	r3, [r7]	@ tmp274, buf
 6321              	.L417:
 6322              		.loc 2 1118 0 discriminator 5
 6323 23ba BA69     		ldr	r2, [r7, #24]	@ tmp277, written_total
 6324 23bc FB68     		ldr	r3, [r7, #12]	@ tmp278, written
 6325 23be 1344     		add	r3, r3, r2	@ tmp276, tmp277
 6326 23c0 BB61     		str	r3, [r7, #24]	@ tmp276, written_total
1119:parson.c      ****             break;
 6327              		.loc 2 1119 0 is_stmt 1 discriminator 5
 6328 23c2 FAE1     		b	.L387	@
 6329              	.L361:
1120:parson.c      ****         /* '\x08' duplicate: '\b' */
1121:parson.c      ****         /* '\x09' duplicate: '\t' */
1122:parson.c      ****         /* '\x0a' duplicate: '\n' */
1123:parson.c      ****         case '\x0b':
1124:parson.c      ****             APPEND_STRING("\\u000b");
 6330              		.loc 2 1124 0
 6331 23c4 40F20001 		movw	r1, #:lower16:.LC31	@,
 6332 23c8 C0F20001 		movt	r1, #:upper16:.LC31	@,
 6333 23cc 3868     		ldr	r0, [r7]	@, buf
 6334 23ce 00F04CFA 		bl	append_string	@
 6335 23d2 F860     		str	r0, [r7, #12]	@, written
 6336 23d4 FB68     		ldr	r3, [r7, #12]	@ tmp279, written
 6337 23d6 002B     		cmp	r3, #0	@ tmp279,
 6338 23d8 02DA     		bge	.L418	@,
 6339              		.loc 2 1124 0 is_stmt 0 discriminator 1
 6340 23da 4FF0FF33 		mov	r3, #-1	@ _43,
 6341 23de 0EE2     		b	.L345	@
 6342              	.L418:
 6343              		.loc 2 1124 0 discriminator 2
 6344 23e0 3B68     		ldr	r3, [r7]	@ tmp280, buf
 6345 23e2 002B     		cmp	r3, #0	@ tmp280,
 6346 23e4 03D0     		beq	.L419	@,
 6347              		.loc 2 1124 0 discriminator 3
 6348 23e6 FB68     		ldr	r3, [r7, #12]	@ written.131_158, written
 6349 23e8 3A68     		ldr	r2, [r7]	@ tmp282, buf
 6350 23ea 1344     		add	r3, r3, r2	@ tmp281, tmp282
 6351 23ec 3B60     		str	r3, [r7]	@ tmp281, buf
 6352              	.L419:
 6353              		.loc 2 1124 0 discriminator 5
 6354 23ee BA69     		ldr	r2, [r7, #24]	@ tmp284, written_total
 6355 23f0 FB68     		ldr	r3, [r7, #12]	@ tmp285, written
 6356 23f2 1344     		add	r3, r3, r2	@ tmp283, tmp284
 6357 23f4 BB61     		str	r3, [r7, #24]	@ tmp283, written_total
1125:parson.c      ****             break;
 6358              		.loc 2 1125 0 is_stmt 1 discriminator 5
 6359 23f6 E0E1     		b	.L387	@
 6360              	.L364:
1126:parson.c      ****         /* '\x0c' duplicate: '\f' */
1127:parson.c      ****         /* '\x0d' duplicate: '\r' */
1128:parson.c      ****         case '\x0e':
1129:parson.c      ****             APPEND_STRING("\\u000e");
 6361              		.loc 2 1129 0
 6362 23f8 40F20001 		movw	r1, #:lower16:.LC32	@,
 6363 23fc C0F20001 		movt	r1, #:upper16:.LC32	@,
 6364 2400 3868     		ldr	r0, [r7]	@, buf
 6365 2402 00F032FA 		bl	append_string	@
 6366 2406 F860     		str	r0, [r7, #12]	@, written
 6367 2408 FB68     		ldr	r3, [r7, #12]	@ tmp286, written
 6368 240a 002B     		cmp	r3, #0	@ tmp286,
 6369 240c 02DA     		bge	.L420	@,
 6370              		.loc 2 1129 0 is_stmt 0 discriminator 1
 6371 240e 4FF0FF33 		mov	r3, #-1	@ _43,
 6372 2412 F4E1     		b	.L345	@
 6373              	.L420:
 6374              		.loc 2 1129 0 discriminator 2
 6375 2414 3B68     		ldr	r3, [r7]	@ tmp287, buf
 6376 2416 002B     		cmp	r3, #0	@ tmp287,
 6377 2418 03D0     		beq	.L421	@,
 6378              		.loc 2 1129 0 discriminator 3
 6379 241a FB68     		ldr	r3, [r7, #12]	@ written.132_164, written
 6380 241c 3A68     		ldr	r2, [r7]	@ tmp289, buf
 6381 241e 1344     		add	r3, r3, r2	@ tmp288, tmp289
 6382 2420 3B60     		str	r3, [r7]	@ tmp288, buf
 6383              	.L421:
 6384              		.loc 2 1129 0 discriminator 5
 6385 2422 BA69     		ldr	r2, [r7, #24]	@ tmp291, written_total
 6386 2424 FB68     		ldr	r3, [r7, #12]	@ tmp292, written
 6387 2426 1344     		add	r3, r3, r2	@ tmp290, tmp291
 6388 2428 BB61     		str	r3, [r7, #24]	@ tmp290, written_total
1130:parson.c      ****             break;
 6389              		.loc 2 1130 0 is_stmt 1 discriminator 5
 6390 242a C6E1     		b	.L387	@
 6391              	.L365:
1131:parson.c      ****         case '\x0f':
1132:parson.c      ****             APPEND_STRING("\\u000f");
 6392              		.loc 2 1132 0
 6393 242c 40F20001 		movw	r1, #:lower16:.LC33	@,
 6394 2430 C0F20001 		movt	r1, #:upper16:.LC33	@,
 6395 2434 3868     		ldr	r0, [r7]	@, buf
 6396 2436 00F018FA 		bl	append_string	@
 6397 243a F860     		str	r0, [r7, #12]	@, written
 6398 243c FB68     		ldr	r3, [r7, #12]	@ tmp293, written
 6399 243e 002B     		cmp	r3, #0	@ tmp293,
 6400 2440 02DA     		bge	.L422	@,
 6401              		.loc 2 1132 0 is_stmt 0 discriminator 1
 6402 2442 4FF0FF33 		mov	r3, #-1	@ _43,
 6403 2446 DAE1     		b	.L345	@
 6404              	.L422:
 6405              		.loc 2 1132 0 discriminator 2
 6406 2448 3B68     		ldr	r3, [r7]	@ tmp294, buf
 6407 244a 002B     		cmp	r3, #0	@ tmp294,
 6408 244c 03D0     		beq	.L423	@,
 6409              		.loc 2 1132 0 discriminator 3
 6410 244e FB68     		ldr	r3, [r7, #12]	@ written.133_170, written
 6411 2450 3A68     		ldr	r2, [r7]	@ tmp296, buf
 6412 2452 1344     		add	r3, r3, r2	@ tmp295, tmp296
 6413 2454 3B60     		str	r3, [r7]	@ tmp295, buf
 6414              	.L423:
 6415              		.loc 2 1132 0 discriminator 5
 6416 2456 BA69     		ldr	r2, [r7, #24]	@ tmp298, written_total
 6417 2458 FB68     		ldr	r3, [r7, #12]	@ tmp299, written
 6418 245a 1344     		add	r3, r3, r2	@ tmp297, tmp298
 6419 245c BB61     		str	r3, [r7, #24]	@ tmp297, written_total
1133:parson.c      ****             break;
 6420              		.loc 2 1133 0 is_stmt 1 discriminator 5
 6421 245e ACE1     		b	.L387	@
 6422              	.L366:
1134:parson.c      ****         case '\x10':
1135:parson.c      ****             APPEND_STRING("\\u0010");
 6423              		.loc 2 1135 0
 6424 2460 40F20001 		movw	r1, #:lower16:.LC34	@,
 6425 2464 C0F20001 		movt	r1, #:upper16:.LC34	@,
 6426 2468 3868     		ldr	r0, [r7]	@, buf
 6427 246a 00F0FEF9 		bl	append_string	@
 6428 246e F860     		str	r0, [r7, #12]	@, written
 6429 2470 FB68     		ldr	r3, [r7, #12]	@ tmp300, written
 6430 2472 002B     		cmp	r3, #0	@ tmp300,
 6431 2474 02DA     		bge	.L424	@,
 6432              		.loc 2 1135 0 is_stmt 0 discriminator 1
 6433 2476 4FF0FF33 		mov	r3, #-1	@ _43,
 6434 247a C0E1     		b	.L345	@
 6435              	.L424:
 6436              		.loc 2 1135 0 discriminator 2
 6437 247c 3B68     		ldr	r3, [r7]	@ tmp301, buf
 6438 247e 002B     		cmp	r3, #0	@ tmp301,
 6439 2480 03D0     		beq	.L425	@,
 6440              		.loc 2 1135 0 discriminator 3
 6441 2482 FB68     		ldr	r3, [r7, #12]	@ written.134_176, written
 6442 2484 3A68     		ldr	r2, [r7]	@ tmp303, buf
 6443 2486 1344     		add	r3, r3, r2	@ tmp302, tmp303
 6444 2488 3B60     		str	r3, [r7]	@ tmp302, buf
 6445              	.L425:
 6446              		.loc 2 1135 0 discriminator 5
 6447 248a BA69     		ldr	r2, [r7, #24]	@ tmp305, written_total
 6448 248c FB68     		ldr	r3, [r7, #12]	@ tmp306, written
 6449 248e 1344     		add	r3, r3, r2	@ tmp304, tmp305
 6450 2490 BB61     		str	r3, [r7, #24]	@ tmp304, written_total
1136:parson.c      ****             break;
 6451              		.loc 2 1136 0 is_stmt 1 discriminator 5
 6452 2492 92E1     		b	.L387	@
 6453              	.L367:
1137:parson.c      ****         case '\x11':
1138:parson.c      ****             APPEND_STRING("\\u0011");
 6454              		.loc 2 1138 0
 6455 2494 40F20001 		movw	r1, #:lower16:.LC35	@,
 6456 2498 C0F20001 		movt	r1, #:upper16:.LC35	@,
 6457 249c 3868     		ldr	r0, [r7]	@, buf
 6458 249e 00F0E4F9 		bl	append_string	@
 6459 24a2 F860     		str	r0, [r7, #12]	@, written
 6460 24a4 FB68     		ldr	r3, [r7, #12]	@ tmp307, written
 6461 24a6 002B     		cmp	r3, #0	@ tmp307,
 6462 24a8 02DA     		bge	.L426	@,
 6463              		.loc 2 1138 0 is_stmt 0 discriminator 1
 6464 24aa 4FF0FF33 		mov	r3, #-1	@ _43,
 6465 24ae A6E1     		b	.L345	@
 6466              	.L426:
 6467              		.loc 2 1138 0 discriminator 2
 6468 24b0 3B68     		ldr	r3, [r7]	@ tmp308, buf
 6469 24b2 002B     		cmp	r3, #0	@ tmp308,
 6470 24b4 03D0     		beq	.L427	@,
 6471              		.loc 2 1138 0 discriminator 3
 6472 24b6 FB68     		ldr	r3, [r7, #12]	@ written.135_182, written
 6473 24b8 3A68     		ldr	r2, [r7]	@ tmp310, buf
 6474 24ba 1344     		add	r3, r3, r2	@ tmp309, tmp310
 6475 24bc 3B60     		str	r3, [r7]	@ tmp309, buf
 6476              	.L427:
 6477              		.loc 2 1138 0 discriminator 5
 6478 24be BA69     		ldr	r2, [r7, #24]	@ tmp312, written_total
 6479 24c0 FB68     		ldr	r3, [r7, #12]	@ tmp313, written
 6480 24c2 1344     		add	r3, r3, r2	@ tmp311, tmp312
 6481 24c4 BB61     		str	r3, [r7, #24]	@ tmp311, written_total
1139:parson.c      ****             break;
 6482              		.loc 2 1139 0 is_stmt 1 discriminator 5
 6483 24c6 78E1     		b	.L387	@
 6484              	.L368:
1140:parson.c      ****         case '\x12':
1141:parson.c      ****             APPEND_STRING("\\u0012");
 6485              		.loc 2 1141 0
 6486 24c8 40F20001 		movw	r1, #:lower16:.LC36	@,
 6487 24cc C0F20001 		movt	r1, #:upper16:.LC36	@,
 6488 24d0 3868     		ldr	r0, [r7]	@, buf
 6489 24d2 00F0CAF9 		bl	append_string	@
 6490 24d6 F860     		str	r0, [r7, #12]	@, written
 6491 24d8 FB68     		ldr	r3, [r7, #12]	@ tmp314, written
 6492 24da 002B     		cmp	r3, #0	@ tmp314,
 6493 24dc 02DA     		bge	.L428	@,
 6494              		.loc 2 1141 0 is_stmt 0 discriminator 1
 6495 24de 4FF0FF33 		mov	r3, #-1	@ _43,
 6496 24e2 8CE1     		b	.L345	@
 6497              	.L428:
 6498              		.loc 2 1141 0 discriminator 2
 6499 24e4 3B68     		ldr	r3, [r7]	@ tmp315, buf
 6500 24e6 002B     		cmp	r3, #0	@ tmp315,
 6501 24e8 03D0     		beq	.L429	@,
 6502              		.loc 2 1141 0 discriminator 3
 6503 24ea FB68     		ldr	r3, [r7, #12]	@ written.136_188, written
 6504 24ec 3A68     		ldr	r2, [r7]	@ tmp317, buf
 6505 24ee 1344     		add	r3, r3, r2	@ tmp316, tmp317
 6506 24f0 3B60     		str	r3, [r7]	@ tmp316, buf
 6507              	.L429:
 6508              		.loc 2 1141 0 discriminator 5
 6509 24f2 BA69     		ldr	r2, [r7, #24]	@ tmp319, written_total
 6510 24f4 FB68     		ldr	r3, [r7, #12]	@ tmp320, written
 6511 24f6 1344     		add	r3, r3, r2	@ tmp318, tmp319
 6512 24f8 BB61     		str	r3, [r7, #24]	@ tmp318, written_total
1142:parson.c      ****             break;
 6513              		.loc 2 1142 0 is_stmt 1 discriminator 5
 6514 24fa 5EE1     		b	.L387	@
 6515              	.L369:
1143:parson.c      ****         case '\x13':
1144:parson.c      ****             APPEND_STRING("\\u0013");
 6516              		.loc 2 1144 0
 6517 24fc 40F20001 		movw	r1, #:lower16:.LC37	@,
 6518 2500 C0F20001 		movt	r1, #:upper16:.LC37	@,
 6519 2504 3868     		ldr	r0, [r7]	@, buf
 6520 2506 00F0B0F9 		bl	append_string	@
 6521 250a F860     		str	r0, [r7, #12]	@, written
 6522 250c FB68     		ldr	r3, [r7, #12]	@ tmp321, written
 6523 250e 002B     		cmp	r3, #0	@ tmp321,
 6524 2510 02DA     		bge	.L430	@,
 6525              		.loc 2 1144 0 is_stmt 0 discriminator 1
 6526 2512 4FF0FF33 		mov	r3, #-1	@ _43,
 6527 2516 72E1     		b	.L345	@
 6528              	.L430:
 6529              		.loc 2 1144 0 discriminator 2
 6530 2518 3B68     		ldr	r3, [r7]	@ tmp322, buf
 6531 251a 002B     		cmp	r3, #0	@ tmp322,
 6532 251c 03D0     		beq	.L431	@,
 6533              		.loc 2 1144 0 discriminator 3
 6534 251e FB68     		ldr	r3, [r7, #12]	@ written.137_194, written
 6535 2520 3A68     		ldr	r2, [r7]	@ tmp324, buf
 6536 2522 1344     		add	r3, r3, r2	@ tmp323, tmp324
 6537 2524 3B60     		str	r3, [r7]	@ tmp323, buf
 6538              	.L431:
 6539              		.loc 2 1144 0 discriminator 5
 6540 2526 BA69     		ldr	r2, [r7, #24]	@ tmp326, written_total
 6541 2528 FB68     		ldr	r3, [r7, #12]	@ tmp327, written
 6542 252a 1344     		add	r3, r3, r2	@ tmp325, tmp326
 6543 252c BB61     		str	r3, [r7, #24]	@ tmp325, written_total
1145:parson.c      ****             break;
 6544              		.loc 2 1145 0 is_stmt 1 discriminator 5
 6545 252e 44E1     		b	.L387	@
 6546              	.L370:
1146:parson.c      ****         case '\x14':
1147:parson.c      ****             APPEND_STRING("\\u0014");
 6547              		.loc 2 1147 0
 6548 2530 40F20001 		movw	r1, #:lower16:.LC38	@,
 6549 2534 C0F20001 		movt	r1, #:upper16:.LC38	@,
 6550 2538 3868     		ldr	r0, [r7]	@, buf
 6551 253a 00F096F9 		bl	append_string	@
 6552 253e F860     		str	r0, [r7, #12]	@, written
 6553 2540 FB68     		ldr	r3, [r7, #12]	@ tmp328, written
 6554 2542 002B     		cmp	r3, #0	@ tmp328,
 6555 2544 02DA     		bge	.L432	@,
 6556              		.loc 2 1147 0 is_stmt 0 discriminator 1
 6557 2546 4FF0FF33 		mov	r3, #-1	@ _43,
 6558 254a 58E1     		b	.L345	@
 6559              	.L432:
 6560              		.loc 2 1147 0 discriminator 2
 6561 254c 3B68     		ldr	r3, [r7]	@ tmp329, buf
 6562 254e 002B     		cmp	r3, #0	@ tmp329,
 6563 2550 03D0     		beq	.L433	@,
 6564              		.loc 2 1147 0 discriminator 3
 6565 2552 FB68     		ldr	r3, [r7, #12]	@ written.138_200, written
 6566 2554 3A68     		ldr	r2, [r7]	@ tmp331, buf
 6567 2556 1344     		add	r3, r3, r2	@ tmp330, tmp331
 6568 2558 3B60     		str	r3, [r7]	@ tmp330, buf
 6569              	.L433:
 6570              		.loc 2 1147 0 discriminator 5
 6571 255a BA69     		ldr	r2, [r7, #24]	@ tmp333, written_total
 6572 255c FB68     		ldr	r3, [r7, #12]	@ tmp334, written
 6573 255e 1344     		add	r3, r3, r2	@ tmp332, tmp333
 6574 2560 BB61     		str	r3, [r7, #24]	@ tmp332, written_total
1148:parson.c      ****             break;
 6575              		.loc 2 1148 0 is_stmt 1 discriminator 5
 6576 2562 2AE1     		b	.L387	@
 6577              	.L371:
1149:parson.c      ****         case '\x15':
1150:parson.c      ****             APPEND_STRING("\\u0015");
 6578              		.loc 2 1150 0
 6579 2564 40F20001 		movw	r1, #:lower16:.LC39	@,
 6580 2568 C0F20001 		movt	r1, #:upper16:.LC39	@,
 6581 256c 3868     		ldr	r0, [r7]	@, buf
 6582 256e 00F07CF9 		bl	append_string	@
 6583 2572 F860     		str	r0, [r7, #12]	@, written
 6584 2574 FB68     		ldr	r3, [r7, #12]	@ tmp335, written
 6585 2576 002B     		cmp	r3, #0	@ tmp335,
 6586 2578 02DA     		bge	.L434	@,
 6587              		.loc 2 1150 0 is_stmt 0 discriminator 1
 6588 257a 4FF0FF33 		mov	r3, #-1	@ _43,
 6589 257e 3EE1     		b	.L345	@
 6590              	.L434:
 6591              		.loc 2 1150 0 discriminator 2
 6592 2580 3B68     		ldr	r3, [r7]	@ tmp336, buf
 6593 2582 002B     		cmp	r3, #0	@ tmp336,
 6594 2584 03D0     		beq	.L435	@,
 6595              		.loc 2 1150 0 discriminator 3
 6596 2586 FB68     		ldr	r3, [r7, #12]	@ written.139_206, written
 6597 2588 3A68     		ldr	r2, [r7]	@ tmp338, buf
 6598 258a 1344     		add	r3, r3, r2	@ tmp337, tmp338
 6599 258c 3B60     		str	r3, [r7]	@ tmp337, buf
 6600              	.L435:
 6601              		.loc 2 1150 0 discriminator 5
 6602 258e BA69     		ldr	r2, [r7, #24]	@ tmp340, written_total
 6603 2590 FB68     		ldr	r3, [r7, #12]	@ tmp341, written
 6604 2592 1344     		add	r3, r3, r2	@ tmp339, tmp340
 6605 2594 BB61     		str	r3, [r7, #24]	@ tmp339, written_total
1151:parson.c      ****             break;
 6606              		.loc 2 1151 0 is_stmt 1 discriminator 5
 6607 2596 10E1     		b	.L387	@
 6608              	.L372:
1152:parson.c      ****         case '\x16':
1153:parson.c      ****             APPEND_STRING("\\u0016");
 6609              		.loc 2 1153 0
 6610 2598 40F20001 		movw	r1, #:lower16:.LC40	@,
 6611 259c C0F20001 		movt	r1, #:upper16:.LC40	@,
 6612 25a0 3868     		ldr	r0, [r7]	@, buf
 6613 25a2 00F062F9 		bl	append_string	@
 6614 25a6 F860     		str	r0, [r7, #12]	@, written
 6615 25a8 FB68     		ldr	r3, [r7, #12]	@ tmp342, written
 6616 25aa 002B     		cmp	r3, #0	@ tmp342,
 6617 25ac 02DA     		bge	.L436	@,
 6618              		.loc 2 1153 0 is_stmt 0 discriminator 1
 6619 25ae 4FF0FF33 		mov	r3, #-1	@ _43,
 6620 25b2 24E1     		b	.L345	@
 6621              	.L436:
 6622              		.loc 2 1153 0 discriminator 2
 6623 25b4 3B68     		ldr	r3, [r7]	@ tmp343, buf
 6624 25b6 002B     		cmp	r3, #0	@ tmp343,
 6625 25b8 03D0     		beq	.L437	@,
 6626              		.loc 2 1153 0 discriminator 3
 6627 25ba FB68     		ldr	r3, [r7, #12]	@ written.140_212, written
 6628 25bc 3A68     		ldr	r2, [r7]	@ tmp345, buf
 6629 25be 1344     		add	r3, r3, r2	@ tmp344, tmp345
 6630 25c0 3B60     		str	r3, [r7]	@ tmp344, buf
 6631              	.L437:
 6632              		.loc 2 1153 0 discriminator 5
 6633 25c2 BA69     		ldr	r2, [r7, #24]	@ tmp347, written_total
 6634 25c4 FB68     		ldr	r3, [r7, #12]	@ tmp348, written
 6635 25c6 1344     		add	r3, r3, r2	@ tmp346, tmp347
 6636 25c8 BB61     		str	r3, [r7, #24]	@ tmp346, written_total
1154:parson.c      ****             break;
 6637              		.loc 2 1154 0 is_stmt 1 discriminator 5
 6638 25ca F6E0     		b	.L387	@
 6639              	.L373:
1155:parson.c      ****         case '\x17':
1156:parson.c      ****             APPEND_STRING("\\u0017");
 6640              		.loc 2 1156 0
 6641 25cc 40F20001 		movw	r1, #:lower16:.LC41	@,
 6642 25d0 C0F20001 		movt	r1, #:upper16:.LC41	@,
 6643 25d4 3868     		ldr	r0, [r7]	@, buf
 6644 25d6 00F048F9 		bl	append_string	@
 6645 25da F860     		str	r0, [r7, #12]	@, written
 6646 25dc FB68     		ldr	r3, [r7, #12]	@ tmp349, written
 6647 25de 002B     		cmp	r3, #0	@ tmp349,
 6648 25e0 02DA     		bge	.L438	@,
 6649              		.loc 2 1156 0 is_stmt 0 discriminator 1
 6650 25e2 4FF0FF33 		mov	r3, #-1	@ _43,
 6651 25e6 0AE1     		b	.L345	@
 6652              	.L438:
 6653              		.loc 2 1156 0 discriminator 2
 6654 25e8 3B68     		ldr	r3, [r7]	@ tmp350, buf
 6655 25ea 002B     		cmp	r3, #0	@ tmp350,
 6656 25ec 03D0     		beq	.L439	@,
 6657              		.loc 2 1156 0 discriminator 3
 6658 25ee FB68     		ldr	r3, [r7, #12]	@ written.141_218, written
 6659 25f0 3A68     		ldr	r2, [r7]	@ tmp352, buf
 6660 25f2 1344     		add	r3, r3, r2	@ tmp351, tmp352
 6661 25f4 3B60     		str	r3, [r7]	@ tmp351, buf
 6662              	.L439:
 6663              		.loc 2 1156 0 discriminator 5
 6664 25f6 BA69     		ldr	r2, [r7, #24]	@ tmp354, written_total
 6665 25f8 FB68     		ldr	r3, [r7, #12]	@ tmp355, written
 6666 25fa 1344     		add	r3, r3, r2	@ tmp353, tmp354
 6667 25fc BB61     		str	r3, [r7, #24]	@ tmp353, written_total
1157:parson.c      ****             break;
 6668              		.loc 2 1157 0 is_stmt 1 discriminator 5
 6669 25fe DCE0     		b	.L387	@
 6670              	.L374:
1158:parson.c      ****         case '\x18':
1159:parson.c      ****             APPEND_STRING("\\u0018");
 6671              		.loc 2 1159 0
 6672 2600 40F20001 		movw	r1, #:lower16:.LC42	@,
 6673 2604 C0F20001 		movt	r1, #:upper16:.LC42	@,
 6674 2608 3868     		ldr	r0, [r7]	@, buf
 6675 260a 00F02EF9 		bl	append_string	@
 6676 260e F860     		str	r0, [r7, #12]	@, written
 6677 2610 FB68     		ldr	r3, [r7, #12]	@ tmp356, written
 6678 2612 002B     		cmp	r3, #0	@ tmp356,
 6679 2614 02DA     		bge	.L440	@,
 6680              		.loc 2 1159 0 is_stmt 0 discriminator 1
 6681 2616 4FF0FF33 		mov	r3, #-1	@ _43,
 6682 261a F0E0     		b	.L345	@
 6683              	.L440:
 6684              		.loc 2 1159 0 discriminator 2
 6685 261c 3B68     		ldr	r3, [r7]	@ tmp357, buf
 6686 261e 002B     		cmp	r3, #0	@ tmp357,
 6687 2620 03D0     		beq	.L441	@,
 6688              		.loc 2 1159 0 discriminator 3
 6689 2622 FB68     		ldr	r3, [r7, #12]	@ written.142_224, written
 6690 2624 3A68     		ldr	r2, [r7]	@ tmp359, buf
 6691 2626 1344     		add	r3, r3, r2	@ tmp358, tmp359
 6692 2628 3B60     		str	r3, [r7]	@ tmp358, buf
 6693              	.L441:
 6694              		.loc 2 1159 0 discriminator 5
 6695 262a BA69     		ldr	r2, [r7, #24]	@ tmp361, written_total
 6696 262c FB68     		ldr	r3, [r7, #12]	@ tmp362, written
 6697 262e 1344     		add	r3, r3, r2	@ tmp360, tmp361
 6698 2630 BB61     		str	r3, [r7, #24]	@ tmp360, written_total
1160:parson.c      ****             break;
 6699              		.loc 2 1160 0 is_stmt 1 discriminator 5
 6700 2632 C2E0     		b	.L387	@
 6701              	.L375:
1161:parson.c      ****         case '\x19':
1162:parson.c      ****             APPEND_STRING("\\u0019");
 6702              		.loc 2 1162 0
 6703 2634 40F20001 		movw	r1, #:lower16:.LC43	@,
 6704 2638 C0F20001 		movt	r1, #:upper16:.LC43	@,
 6705 263c 3868     		ldr	r0, [r7]	@, buf
 6706 263e 00F014F9 		bl	append_string	@
 6707 2642 F860     		str	r0, [r7, #12]	@, written
 6708 2644 FB68     		ldr	r3, [r7, #12]	@ tmp363, written
 6709 2646 002B     		cmp	r3, #0	@ tmp363,
 6710 2648 02DA     		bge	.L442	@,
 6711              		.loc 2 1162 0 is_stmt 0 discriminator 1
 6712 264a 4FF0FF33 		mov	r3, #-1	@ _43,
 6713 264e D6E0     		b	.L345	@
 6714              	.L442:
 6715              		.loc 2 1162 0 discriminator 2
 6716 2650 3B68     		ldr	r3, [r7]	@ tmp364, buf
 6717 2652 002B     		cmp	r3, #0	@ tmp364,
 6718 2654 03D0     		beq	.L443	@,
 6719              		.loc 2 1162 0 discriminator 3
 6720 2656 FB68     		ldr	r3, [r7, #12]	@ written.143_230, written
 6721 2658 3A68     		ldr	r2, [r7]	@ tmp366, buf
 6722 265a 1344     		add	r3, r3, r2	@ tmp365, tmp366
 6723 265c 3B60     		str	r3, [r7]	@ tmp365, buf
 6724              	.L443:
 6725              		.loc 2 1162 0 discriminator 5
 6726 265e BA69     		ldr	r2, [r7, #24]	@ tmp368, written_total
 6727 2660 FB68     		ldr	r3, [r7, #12]	@ tmp369, written
 6728 2662 1344     		add	r3, r3, r2	@ tmp367, tmp368
 6729 2664 BB61     		str	r3, [r7, #24]	@ tmp367, written_total
1163:parson.c      ****             break;
 6730              		.loc 2 1163 0 is_stmt 1 discriminator 5
 6731 2666 A8E0     		b	.L387	@
 6732              	.L376:
1164:parson.c      ****         case '\x1a':
1165:parson.c      ****             APPEND_STRING("\\u001a");
 6733              		.loc 2 1165 0
 6734 2668 40F20001 		movw	r1, #:lower16:.LC44	@,
 6735 266c C0F20001 		movt	r1, #:upper16:.LC44	@,
 6736 2670 3868     		ldr	r0, [r7]	@, buf
 6737 2672 00F0FAF8 		bl	append_string	@
 6738 2676 F860     		str	r0, [r7, #12]	@, written
 6739 2678 FB68     		ldr	r3, [r7, #12]	@ tmp370, written
 6740 267a 002B     		cmp	r3, #0	@ tmp370,
 6741 267c 02DA     		bge	.L444	@,
 6742              		.loc 2 1165 0 is_stmt 0 discriminator 1
 6743 267e 4FF0FF33 		mov	r3, #-1	@ _43,
 6744 2682 BCE0     		b	.L345	@
 6745              	.L444:
 6746              		.loc 2 1165 0 discriminator 2
 6747 2684 3B68     		ldr	r3, [r7]	@ tmp371, buf
 6748 2686 002B     		cmp	r3, #0	@ tmp371,
 6749 2688 03D0     		beq	.L445	@,
 6750              		.loc 2 1165 0 discriminator 3
 6751 268a FB68     		ldr	r3, [r7, #12]	@ written.144_236, written
 6752 268c 3A68     		ldr	r2, [r7]	@ tmp373, buf
 6753 268e 1344     		add	r3, r3, r2	@ tmp372, tmp373
 6754 2690 3B60     		str	r3, [r7]	@ tmp372, buf
 6755              	.L445:
 6756              		.loc 2 1165 0 discriminator 5
 6757 2692 BA69     		ldr	r2, [r7, #24]	@ tmp375, written_total
 6758 2694 FB68     		ldr	r3, [r7, #12]	@ tmp376, written
 6759 2696 1344     		add	r3, r3, r2	@ tmp374, tmp375
 6760 2698 BB61     		str	r3, [r7, #24]	@ tmp374, written_total
1166:parson.c      ****             break;
 6761              		.loc 2 1166 0 is_stmt 1 discriminator 5
 6762 269a 8EE0     		b	.L387	@
 6763              	.L377:
1167:parson.c      ****         case '\x1b':
1168:parson.c      ****             APPEND_STRING("\\u001b");
 6764              		.loc 2 1168 0
 6765 269c 40F20001 		movw	r1, #:lower16:.LC45	@,
 6766 26a0 C0F20001 		movt	r1, #:upper16:.LC45	@,
 6767 26a4 3868     		ldr	r0, [r7]	@, buf
 6768 26a6 00F0E0F8 		bl	append_string	@
 6769 26aa F860     		str	r0, [r7, #12]	@, written
 6770 26ac FB68     		ldr	r3, [r7, #12]	@ tmp377, written
 6771 26ae 002B     		cmp	r3, #0	@ tmp377,
 6772 26b0 02DA     		bge	.L446	@,
 6773              		.loc 2 1168 0 is_stmt 0 discriminator 1
 6774 26b2 4FF0FF33 		mov	r3, #-1	@ _43,
 6775 26b6 A2E0     		b	.L345	@
 6776              	.L446:
 6777              		.loc 2 1168 0 discriminator 2
 6778 26b8 3B68     		ldr	r3, [r7]	@ tmp378, buf
 6779 26ba 002B     		cmp	r3, #0	@ tmp378,
 6780 26bc 03D0     		beq	.L447	@,
 6781              		.loc 2 1168 0 discriminator 3
 6782 26be FB68     		ldr	r3, [r7, #12]	@ written.145_242, written
 6783 26c0 3A68     		ldr	r2, [r7]	@ tmp380, buf
 6784 26c2 1344     		add	r3, r3, r2	@ tmp379, tmp380
 6785 26c4 3B60     		str	r3, [r7]	@ tmp379, buf
 6786              	.L447:
 6787              		.loc 2 1168 0 discriminator 5
 6788 26c6 BA69     		ldr	r2, [r7, #24]	@ tmp382, written_total
 6789 26c8 FB68     		ldr	r3, [r7, #12]	@ tmp383, written
 6790 26ca 1344     		add	r3, r3, r2	@ tmp381, tmp382
 6791 26cc BB61     		str	r3, [r7, #24]	@ tmp381, written_total
1169:parson.c      ****             break;
 6792              		.loc 2 1169 0 is_stmt 1 discriminator 5
 6793 26ce 74E0     		b	.L387	@
 6794              	.L378:
1170:parson.c      ****         case '\x1c':
1171:parson.c      ****             APPEND_STRING("\\u001c");
 6795              		.loc 2 1171 0
 6796 26d0 40F20001 		movw	r1, #:lower16:.LC46	@,
 6797 26d4 C0F20001 		movt	r1, #:upper16:.LC46	@,
 6798 26d8 3868     		ldr	r0, [r7]	@, buf
 6799 26da 00F0C6F8 		bl	append_string	@
 6800 26de F860     		str	r0, [r7, #12]	@, written
 6801 26e0 FB68     		ldr	r3, [r7, #12]	@ tmp384, written
 6802 26e2 002B     		cmp	r3, #0	@ tmp384,
 6803 26e4 02DA     		bge	.L448	@,
 6804              		.loc 2 1171 0 is_stmt 0 discriminator 1
 6805 26e6 4FF0FF33 		mov	r3, #-1	@ _43,
 6806 26ea 88E0     		b	.L345	@
 6807              	.L448:
 6808              		.loc 2 1171 0 discriminator 2
 6809 26ec 3B68     		ldr	r3, [r7]	@ tmp385, buf
 6810 26ee 002B     		cmp	r3, #0	@ tmp385,
 6811 26f0 03D0     		beq	.L449	@,
 6812              		.loc 2 1171 0 discriminator 3
 6813 26f2 FB68     		ldr	r3, [r7, #12]	@ written.146_248, written
 6814 26f4 3A68     		ldr	r2, [r7]	@ tmp387, buf
 6815 26f6 1344     		add	r3, r3, r2	@ tmp386, tmp387
 6816 26f8 3B60     		str	r3, [r7]	@ tmp386, buf
 6817              	.L449:
 6818              		.loc 2 1171 0 discriminator 5
 6819 26fa BA69     		ldr	r2, [r7, #24]	@ tmp389, written_total
 6820 26fc FB68     		ldr	r3, [r7, #12]	@ tmp390, written
 6821 26fe 1344     		add	r3, r3, r2	@ tmp388, tmp389
 6822 2700 BB61     		str	r3, [r7, #24]	@ tmp388, written_total
1172:parson.c      ****             break;
 6823              		.loc 2 1172 0 is_stmt 1 discriminator 5
 6824 2702 5AE0     		b	.L387	@
 6825              	.L379:
1173:parson.c      ****         case '\x1d':
1174:parson.c      ****             APPEND_STRING("\\u001d");
 6826              		.loc 2 1174 0
 6827 2704 40F20001 		movw	r1, #:lower16:.LC47	@,
 6828 2708 C0F20001 		movt	r1, #:upper16:.LC47	@,
 6829 270c 3868     		ldr	r0, [r7]	@, buf
 6830 270e 00F0ACF8 		bl	append_string	@
 6831 2712 F860     		str	r0, [r7, #12]	@, written
 6832 2714 FB68     		ldr	r3, [r7, #12]	@ tmp391, written
 6833 2716 002B     		cmp	r3, #0	@ tmp391,
 6834 2718 02DA     		bge	.L450	@,
 6835              		.loc 2 1174 0 is_stmt 0 discriminator 1
 6836 271a 4FF0FF33 		mov	r3, #-1	@ _43,
 6837 271e 6EE0     		b	.L345	@
 6838              	.L450:
 6839              		.loc 2 1174 0 discriminator 2
 6840 2720 3B68     		ldr	r3, [r7]	@ tmp392, buf
 6841 2722 002B     		cmp	r3, #0	@ tmp392,
 6842 2724 03D0     		beq	.L451	@,
 6843              		.loc 2 1174 0 discriminator 3
 6844 2726 FB68     		ldr	r3, [r7, #12]	@ written.147_254, written
 6845 2728 3A68     		ldr	r2, [r7]	@ tmp394, buf
 6846 272a 1344     		add	r3, r3, r2	@ tmp393, tmp394
 6847 272c 3B60     		str	r3, [r7]	@ tmp393, buf
 6848              	.L451:
 6849              		.loc 2 1174 0 discriminator 5
 6850 272e BA69     		ldr	r2, [r7, #24]	@ tmp396, written_total
 6851 2730 FB68     		ldr	r3, [r7, #12]	@ tmp397, written
 6852 2732 1344     		add	r3, r3, r2	@ tmp395, tmp396
 6853 2734 BB61     		str	r3, [r7, #24]	@ tmp395, written_total
1175:parson.c      ****             break;
 6854              		.loc 2 1175 0 is_stmt 1 discriminator 5
 6855 2736 40E0     		b	.L387	@
 6856              	.L380:
1176:parson.c      ****         case '\x1e':
1177:parson.c      ****             APPEND_STRING("\\u001e");
 6857              		.loc 2 1177 0
 6858 2738 40F20001 		movw	r1, #:lower16:.LC48	@,
 6859 273c C0F20001 		movt	r1, #:upper16:.LC48	@,
 6860 2740 3868     		ldr	r0, [r7]	@, buf
 6861 2742 00F092F8 		bl	append_string	@
 6862 2746 F860     		str	r0, [r7, #12]	@, written
 6863 2748 FB68     		ldr	r3, [r7, #12]	@ tmp398, written
 6864 274a 002B     		cmp	r3, #0	@ tmp398,
 6865 274c 02DA     		bge	.L452	@,
 6866              		.loc 2 1177 0 is_stmt 0 discriminator 1
 6867 274e 4FF0FF33 		mov	r3, #-1	@ _43,
 6868 2752 54E0     		b	.L345	@
 6869              	.L452:
 6870              		.loc 2 1177 0 discriminator 2
 6871 2754 3B68     		ldr	r3, [r7]	@ tmp399, buf
 6872 2756 002B     		cmp	r3, #0	@ tmp399,
 6873 2758 03D0     		beq	.L453	@,
 6874              		.loc 2 1177 0 discriminator 3
 6875 275a FB68     		ldr	r3, [r7, #12]	@ written.148_260, written
 6876 275c 3A68     		ldr	r2, [r7]	@ tmp401, buf
 6877 275e 1344     		add	r3, r3, r2	@ tmp400, tmp401
 6878 2760 3B60     		str	r3, [r7]	@ tmp400, buf
 6879              	.L453:
 6880              		.loc 2 1177 0 discriminator 5
 6881 2762 BA69     		ldr	r2, [r7, #24]	@ tmp403, written_total
 6882 2764 FB68     		ldr	r3, [r7, #12]	@ tmp404, written
 6883 2766 1344     		add	r3, r3, r2	@ tmp402, tmp403
 6884 2768 BB61     		str	r3, [r7, #24]	@ tmp402, written_total
1178:parson.c      ****             break;
 6885              		.loc 2 1178 0 is_stmt 1 discriminator 5
 6886 276a 26E0     		b	.L387	@
 6887              	.L381:
1179:parson.c      ****         case '\x1f':
1180:parson.c      ****             APPEND_STRING("\\u001f");
 6888              		.loc 2 1180 0
 6889 276c 40F20001 		movw	r1, #:lower16:.LC49	@,
 6890 2770 C0F20001 		movt	r1, #:upper16:.LC49	@,
 6891 2774 3868     		ldr	r0, [r7]	@, buf
 6892 2776 00F078F8 		bl	append_string	@
 6893 277a F860     		str	r0, [r7, #12]	@, written
 6894 277c FB68     		ldr	r3, [r7, #12]	@ tmp405, written
 6895 277e 002B     		cmp	r3, #0	@ tmp405,
 6896 2780 02DA     		bge	.L454	@,
 6897              		.loc 2 1180 0 is_stmt 0 discriminator 1
 6898 2782 4FF0FF33 		mov	r3, #-1	@ _43,
 6899 2786 3AE0     		b	.L345	@
 6900              	.L454:
 6901              		.loc 2 1180 0 discriminator 2
 6902 2788 3B68     		ldr	r3, [r7]	@ tmp406, buf
 6903 278a 002B     		cmp	r3, #0	@ tmp406,
 6904 278c 03D0     		beq	.L455	@,
 6905              		.loc 2 1180 0 discriminator 3
 6906 278e FB68     		ldr	r3, [r7, #12]	@ written.149_266, written
 6907 2790 3A68     		ldr	r2, [r7]	@ tmp408, buf
 6908 2792 1344     		add	r3, r3, r2	@ tmp407, tmp408
 6909 2794 3B60     		str	r3, [r7]	@ tmp407, buf
 6910              	.L455:
 6911              		.loc 2 1180 0 discriminator 5
 6912 2796 BA69     		ldr	r2, [r7, #24]	@ tmp410, written_total
 6913 2798 FB68     		ldr	r3, [r7, #12]	@ tmp411, written
 6914 279a 1344     		add	r3, r3, r2	@ tmp409, tmp410
 6915 279c BB61     		str	r3, [r7, #24]	@ tmp409, written_total
1181:parson.c      ****             break;
 6916              		.loc 2 1181 0 is_stmt 1 discriminator 5
 6917 279e 0CE0     		b	.L387	@
 6918              	.L348:
1182:parson.c      ****         default:
1183:parson.c      ****             if (buf != NULL) {
 6919              		.loc 2 1183 0
 6920 27a0 3B68     		ldr	r3, [r7]	@ tmp412, buf
 6921 27a2 002B     		cmp	r3, #0	@ tmp412,
 6922 27a4 05D0     		beq	.L456	@,
1184:parson.c      ****                 buf[0] = c;
 6923              		.loc 2 1184 0
 6924 27a6 3B68     		ldr	r3, [r7]	@ tmp413, buf
 6925 27a8 FA7C     		ldrb	r2, [r7, #19]	@ tmp414, c
 6926 27aa 1A70     		strb	r2, [r3]	@ tmp414, *buf_39
1185:parson.c      ****                 buf += 1;
 6927              		.loc 2 1185 0
 6928 27ac 3B68     		ldr	r3, [r7]	@ tmp416, buf
 6929 27ae 0133     		adds	r3, r3, #1	@ tmp415, tmp416,
 6930 27b0 3B60     		str	r3, [r7]	@ tmp415, buf
 6931              	.L456:
1186:parson.c      ****             }
1187:parson.c      ****             written_total += 1;
 6932              		.loc 2 1187 0
 6933 27b2 BB69     		ldr	r3, [r7, #24]	@ tmp418, written_total
 6934 27b4 0133     		adds	r3, r3, #1	@ tmp417, tmp418,
 6935 27b6 BB61     		str	r3, [r7, #24]	@ tmp417, written_total
1188:parson.c      ****             break;
 6936              		.loc 2 1188 0
 6937 27b8 00BF     		nop
 6938              	.L387:
1069:parson.c      ****         c = string[i];
 6939              		.loc 2 1069 0 discriminator 2
 6940 27ba FB69     		ldr	r3, [r7, #28]	@ tmp420, i
 6941 27bc 0133     		adds	r3, r3, #1	@ tmp419, tmp420,
 6942 27be FB61     		str	r3, [r7, #28]	@ tmp419, i
 6943              	.L347:
1069:parson.c      ****         c = string[i];
 6944              		.loc 2 1069 0 is_stmt 0 discriminator 1
 6945 27c0 FA69     		ldr	r2, [r7, #28]	@ tmp421, i
 6946 27c2 7B69     		ldr	r3, [r7, #20]	@ tmp422, len
 6947 27c4 9A42     		cmp	r2, r3	@ tmp421, tmp422
 6948 27c6 FFF496AB 		bcc	.L457	@,
1189:parson.c      ****         }
1190:parson.c      ****     }
1191:parson.c      ****     APPEND_STRING("\"");
 6949              		.loc 2 1191 0 is_stmt 1
 6950 27ca 40F20001 		movw	r1, #:lower16:.LC14	@,
 6951 27ce C0F20001 		movt	r1, #:upper16:.LC14	@,
 6952 27d2 3868     		ldr	r0, [r7]	@, buf
 6953 27d4 00F049F8 		bl	append_string	@
 6954 27d8 F860     		str	r0, [r7, #12]	@, written
 6955 27da FB68     		ldr	r3, [r7, #12]	@ tmp423, written
 6956 27dc 002B     		cmp	r3, #0	@ tmp423,
 6957 27de 02DA     		bge	.L458	@,
 6958              		.loc 2 1191 0 is_stmt 0 discriminator 1
 6959 27e0 4FF0FF33 		mov	r3, #-1	@ _43,
 6960 27e4 0BE0     		b	.L345	@
 6961              	.L458:
 6962              		.loc 2 1191 0 discriminator 2
 6963 27e6 3B68     		ldr	r3, [r7]	@ tmp424, buf
 6964 27e8 002B     		cmp	r3, #0	@ tmp424,
 6965 27ea 03D0     		beq	.L459	@,
 6966              		.loc 2 1191 0 discriminator 3
 6967 27ec FB68     		ldr	r3, [r7, #12]	@ written.150_283, written
 6968 27ee 3A68     		ldr	r2, [r7]	@ tmp426, buf
 6969 27f0 1344     		add	r3, r3, r2	@ tmp425, tmp426
 6970 27f2 3B60     		str	r3, [r7]	@ tmp425, buf
 6971              	.L459:
 6972              		.loc 2 1191 0 discriminator 5
 6973 27f4 BA69     		ldr	r2, [r7, #24]	@ tmp428, written_total
 6974 27f6 FB68     		ldr	r3, [r7, #12]	@ tmp429, written
 6975 27f8 1344     		add	r3, r3, r2	@ tmp427, tmp428
 6976 27fa BB61     		str	r3, [r7, #24]	@ tmp427, written_total
1192:parson.c      ****     return written_total;
 6977              		.loc 2 1192 0 is_stmt 1 discriminator 5
 6978 27fc BB69     		ldr	r3, [r7, #24]	@ _43, written_total
 6979              	.L345:
1193:parson.c      **** }
 6980              		.loc 2 1193 0
 6981 27fe 1846     		mov	r0, r3	@, <retval>
 6982 2800 2037     		adds	r7, r7, #32	@,,
 6983              	.LCFI182:
 6984              		.cfi_def_cfa_offset 8
 6985 2802 BD46     		mov	sp, r7	@,
 6986              	.LCFI183:
 6987              		.cfi_def_cfa_register 13
 6988              		@ sp needed	@
 6989 2804 80BD     		pop	{r7, pc}	@
 6990              		.cfi_endproc
 6991              	.LFE52:
 6993              		.section	.rodata
 6994 0143 00       		.align	2
 6995              	.LC50:
 6996 0144 20202020 		.ascii	"    \000"
 6996      00
 6997              		.text
 6998              		.align	1
 6999              		.syntax unified
 7000              		.thumb
 7001              		.thumb_func
 7002              		.fpu neon
 7004              	append_indent:
 7005              	.LFB53:
1194:parson.c      **** 
1195:parson.c      **** static int append_indent(char *buf, int level)
1196:parson.c      **** {
 7006              		.loc 2 1196 0
 7007              		.cfi_startproc
 7008              		@ args = 0, pretend = 0, frame = 24
 7009              		@ frame_needed = 1, uses_anonymous_args = 0
 7010 2806 80B5     		push	{r7, lr}	@
 7011              	.LCFI184:
 7012              		.cfi_def_cfa_offset 8
 7013              		.cfi_offset 7, -8
 7014              		.cfi_offset 14, -4
 7015 2808 86B0     		sub	sp, sp, #24	@,,
 7016              	.LCFI185:
 7017              		.cfi_def_cfa_offset 32
 7018 280a 00AF     		add	r7, sp, #0	@,,
 7019              	.LCFI186:
 7020              		.cfi_def_cfa_register 7
 7021 280c 7860     		str	r0, [r7, #4]	@ buf, buf
 7022 280e 3960     		str	r1, [r7]	@ level, level
1197:parson.c      ****     int i;
1198:parson.c      ****     int written = -1, written_total = 0;
 7023              		.loc 2 1198 0
 7024 2810 4FF0FF33 		mov	r3, #-1	@ tmp113,
 7025 2814 FB60     		str	r3, [r7, #12]	@ tmp113, written
 7026 2816 0023     		movs	r3, #0	@ tmp114,
 7027 2818 3B61     		str	r3, [r7, #16]	@ tmp114, written_total
1199:parson.c      ****     for (i = 0; i < level; i++) {
 7028              		.loc 2 1199 0
 7029 281a 0023     		movs	r3, #0	@ tmp115,
 7030 281c 7B61     		str	r3, [r7, #20]	@ tmp115, i
 7031 281e 1BE0     		b	.L461	@
 7032              	.L465:
1200:parson.c      ****         APPEND_STRING("    ");
 7033              		.loc 2 1200 0
 7034 2820 40F20001 		movw	r1, #:lower16:.LC50	@,
 7035 2824 C0F20001 		movt	r1, #:upper16:.LC50	@,
 7036 2828 7868     		ldr	r0, [r7, #4]	@, buf
 7037 282a 00F01EF8 		bl	append_string	@
 7038 282e F860     		str	r0, [r7, #12]	@, written
 7039 2830 FB68     		ldr	r3, [r7, #12]	@ tmp116, written
 7040 2832 002B     		cmp	r3, #0	@ tmp116,
 7041 2834 02DA     		bge	.L462	@,
 7042              		.loc 2 1200 0 is_stmt 0 discriminator 1
 7043 2836 4FF0FF33 		mov	r3, #-1	@ _5,
 7044 283a 12E0     		b	.L463	@
 7045              	.L462:
 7046              		.loc 2 1200 0 discriminator 2
 7047 283c 7B68     		ldr	r3, [r7, #4]	@ tmp117, buf
 7048 283e 002B     		cmp	r3, #0	@ tmp117,
 7049 2840 03D0     		beq	.L464	@,
 7050              		.loc 2 1200 0 discriminator 3
 7051 2842 FB68     		ldr	r3, [r7, #12]	@ written.151_16, written
 7052 2844 7A68     		ldr	r2, [r7, #4]	@ tmp119, buf
 7053 2846 1344     		add	r3, r3, r2	@ tmp118, tmp119
 7054 2848 7B60     		str	r3, [r7, #4]	@ tmp118, buf
 7055              	.L464:
 7056              		.loc 2 1200 0 discriminator 5
 7057 284a 3A69     		ldr	r2, [r7, #16]	@ tmp121, written_total
 7058 284c FB68     		ldr	r3, [r7, #12]	@ tmp122, written
 7059 284e 1344     		add	r3, r3, r2	@ tmp120, tmp121
 7060 2850 3B61     		str	r3, [r7, #16]	@ tmp120, written_total
1199:parson.c      ****     for (i = 0; i < level; i++) {
 7061              		.loc 2 1199 0 is_stmt 1 discriminator 5
 7062 2852 7B69     		ldr	r3, [r7, #20]	@ tmp124, i
 7063 2854 0133     		adds	r3, r3, #1	@ tmp123, tmp124,
 7064 2856 7B61     		str	r3, [r7, #20]	@ tmp123, i
 7065              	.L461:
1199:parson.c      ****     for (i = 0; i < level; i++) {
 7066              		.loc 2 1199 0 is_stmt 0 discriminator 2
 7067 2858 7A69     		ldr	r2, [r7, #20]	@ tmp125, i
 7068 285a 3B68     		ldr	r3, [r7]	@ tmp126, level
 7069 285c 9A42     		cmp	r2, r3	@ tmp125, tmp126
 7070 285e DFDB     		blt	.L465	@,
1201:parson.c      ****     }
1202:parson.c      ****     return written_total;
 7071              		.loc 2 1202 0 is_stmt 1
 7072 2860 3B69     		ldr	r3, [r7, #16]	@ _5, written_total
 7073              	.L463:
1203:parson.c      **** }
 7074              		.loc 2 1203 0
 7075 2862 1846     		mov	r0, r3	@, <retval>
 7076 2864 1837     		adds	r7, r7, #24	@,,
 7077              	.LCFI187:
 7078              		.cfi_def_cfa_offset 8
 7079 2866 BD46     		mov	sp, r7	@,
 7080              	.LCFI188:
 7081              		.cfi_def_cfa_register 13
 7082              		@ sp needed	@
 7083 2868 80BD     		pop	{r7, pc}	@
 7084              		.cfi_endproc
 7085              	.LFE53:
 7087              		.section	.rodata
 7088 0149 000000   		.align	2
 7089              	.LC51:
 7090 014c 257300   		.ascii	"%s\000"
 7091              		.text
 7092              		.align	1
 7093              		.syntax unified
 7094              		.thumb
 7095              		.thumb_func
 7096              		.fpu neon
 7098              	append_string:
 7099              	.LFB54:
1204:parson.c      **** 
1205:parson.c      **** static int append_string(char *buf, const char *string)
1206:parson.c      **** {
 7100              		.loc 2 1206 0
 7101              		.cfi_startproc
 7102              		@ args = 0, pretend = 0, frame = 8
 7103              		@ frame_needed = 1, uses_anonymous_args = 0
 7104 286a 80B5     		push	{r7, lr}	@
 7105              	.LCFI189:
 7106              		.cfi_def_cfa_offset 8
 7107              		.cfi_offset 7, -8
 7108              		.cfi_offset 14, -4
 7109 286c 82B0     		sub	sp, sp, #8	@,,
 7110              	.LCFI190:
 7111              		.cfi_def_cfa_offset 16
 7112 286e 00AF     		add	r7, sp, #0	@,,
 7113              	.LCFI191:
 7114              		.cfi_def_cfa_register 7
 7115 2870 7860     		str	r0, [r7, #4]	@ buf, buf
 7116 2872 3960     		str	r1, [r7]	@ string, string
1207:parson.c      ****     if (buf == NULL) {
 7117              		.loc 2 1207 0
 7118 2874 7B68     		ldr	r3, [r7, #4]	@ tmp113, buf
 7119 2876 002B     		cmp	r3, #0	@ tmp113,
 7120 2878 04D1     		bne	.L467	@,
1208:parson.c      ****         return (int)strlen(string);
 7121              		.loc 2 1208 0
 7122 287a 3868     		ldr	r0, [r7]	@, string
 7123 287c FFF7FEFF 		bl	strlen	@
 7124 2880 0346     		mov	r3, r0	@ _6,
 7125 2882 08E0     		b	.L468	@
 7126              	.L467:
1209:parson.c      ****     }
1210:parson.c      ****     return sprintf(buf, "%s", string);
 7127              		.loc 2 1210 0
 7128 2884 3A68     		ldr	r2, [r7]	@, string
 7129 2886 40F20001 		movw	r1, #:lower16:.LC51	@,
 7130 288a C0F20001 		movt	r1, #:upper16:.LC51	@,
 7131 288e 7868     		ldr	r0, [r7, #4]	@, buf
 7132 2890 FFF7FEFF 		bl	sprintf	@
 7133 2894 0346     		mov	r3, r0	@ _1,
 7134              	.L468:
1211:parson.c      **** }
 7135              		.loc 2 1211 0
 7136 2896 1846     		mov	r0, r3	@, <retval>
 7137 2898 0837     		adds	r7, r7, #8	@,,
 7138              	.LCFI192:
 7139              		.cfi_def_cfa_offset 8
 7140 289a BD46     		mov	sp, r7	@,
 7141              	.LCFI193:
 7142              		.cfi_def_cfa_register 13
 7143              		@ sp needed	@
 7144 289c 80BD     		pop	{r7, pc}	@
 7145              		.cfi_endproc
 7146              	.LFE54:
 7148              		.align	1
 7149              		.global	json_parse_string
 7150              		.syntax unified
 7151              		.thumb
 7152              		.thumb_func
 7153              		.fpu neon
 7155              	json_parse_string:
 7156              	.LFB55:
1212:parson.c      **** 
1213:parson.c      **** #undef APPEND_STRING
1214:parson.c      **** #undef APPEND_INDENT
1215:parson.c      **** 
1216:parson.c      **** /* Parser API */
1217:parson.c      **** JSON_Value *json_parse_string(const char *string)
1218:parson.c      **** {
 7157              		.loc 2 1218 0
 7158              		.cfi_startproc
 7159              		@ args = 0, pretend = 0, frame = 8
 7160              		@ frame_needed = 1, uses_anonymous_args = 0
 7161 289e 80B5     		push	{r7, lr}	@
 7162              	.LCFI194:
 7163              		.cfi_def_cfa_offset 8
 7164              		.cfi_offset 7, -8
 7165              		.cfi_offset 14, -4
 7166 28a0 82B0     		sub	sp, sp, #8	@,,
 7167              	.LCFI195:
 7168              		.cfi_def_cfa_offset 16
 7169 28a2 00AF     		add	r7, sp, #0	@,,
 7170              	.LCFI196:
 7171              		.cfi_def_cfa_register 7
 7172 28a4 7860     		str	r0, [r7, #4]	@ string, string
1219:parson.c      ****     if (string == NULL) {
 7173              		.loc 2 1219 0
 7174 28a6 7B68     		ldr	r3, [r7, #4]	@ string.152_5, string
 7175 28a8 002B     		cmp	r3, #0	@ string.152_5,
 7176 28aa 01D1     		bne	.L470	@,
1220:parson.c      ****         return NULL;
 7177              		.loc 2 1220 0
 7178 28ac 0023     		movs	r3, #0	@ _1,
 7179 28ae 16E0     		b	.L471	@
 7180              	.L470:
1221:parson.c      ****     }
1222:parson.c      ****     if (string[0] == '\xEF' && string[1] == '\xBB' && string[2] == '\xBF') {
 7181              		.loc 2 1222 0
 7182 28b0 7B68     		ldr	r3, [r7, #4]	@ string.153_7, string
 7183 28b2 1B78     		ldrb	r3, [r3]	@ zero_extendqisi2	@ _8, *string.153_7
 7184 28b4 EF2B     		cmp	r3, #239	@ _8,
 7185 28b6 0CD1     		bne	.L472	@,
 7186              		.loc 2 1222 0 is_stmt 0 discriminator 1
 7187 28b8 7B68     		ldr	r3, [r7, #4]	@ string.154_9, string
 7188 28ba 0133     		adds	r3, r3, #1	@ _10, string.154_9,
 7189 28bc 1B78     		ldrb	r3, [r3]	@ zero_extendqisi2	@ _11, *_10
 7190 28be BB2B     		cmp	r3, #187	@ _11,
 7191 28c0 07D1     		bne	.L472	@,
 7192              		.loc 2 1222 0 discriminator 2
 7193 28c2 7B68     		ldr	r3, [r7, #4]	@ string.155_12, string
 7194 28c4 0233     		adds	r3, r3, #2	@ _13, string.155_12,
 7195 28c6 1B78     		ldrb	r3, [r3]	@ zero_extendqisi2	@ _14, *_13
 7196 28c8 BF2B     		cmp	r3, #191	@ _14,
 7197 28ca 02D1     		bne	.L472	@,
1223:parson.c      ****         string = string + 3; /* Support for UTF-8 BOM */
 7198              		.loc 2 1223 0 is_stmt 1
 7199 28cc 7B68     		ldr	r3, [r7, #4]	@ string.156_15, string
 7200 28ce 0333     		adds	r3, r3, #3	@ string.157_16, string.156_15,
 7201 28d0 7B60     		str	r3, [r7, #4]	@ string.157_16, string
 7202              	.L472:
1224:parson.c      ****     }
1225:parson.c      ****     return parse_value((const char **)&string, 0);
 7203              		.loc 2 1225 0
 7204 28d2 3B1D     		adds	r3, r7, #4	@ tmp123,,
 7205 28d4 0021     		movs	r1, #0	@,
 7206 28d6 1846     		mov	r0, r3	@, tmp123
 7207 28d8 FEF737FC 		bl	parse_value	@
 7208 28dc 0346     		mov	r3, r0	@ _1,
 7209              	.L471:
1226:parson.c      **** }
 7210              		.loc 2 1226 0
 7211 28de 1846     		mov	r0, r3	@, <retval>
 7212 28e0 0837     		adds	r7, r7, #8	@,,
 7213              	.LCFI197:
 7214              		.cfi_def_cfa_offset 8
 7215 28e2 BD46     		mov	sp, r7	@,
 7216              	.LCFI198:
 7217              		.cfi_def_cfa_register 13
 7218              		@ sp needed	@
 7219 28e4 80BD     		pop	{r7, pc}	@
 7220              		.cfi_endproc
 7221              	.LFE55:
 7223              		.section	.rodata
 7224 014f 00       		.align	2
 7225              	.LC52:
 7226 0150 2A2F00   		.ascii	"*/\000"
 7227 0153 00       		.align	2
 7228              	.LC53:
 7229 0154 2F2A00   		.ascii	"/*\000"
 7230 0157 00       		.align	2
 7231              	.LC54:
 7232 0158 2F2F00   		.ascii	"//\000"
 7233              		.text
 7234              		.align	1
 7235              		.global	json_parse_string_with_comments
 7236              		.syntax unified
 7237              		.thumb
 7238              		.thumb_func
 7239              		.fpu neon
 7241              	json_parse_string_with_comments:
 7242              	.LFB56:
1227:parson.c      **** 
1228:parson.c      **** JSON_Value *json_parse_string_with_comments(const char *string)
1229:parson.c      **** {
 7243              		.loc 2 1229 0
 7244              		.cfi_startproc
 7245              		@ args = 0, pretend = 0, frame = 24
 7246              		@ frame_needed = 1, uses_anonymous_args = 0
 7247 28e6 80B5     		push	{r7, lr}	@
 7248              	.LCFI199:
 7249              		.cfi_def_cfa_offset 8
 7250              		.cfi_offset 7, -8
 7251              		.cfi_offset 14, -4
 7252 28e8 86B0     		sub	sp, sp, #24	@,,
 7253              	.LCFI200:
 7254              		.cfi_def_cfa_offset 32
 7255 28ea 00AF     		add	r7, sp, #0	@,,
 7256              	.LCFI201:
 7257              		.cfi_def_cfa_register 7
 7258 28ec 7860     		str	r0, [r7, #4]	@ string, string
1230:parson.c      ****     JSON_Value *result = NULL;
 7259              		.loc 2 1230 0
 7260 28ee 0023     		movs	r3, #0	@ tmp113,
 7261 28f0 7B61     		str	r3, [r7, #20]	@ tmp113, result
1231:parson.c      ****     char *string_mutable_copy = NULL, *string_mutable_copy_ptr = NULL;
 7262              		.loc 2 1231 0
 7263 28f2 0023     		movs	r3, #0	@ tmp114,
 7264 28f4 3B61     		str	r3, [r7, #16]	@ tmp114, string_mutable_copy
 7265 28f6 0023     		movs	r3, #0	@ tmp115,
 7266 28f8 FB60     		str	r3, [r7, #12]	@ tmp115, string_mutable_copy_ptr
1232:parson.c      ****     string_mutable_copy = parson_strdup(string);
 7267              		.loc 2 1232 0
 7268 28fa 7868     		ldr	r0, [r7, #4]	@, string
 7269 28fc FDF7B7FB 		bl	parson_strdup	@
 7270 2900 3861     		str	r0, [r7, #16]	@, string_mutable_copy
1233:parson.c      ****     if (string_mutable_copy == NULL) {
 7271              		.loc 2 1233 0
 7272 2902 3B69     		ldr	r3, [r7, #16]	@ tmp116, string_mutable_copy
 7273 2904 002B     		cmp	r3, #0	@ tmp116,
 7274 2906 01D1     		bne	.L474	@,
1234:parson.c      ****         return NULL;
 7275              		.loc 2 1234 0
 7276 2908 0023     		movs	r3, #0	@ _1,
 7277 290a 26E0     		b	.L476	@
 7278              	.L474:
1235:parson.c      ****     }
1236:parson.c      ****     remove_comments(string_mutable_copy, "/*", "*/");
 7279              		.loc 2 1236 0
 7280 290c 40F20002 		movw	r2, #:lower16:.LC52	@,
 7281 2910 C0F20002 		movt	r2, #:upper16:.LC52	@,
 7282 2914 40F20001 		movw	r1, #:lower16:.LC53	@,
 7283 2918 C0F20001 		movt	r1, #:upper16:.LC53	@,
 7284 291c 3869     		ldr	r0, [r7, #16]	@, string_mutable_copy
 7285 291e FDF79BFD 		bl	remove_comments	@
1237:parson.c      ****     remove_comments(string_mutable_copy, "//", "\n");
 7286              		.loc 2 1237 0
 7287 2922 40F20002 		movw	r2, #:lower16:.LC6	@,
 7288 2926 C0F20002 		movt	r2, #:upper16:.LC6	@,
 7289 292a 40F20001 		movw	r1, #:lower16:.LC54	@,
 7290 292e C0F20001 		movt	r1, #:upper16:.LC54	@,
 7291 2932 3869     		ldr	r0, [r7, #16]	@, string_mutable_copy
 7292 2934 FDF790FD 		bl	remove_comments	@
1238:parson.c      ****     string_mutable_copy_ptr = string_mutable_copy;
 7293              		.loc 2 1238 0
 7294 2938 3B69     		ldr	r3, [r7, #16]	@ tmp117, string_mutable_copy
 7295 293a FB60     		str	r3, [r7, #12]	@ tmp117, string_mutable_copy_ptr
1239:parson.c      ****     result = parse_value((const char **)&string_mutable_copy_ptr, 0);
 7296              		.loc 2 1239 0
 7297 293c 07F10C03 		add	r3, r7, #12	@ tmp118,,
 7298 2940 0021     		movs	r1, #0	@,
 7299 2942 1846     		mov	r0, r3	@, tmp118
 7300 2944 FEF701FC 		bl	parse_value	@
 7301 2948 7861     		str	r0, [r7, #20]	@, result
1240:parson.c      ****     parson_free(string_mutable_copy);
 7302              		.loc 2 1240 0
 7303 294a 40F20003 		movw	r3, #:lower16:parson_free	@ tmp119,
 7304 294e C0F20003 		movt	r3, #:upper16:parson_free	@ tmp119,
 7305 2952 1B68     		ldr	r3, [r3]	@ parson_free.158_16, parson_free
 7306 2954 3869     		ldr	r0, [r7, #16]	@, string_mutable_copy
 7307 2956 9847     		blx	r3	@ parson_free.158_16
 7308              	.LVL27:
1241:parson.c      ****     return result;
 7309              		.loc 2 1241 0
 7310 2958 7B69     		ldr	r3, [r7, #20]	@ _1, result
 7311              	.L476:
1242:parson.c      **** }
 7312              		.loc 2 1242 0 discriminator 1
 7313 295a 1846     		mov	r0, r3	@, <retval>
 7314 295c 1837     		adds	r7, r7, #24	@,,
 7315              	.LCFI202:
 7316              		.cfi_def_cfa_offset 8
 7317 295e BD46     		mov	sp, r7	@,
 7318              	.LCFI203:
 7319              		.cfi_def_cfa_register 13
 7320              		@ sp needed	@
 7321 2960 80BD     		pop	{r7, pc}	@
 7322              		.cfi_endproc
 7323              	.LFE56:
 7325              		.align	1
 7326              		.global	json_object_get_value
 7327              		.syntax unified
 7328              		.thumb
 7329              		.thumb_func
 7330              		.fpu neon
 7332              	json_object_get_value:
 7333              	.LFB57:
1243:parson.c      **** 
1244:parson.c      **** /* JSON Object API */
1245:parson.c      **** 
1246:parson.c      **** JSON_Value *json_object_get_value(const JSON_Object *object, const char *name)
1247:parson.c      **** {
 7334              		.loc 2 1247 0
 7335              		.cfi_startproc
 7336              		@ args = 0, pretend = 0, frame = 8
 7337              		@ frame_needed = 1, uses_anonymous_args = 0
 7338 2962 80B5     		push	{r7, lr}	@
 7339              	.LCFI204:
 7340              		.cfi_def_cfa_offset 8
 7341              		.cfi_offset 7, -8
 7342              		.cfi_offset 14, -4
 7343 2964 82B0     		sub	sp, sp, #8	@,,
 7344              	.LCFI205:
 7345              		.cfi_def_cfa_offset 16
 7346 2966 00AF     		add	r7, sp, #0	@,,
 7347              	.LCFI206:
 7348              		.cfi_def_cfa_register 7
 7349 2968 7860     		str	r0, [r7, #4]	@ object, object
 7350 296a 3960     		str	r1, [r7]	@ name, name
1248:parson.c      ****     if (object == NULL || name == NULL) {
 7351              		.loc 2 1248 0
 7352 296c 7B68     		ldr	r3, [r7, #4]	@ tmp113, object
 7353 296e 002B     		cmp	r3, #0	@ tmp113,
 7354 2970 02D0     		beq	.L478	@,
 7355              		.loc 2 1248 0 is_stmt 0 discriminator 1
 7356 2972 3B68     		ldr	r3, [r7]	@ tmp114, name
 7357 2974 002B     		cmp	r3, #0	@ tmp114,
 7358 2976 01D1     		bne	.L479	@,
 7359              	.L478:
1249:parson.c      ****         return NULL;
 7360              		.loc 2 1249 0 is_stmt 1
 7361 2978 0023     		movs	r3, #0	@ _1,
 7362 297a 09E0     		b	.L480	@
 7363              	.L479:
1250:parson.c      ****     }
1251:parson.c      ****     return json_object_getn_value(object, name, strlen(name));
 7364              		.loc 2 1251 0
 7365 297c 3868     		ldr	r0, [r7]	@, name
 7366 297e FFF7FEFF 		bl	strlen	@
 7367 2982 0346     		mov	r3, r0	@ _6,
 7368 2984 1A46     		mov	r2, r3	@, _6
 7369 2986 3968     		ldr	r1, [r7]	@, name
 7370 2988 7868     		ldr	r0, [r7, #4]	@, object
 7371 298a FDF716FF 		bl	json_object_getn_value	@
 7372 298e 0346     		mov	r3, r0	@ _1,
 7373              	.L480:
1252:parson.c      **** }
 7374              		.loc 2 1252 0
 7375 2990 1846     		mov	r0, r3	@, <retval>
 7376 2992 0837     		adds	r7, r7, #8	@,,
 7377              	.LCFI207:
 7378              		.cfi_def_cfa_offset 8
 7379 2994 BD46     		mov	sp, r7	@,
 7380              	.LCFI208:
 7381              		.cfi_def_cfa_register 13
 7382              		@ sp needed	@
 7383 2996 80BD     		pop	{r7, pc}	@
 7384              		.cfi_endproc
 7385              	.LFE57:
 7387              		.align	1
 7388              		.global	json_object_get_string
 7389              		.syntax unified
 7390              		.thumb
 7391              		.thumb_func
 7392              		.fpu neon
 7394              	json_object_get_string:
 7395              	.LFB58:
1253:parson.c      **** 
1254:parson.c      **** const char *json_object_get_string(const JSON_Object *object, const char *name)
1255:parson.c      **** {
 7396              		.loc 2 1255 0
 7397              		.cfi_startproc
 7398              		@ args = 0, pretend = 0, frame = 8
 7399              		@ frame_needed = 1, uses_anonymous_args = 0
 7400 2998 80B5     		push	{r7, lr}	@
 7401              	.LCFI209:
 7402              		.cfi_def_cfa_offset 8
 7403              		.cfi_offset 7, -8
 7404              		.cfi_offset 14, -4
 7405 299a 82B0     		sub	sp, sp, #8	@,,
 7406              	.LCFI210:
 7407              		.cfi_def_cfa_offset 16
 7408 299c 00AF     		add	r7, sp, #0	@,,
 7409              	.LCFI211:
 7410              		.cfi_def_cfa_register 7
 7411 299e 7860     		str	r0, [r7, #4]	@ object, object
 7412 29a0 3960     		str	r1, [r7]	@ name, name
1256:parson.c      ****     return json_value_get_string(json_object_get_value(object, name));
 7413              		.loc 2 1256 0
 7414 29a2 3968     		ldr	r1, [r7]	@, name
 7415 29a4 7868     		ldr	r0, [r7, #4]	@, object
 7416 29a6 FFF7FEFF 		bl	json_object_get_value	@
 7417 29aa 0346     		mov	r3, r0	@ _5,
 7418 29ac 1846     		mov	r0, r3	@, _5
 7419 29ae FFF7FEFF 		bl	json_value_get_string	@
 7420 29b2 0346     		mov	r3, r0	@ _7,
1257:parson.c      **** }
 7421              		.loc 2 1257 0
 7422 29b4 1846     		mov	r0, r3	@, <retval>
 7423 29b6 0837     		adds	r7, r7, #8	@,,
 7424              	.LCFI212:
 7425              		.cfi_def_cfa_offset 8
 7426 29b8 BD46     		mov	sp, r7	@,
 7427              	.LCFI213:
 7428              		.cfi_def_cfa_register 13
 7429              		@ sp needed	@
 7430 29ba 80BD     		pop	{r7, pc}	@
 7431              		.cfi_endproc
 7432              	.LFE58:
 7434              		.align	1
 7435              		.global	json_object_get_number
 7436              		.syntax unified
 7437              		.thumb
 7438              		.thumb_func
 7439              		.fpu neon
 7441              	json_object_get_number:
 7442              	.LFB59:
1258:parson.c      **** 
1259:parson.c      **** double json_object_get_number(const JSON_Object *object, const char *name)
1260:parson.c      **** {
 7443              		.loc 2 1260 0
 7444              		.cfi_startproc
 7445              		@ args = 0, pretend = 0, frame = 8
 7446              		@ frame_needed = 1, uses_anonymous_args = 0
 7447 29bc 80B5     		push	{r7, lr}	@
 7448              	.LCFI214:
 7449              		.cfi_def_cfa_offset 8
 7450              		.cfi_offset 7, -8
 7451              		.cfi_offset 14, -4
 7452 29be 82B0     		sub	sp, sp, #8	@,,
 7453              	.LCFI215:
 7454              		.cfi_def_cfa_offset 16
 7455 29c0 00AF     		add	r7, sp, #0	@,,
 7456              	.LCFI216:
 7457              		.cfi_def_cfa_register 7
 7458 29c2 7860     		str	r0, [r7, #4]	@ object, object
 7459 29c4 3960     		str	r1, [r7]	@ name, name
1261:parson.c      ****     return json_value_get_number(json_object_get_value(object, name));
 7460              		.loc 2 1261 0
 7461 29c6 3968     		ldr	r1, [r7]	@, name
 7462 29c8 7868     		ldr	r0, [r7, #4]	@, object
 7463 29ca FFF7FEFF 		bl	json_object_get_value	@
 7464 29ce 0346     		mov	r3, r0	@ _5,
 7465 29d0 1846     		mov	r0, r3	@, _5
 7466 29d2 FFF7FEFF 		bl	json_value_get_number	@
 7467 29d6 F0EE400B 		vmov.f64	d16, d0	@ _7,
1262:parson.c      **** }
 7468              		.loc 2 1262 0
 7469 29da B0EE600B 		vmov.f64	d0, d16	@, <retval>
 7470 29de 0837     		adds	r7, r7, #8	@,,
 7471              	.LCFI217:
 7472              		.cfi_def_cfa_offset 8
 7473 29e0 BD46     		mov	sp, r7	@,
 7474              	.LCFI218:
 7475              		.cfi_def_cfa_register 13
 7476              		@ sp needed	@
 7477 29e2 80BD     		pop	{r7, pc}	@
 7478              		.cfi_endproc
 7479              	.LFE59:
 7481              		.align	1
 7482              		.global	json_object_get_object
 7483              		.syntax unified
 7484              		.thumb
 7485              		.thumb_func
 7486              		.fpu neon
 7488              	json_object_get_object:
 7489              	.LFB60:
1263:parson.c      **** 
1264:parson.c      **** JSON_Object *json_object_get_object(const JSON_Object *object, const char *name)
1265:parson.c      **** {
 7490              		.loc 2 1265 0
 7491              		.cfi_startproc
 7492              		@ args = 0, pretend = 0, frame = 8
 7493              		@ frame_needed = 1, uses_anonymous_args = 0
 7494 29e4 80B5     		push	{r7, lr}	@
 7495              	.LCFI219:
 7496              		.cfi_def_cfa_offset 8
 7497              		.cfi_offset 7, -8
 7498              		.cfi_offset 14, -4
 7499 29e6 82B0     		sub	sp, sp, #8	@,,
 7500              	.LCFI220:
 7501              		.cfi_def_cfa_offset 16
 7502 29e8 00AF     		add	r7, sp, #0	@,,
 7503              	.LCFI221:
 7504              		.cfi_def_cfa_register 7
 7505 29ea 7860     		str	r0, [r7, #4]	@ object, object
 7506 29ec 3960     		str	r1, [r7]	@ name, name
1266:parson.c      ****     return json_value_get_object(json_object_get_value(object, name));
 7507              		.loc 2 1266 0
 7508 29ee 3968     		ldr	r1, [r7]	@, name
 7509 29f0 7868     		ldr	r0, [r7, #4]	@, object
 7510 29f2 FFF7FEFF 		bl	json_object_get_value	@
 7511 29f6 0346     		mov	r3, r0	@ _5,
 7512 29f8 1846     		mov	r0, r3	@, _5
 7513 29fa FFF7FEFF 		bl	json_value_get_object	@
 7514 29fe 0346     		mov	r3, r0	@ _7,
1267:parson.c      **** }
 7515              		.loc 2 1267 0
 7516 2a00 1846     		mov	r0, r3	@, <retval>
 7517 2a02 0837     		adds	r7, r7, #8	@,,
 7518              	.LCFI222:
 7519              		.cfi_def_cfa_offset 8
 7520 2a04 BD46     		mov	sp, r7	@,
 7521              	.LCFI223:
 7522              		.cfi_def_cfa_register 13
 7523              		@ sp needed	@
 7524 2a06 80BD     		pop	{r7, pc}	@
 7525              		.cfi_endproc
 7526              	.LFE60:
 7528              		.align	1
 7529              		.global	json_object_get_array
 7530              		.syntax unified
 7531              		.thumb
 7532              		.thumb_func
 7533              		.fpu neon
 7535              	json_object_get_array:
 7536              	.LFB61:
1268:parson.c      **** 
1269:parson.c      **** JSON_Array *json_object_get_array(const JSON_Object *object, const char *name)
1270:parson.c      **** {
 7537              		.loc 2 1270 0
 7538              		.cfi_startproc
 7539              		@ args = 0, pretend = 0, frame = 8
 7540              		@ frame_needed = 1, uses_anonymous_args = 0
 7541 2a08 80B5     		push	{r7, lr}	@
 7542              	.LCFI224:
 7543              		.cfi_def_cfa_offset 8
 7544              		.cfi_offset 7, -8
 7545              		.cfi_offset 14, -4
 7546 2a0a 82B0     		sub	sp, sp, #8	@,,
 7547              	.LCFI225:
 7548              		.cfi_def_cfa_offset 16
 7549 2a0c 00AF     		add	r7, sp, #0	@,,
 7550              	.LCFI226:
 7551              		.cfi_def_cfa_register 7
 7552 2a0e 7860     		str	r0, [r7, #4]	@ object, object
 7553 2a10 3960     		str	r1, [r7]	@ name, name
1271:parson.c      ****     return json_value_get_array(json_object_get_value(object, name));
 7554              		.loc 2 1271 0
 7555 2a12 3968     		ldr	r1, [r7]	@, name
 7556 2a14 7868     		ldr	r0, [r7, #4]	@, object
 7557 2a16 FFF7FEFF 		bl	json_object_get_value	@
 7558 2a1a 0346     		mov	r3, r0	@ _5,
 7559 2a1c 1846     		mov	r0, r3	@, _5
 7560 2a1e FFF7FEFF 		bl	json_value_get_array	@
 7561 2a22 0346     		mov	r3, r0	@ _7,
1272:parson.c      **** }
 7562              		.loc 2 1272 0
 7563 2a24 1846     		mov	r0, r3	@, <retval>
 7564 2a26 0837     		adds	r7, r7, #8	@,,
 7565              	.LCFI227:
 7566              		.cfi_def_cfa_offset 8
 7567 2a28 BD46     		mov	sp, r7	@,
 7568              	.LCFI228:
 7569              		.cfi_def_cfa_register 13
 7570              		@ sp needed	@
 7571 2a2a 80BD     		pop	{r7, pc}	@
 7572              		.cfi_endproc
 7573              	.LFE61:
 7575              		.align	1
 7576              		.global	json_object_get_boolean
 7577              		.syntax unified
 7578              		.thumb
 7579              		.thumb_func
 7580              		.fpu neon
 7582              	json_object_get_boolean:
 7583              	.LFB62:
1273:parson.c      **** 
1274:parson.c      **** int json_object_get_boolean(const JSON_Object *object, const char *name)
1275:parson.c      **** {
 7584              		.loc 2 1275 0
 7585              		.cfi_startproc
 7586              		@ args = 0, pretend = 0, frame = 8
 7587              		@ frame_needed = 1, uses_anonymous_args = 0
 7588 2a2c 80B5     		push	{r7, lr}	@
 7589              	.LCFI229:
 7590              		.cfi_def_cfa_offset 8
 7591              		.cfi_offset 7, -8
 7592              		.cfi_offset 14, -4
 7593 2a2e 82B0     		sub	sp, sp, #8	@,,
 7594              	.LCFI230:
 7595              		.cfi_def_cfa_offset 16
 7596 2a30 00AF     		add	r7, sp, #0	@,,
 7597              	.LCFI231:
 7598              		.cfi_def_cfa_register 7
 7599 2a32 7860     		str	r0, [r7, #4]	@ object, object
 7600 2a34 3960     		str	r1, [r7]	@ name, name
1276:parson.c      ****     return json_value_get_boolean(json_object_get_value(object, name));
 7601              		.loc 2 1276 0
 7602 2a36 3968     		ldr	r1, [r7]	@, name
 7603 2a38 7868     		ldr	r0, [r7, #4]	@, object
 7604 2a3a FFF7FEFF 		bl	json_object_get_value	@
 7605 2a3e 0346     		mov	r3, r0	@ _5,
 7606 2a40 1846     		mov	r0, r3	@, _5
 7607 2a42 FFF7FEFF 		bl	json_value_get_boolean	@
 7608 2a46 0346     		mov	r3, r0	@ _7,
1277:parson.c      **** }
 7609              		.loc 2 1277 0
 7610 2a48 1846     		mov	r0, r3	@, <retval>
 7611 2a4a 0837     		adds	r7, r7, #8	@,,
 7612              	.LCFI232:
 7613              		.cfi_def_cfa_offset 8
 7614 2a4c BD46     		mov	sp, r7	@,
 7615              	.LCFI233:
 7616              		.cfi_def_cfa_register 13
 7617              		@ sp needed	@
 7618 2a4e 80BD     		pop	{r7, pc}	@
 7619              		.cfi_endproc
 7620              	.LFE62:
 7622              		.align	1
 7623              		.global	json_object_dotget_value
 7624              		.syntax unified
 7625              		.thumb
 7626              		.thumb_func
 7627              		.fpu neon
 7629              	json_object_dotget_value:
 7630              	.LFB63:
1278:parson.c      **** 
1279:parson.c      **** JSON_Value *json_object_dotget_value(const JSON_Object *object, const char *name)
1280:parson.c      **** {
 7631              		.loc 2 1280 0
 7632              		.cfi_startproc
 7633              		@ args = 0, pretend = 0, frame = 16
 7634              		@ frame_needed = 1, uses_anonymous_args = 0
 7635 2a50 80B5     		push	{r7, lr}	@
 7636              	.LCFI234:
 7637              		.cfi_def_cfa_offset 8
 7638              		.cfi_offset 7, -8
 7639              		.cfi_offset 14, -4
 7640 2a52 84B0     		sub	sp, sp, #16	@,,
 7641              	.LCFI235:
 7642              		.cfi_def_cfa_offset 24
 7643 2a54 00AF     		add	r7, sp, #0	@,,
 7644              	.LCFI236:
 7645              		.cfi_def_cfa_register 7
 7646 2a56 7860     		str	r0, [r7, #4]	@ object, object
 7647 2a58 3960     		str	r1, [r7]	@ name, name
1281:parson.c      ****     const char *dot_position = strchr(name, '.');
 7648              		.loc 2 1281 0
 7649 2a5a 2E21     		movs	r1, #46	@,
 7650 2a5c 3868     		ldr	r0, [r7]	@, name
 7651 2a5e FFF7FEFF 		bl	strchr	@
 7652 2a62 F860     		str	r0, [r7, #12]	@, dot_position
1282:parson.c      ****     if (!dot_position) {
 7653              		.loc 2 1282 0
 7654 2a64 FB68     		ldr	r3, [r7, #12]	@ tmp118, dot_position
 7655 2a66 002B     		cmp	r3, #0	@ tmp118,
 7656 2a68 05D1     		bne	.L492	@,
1283:parson.c      ****         return json_object_get_value(object, name);
 7657              		.loc 2 1283 0
 7658 2a6a 3968     		ldr	r1, [r7]	@, name
 7659 2a6c 7868     		ldr	r0, [r7, #4]	@, object
 7660 2a6e FFF7FEFF 		bl	json_object_get_value	@
 7661 2a72 0346     		mov	r3, r0	@ _1,
 7662 2a74 13E0     		b	.L493	@
 7663              	.L492:
1284:parson.c      ****     }
1285:parson.c      ****     object =
1286:parson.c      ****         json_value_get_object(json_object_getn_value(object, name, (size_t)(dot_position - name)));
 7664              		.loc 2 1286 0
 7665 2a76 FA68     		ldr	r2, [r7, #12]	@ dot_position.159_9, dot_position
 7666 2a78 3B68     		ldr	r3, [r7]	@ name.160_10, name
 7667 2a7a D31A     		subs	r3, r2, r3	@ _11, dot_position.159_9, name.160_10
 7668 2a7c 1A46     		mov	r2, r3	@, _12
 7669 2a7e 3968     		ldr	r1, [r7]	@, name
 7670 2a80 7868     		ldr	r0, [r7, #4]	@, object
 7671 2a82 FDF79AFE 		bl	json_object_getn_value	@
 7672 2a86 0346     		mov	r3, r0	@ _14,
1285:parson.c      ****         json_value_get_object(json_object_getn_value(object, name, (size_t)(dot_position - name)));
 7673              		.loc 2 1285 0
 7674 2a88 1846     		mov	r0, r3	@, _14
 7675 2a8a FFF7FEFF 		bl	json_value_get_object	@
 7676 2a8e 7860     		str	r0, [r7, #4]	@, object
1287:parson.c      ****     return json_object_dotget_value(object, dot_position + 1);
 7677              		.loc 2 1287 0
 7678 2a90 FB68     		ldr	r3, [r7, #12]	@ tmp119, dot_position
 7679 2a92 0133     		adds	r3, r3, #1	@ _17, tmp119,
 7680 2a94 1946     		mov	r1, r3	@, _17
 7681 2a96 7868     		ldr	r0, [r7, #4]	@, object
 7682 2a98 FFF7FEFF 		bl	json_object_dotget_value	@
 7683 2a9c 0346     		mov	r3, r0	@ _1,
 7684              	.L493:
1288:parson.c      **** }
 7685              		.loc 2 1288 0
 7686 2a9e 1846     		mov	r0, r3	@, <retval>
 7687 2aa0 1037     		adds	r7, r7, #16	@,,
 7688              	.LCFI237:
 7689              		.cfi_def_cfa_offset 8
 7690 2aa2 BD46     		mov	sp, r7	@,
 7691              	.LCFI238:
 7692              		.cfi_def_cfa_register 13
 7693              		@ sp needed	@
 7694 2aa4 80BD     		pop	{r7, pc}	@
 7695              		.cfi_endproc
 7696              	.LFE63:
 7698              		.align	1
 7699              		.global	json_object_dotget_string
 7700              		.syntax unified
 7701              		.thumb
 7702              		.thumb_func
 7703              		.fpu neon
 7705              	json_object_dotget_string:
 7706              	.LFB64:
1289:parson.c      **** 
1290:parson.c      **** const char *json_object_dotget_string(const JSON_Object *object, const char *name)
1291:parson.c      **** {
 7707              		.loc 2 1291 0
 7708              		.cfi_startproc
 7709              		@ args = 0, pretend = 0, frame = 8
 7710              		@ frame_needed = 1, uses_anonymous_args = 0
 7711 2aa6 80B5     		push	{r7, lr}	@
 7712              	.LCFI239:
 7713              		.cfi_def_cfa_offset 8
 7714              		.cfi_offset 7, -8
 7715              		.cfi_offset 14, -4
 7716 2aa8 82B0     		sub	sp, sp, #8	@,,
 7717              	.LCFI240:
 7718              		.cfi_def_cfa_offset 16
 7719 2aaa 00AF     		add	r7, sp, #0	@,,
 7720              	.LCFI241:
 7721              		.cfi_def_cfa_register 7
 7722 2aac 7860     		str	r0, [r7, #4]	@ object, object
 7723 2aae 3960     		str	r1, [r7]	@ name, name
1292:parson.c      ****     return json_value_get_string(json_object_dotget_value(object, name));
 7724              		.loc 2 1292 0
 7725 2ab0 3968     		ldr	r1, [r7]	@, name
 7726 2ab2 7868     		ldr	r0, [r7, #4]	@, object
 7727 2ab4 FFF7FEFF 		bl	json_object_dotget_value	@
 7728 2ab8 0346     		mov	r3, r0	@ _5,
 7729 2aba 1846     		mov	r0, r3	@, _5
 7730 2abc FFF7FEFF 		bl	json_value_get_string	@
 7731 2ac0 0346     		mov	r3, r0	@ _7,
1293:parson.c      **** }
 7732              		.loc 2 1293 0
 7733 2ac2 1846     		mov	r0, r3	@, <retval>
 7734 2ac4 0837     		adds	r7, r7, #8	@,,
 7735              	.LCFI242:
 7736              		.cfi_def_cfa_offset 8
 7737 2ac6 BD46     		mov	sp, r7	@,
 7738              	.LCFI243:
 7739              		.cfi_def_cfa_register 13
 7740              		@ sp needed	@
 7741 2ac8 80BD     		pop	{r7, pc}	@
 7742              		.cfi_endproc
 7743              	.LFE64:
 7745              		.align	1
 7746              		.global	json_object_dotget_number
 7747              		.syntax unified
 7748              		.thumb
 7749              		.thumb_func
 7750              		.fpu neon
 7752              	json_object_dotget_number:
 7753              	.LFB65:
1294:parson.c      **** 
1295:parson.c      **** double json_object_dotget_number(const JSON_Object *object, const char *name)
1296:parson.c      **** {
 7754              		.loc 2 1296 0
 7755              		.cfi_startproc
 7756              		@ args = 0, pretend = 0, frame = 8
 7757              		@ frame_needed = 1, uses_anonymous_args = 0
 7758 2aca 80B5     		push	{r7, lr}	@
 7759              	.LCFI244:
 7760              		.cfi_def_cfa_offset 8
 7761              		.cfi_offset 7, -8
 7762              		.cfi_offset 14, -4
 7763 2acc 82B0     		sub	sp, sp, #8	@,,
 7764              	.LCFI245:
 7765              		.cfi_def_cfa_offset 16
 7766 2ace 00AF     		add	r7, sp, #0	@,,
 7767              	.LCFI246:
 7768              		.cfi_def_cfa_register 7
 7769 2ad0 7860     		str	r0, [r7, #4]	@ object, object
 7770 2ad2 3960     		str	r1, [r7]	@ name, name
1297:parson.c      ****     return json_value_get_number(json_object_dotget_value(object, name));
 7771              		.loc 2 1297 0
 7772 2ad4 3968     		ldr	r1, [r7]	@, name
 7773 2ad6 7868     		ldr	r0, [r7, #4]	@, object
 7774 2ad8 FFF7FEFF 		bl	json_object_dotget_value	@
 7775 2adc 0346     		mov	r3, r0	@ _5,
 7776 2ade 1846     		mov	r0, r3	@, _5
 7777 2ae0 FFF7FEFF 		bl	json_value_get_number	@
 7778 2ae4 F0EE400B 		vmov.f64	d16, d0	@ _7,
1298:parson.c      **** }
 7779              		.loc 2 1298 0
 7780 2ae8 B0EE600B 		vmov.f64	d0, d16	@, <retval>
 7781 2aec 0837     		adds	r7, r7, #8	@,,
 7782              	.LCFI247:
 7783              		.cfi_def_cfa_offset 8
 7784 2aee BD46     		mov	sp, r7	@,
 7785              	.LCFI248:
 7786              		.cfi_def_cfa_register 13
 7787              		@ sp needed	@
 7788 2af0 80BD     		pop	{r7, pc}	@
 7789              		.cfi_endproc
 7790              	.LFE65:
 7792              		.align	1
 7793              		.global	json_object_dotget_object
 7794              		.syntax unified
 7795              		.thumb
 7796              		.thumb_func
 7797              		.fpu neon
 7799              	json_object_dotget_object:
 7800              	.LFB66:
1299:parson.c      **** 
1300:parson.c      **** JSON_Object *json_object_dotget_object(const JSON_Object *object, const char *name)
1301:parson.c      **** {
 7801              		.loc 2 1301 0
 7802              		.cfi_startproc
 7803              		@ args = 0, pretend = 0, frame = 8
 7804              		@ frame_needed = 1, uses_anonymous_args = 0
 7805 2af2 80B5     		push	{r7, lr}	@
 7806              	.LCFI249:
 7807              		.cfi_def_cfa_offset 8
 7808              		.cfi_offset 7, -8
 7809              		.cfi_offset 14, -4
 7810 2af4 82B0     		sub	sp, sp, #8	@,,
 7811              	.LCFI250:
 7812              		.cfi_def_cfa_offset 16
 7813 2af6 00AF     		add	r7, sp, #0	@,,
 7814              	.LCFI251:
 7815              		.cfi_def_cfa_register 7
 7816 2af8 7860     		str	r0, [r7, #4]	@ object, object
 7817 2afa 3960     		str	r1, [r7]	@ name, name
1302:parson.c      ****     return json_value_get_object(json_object_dotget_value(object, name));
 7818              		.loc 2 1302 0
 7819 2afc 3968     		ldr	r1, [r7]	@, name
 7820 2afe 7868     		ldr	r0, [r7, #4]	@, object
 7821 2b00 FFF7FEFF 		bl	json_object_dotget_value	@
 7822 2b04 0346     		mov	r3, r0	@ _5,
 7823 2b06 1846     		mov	r0, r3	@, _5
 7824 2b08 FFF7FEFF 		bl	json_value_get_object	@
 7825 2b0c 0346     		mov	r3, r0	@ _7,
1303:parson.c      **** }
 7826              		.loc 2 1303 0
 7827 2b0e 1846     		mov	r0, r3	@, <retval>
 7828 2b10 0837     		adds	r7, r7, #8	@,,
 7829              	.LCFI252:
 7830              		.cfi_def_cfa_offset 8
 7831 2b12 BD46     		mov	sp, r7	@,
 7832              	.LCFI253:
 7833              		.cfi_def_cfa_register 13
 7834              		@ sp needed	@
 7835 2b14 80BD     		pop	{r7, pc}	@
 7836              		.cfi_endproc
 7837              	.LFE66:
 7839              		.align	1
 7840              		.global	json_object_dotget_array
 7841              		.syntax unified
 7842              		.thumb
 7843              		.thumb_func
 7844              		.fpu neon
 7846              	json_object_dotget_array:
 7847              	.LFB67:
1304:parson.c      **** 
1305:parson.c      **** JSON_Array *json_object_dotget_array(const JSON_Object *object, const char *name)
1306:parson.c      **** {
 7848              		.loc 2 1306 0
 7849              		.cfi_startproc
 7850              		@ args = 0, pretend = 0, frame = 8
 7851              		@ frame_needed = 1, uses_anonymous_args = 0
 7852 2b16 80B5     		push	{r7, lr}	@
 7853              	.LCFI254:
 7854              		.cfi_def_cfa_offset 8
 7855              		.cfi_offset 7, -8
 7856              		.cfi_offset 14, -4
 7857 2b18 82B0     		sub	sp, sp, #8	@,,
 7858              	.LCFI255:
 7859              		.cfi_def_cfa_offset 16
 7860 2b1a 00AF     		add	r7, sp, #0	@,,
 7861              	.LCFI256:
 7862              		.cfi_def_cfa_register 7
 7863 2b1c 7860     		str	r0, [r7, #4]	@ object, object
 7864 2b1e 3960     		str	r1, [r7]	@ name, name
1307:parson.c      ****     return json_value_get_array(json_object_dotget_value(object, name));
 7865              		.loc 2 1307 0
 7866 2b20 3968     		ldr	r1, [r7]	@, name
 7867 2b22 7868     		ldr	r0, [r7, #4]	@, object
 7868 2b24 FFF7FEFF 		bl	json_object_dotget_value	@
 7869 2b28 0346     		mov	r3, r0	@ _5,
 7870 2b2a 1846     		mov	r0, r3	@, _5
 7871 2b2c FFF7FEFF 		bl	json_value_get_array	@
 7872 2b30 0346     		mov	r3, r0	@ _7,
1308:parson.c      **** }
 7873              		.loc 2 1308 0
 7874 2b32 1846     		mov	r0, r3	@, <retval>
 7875 2b34 0837     		adds	r7, r7, #8	@,,
 7876              	.LCFI257:
 7877              		.cfi_def_cfa_offset 8
 7878 2b36 BD46     		mov	sp, r7	@,
 7879              	.LCFI258:
 7880              		.cfi_def_cfa_register 13
 7881              		@ sp needed	@
 7882 2b38 80BD     		pop	{r7, pc}	@
 7883              		.cfi_endproc
 7884              	.LFE67:
 7886              		.align	1
 7887              		.global	json_object_dotget_boolean
 7888              		.syntax unified
 7889              		.thumb
 7890              		.thumb_func
 7891              		.fpu neon
 7893              	json_object_dotget_boolean:
 7894              	.LFB68:
1309:parson.c      **** 
1310:parson.c      **** int json_object_dotget_boolean(const JSON_Object *object, const char *name)
1311:parson.c      **** {
 7895              		.loc 2 1311 0
 7896              		.cfi_startproc
 7897              		@ args = 0, pretend = 0, frame = 8
 7898              		@ frame_needed = 1, uses_anonymous_args = 0
 7899 2b3a 80B5     		push	{r7, lr}	@
 7900              	.LCFI259:
 7901              		.cfi_def_cfa_offset 8
 7902              		.cfi_offset 7, -8
 7903              		.cfi_offset 14, -4
 7904 2b3c 82B0     		sub	sp, sp, #8	@,,
 7905              	.LCFI260:
 7906              		.cfi_def_cfa_offset 16
 7907 2b3e 00AF     		add	r7, sp, #0	@,,
 7908              	.LCFI261:
 7909              		.cfi_def_cfa_register 7
 7910 2b40 7860     		str	r0, [r7, #4]	@ object, object
 7911 2b42 3960     		str	r1, [r7]	@ name, name
1312:parson.c      ****     return json_value_get_boolean(json_object_dotget_value(object, name));
 7912              		.loc 2 1312 0
 7913 2b44 3968     		ldr	r1, [r7]	@, name
 7914 2b46 7868     		ldr	r0, [r7, #4]	@, object
 7915 2b48 FFF7FEFF 		bl	json_object_dotget_value	@
 7916 2b4c 0346     		mov	r3, r0	@ _5,
 7917 2b4e 1846     		mov	r0, r3	@, _5
 7918 2b50 FFF7FEFF 		bl	json_value_get_boolean	@
 7919 2b54 0346     		mov	r3, r0	@ _7,
1313:parson.c      **** }
 7920              		.loc 2 1313 0
 7921 2b56 1846     		mov	r0, r3	@, <retval>
 7922 2b58 0837     		adds	r7, r7, #8	@,,
 7923              	.LCFI262:
 7924              		.cfi_def_cfa_offset 8
 7925 2b5a BD46     		mov	sp, r7	@,
 7926              	.LCFI263:
 7927              		.cfi_def_cfa_register 13
 7928              		@ sp needed	@
 7929 2b5c 80BD     		pop	{r7, pc}	@
 7930              		.cfi_endproc
 7931              	.LFE68:
 7933              		.align	1
 7934              		.global	json_object_get_count
 7935              		.syntax unified
 7936              		.thumb
 7937              		.thumb_func
 7938              		.fpu neon
 7940              	json_object_get_count:
 7941              	.LFB69:
1314:parson.c      **** 
1315:parson.c      **** size_t json_object_get_count(const JSON_Object *object)
1316:parson.c      **** {
 7942              		.loc 2 1316 0
 7943              		.cfi_startproc
 7944              		@ args = 0, pretend = 0, frame = 8
 7945              		@ frame_needed = 1, uses_anonymous_args = 0
 7946              		@ link register save eliminated.
 7947 2b5e 80B4     		push	{r7}	@
 7948              	.LCFI264:
 7949              		.cfi_def_cfa_offset 4
 7950              		.cfi_offset 7, -4
 7951 2b60 83B0     		sub	sp, sp, #12	@,,
 7952              	.LCFI265:
 7953              		.cfi_def_cfa_offset 16
 7954 2b62 00AF     		add	r7, sp, #0	@,,
 7955              	.LCFI266:
 7956              		.cfi_def_cfa_register 7
 7957 2b64 7860     		str	r0, [r7, #4]	@ object, object
1317:parson.c      ****     return object ? object->count : 0;
 7958              		.loc 2 1317 0
 7959 2b66 7B68     		ldr	r3, [r7, #4]	@ tmp112, object
 7960 2b68 002B     		cmp	r3, #0	@ tmp112,
 7961 2b6a 02D0     		beq	.L505	@,
 7962              		.loc 2 1317 0 is_stmt 0 discriminator 1
 7963 2b6c 7B68     		ldr	r3, [r7, #4]	@ tmp113, object
 7964 2b6e DB68     		ldr	r3, [r3, #12]	@ iftmp.161_1, object_2(D)->count
 7965 2b70 00E0     		b	.L507	@
 7966              	.L505:
 7967              		.loc 2 1317 0 discriminator 2
 7968 2b72 0023     		movs	r3, #0	@ iftmp.161_1,
 7969              	.L507:
1318:parson.c      **** }
 7970              		.loc 2 1318 0 is_stmt 1 discriminator 5
 7971 2b74 1846     		mov	r0, r3	@, <retval>
 7972 2b76 0C37     		adds	r7, r7, #12	@,,
 7973              	.LCFI267:
 7974              		.cfi_def_cfa_offset 4
 7975 2b78 BD46     		mov	sp, r7	@,
 7976              	.LCFI268:
 7977              		.cfi_def_cfa_register 13
 7978              		@ sp needed	@
 7979 2b7a 5DF8047B 		ldr	r7, [sp], #4	@,
 7980              	.LCFI269:
 7981              		.cfi_restore 7
 7982              		.cfi_def_cfa_offset 0
 7983 2b7e 7047     		bx	lr	@
 7984              		.cfi_endproc
 7985              	.LFE69:
 7987              		.align	1
 7988              		.global	json_object_get_name
 7989              		.syntax unified
 7990              		.thumb
 7991              		.thumb_func
 7992              		.fpu neon
 7994              	json_object_get_name:
 7995              	.LFB70:
1319:parson.c      **** 
1320:parson.c      **** const char *json_object_get_name(const JSON_Object *object, size_t index)
1321:parson.c      **** {
 7996              		.loc 2 1321 0
 7997              		.cfi_startproc
 7998              		@ args = 0, pretend = 0, frame = 8
 7999              		@ frame_needed = 1, uses_anonymous_args = 0
 8000 2b80 80B5     		push	{r7, lr}	@
 8001              	.LCFI270:
 8002              		.cfi_def_cfa_offset 8
 8003              		.cfi_offset 7, -8
 8004              		.cfi_offset 14, -4
 8005 2b82 82B0     		sub	sp, sp, #8	@,,
 8006              	.LCFI271:
 8007              		.cfi_def_cfa_offset 16
 8008 2b84 00AF     		add	r7, sp, #0	@,,
 8009              	.LCFI272:
 8010              		.cfi_def_cfa_register 7
 8011 2b86 7860     		str	r0, [r7, #4]	@ object, object
 8012 2b88 3960     		str	r1, [r7]	@ index, index
1322:parson.c      ****     if (object == NULL || index >= json_object_get_count(object)) {
 8013              		.loc 2 1322 0
 8014 2b8a 7B68     		ldr	r3, [r7, #4]	@ tmp116, object
 8015 2b8c 002B     		cmp	r3, #0	@ tmp116,
 8016 2b8e 06D0     		beq	.L509	@,
 8017              		.loc 2 1322 0 is_stmt 0 discriminator 1
 8018 2b90 7868     		ldr	r0, [r7, #4]	@, object
 8019 2b92 FFF7FEFF 		bl	json_object_get_count	@
 8020 2b96 0246     		mov	r2, r0	@ _7,
 8021 2b98 3B68     		ldr	r3, [r7]	@ tmp117, index
 8022 2b9a 9A42     		cmp	r2, r3	@ _7, tmp117
 8023 2b9c 01D8     		bhi	.L510	@,
 8024              	.L509:
1323:parson.c      ****         return NULL;
 8025              		.loc 2 1323 0 is_stmt 1
 8026 2b9e 0023     		movs	r3, #0	@ _1,
 8027 2ba0 05E0     		b	.L511	@
 8028              	.L510:
1324:parson.c      ****     }
1325:parson.c      ****     return object->names[index];
 8029              		.loc 2 1325 0
 8030 2ba2 7B68     		ldr	r3, [r7, #4]	@ tmp118, object
 8031 2ba4 5A68     		ldr	r2, [r3, #4]	@ _9, object_4(D)->names
 8032 2ba6 3B68     		ldr	r3, [r7]	@ tmp119, index
 8033 2ba8 9B00     		lsls	r3, r3, #2	@ _10, tmp119,
 8034 2baa 1344     		add	r3, r3, r2	@ _11, _9
 8035 2bac 1B68     		ldr	r3, [r3]	@ _1, *_11
 8036              	.L511:
1326:parson.c      **** }
 8037              		.loc 2 1326 0
 8038 2bae 1846     		mov	r0, r3	@, <retval>
 8039 2bb0 0837     		adds	r7, r7, #8	@,,
 8040              	.LCFI273:
 8041              		.cfi_def_cfa_offset 8
 8042 2bb2 BD46     		mov	sp, r7	@,
 8043              	.LCFI274:
 8044              		.cfi_def_cfa_register 13
 8045              		@ sp needed	@
 8046 2bb4 80BD     		pop	{r7, pc}	@
 8047              		.cfi_endproc
 8048              	.LFE70:
 8050              		.align	1
 8051              		.global	json_object_get_value_at
 8052              		.syntax unified
 8053              		.thumb
 8054              		.thumb_func
 8055              		.fpu neon
 8057              	json_object_get_value_at:
 8058              	.LFB71:
1327:parson.c      **** 
1328:parson.c      **** JSON_Value *json_object_get_value_at(const JSON_Object *object, size_t index)
1329:parson.c      **** {
 8059              		.loc 2 1329 0
 8060              		.cfi_startproc
 8061              		@ args = 0, pretend = 0, frame = 8
 8062              		@ frame_needed = 1, uses_anonymous_args = 0
 8063 2bb6 80B5     		push	{r7, lr}	@
 8064              	.LCFI275:
 8065              		.cfi_def_cfa_offset 8
 8066              		.cfi_offset 7, -8
 8067              		.cfi_offset 14, -4
 8068 2bb8 82B0     		sub	sp, sp, #8	@,,
 8069              	.LCFI276:
 8070              		.cfi_def_cfa_offset 16
 8071 2bba 00AF     		add	r7, sp, #0	@,,
 8072              	.LCFI277:
 8073              		.cfi_def_cfa_register 7
 8074 2bbc 7860     		str	r0, [r7, #4]	@ object, object
 8075 2bbe 3960     		str	r1, [r7]	@ index, index
1330:parson.c      ****     if (object == NULL || index >= json_object_get_count(object)) {
 8076              		.loc 2 1330 0
 8077 2bc0 7B68     		ldr	r3, [r7, #4]	@ tmp116, object
 8078 2bc2 002B     		cmp	r3, #0	@ tmp116,
 8079 2bc4 06D0     		beq	.L513	@,
 8080              		.loc 2 1330 0 is_stmt 0 discriminator 1
 8081 2bc6 7868     		ldr	r0, [r7, #4]	@, object
 8082 2bc8 FFF7FEFF 		bl	json_object_get_count	@
 8083 2bcc 0246     		mov	r2, r0	@ _7,
 8084 2bce 3B68     		ldr	r3, [r7]	@ tmp117, index
 8085 2bd0 9A42     		cmp	r2, r3	@ _7, tmp117
 8086 2bd2 01D8     		bhi	.L514	@,
 8087              	.L513:
1331:parson.c      ****         return NULL;
 8088              		.loc 2 1331 0 is_stmt 1
 8089 2bd4 0023     		movs	r3, #0	@ _1,
 8090 2bd6 05E0     		b	.L515	@
 8091              	.L514:
1332:parson.c      ****     }
1333:parson.c      ****     return object->values[index];
 8092              		.loc 2 1333 0
 8093 2bd8 7B68     		ldr	r3, [r7, #4]	@ tmp118, object
 8094 2bda 9A68     		ldr	r2, [r3, #8]	@ _9, object_4(D)->values
 8095 2bdc 3B68     		ldr	r3, [r7]	@ tmp119, index
 8096 2bde 9B00     		lsls	r3, r3, #2	@ _10, tmp119,
 8097 2be0 1344     		add	r3, r3, r2	@ _11, _9
 8098 2be2 1B68     		ldr	r3, [r3]	@ _1, *_11
 8099              	.L515:
1334:parson.c      **** }
 8100              		.loc 2 1334 0
 8101 2be4 1846     		mov	r0, r3	@, <retval>
 8102 2be6 0837     		adds	r7, r7, #8	@,,
 8103              	.LCFI278:
 8104              		.cfi_def_cfa_offset 8
 8105 2be8 BD46     		mov	sp, r7	@,
 8106              	.LCFI279:
 8107              		.cfi_def_cfa_register 13
 8108              		@ sp needed	@
 8109 2bea 80BD     		pop	{r7, pc}	@
 8110              		.cfi_endproc
 8111              	.LFE71:
 8113              		.align	1
 8114              		.global	json_object_get_wrapping_value
 8115              		.syntax unified
 8116              		.thumb
 8117              		.thumb_func
 8118              		.fpu neon
 8120              	json_object_get_wrapping_value:
 8121              	.LFB72:
1335:parson.c      **** 
1336:parson.c      **** JSON_Value *json_object_get_wrapping_value(const JSON_Object *object)
1337:parson.c      **** {
 8122              		.loc 2 1337 0
 8123              		.cfi_startproc
 8124              		@ args = 0, pretend = 0, frame = 8
 8125              		@ frame_needed = 1, uses_anonymous_args = 0
 8126              		@ link register save eliminated.
 8127 2bec 80B4     		push	{r7}	@
 8128              	.LCFI280:
 8129              		.cfi_def_cfa_offset 4
 8130              		.cfi_offset 7, -4
 8131 2bee 83B0     		sub	sp, sp, #12	@,,
 8132              	.LCFI281:
 8133              		.cfi_def_cfa_offset 16
 8134 2bf0 00AF     		add	r7, sp, #0	@,,
 8135              	.LCFI282:
 8136              		.cfi_def_cfa_register 7
 8137 2bf2 7860     		str	r0, [r7, #4]	@ object, object
1338:parson.c      ****     return object->wrapping_value;
 8138              		.loc 2 1338 0
 8139 2bf4 7B68     		ldr	r3, [r7, #4]	@ tmp112, object
 8140 2bf6 1B68     		ldr	r3, [r3]	@ _3, object_2(D)->wrapping_value
1339:parson.c      **** }
 8141              		.loc 2 1339 0
 8142 2bf8 1846     		mov	r0, r3	@, <retval>
 8143 2bfa 0C37     		adds	r7, r7, #12	@,,
 8144              	.LCFI283:
 8145              		.cfi_def_cfa_offset 4
 8146 2bfc BD46     		mov	sp, r7	@,
 8147              	.LCFI284:
 8148              		.cfi_def_cfa_register 13
 8149              		@ sp needed	@
 8150 2bfe 5DF8047B 		ldr	r7, [sp], #4	@,
 8151              	.LCFI285:
 8152              		.cfi_restore 7
 8153              		.cfi_def_cfa_offset 0
 8154 2c02 7047     		bx	lr	@
 8155              		.cfi_endproc
 8156              	.LFE72:
 8158              		.align	1
 8159              		.global	json_object_has_value
 8160              		.syntax unified
 8161              		.thumb
 8162              		.thumb_func
 8163              		.fpu neon
 8165              	json_object_has_value:
 8166              	.LFB73:
1340:parson.c      **** 
1341:parson.c      **** int json_object_has_value(const JSON_Object *object, const char *name)
1342:parson.c      **** {
 8167              		.loc 2 1342 0
 8168              		.cfi_startproc
 8169              		@ args = 0, pretend = 0, frame = 8
 8170              		@ frame_needed = 1, uses_anonymous_args = 0
 8171 2c04 80B5     		push	{r7, lr}	@
 8172              	.LCFI286:
 8173              		.cfi_def_cfa_offset 8
 8174              		.cfi_offset 7, -8
 8175              		.cfi_offset 14, -4
 8176 2c06 82B0     		sub	sp, sp, #8	@,,
 8177              	.LCFI287:
 8178              		.cfi_def_cfa_offset 16
 8179 2c08 00AF     		add	r7, sp, #0	@,,
 8180              	.LCFI288:
 8181              		.cfi_def_cfa_register 7
 8182 2c0a 7860     		str	r0, [r7, #4]	@ object, object
 8183 2c0c 3960     		str	r1, [r7]	@ name, name
1343:parson.c      ****     return json_object_get_value(object, name) != NULL;
 8184              		.loc 2 1343 0
 8185 2c0e 3968     		ldr	r1, [r7]	@, name
 8186 2c10 7868     		ldr	r0, [r7, #4]	@, object
 8187 2c12 FFF7FEFF 		bl	json_object_get_value	@
 8188 2c16 0346     		mov	r3, r0	@ _5,
 8189 2c18 002B     		cmp	r3, #0	@ _5,
 8190 2c1a 14BF     		ite	ne
 8191 2c1c 0123     		movne	r3, #1	@ tmp115,
 8192 2c1e 0023     		moveq	r3, #0	@ tmp115,
 8193 2c20 DBB2     		uxtb	r3, r3	@ _6, tmp114
1344:parson.c      **** }
 8194              		.loc 2 1344 0
 8195 2c22 1846     		mov	r0, r3	@, <retval>
 8196 2c24 0837     		adds	r7, r7, #8	@,,
 8197              	.LCFI289:
 8198              		.cfi_def_cfa_offset 8
 8199 2c26 BD46     		mov	sp, r7	@,
 8200              	.LCFI290:
 8201              		.cfi_def_cfa_register 13
 8202              		@ sp needed	@
 8203 2c28 80BD     		pop	{r7, pc}	@
 8204              		.cfi_endproc
 8205              	.LFE73:
 8207              		.align	1
 8208              		.global	json_object_has_value_of_type
 8209              		.syntax unified
 8210              		.thumb
 8211              		.thumb_func
 8212              		.fpu neon
 8214              	json_object_has_value_of_type:
 8215              	.LFB74:
1345:parson.c      **** 
1346:parson.c      **** int json_object_has_value_of_type(const JSON_Object *object, const char *name, JSON_Value_Type type
1347:parson.c      **** {
 8216              		.loc 2 1347 0
 8217              		.cfi_startproc
 8218              		@ args = 0, pretend = 0, frame = 24
 8219              		@ frame_needed = 1, uses_anonymous_args = 0
 8220 2c2a 80B5     		push	{r7, lr}	@
 8221              	.LCFI291:
 8222              		.cfi_def_cfa_offset 8
 8223              		.cfi_offset 7, -8
 8224              		.cfi_offset 14, -4
 8225 2c2c 86B0     		sub	sp, sp, #24	@,,
 8226              	.LCFI292:
 8227              		.cfi_def_cfa_offset 32
 8228 2c2e 00AF     		add	r7, sp, #0	@,,
 8229              	.LCFI293:
 8230              		.cfi_def_cfa_register 7
 8231 2c30 F860     		str	r0, [r7, #12]	@ object, object
 8232 2c32 B960     		str	r1, [r7, #8]	@ name, name
 8233 2c34 7A60     		str	r2, [r7, #4]	@ type, type
1348:parson.c      ****     JSON_Value *val = json_object_get_value(object, name);
 8234              		.loc 2 1348 0
 8235 2c36 B968     		ldr	r1, [r7, #8]	@, name
 8236 2c38 F868     		ldr	r0, [r7, #12]	@, object
 8237 2c3a FFF7FEFF 		bl	json_object_get_value	@
 8238 2c3e 7861     		str	r0, [r7, #20]	@, val
1349:parson.c      ****     return val != NULL && json_value_get_type(val) == type;
 8239              		.loc 2 1349 0
 8240 2c40 7B69     		ldr	r3, [r7, #20]	@ tmp113, val
 8241 2c42 002B     		cmp	r3, #0	@ tmp113,
 8242 2c44 08D0     		beq	.L521	@,
 8243              		.loc 2 1349 0 is_stmt 0 discriminator 1
 8244 2c46 7869     		ldr	r0, [r7, #20]	@, val
 8245 2c48 FFF7FEFF 		bl	json_value_get_type	@
 8246 2c4c 0246     		mov	r2, r0	@ _10,
 8247 2c4e 7B68     		ldr	r3, [r7, #4]	@ tmp114, type
 8248 2c50 9A42     		cmp	r2, r3	@ _10, tmp114
 8249 2c52 01D1     		bne	.L521	@,
 8250              		.loc 2 1349 0 discriminator 3
 8251 2c54 0123     		movs	r3, #1	@ iftmp.162_1,
 8252 2c56 00E0     		b	.L523	@
 8253              	.L521:
 8254              		.loc 2 1349 0 discriminator 4
 8255 2c58 0023     		movs	r3, #0	@ iftmp.162_1,
 8256              	.L523:
1350:parson.c      **** }
 8257              		.loc 2 1350 0 is_stmt 1 discriminator 7
 8258 2c5a 1846     		mov	r0, r3	@, <retval>
 8259 2c5c 1837     		adds	r7, r7, #24	@,,
 8260              	.LCFI294:
 8261              		.cfi_def_cfa_offset 8
 8262 2c5e BD46     		mov	sp, r7	@,
 8263              	.LCFI295:
 8264              		.cfi_def_cfa_register 13
 8265              		@ sp needed	@
 8266 2c60 80BD     		pop	{r7, pc}	@
 8267              		.cfi_endproc
 8268              	.LFE74:
 8270              		.align	1
 8271              		.global	json_object_dothas_value
 8272              		.syntax unified
 8273              		.thumb
 8274              		.thumb_func
 8275              		.fpu neon
 8277              	json_object_dothas_value:
 8278              	.LFB75:
1351:parson.c      **** 
1352:parson.c      **** int json_object_dothas_value(const JSON_Object *object, const char *name)
1353:parson.c      **** {
 8279              		.loc 2 1353 0
 8280              		.cfi_startproc
 8281              		@ args = 0, pretend = 0, frame = 8
 8282              		@ frame_needed = 1, uses_anonymous_args = 0
 8283 2c62 80B5     		push	{r7, lr}	@
 8284              	.LCFI296:
 8285              		.cfi_def_cfa_offset 8
 8286              		.cfi_offset 7, -8
 8287              		.cfi_offset 14, -4
 8288 2c64 82B0     		sub	sp, sp, #8	@,,
 8289              	.LCFI297:
 8290              		.cfi_def_cfa_offset 16
 8291 2c66 00AF     		add	r7, sp, #0	@,,
 8292              	.LCFI298:
 8293              		.cfi_def_cfa_register 7
 8294 2c68 7860     		str	r0, [r7, #4]	@ object, object
 8295 2c6a 3960     		str	r1, [r7]	@ name, name
1354:parson.c      ****     return json_object_dotget_value(object, name) != NULL;
 8296              		.loc 2 1354 0
 8297 2c6c 3968     		ldr	r1, [r7]	@, name
 8298 2c6e 7868     		ldr	r0, [r7, #4]	@, object
 8299 2c70 FFF7FEFF 		bl	json_object_dotget_value	@
 8300 2c74 0346     		mov	r3, r0	@ _5,
 8301 2c76 002B     		cmp	r3, #0	@ _5,
 8302 2c78 14BF     		ite	ne
 8303 2c7a 0123     		movne	r3, #1	@ tmp115,
 8304 2c7c 0023     		moveq	r3, #0	@ tmp115,
 8305 2c7e DBB2     		uxtb	r3, r3	@ _6, tmp114
1355:parson.c      **** }
 8306              		.loc 2 1355 0
 8307 2c80 1846     		mov	r0, r3	@, <retval>
 8308 2c82 0837     		adds	r7, r7, #8	@,,
 8309              	.LCFI299:
 8310              		.cfi_def_cfa_offset 8
 8311 2c84 BD46     		mov	sp, r7	@,
 8312              	.LCFI300:
 8313              		.cfi_def_cfa_register 13
 8314              		@ sp needed	@
 8315 2c86 80BD     		pop	{r7, pc}	@
 8316              		.cfi_endproc
 8317              	.LFE75:
 8319              		.align	1
 8320              		.global	json_object_dothas_value_of_type
 8321              		.syntax unified
 8322              		.thumb
 8323              		.thumb_func
 8324              		.fpu neon
 8326              	json_object_dothas_value_of_type:
 8327              	.LFB76:
1356:parson.c      **** 
1357:parson.c      **** int json_object_dothas_value_of_type(const JSON_Object *object, const char *name,
1358:parson.c      ****                                      JSON_Value_Type type)
1359:parson.c      **** {
 8328              		.loc 2 1359 0
 8329              		.cfi_startproc
 8330              		@ args = 0, pretend = 0, frame = 24
 8331              		@ frame_needed = 1, uses_anonymous_args = 0
 8332 2c88 80B5     		push	{r7, lr}	@
 8333              	.LCFI301:
 8334              		.cfi_def_cfa_offset 8
 8335              		.cfi_offset 7, -8
 8336              		.cfi_offset 14, -4
 8337 2c8a 86B0     		sub	sp, sp, #24	@,,
 8338              	.LCFI302:
 8339              		.cfi_def_cfa_offset 32
 8340 2c8c 00AF     		add	r7, sp, #0	@,,
 8341              	.LCFI303:
 8342              		.cfi_def_cfa_register 7
 8343 2c8e F860     		str	r0, [r7, #12]	@ object, object
 8344 2c90 B960     		str	r1, [r7, #8]	@ name, name
 8345 2c92 7A60     		str	r2, [r7, #4]	@ type, type
1360:parson.c      ****     JSON_Value *val = json_object_dotget_value(object, name);
 8346              		.loc 2 1360 0
 8347 2c94 B968     		ldr	r1, [r7, #8]	@, name
 8348 2c96 F868     		ldr	r0, [r7, #12]	@, object
 8349 2c98 FFF7FEFF 		bl	json_object_dotget_value	@
 8350 2c9c 7861     		str	r0, [r7, #20]	@, val
1361:parson.c      ****     return val != NULL && json_value_get_type(val) == type;
 8351              		.loc 2 1361 0
 8352 2c9e 7B69     		ldr	r3, [r7, #20]	@ tmp113, val
 8353 2ca0 002B     		cmp	r3, #0	@ tmp113,
 8354 2ca2 08D0     		beq	.L527	@,
 8355              		.loc 2 1361 0 is_stmt 0 discriminator 1
 8356 2ca4 7869     		ldr	r0, [r7, #20]	@, val
 8357 2ca6 FFF7FEFF 		bl	json_value_get_type	@
 8358 2caa 0246     		mov	r2, r0	@ _10,
 8359 2cac 7B68     		ldr	r3, [r7, #4]	@ tmp114, type
 8360 2cae 9A42     		cmp	r2, r3	@ _10, tmp114
 8361 2cb0 01D1     		bne	.L527	@,
 8362              		.loc 2 1361 0 discriminator 3
 8363 2cb2 0123     		movs	r3, #1	@ iftmp.163_1,
 8364 2cb4 00E0     		b	.L529	@
 8365              	.L527:
 8366              		.loc 2 1361 0 discriminator 4
 8367 2cb6 0023     		movs	r3, #0	@ iftmp.163_1,
 8368              	.L529:
1362:parson.c      **** }
 8369              		.loc 2 1362 0 is_stmt 1 discriminator 7
 8370 2cb8 1846     		mov	r0, r3	@, <retval>
 8371 2cba 1837     		adds	r7, r7, #24	@,,
 8372              	.LCFI304:
 8373              		.cfi_def_cfa_offset 8
 8374 2cbc BD46     		mov	sp, r7	@,
 8375              	.LCFI305:
 8376              		.cfi_def_cfa_register 13
 8377              		@ sp needed	@
 8378 2cbe 80BD     		pop	{r7, pc}	@
 8379              		.cfi_endproc
 8380              	.LFE76:
 8382              		.align	1
 8383              		.global	json_array_get_value
 8384              		.syntax unified
 8385              		.thumb
 8386              		.thumb_func
 8387              		.fpu neon
 8389              	json_array_get_value:
 8390              	.LFB77:
1363:parson.c      **** 
1364:parson.c      **** /* JSON Array API */
1365:parson.c      **** JSON_Value *json_array_get_value(const JSON_Array *array, size_t index)
1366:parson.c      **** {
 8391              		.loc 2 1366 0
 8392              		.cfi_startproc
 8393              		@ args = 0, pretend = 0, frame = 8
 8394              		@ frame_needed = 1, uses_anonymous_args = 0
 8395 2cc0 80B5     		push	{r7, lr}	@
 8396              	.LCFI306:
 8397              		.cfi_def_cfa_offset 8
 8398              		.cfi_offset 7, -8
 8399              		.cfi_offset 14, -4
 8400 2cc2 82B0     		sub	sp, sp, #8	@,,
 8401              	.LCFI307:
 8402              		.cfi_def_cfa_offset 16
 8403 2cc4 00AF     		add	r7, sp, #0	@,,
 8404              	.LCFI308:
 8405              		.cfi_def_cfa_register 7
 8406 2cc6 7860     		str	r0, [r7, #4]	@ array, array
 8407 2cc8 3960     		str	r1, [r7]	@ index, index
1367:parson.c      ****     if (array == NULL || index >= json_array_get_count(array)) {
 8408              		.loc 2 1367 0
 8409 2cca 7B68     		ldr	r3, [r7, #4]	@ tmp116, array
 8410 2ccc 002B     		cmp	r3, #0	@ tmp116,
 8411 2cce 06D0     		beq	.L531	@,
 8412              		.loc 2 1367 0 is_stmt 0 discriminator 1
 8413 2cd0 7868     		ldr	r0, [r7, #4]	@, array
 8414 2cd2 FFF7FEFF 		bl	json_array_get_count	@
 8415 2cd6 0246     		mov	r2, r0	@ _7,
 8416 2cd8 3B68     		ldr	r3, [r7]	@ tmp117, index
 8417 2cda 9A42     		cmp	r2, r3	@ _7, tmp117
 8418 2cdc 01D8     		bhi	.L532	@,
 8419              	.L531:
1368:parson.c      ****         return NULL;
 8420              		.loc 2 1368 0 is_stmt 1
 8421 2cde 0023     		movs	r3, #0	@ _1,
 8422 2ce0 05E0     		b	.L533	@
 8423              	.L532:
1369:parson.c      ****     }
1370:parson.c      ****     return array->items[index];
 8424              		.loc 2 1370 0
 8425 2ce2 7B68     		ldr	r3, [r7, #4]	@ tmp118, array
 8426 2ce4 5A68     		ldr	r2, [r3, #4]	@ _9, array_4(D)->items
 8427 2ce6 3B68     		ldr	r3, [r7]	@ tmp119, index
 8428 2ce8 9B00     		lsls	r3, r3, #2	@ _10, tmp119,
 8429 2cea 1344     		add	r3, r3, r2	@ _11, _9
 8430 2cec 1B68     		ldr	r3, [r3]	@ _1, *_11
 8431              	.L533:
1371:parson.c      **** }
 8432              		.loc 2 1371 0
 8433 2cee 1846     		mov	r0, r3	@, <retval>
 8434 2cf0 0837     		adds	r7, r7, #8	@,,
 8435              	.LCFI309:
 8436              		.cfi_def_cfa_offset 8
 8437 2cf2 BD46     		mov	sp, r7	@,
 8438              	.LCFI310:
 8439              		.cfi_def_cfa_register 13
 8440              		@ sp needed	@
 8441 2cf4 80BD     		pop	{r7, pc}	@
 8442              		.cfi_endproc
 8443              	.LFE77:
 8445              		.align	1
 8446              		.global	json_array_get_string
 8447              		.syntax unified
 8448              		.thumb
 8449              		.thumb_func
 8450              		.fpu neon
 8452              	json_array_get_string:
 8453              	.LFB78:
1372:parson.c      **** 
1373:parson.c      **** const char *json_array_get_string(const JSON_Array *array, size_t index)
1374:parson.c      **** {
 8454              		.loc 2 1374 0
 8455              		.cfi_startproc
 8456              		@ args = 0, pretend = 0, frame = 8
 8457              		@ frame_needed = 1, uses_anonymous_args = 0
 8458 2cf6 80B5     		push	{r7, lr}	@
 8459              	.LCFI311:
 8460              		.cfi_def_cfa_offset 8
 8461              		.cfi_offset 7, -8
 8462              		.cfi_offset 14, -4
 8463 2cf8 82B0     		sub	sp, sp, #8	@,,
 8464              	.LCFI312:
 8465              		.cfi_def_cfa_offset 16
 8466 2cfa 00AF     		add	r7, sp, #0	@,,
 8467              	.LCFI313:
 8468              		.cfi_def_cfa_register 7
 8469 2cfc 7860     		str	r0, [r7, #4]	@ array, array
 8470 2cfe 3960     		str	r1, [r7]	@ index, index
1375:parson.c      ****     return json_value_get_string(json_array_get_value(array, index));
 8471              		.loc 2 1375 0
 8472 2d00 3968     		ldr	r1, [r7]	@, index
 8473 2d02 7868     		ldr	r0, [r7, #4]	@, array
 8474 2d04 FFF7FEFF 		bl	json_array_get_value	@
 8475 2d08 0346     		mov	r3, r0	@ _5,
 8476 2d0a 1846     		mov	r0, r3	@, _5
 8477 2d0c FFF7FEFF 		bl	json_value_get_string	@
 8478 2d10 0346     		mov	r3, r0	@ _7,
1376:parson.c      **** }
 8479              		.loc 2 1376 0
 8480 2d12 1846     		mov	r0, r3	@, <retval>
 8481 2d14 0837     		adds	r7, r7, #8	@,,
 8482              	.LCFI314:
 8483              		.cfi_def_cfa_offset 8
 8484 2d16 BD46     		mov	sp, r7	@,
 8485              	.LCFI315:
 8486              		.cfi_def_cfa_register 13
 8487              		@ sp needed	@
 8488 2d18 80BD     		pop	{r7, pc}	@
 8489              		.cfi_endproc
 8490              	.LFE78:
 8492              		.align	1
 8493              		.global	json_array_get_number
 8494              		.syntax unified
 8495              		.thumb
 8496              		.thumb_func
 8497              		.fpu neon
 8499              	json_array_get_number:
 8500              	.LFB79:
1377:parson.c      **** 
1378:parson.c      **** double json_array_get_number(const JSON_Array *array, size_t index)
1379:parson.c      **** {
 8501              		.loc 2 1379 0
 8502              		.cfi_startproc
 8503              		@ args = 0, pretend = 0, frame = 8
 8504              		@ frame_needed = 1, uses_anonymous_args = 0
 8505 2d1a 80B5     		push	{r7, lr}	@
 8506              	.LCFI316:
 8507              		.cfi_def_cfa_offset 8
 8508              		.cfi_offset 7, -8
 8509              		.cfi_offset 14, -4
 8510 2d1c 82B0     		sub	sp, sp, #8	@,,
 8511              	.LCFI317:
 8512              		.cfi_def_cfa_offset 16
 8513 2d1e 00AF     		add	r7, sp, #0	@,,
 8514              	.LCFI318:
 8515              		.cfi_def_cfa_register 7
 8516 2d20 7860     		str	r0, [r7, #4]	@ array, array
 8517 2d22 3960     		str	r1, [r7]	@ index, index
1380:parson.c      ****     return json_value_get_number(json_array_get_value(array, index));
 8518              		.loc 2 1380 0
 8519 2d24 3968     		ldr	r1, [r7]	@, index
 8520 2d26 7868     		ldr	r0, [r7, #4]	@, array
 8521 2d28 FFF7FEFF 		bl	json_array_get_value	@
 8522 2d2c 0346     		mov	r3, r0	@ _5,
 8523 2d2e 1846     		mov	r0, r3	@, _5
 8524 2d30 FFF7FEFF 		bl	json_value_get_number	@
 8525 2d34 F0EE400B 		vmov.f64	d16, d0	@ _7,
1381:parson.c      **** }
 8526              		.loc 2 1381 0
 8527 2d38 B0EE600B 		vmov.f64	d0, d16	@, <retval>
 8528 2d3c 0837     		adds	r7, r7, #8	@,,
 8529              	.LCFI319:
 8530              		.cfi_def_cfa_offset 8
 8531 2d3e BD46     		mov	sp, r7	@,
 8532              	.LCFI320:
 8533              		.cfi_def_cfa_register 13
 8534              		@ sp needed	@
 8535 2d40 80BD     		pop	{r7, pc}	@
 8536              		.cfi_endproc
 8537              	.LFE79:
 8539              		.align	1
 8540              		.global	json_array_get_object
 8541              		.syntax unified
 8542              		.thumb
 8543              		.thumb_func
 8544              		.fpu neon
 8546              	json_array_get_object:
 8547              	.LFB80:
1382:parson.c      **** 
1383:parson.c      **** JSON_Object *json_array_get_object(const JSON_Array *array, size_t index)
1384:parson.c      **** {
 8548              		.loc 2 1384 0
 8549              		.cfi_startproc
 8550              		@ args = 0, pretend = 0, frame = 8
 8551              		@ frame_needed = 1, uses_anonymous_args = 0
 8552 2d42 80B5     		push	{r7, lr}	@
 8553              	.LCFI321:
 8554              		.cfi_def_cfa_offset 8
 8555              		.cfi_offset 7, -8
 8556              		.cfi_offset 14, -4
 8557 2d44 82B0     		sub	sp, sp, #8	@,,
 8558              	.LCFI322:
 8559              		.cfi_def_cfa_offset 16
 8560 2d46 00AF     		add	r7, sp, #0	@,,
 8561              	.LCFI323:
 8562              		.cfi_def_cfa_register 7
 8563 2d48 7860     		str	r0, [r7, #4]	@ array, array
 8564 2d4a 3960     		str	r1, [r7]	@ index, index
1385:parson.c      ****     return json_value_get_object(json_array_get_value(array, index));
 8565              		.loc 2 1385 0
 8566 2d4c 3968     		ldr	r1, [r7]	@, index
 8567 2d4e 7868     		ldr	r0, [r7, #4]	@, array
 8568 2d50 FFF7FEFF 		bl	json_array_get_value	@
 8569 2d54 0346     		mov	r3, r0	@ _5,
 8570 2d56 1846     		mov	r0, r3	@, _5
 8571 2d58 FFF7FEFF 		bl	json_value_get_object	@
 8572 2d5c 0346     		mov	r3, r0	@ _7,
1386:parson.c      **** }
 8573              		.loc 2 1386 0
 8574 2d5e 1846     		mov	r0, r3	@, <retval>
 8575 2d60 0837     		adds	r7, r7, #8	@,,
 8576              	.LCFI324:
 8577              		.cfi_def_cfa_offset 8
 8578 2d62 BD46     		mov	sp, r7	@,
 8579              	.LCFI325:
 8580              		.cfi_def_cfa_register 13
 8581              		@ sp needed	@
 8582 2d64 80BD     		pop	{r7, pc}	@
 8583              		.cfi_endproc
 8584              	.LFE80:
 8586              		.align	1
 8587              		.global	json_array_get_array
 8588              		.syntax unified
 8589              		.thumb
 8590              		.thumb_func
 8591              		.fpu neon
 8593              	json_array_get_array:
 8594              	.LFB81:
1387:parson.c      **** 
1388:parson.c      **** JSON_Array *json_array_get_array(const JSON_Array *array, size_t index)
1389:parson.c      **** {
 8595              		.loc 2 1389 0
 8596              		.cfi_startproc
 8597              		@ args = 0, pretend = 0, frame = 8
 8598              		@ frame_needed = 1, uses_anonymous_args = 0
 8599 2d66 80B5     		push	{r7, lr}	@
 8600              	.LCFI326:
 8601              		.cfi_def_cfa_offset 8
 8602              		.cfi_offset 7, -8
 8603              		.cfi_offset 14, -4
 8604 2d68 82B0     		sub	sp, sp, #8	@,,
 8605              	.LCFI327:
 8606              		.cfi_def_cfa_offset 16
 8607 2d6a 00AF     		add	r7, sp, #0	@,,
 8608              	.LCFI328:
 8609              		.cfi_def_cfa_register 7
 8610 2d6c 7860     		str	r0, [r7, #4]	@ array, array
 8611 2d6e 3960     		str	r1, [r7]	@ index, index
1390:parson.c      ****     return json_value_get_array(json_array_get_value(array, index));
 8612              		.loc 2 1390 0
 8613 2d70 3968     		ldr	r1, [r7]	@, index
 8614 2d72 7868     		ldr	r0, [r7, #4]	@, array
 8615 2d74 FFF7FEFF 		bl	json_array_get_value	@
 8616 2d78 0346     		mov	r3, r0	@ _5,
 8617 2d7a 1846     		mov	r0, r3	@, _5
 8618 2d7c FFF7FEFF 		bl	json_value_get_array	@
 8619 2d80 0346     		mov	r3, r0	@ _7,
1391:parson.c      **** }
 8620              		.loc 2 1391 0
 8621 2d82 1846     		mov	r0, r3	@, <retval>
 8622 2d84 0837     		adds	r7, r7, #8	@,,
 8623              	.LCFI329:
 8624              		.cfi_def_cfa_offset 8
 8625 2d86 BD46     		mov	sp, r7	@,
 8626              	.LCFI330:
 8627              		.cfi_def_cfa_register 13
 8628              		@ sp needed	@
 8629 2d88 80BD     		pop	{r7, pc}	@
 8630              		.cfi_endproc
 8631              	.LFE81:
 8633              		.align	1
 8634              		.global	json_array_get_boolean
 8635              		.syntax unified
 8636              		.thumb
 8637              		.thumb_func
 8638              		.fpu neon
 8640              	json_array_get_boolean:
 8641              	.LFB82:
1392:parson.c      **** 
1393:parson.c      **** int json_array_get_boolean(const JSON_Array *array, size_t index)
1394:parson.c      **** {
 8642              		.loc 2 1394 0
 8643              		.cfi_startproc
 8644              		@ args = 0, pretend = 0, frame = 8
 8645              		@ frame_needed = 1, uses_anonymous_args = 0
 8646 2d8a 80B5     		push	{r7, lr}	@
 8647              	.LCFI331:
 8648              		.cfi_def_cfa_offset 8
 8649              		.cfi_offset 7, -8
 8650              		.cfi_offset 14, -4
 8651 2d8c 82B0     		sub	sp, sp, #8	@,,
 8652              	.LCFI332:
 8653              		.cfi_def_cfa_offset 16
 8654 2d8e 00AF     		add	r7, sp, #0	@,,
 8655              	.LCFI333:
 8656              		.cfi_def_cfa_register 7
 8657 2d90 7860     		str	r0, [r7, #4]	@ array, array
 8658 2d92 3960     		str	r1, [r7]	@ index, index
1395:parson.c      ****     return json_value_get_boolean(json_array_get_value(array, index));
 8659              		.loc 2 1395 0
 8660 2d94 3968     		ldr	r1, [r7]	@, index
 8661 2d96 7868     		ldr	r0, [r7, #4]	@, array
 8662 2d98 FFF7FEFF 		bl	json_array_get_value	@
 8663 2d9c 0346     		mov	r3, r0	@ _5,
 8664 2d9e 1846     		mov	r0, r3	@, _5
 8665 2da0 FFF7FEFF 		bl	json_value_get_boolean	@
 8666 2da4 0346     		mov	r3, r0	@ _7,
1396:parson.c      **** }
 8667              		.loc 2 1396 0
 8668 2da6 1846     		mov	r0, r3	@, <retval>
 8669 2da8 0837     		adds	r7, r7, #8	@,,
 8670              	.LCFI334:
 8671              		.cfi_def_cfa_offset 8
 8672 2daa BD46     		mov	sp, r7	@,
 8673              	.LCFI335:
 8674              		.cfi_def_cfa_register 13
 8675              		@ sp needed	@
 8676 2dac 80BD     		pop	{r7, pc}	@
 8677              		.cfi_endproc
 8678              	.LFE82:
 8680              		.align	1
 8681              		.global	json_array_get_count
 8682              		.syntax unified
 8683              		.thumb
 8684              		.thumb_func
 8685              		.fpu neon
 8687              	json_array_get_count:
 8688              	.LFB83:
1397:parson.c      **** 
1398:parson.c      **** size_t json_array_get_count(const JSON_Array *array)
1399:parson.c      **** {
 8689              		.loc 2 1399 0
 8690              		.cfi_startproc
 8691              		@ args = 0, pretend = 0, frame = 8
 8692              		@ frame_needed = 1, uses_anonymous_args = 0
 8693              		@ link register save eliminated.
 8694 2dae 80B4     		push	{r7}	@
 8695              	.LCFI336:
 8696              		.cfi_def_cfa_offset 4
 8697              		.cfi_offset 7, -4
 8698 2db0 83B0     		sub	sp, sp, #12	@,,
 8699              	.LCFI337:
 8700              		.cfi_def_cfa_offset 16
 8701 2db2 00AF     		add	r7, sp, #0	@,,
 8702              	.LCFI338:
 8703              		.cfi_def_cfa_register 7
 8704 2db4 7860     		str	r0, [r7, #4]	@ array, array
1400:parson.c      ****     return array ? array->count : 0;
 8705              		.loc 2 1400 0
 8706 2db6 7B68     		ldr	r3, [r7, #4]	@ tmp112, array
 8707 2db8 002B     		cmp	r3, #0	@ tmp112,
 8708 2dba 02D0     		beq	.L545	@,
 8709              		.loc 2 1400 0 is_stmt 0 discriminator 1
 8710 2dbc 7B68     		ldr	r3, [r7, #4]	@ tmp113, array
 8711 2dbe 9B68     		ldr	r3, [r3, #8]	@ iftmp.164_1, array_2(D)->count
 8712 2dc0 00E0     		b	.L547	@
 8713              	.L545:
 8714              		.loc 2 1400 0 discriminator 2
 8715 2dc2 0023     		movs	r3, #0	@ iftmp.164_1,
 8716              	.L547:
1401:parson.c      **** }
 8717              		.loc 2 1401 0 is_stmt 1 discriminator 5
 8718 2dc4 1846     		mov	r0, r3	@, <retval>
 8719 2dc6 0C37     		adds	r7, r7, #12	@,,
 8720              	.LCFI339:
 8721              		.cfi_def_cfa_offset 4
 8722 2dc8 BD46     		mov	sp, r7	@,
 8723              	.LCFI340:
 8724              		.cfi_def_cfa_register 13
 8725              		@ sp needed	@
 8726 2dca 5DF8047B 		ldr	r7, [sp], #4	@,
 8727              	.LCFI341:
 8728              		.cfi_restore 7
 8729              		.cfi_def_cfa_offset 0
 8730 2dce 7047     		bx	lr	@
 8731              		.cfi_endproc
 8732              	.LFE83:
 8734              		.align	1
 8735              		.global	json_array_get_wrapping_value
 8736              		.syntax unified
 8737              		.thumb
 8738              		.thumb_func
 8739              		.fpu neon
 8741              	json_array_get_wrapping_value:
 8742              	.LFB84:
1402:parson.c      **** 
1403:parson.c      **** JSON_Value *json_array_get_wrapping_value(const JSON_Array *array)
1404:parson.c      **** {
 8743              		.loc 2 1404 0
 8744              		.cfi_startproc
 8745              		@ args = 0, pretend = 0, frame = 8
 8746              		@ frame_needed = 1, uses_anonymous_args = 0
 8747              		@ link register save eliminated.
 8748 2dd0 80B4     		push	{r7}	@
 8749              	.LCFI342:
 8750              		.cfi_def_cfa_offset 4
 8751              		.cfi_offset 7, -4
 8752 2dd2 83B0     		sub	sp, sp, #12	@,,
 8753              	.LCFI343:
 8754              		.cfi_def_cfa_offset 16
 8755 2dd4 00AF     		add	r7, sp, #0	@,,
 8756              	.LCFI344:
 8757              		.cfi_def_cfa_register 7
 8758 2dd6 7860     		str	r0, [r7, #4]	@ array, array
1405:parson.c      ****     return array->wrapping_value;
 8759              		.loc 2 1405 0
 8760 2dd8 7B68     		ldr	r3, [r7, #4]	@ tmp112, array
 8761 2dda 1B68     		ldr	r3, [r3]	@ _3, array_2(D)->wrapping_value
1406:parson.c      **** }
 8762              		.loc 2 1406 0
 8763 2ddc 1846     		mov	r0, r3	@, <retval>
 8764 2dde 0C37     		adds	r7, r7, #12	@,,
 8765              	.LCFI345:
 8766              		.cfi_def_cfa_offset 4
 8767 2de0 BD46     		mov	sp, r7	@,
 8768              	.LCFI346:
 8769              		.cfi_def_cfa_register 13
 8770              		@ sp needed	@
 8771 2de2 5DF8047B 		ldr	r7, [sp], #4	@,
 8772              	.LCFI347:
 8773              		.cfi_restore 7
 8774              		.cfi_def_cfa_offset 0
 8775 2de6 7047     		bx	lr	@
 8776              		.cfi_endproc
 8777              	.LFE84:
 8779              		.align	1
 8780              		.global	json_value_get_type
 8781              		.syntax unified
 8782              		.thumb
 8783              		.thumb_func
 8784              		.fpu neon
 8786              	json_value_get_type:
 8787              	.LFB85:
1407:parson.c      **** 
1408:parson.c      **** /* JSON Value API */
1409:parson.c      **** JSON_Value_Type json_value_get_type(const JSON_Value *value)
1410:parson.c      **** {
 8788              		.loc 2 1410 0
 8789              		.cfi_startproc
 8790              		@ args = 0, pretend = 0, frame = 8
 8791              		@ frame_needed = 1, uses_anonymous_args = 0
 8792              		@ link register save eliminated.
 8793 2de8 80B4     		push	{r7}	@
 8794              	.LCFI348:
 8795              		.cfi_def_cfa_offset 4
 8796              		.cfi_offset 7, -4
 8797 2dea 83B0     		sub	sp, sp, #12	@,,
 8798              	.LCFI349:
 8799              		.cfi_def_cfa_offset 16
 8800 2dec 00AF     		add	r7, sp, #0	@,,
 8801              	.LCFI350:
 8802              		.cfi_def_cfa_register 7
 8803 2dee 7860     		str	r0, [r7, #4]	@ value, value
1411:parson.c      ****     return value ? value->type : JSONError;
 8804              		.loc 2 1411 0
 8805 2df0 7B68     		ldr	r3, [r7, #4]	@ tmp112, value
 8806 2df2 002B     		cmp	r3, #0	@ tmp112,
 8807 2df4 02D0     		beq	.L551	@,
 8808              		.loc 2 1411 0 is_stmt 0 discriminator 1
 8809 2df6 7B68     		ldr	r3, [r7, #4]	@ tmp113, value
 8810 2df8 5B68     		ldr	r3, [r3, #4]	@ iftmp.165_1, value_2(D)->type
 8811 2dfa 01E0     		b	.L553	@
 8812              	.L551:
 8813              		.loc 2 1411 0 discriminator 2
 8814 2dfc 4FF0FF33 		mov	r3, #-1	@ iftmp.165_1,
 8815              	.L553:
1412:parson.c      **** }
 8816              		.loc 2 1412 0 is_stmt 1 discriminator 5
 8817 2e00 1846     		mov	r0, r3	@, <retval>
 8818 2e02 0C37     		adds	r7, r7, #12	@,,
 8819              	.LCFI351:
 8820              		.cfi_def_cfa_offset 4
 8821 2e04 BD46     		mov	sp, r7	@,
 8822              	.LCFI352:
 8823              		.cfi_def_cfa_register 13
 8824              		@ sp needed	@
 8825 2e06 5DF8047B 		ldr	r7, [sp], #4	@,
 8826              	.LCFI353:
 8827              		.cfi_restore 7
 8828              		.cfi_def_cfa_offset 0
 8829 2e0a 7047     		bx	lr	@
 8830              		.cfi_endproc
 8831              	.LFE85:
 8833              		.align	1
 8834              		.global	json_value_get_object
 8835              		.syntax unified
 8836              		.thumb
 8837              		.thumb_func
 8838              		.fpu neon
 8840              	json_value_get_object:
 8841              	.LFB86:
1413:parson.c      **** 
1414:parson.c      **** JSON_Object *json_value_get_object(const JSON_Value *value)
1415:parson.c      **** {
 8842              		.loc 2 1415 0
 8843              		.cfi_startproc
 8844              		@ args = 0, pretend = 0, frame = 8
 8845              		@ frame_needed = 1, uses_anonymous_args = 0
 8846 2e0c 80B5     		push	{r7, lr}	@
 8847              	.LCFI354:
 8848              		.cfi_def_cfa_offset 8
 8849              		.cfi_offset 7, -8
 8850              		.cfi_offset 14, -4
 8851 2e0e 82B0     		sub	sp, sp, #8	@,,
 8852              	.LCFI355:
 8853              		.cfi_def_cfa_offset 16
 8854 2e10 00AF     		add	r7, sp, #0	@,,
 8855              	.LCFI356:
 8856              		.cfi_def_cfa_register 7
 8857 2e12 7860     		str	r0, [r7, #4]	@ value, value
1416:parson.c      ****     return json_value_get_type(value) == JSONObject ? value->value.object : NULL;
 8858              		.loc 2 1416 0
 8859 2e14 7868     		ldr	r0, [r7, #4]	@, value
 8860 2e16 FFF7FEFF 		bl	json_value_get_type	@
 8861 2e1a 0346     		mov	r3, r0	@ _5,
 8862 2e1c 042B     		cmp	r3, #4	@ _5,
 8863 2e1e 02D1     		bne	.L555	@,
 8864              		.loc 2 1416 0 is_stmt 0 discriminator 1
 8865 2e20 7B68     		ldr	r3, [r7, #4]	@ tmp113, value
 8866 2e22 9B68     		ldr	r3, [r3, #8]	@ iftmp.166_1, value_3(D)->value.object
 8867 2e24 00E0     		b	.L557	@
 8868              	.L555:
 8869              		.loc 2 1416 0 discriminator 2
 8870 2e26 0023     		movs	r3, #0	@ iftmp.166_1,
 8871              	.L557:
1417:parson.c      **** }
 8872              		.loc 2 1417 0 is_stmt 1 discriminator 5
 8873 2e28 1846     		mov	r0, r3	@, <retval>
 8874 2e2a 0837     		adds	r7, r7, #8	@,,
 8875              	.LCFI357:
 8876              		.cfi_def_cfa_offset 8
 8877 2e2c BD46     		mov	sp, r7	@,
 8878              	.LCFI358:
 8879              		.cfi_def_cfa_register 13
 8880              		@ sp needed	@
 8881 2e2e 80BD     		pop	{r7, pc}	@
 8882              		.cfi_endproc
 8883              	.LFE86:
 8885              		.align	1
 8886              		.global	json_value_get_array
 8887              		.syntax unified
 8888              		.thumb
 8889              		.thumb_func
 8890              		.fpu neon
 8892              	json_value_get_array:
 8893              	.LFB87:
1418:parson.c      **** 
1419:parson.c      **** JSON_Array *json_value_get_array(const JSON_Value *value)
1420:parson.c      **** {
 8894              		.loc 2 1420 0
 8895              		.cfi_startproc
 8896              		@ args = 0, pretend = 0, frame = 8
 8897              		@ frame_needed = 1, uses_anonymous_args = 0
 8898 2e30 80B5     		push	{r7, lr}	@
 8899              	.LCFI359:
 8900              		.cfi_def_cfa_offset 8
 8901              		.cfi_offset 7, -8
 8902              		.cfi_offset 14, -4
 8903 2e32 82B0     		sub	sp, sp, #8	@,,
 8904              	.LCFI360:
 8905              		.cfi_def_cfa_offset 16
 8906 2e34 00AF     		add	r7, sp, #0	@,,
 8907              	.LCFI361:
 8908              		.cfi_def_cfa_register 7
 8909 2e36 7860     		str	r0, [r7, #4]	@ value, value
1421:parson.c      ****     return json_value_get_type(value) == JSONArray ? value->value.array : NULL;
 8910              		.loc 2 1421 0
 8911 2e38 7868     		ldr	r0, [r7, #4]	@, value
 8912 2e3a FFF7FEFF 		bl	json_value_get_type	@
 8913 2e3e 0346     		mov	r3, r0	@ _5,
 8914 2e40 052B     		cmp	r3, #5	@ _5,
 8915 2e42 02D1     		bne	.L559	@,
 8916              		.loc 2 1421 0 is_stmt 0 discriminator 1
 8917 2e44 7B68     		ldr	r3, [r7, #4]	@ tmp113, value
 8918 2e46 9B68     		ldr	r3, [r3, #8]	@ iftmp.167_1, value_3(D)->value.array
 8919 2e48 00E0     		b	.L561	@
 8920              	.L559:
 8921              		.loc 2 1421 0 discriminator 2
 8922 2e4a 0023     		movs	r3, #0	@ iftmp.167_1,
 8923              	.L561:
1422:parson.c      **** }
 8924              		.loc 2 1422 0 is_stmt 1 discriminator 5
 8925 2e4c 1846     		mov	r0, r3	@, <retval>
 8926 2e4e 0837     		adds	r7, r7, #8	@,,
 8927              	.LCFI362:
 8928              		.cfi_def_cfa_offset 8
 8929 2e50 BD46     		mov	sp, r7	@,
 8930              	.LCFI363:
 8931              		.cfi_def_cfa_register 13
 8932              		@ sp needed	@
 8933 2e52 80BD     		pop	{r7, pc}	@
 8934              		.cfi_endproc
 8935              	.LFE87:
 8937              		.align	1
 8938              		.global	json_value_get_string
 8939              		.syntax unified
 8940              		.thumb
 8941              		.thumb_func
 8942              		.fpu neon
 8944              	json_value_get_string:
 8945              	.LFB88:
1423:parson.c      **** 
1424:parson.c      **** const char *json_value_get_string(const JSON_Value *value)
1425:parson.c      **** {
 8946              		.loc 2 1425 0
 8947              		.cfi_startproc
 8948              		@ args = 0, pretend = 0, frame = 8
 8949              		@ frame_needed = 1, uses_anonymous_args = 0
 8950 2e54 80B5     		push	{r7, lr}	@
 8951              	.LCFI364:
 8952              		.cfi_def_cfa_offset 8
 8953              		.cfi_offset 7, -8
 8954              		.cfi_offset 14, -4
 8955 2e56 82B0     		sub	sp, sp, #8	@,,
 8956              	.LCFI365:
 8957              		.cfi_def_cfa_offset 16
 8958 2e58 00AF     		add	r7, sp, #0	@,,
 8959              	.LCFI366:
 8960              		.cfi_def_cfa_register 7
 8961 2e5a 7860     		str	r0, [r7, #4]	@ value, value
1426:parson.c      ****     return json_value_get_type(value) == JSONString ? value->value.string : NULL;
 8962              		.loc 2 1426 0
 8963 2e5c 7868     		ldr	r0, [r7, #4]	@, value
 8964 2e5e FFF7FEFF 		bl	json_value_get_type	@
 8965 2e62 0346     		mov	r3, r0	@ _5,
 8966 2e64 022B     		cmp	r3, #2	@ _5,
 8967 2e66 02D1     		bne	.L563	@,
 8968              		.loc 2 1426 0 is_stmt 0 discriminator 1
 8969 2e68 7B68     		ldr	r3, [r7, #4]	@ tmp113, value
 8970 2e6a 9B68     		ldr	r3, [r3, #8]	@ iftmp.168_1, value_3(D)->value.string
 8971 2e6c 00E0     		b	.L565	@
 8972              	.L563:
 8973              		.loc 2 1426 0 discriminator 2
 8974 2e6e 0023     		movs	r3, #0	@ iftmp.168_1,
 8975              	.L565:
1427:parson.c      **** }
 8976              		.loc 2 1427 0 is_stmt 1 discriminator 5
 8977 2e70 1846     		mov	r0, r3	@, <retval>
 8978 2e72 0837     		adds	r7, r7, #8	@,,
 8979              	.LCFI367:
 8980              		.cfi_def_cfa_offset 8
 8981 2e74 BD46     		mov	sp, r7	@,
 8982              	.LCFI368:
 8983              		.cfi_def_cfa_register 13
 8984              		@ sp needed	@
 8985 2e76 80BD     		pop	{r7, pc}	@
 8986              		.cfi_endproc
 8987              	.LFE88:
 8989              		.align	1
 8990              		.global	json_value_get_number
 8991              		.syntax unified
 8992              		.thumb
 8993              		.thumb_func
 8994              		.fpu neon
 8996              	json_value_get_number:
 8997              	.LFB89:
1428:parson.c      **** 
1429:parson.c      **** double json_value_get_number(const JSON_Value *value)
1430:parson.c      **** {
 8998              		.loc 2 1430 0
 8999              		.cfi_startproc
 9000              		@ args = 0, pretend = 0, frame = 8
 9001              		@ frame_needed = 1, uses_anonymous_args = 0
 9002 2e78 90B5     		push	{r4, r7, lr}	@
 9003              	.LCFI369:
 9004              		.cfi_def_cfa_offset 12
 9005              		.cfi_offset 4, -12
 9006              		.cfi_offset 7, -8
 9007              		.cfi_offset 14, -4
 9008 2e7a 83B0     		sub	sp, sp, #12	@,,
 9009              	.LCFI370:
 9010              		.cfi_def_cfa_offset 24
 9011 2e7c 00AF     		add	r7, sp, #0	@,,
 9012              	.LCFI371:
 9013              		.cfi_def_cfa_register 7
 9014 2e7e 7860     		str	r0, [r7, #4]	@ value, value
1431:parson.c      ****     return json_value_get_type(value) == JSONNumber ? value->value.number : 0;
 9015              		.loc 2 1431 0
 9016 2e80 7868     		ldr	r0, [r7, #4]	@, value
 9017 2e82 FFF7FEFF 		bl	json_value_get_type	@
 9018 2e86 0346     		mov	r3, r0	@ _5,
 9019 2e88 032B     		cmp	r3, #3	@ _5,
 9020 2e8a 03D1     		bne	.L567	@,
 9021              		.loc 2 1431 0 is_stmt 0 discriminator 1
 9022 2e8c 7B68     		ldr	r3, [r7, #4]	@ tmp113, value
 9023 2e8e D3E90234 		ldrd	r3, [r3, #8]	@ iftmp.169_1, tmp113,
 9024 2e92 03E0     		b	.L569	@
 9025              	.L567:
 9026              		.loc 2 1431 0 discriminator 2
 9027 2e94 4FF00003 		mov	r3, #0	@ iftmp.169_1,
 9028 2e98 4FF00004 		mov	r4, #0	@ iftmp.169_1,
 9029              	.L569:
 9030              		.loc 2 1431 0 discriminator 5
 9031 2e9c 44EC303B 		vmov	d16, r3, r4	@ <retval>, iftmp.169_1
1432:parson.c      **** }
 9032              		.loc 2 1432 0 is_stmt 1 discriminator 5
 9033 2ea0 B0EE600B 		vmov.f64	d0, d16	@, <retval>
 9034 2ea4 0C37     		adds	r7, r7, #12	@,,
 9035              	.LCFI372:
 9036              		.cfi_def_cfa_offset 12
 9037 2ea6 BD46     		mov	sp, r7	@,
 9038              	.LCFI373:
 9039              		.cfi_def_cfa_register 13
 9040              		@ sp needed	@
 9041 2ea8 90BD     		pop	{r4, r7, pc}	@
 9042              		.cfi_endproc
 9043              	.LFE89:
 9045              		.align	1
 9046              		.global	json_value_get_boolean
 9047              		.syntax unified
 9048              		.thumb
 9049              		.thumb_func
 9050              		.fpu neon
 9052              	json_value_get_boolean:
 9053              	.LFB90:
1433:parson.c      **** 
1434:parson.c      **** int json_value_get_boolean(const JSON_Value *value)
1435:parson.c      **** {
 9054              		.loc 2 1435 0
 9055              		.cfi_startproc
 9056              		@ args = 0, pretend = 0, frame = 8
 9057              		@ frame_needed = 1, uses_anonymous_args = 0
 9058 2eaa 80B5     		push	{r7, lr}	@
 9059              	.LCFI374:
 9060              		.cfi_def_cfa_offset 8
 9061              		.cfi_offset 7, -8
 9062              		.cfi_offset 14, -4
 9063 2eac 82B0     		sub	sp, sp, #8	@,,
 9064              	.LCFI375:
 9065              		.cfi_def_cfa_offset 16
 9066 2eae 00AF     		add	r7, sp, #0	@,,
 9067              	.LCFI376:
 9068              		.cfi_def_cfa_register 7
 9069 2eb0 7860     		str	r0, [r7, #4]	@ value, value
1436:parson.c      ****     return json_value_get_type(value) == JSONBoolean ? value->value.boolean : -1;
 9070              		.loc 2 1436 0
 9071 2eb2 7868     		ldr	r0, [r7, #4]	@, value
 9072 2eb4 FFF7FEFF 		bl	json_value_get_type	@
 9073 2eb8 0346     		mov	r3, r0	@ _5,
 9074 2eba 062B     		cmp	r3, #6	@ _5,
 9075 2ebc 02D1     		bne	.L571	@,
 9076              		.loc 2 1436 0 is_stmt 0 discriminator 1
 9077 2ebe 7B68     		ldr	r3, [r7, #4]	@ tmp113, value
 9078 2ec0 9B68     		ldr	r3, [r3, #8]	@ iftmp.170_1, value_3(D)->value.boolean
 9079 2ec2 01E0     		b	.L573	@
 9080              	.L571:
 9081              		.loc 2 1436 0 discriminator 2
 9082 2ec4 4FF0FF33 		mov	r3, #-1	@ iftmp.170_1,
 9083              	.L573:
1437:parson.c      **** }
 9084              		.loc 2 1437 0 is_stmt 1 discriminator 5
 9085 2ec8 1846     		mov	r0, r3	@, <retval>
 9086 2eca 0837     		adds	r7, r7, #8	@,,
 9087              	.LCFI377:
 9088              		.cfi_def_cfa_offset 8
 9089 2ecc BD46     		mov	sp, r7	@,
 9090              	.LCFI378:
 9091              		.cfi_def_cfa_register 13
 9092              		@ sp needed	@
 9093 2ece 80BD     		pop	{r7, pc}	@
 9094              		.cfi_endproc
 9095              	.LFE90:
 9097              		.align	1
 9098              		.global	json_value_get_parent
 9099              		.syntax unified
 9100              		.thumb
 9101              		.thumb_func
 9102              		.fpu neon
 9104              	json_value_get_parent:
 9105              	.LFB91:
1438:parson.c      **** 
1439:parson.c      **** JSON_Value *json_value_get_parent(const JSON_Value *value)
1440:parson.c      **** {
 9106              		.loc 2 1440 0
 9107              		.cfi_startproc
 9108              		@ args = 0, pretend = 0, frame = 8
 9109              		@ frame_needed = 1, uses_anonymous_args = 0
 9110              		@ link register save eliminated.
 9111 2ed0 80B4     		push	{r7}	@
 9112              	.LCFI379:
 9113              		.cfi_def_cfa_offset 4
 9114              		.cfi_offset 7, -4
 9115 2ed2 83B0     		sub	sp, sp, #12	@,,
 9116              	.LCFI380:
 9117              		.cfi_def_cfa_offset 16
 9118 2ed4 00AF     		add	r7, sp, #0	@,,
 9119              	.LCFI381:
 9120              		.cfi_def_cfa_register 7
 9121 2ed6 7860     		str	r0, [r7, #4]	@ value, value
1441:parson.c      ****     return value ? value->parent : NULL;
 9122              		.loc 2 1441 0
 9123 2ed8 7B68     		ldr	r3, [r7, #4]	@ tmp112, value
 9124 2eda 002B     		cmp	r3, #0	@ tmp112,
 9125 2edc 02D0     		beq	.L575	@,
 9126              		.loc 2 1441 0 is_stmt 0 discriminator 1
 9127 2ede 7B68     		ldr	r3, [r7, #4]	@ tmp113, value
 9128 2ee0 1B68     		ldr	r3, [r3]	@ iftmp.171_1, value_2(D)->parent
 9129 2ee2 00E0     		b	.L577	@
 9130              	.L575:
 9131              		.loc 2 1441 0 discriminator 2
 9132 2ee4 0023     		movs	r3, #0	@ iftmp.171_1,
 9133              	.L577:
1442:parson.c      **** }
 9134              		.loc 2 1442 0 is_stmt 1 discriminator 5
 9135 2ee6 1846     		mov	r0, r3	@, <retval>
 9136 2ee8 0C37     		adds	r7, r7, #12	@,,
 9137              	.LCFI382:
 9138              		.cfi_def_cfa_offset 4
 9139 2eea BD46     		mov	sp, r7	@,
 9140              	.LCFI383:
 9141              		.cfi_def_cfa_register 13
 9142              		@ sp needed	@
 9143 2eec 5DF8047B 		ldr	r7, [sp], #4	@,
 9144              	.LCFI384:
 9145              		.cfi_restore 7
 9146              		.cfi_def_cfa_offset 0
 9147 2ef0 7047     		bx	lr	@
 9148              		.cfi_endproc
 9149              	.LFE91:
 9151              		.align	1
 9152              		.global	json_value_free
 9153              		.syntax unified
 9154              		.thumb
 9155              		.thumb_func
 9156              		.fpu neon
 9158              	json_value_free:
 9159              	.LFB92:
1443:parson.c      **** 
1444:parson.c      **** void json_value_free(JSON_Value *value)
1445:parson.c      **** {
 9160              		.loc 2 1445 0
 9161              		.cfi_startproc
 9162              		@ args = 0, pretend = 0, frame = 8
 9163              		@ frame_needed = 1, uses_anonymous_args = 0
 9164 2ef2 80B5     		push	{r7, lr}	@
 9165              	.LCFI385:
 9166              		.cfi_def_cfa_offset 8
 9167              		.cfi_offset 7, -8
 9168              		.cfi_offset 14, -4
 9169 2ef4 82B0     		sub	sp, sp, #8	@,,
 9170              	.LCFI386:
 9171              		.cfi_def_cfa_offset 16
 9172 2ef6 00AF     		add	r7, sp, #0	@,,
 9173              	.LCFI387:
 9174              		.cfi_def_cfa_register 7
 9175 2ef8 7860     		str	r0, [r7, #4]	@ value, value
1446:parson.c      ****     switch (json_value_get_type(value)) {
 9176              		.loc 2 1446 0
 9177 2efa 7868     		ldr	r0, [r7, #4]	@, value
 9178 2efc FFF7FEFF 		bl	json_value_get_type	@
 9179 2f00 0346     		mov	r3, r0	@ _5,
 9180 2f02 042B     		cmp	r3, #4	@ _5,
 9181 2f04 04D0     		beq	.L580	@,
 9182 2f06 052B     		cmp	r3, #5	@ _5,
 9183 2f08 12D0     		beq	.L581	@,
 9184 2f0a 022B     		cmp	r3, #2	@ _5,
 9185 2f0c 06D0     		beq	.L582	@,
1447:parson.c      ****     case JSONObject:
1448:parson.c      ****         json_object_free(value->value.object);
1449:parson.c      ****         break;
1450:parson.c      ****     case JSONString:
1451:parson.c      ****         parson_free(value->value.string);
1452:parson.c      ****         break;
1453:parson.c      ****     case JSONArray:
1454:parson.c      ****         json_array_free(value->value.array);
1455:parson.c      ****         break;
1456:parson.c      ****     default:
1457:parson.c      ****         break;
 9186              		.loc 2 1457 0
 9187 2f0e 15E0     		b	.L583	@
 9188              	.L580:
1448:parson.c      ****         break;
 9189              		.loc 2 1448 0
 9190 2f10 7B68     		ldr	r3, [r7, #4]	@ tmp116, value
 9191 2f12 9B68     		ldr	r3, [r3, #8]	@ _6, value_3(D)->value.object
 9192 2f14 1846     		mov	r0, r3	@, _6
 9193 2f16 FDF740FD 		bl	json_object_free	@
1449:parson.c      ****     case JSONString:
 9194              		.loc 2 1449 0
 9195 2f1a 0FE0     		b	.L583	@
 9196              	.L582:
1451:parson.c      ****         break;
 9197              		.loc 2 1451 0
 9198 2f1c 40F20003 		movw	r3, #:lower16:parson_free	@ tmp117,
 9199 2f20 C0F20003 		movt	r3, #:upper16:parson_free	@ tmp117,
 9200 2f24 1B68     		ldr	r3, [r3]	@ parson_free.172_8, parson_free
 9201 2f26 7A68     		ldr	r2, [r7, #4]	@ tmp118, value
 9202 2f28 9268     		ldr	r2, [r2, #8]	@ _9, value_3(D)->value.string
 9203 2f2a 1046     		mov	r0, r2	@, _9
 9204 2f2c 9847     		blx	r3	@ parson_free.172_8
 9205              	.LVL28:
1452:parson.c      ****     case JSONArray:
 9206              		.loc 2 1452 0
 9207 2f2e 05E0     		b	.L583	@
 9208              	.L581:
1454:parson.c      ****         break;
 9209              		.loc 2 1454 0
 9210 2f30 7B68     		ldr	r3, [r7, #4]	@ tmp119, value
 9211 2f32 9B68     		ldr	r3, [r3, #8]	@ _11, value_3(D)->value.array
 9212 2f34 1846     		mov	r0, r3	@, _11
 9213 2f36 FDF70BFE 		bl	json_array_free	@
1455:parson.c      ****     default:
 9214              		.loc 2 1455 0
 9215 2f3a 00BF     		nop
 9216              	.L583:
1458:parson.c      ****     }
1459:parson.c      ****     parson_free(value);
 9217              		.loc 2 1459 0
 9218 2f3c 40F20003 		movw	r3, #:lower16:parson_free	@ tmp120,
 9219 2f40 C0F20003 		movt	r3, #:upper16:parson_free	@ tmp120,
 9220 2f44 1B68     		ldr	r3, [r3]	@ parson_free.173_13, parson_free
 9221 2f46 7868     		ldr	r0, [r7, #4]	@, value
 9222 2f48 9847     		blx	r3	@ parson_free.173_13
 9223              	.LVL29:
1460:parson.c      **** }
 9224              		.loc 2 1460 0
 9225 2f4a 00BF     		nop
 9226 2f4c 0837     		adds	r7, r7, #8	@,,
 9227              	.LCFI388:
 9228              		.cfi_def_cfa_offset 8
 9229 2f4e BD46     		mov	sp, r7	@,
 9230              	.LCFI389:
 9231              		.cfi_def_cfa_register 13
 9232              		@ sp needed	@
 9233 2f50 80BD     		pop	{r7, pc}	@
 9234              		.cfi_endproc
 9235              	.LFE92:
 9237              		.align	1
 9238              		.global	json_value_init_object
 9239              		.syntax unified
 9240              		.thumb
 9241              		.thumb_func
 9242              		.fpu neon
 9244              	json_value_init_object:
 9245              	.LFB93:
1461:parson.c      **** 
1462:parson.c      **** JSON_Value *json_value_init_object(void)
1463:parson.c      **** {
 9246              		.loc 2 1463 0
 9247              		.cfi_startproc
 9248              		@ args = 0, pretend = 0, frame = 8
 9249              		@ frame_needed = 1, uses_anonymous_args = 0
 9250 2f52 80B5     		push	{r7, lr}	@
 9251              	.LCFI390:
 9252              		.cfi_def_cfa_offset 8
 9253              		.cfi_offset 7, -8
 9254              		.cfi_offset 14, -4
 9255 2f54 82B0     		sub	sp, sp, #8	@,,
 9256              	.LCFI391:
 9257              		.cfi_def_cfa_offset 16
 9258 2f56 00AF     		add	r7, sp, #0	@,,
 9259              	.LCFI392:
 9260              		.cfi_def_cfa_register 7
1464:parson.c      ****     JSON_Value *new_value = (JSON_Value *)parson_malloc(sizeof(JSON_Value));
 9261              		.loc 2 1464 0
 9262 2f58 40F20003 		movw	r3, #:lower16:parson_malloc	@ tmp116,
 9263 2f5c C0F20003 		movt	r3, #:upper16:parson_malloc	@ tmp116,
 9264 2f60 1B68     		ldr	r3, [r3]	@ parson_malloc.174_4, parson_malloc
 9265 2f62 1020     		movs	r0, #16	@,
 9266 2f64 9847     		blx	r3	@ parson_malloc.174_4
 9267              	.LVL30:
 9268 2f66 7860     		str	r0, [r7, #4]	@, new_value
1465:parson.c      ****     if (!new_value) {
 9269              		.loc 2 1465 0
 9270 2f68 7B68     		ldr	r3, [r7, #4]	@ tmp117, new_value
 9271 2f6a 002B     		cmp	r3, #0	@ tmp117,
 9272 2f6c 01D1     		bne	.L585	@,
1466:parson.c      ****         return NULL;
 9273              		.loc 2 1466 0
 9274 2f6e 0023     		movs	r3, #0	@ _1,
 9275 2f70 19E0     		b	.L586	@
 9276              	.L585:
1467:parson.c      ****     }
1468:parson.c      ****     new_value->parent = NULL;
 9277              		.loc 2 1468 0
 9278 2f72 7B68     		ldr	r3, [r7, #4]	@ tmp118, new_value
 9279 2f74 0022     		movs	r2, #0	@ tmp119,
 9280 2f76 1A60     		str	r2, [r3]	@ tmp119, new_value_6->parent
1469:parson.c      ****     new_value->type = JSONObject;
 9281              		.loc 2 1469 0
 9282 2f78 7B68     		ldr	r3, [r7, #4]	@ tmp120, new_value
 9283 2f7a 0422     		movs	r2, #4	@ tmp121,
 9284 2f7c 5A60     		str	r2, [r3, #4]	@ tmp121, new_value_6->type
1470:parson.c      ****     new_value->value.object = json_object_init(new_value);
 9285              		.loc 2 1470 0
 9286 2f7e 7868     		ldr	r0, [r7, #4]	@, new_value
 9287 2f80 FDF7F0FA 		bl	json_object_init	@
 9288 2f84 0246     		mov	r2, r0	@ _11,
 9289 2f86 7B68     		ldr	r3, [r7, #4]	@ tmp122, new_value
 9290 2f88 9A60     		str	r2, [r3, #8]	@ _11, new_value_6->value.object
1471:parson.c      ****     if (!new_value->value.object) {
 9291              		.loc 2 1471 0
 9292 2f8a 7B68     		ldr	r3, [r7, #4]	@ tmp123, new_value
 9293 2f8c 9B68     		ldr	r3, [r3, #8]	@ _13, new_value_6->value.object
 9294 2f8e 002B     		cmp	r3, #0	@ _13,
 9295 2f90 08D1     		bne	.L587	@,
1472:parson.c      ****         parson_free(new_value);
 9296              		.loc 2 1472 0
 9297 2f92 40F20003 		movw	r3, #:lower16:parson_free	@ tmp124,
 9298 2f96 C0F20003 		movt	r3, #:upper16:parson_free	@ tmp124,
 9299 2f9a 1B68     		ldr	r3, [r3]	@ parson_free.175_14, parson_free
 9300 2f9c 7868     		ldr	r0, [r7, #4]	@, new_value
 9301 2f9e 9847     		blx	r3	@ parson_free.175_14
 9302              	.LVL31:
1473:parson.c      ****         return NULL;
 9303              		.loc 2 1473 0
 9304 2fa0 0023     		movs	r3, #0	@ _1,
 9305 2fa2 00E0     		b	.L586	@
 9306              	.L587:
1474:parson.c      ****     }
1475:parson.c      ****     return new_value;
 9307              		.loc 2 1475 0
 9308 2fa4 7B68     		ldr	r3, [r7, #4]	@ _1, new_value
 9309              	.L586:
1476:parson.c      **** }
 9310              		.loc 2 1476 0
 9311 2fa6 1846     		mov	r0, r3	@, <retval>
 9312 2fa8 0837     		adds	r7, r7, #8	@,,
 9313              	.LCFI393:
 9314              		.cfi_def_cfa_offset 8
 9315 2faa BD46     		mov	sp, r7	@,
 9316              	.LCFI394:
 9317              		.cfi_def_cfa_register 13
 9318              		@ sp needed	@
 9319 2fac 80BD     		pop	{r7, pc}	@
 9320              		.cfi_endproc
 9321              	.LFE93:
 9323              		.align	1
 9324              		.global	json_value_init_array
 9325              		.syntax unified
 9326              		.thumb
 9327              		.thumb_func
 9328              		.fpu neon
 9330              	json_value_init_array:
 9331              	.LFB94:
1477:parson.c      **** 
1478:parson.c      **** JSON_Value *json_value_init_array(void)
1479:parson.c      **** {
 9332              		.loc 2 1479 0
 9333              		.cfi_startproc
 9334              		@ args = 0, pretend = 0, frame = 8
 9335              		@ frame_needed = 1, uses_anonymous_args = 0
 9336 2fae 80B5     		push	{r7, lr}	@
 9337              	.LCFI395:
 9338              		.cfi_def_cfa_offset 8
 9339              		.cfi_offset 7, -8
 9340              		.cfi_offset 14, -4
 9341 2fb0 82B0     		sub	sp, sp, #8	@,,
 9342              	.LCFI396:
 9343              		.cfi_def_cfa_offset 16
 9344 2fb2 00AF     		add	r7, sp, #0	@,,
 9345              	.LCFI397:
 9346              		.cfi_def_cfa_register 7
1480:parson.c      ****     JSON_Value *new_value = (JSON_Value *)parson_malloc(sizeof(JSON_Value));
 9347              		.loc 2 1480 0
 9348 2fb4 40F20003 		movw	r3, #:lower16:parson_malloc	@ tmp116,
 9349 2fb8 C0F20003 		movt	r3, #:upper16:parson_malloc	@ tmp116,
 9350 2fbc 1B68     		ldr	r3, [r3]	@ parson_malloc.176_4, parson_malloc
 9351 2fbe 1020     		movs	r0, #16	@,
 9352 2fc0 9847     		blx	r3	@ parson_malloc.176_4
 9353              	.LVL32:
 9354 2fc2 7860     		str	r0, [r7, #4]	@, new_value
1481:parson.c      ****     if (!new_value) {
 9355              		.loc 2 1481 0
 9356 2fc4 7B68     		ldr	r3, [r7, #4]	@ tmp117, new_value
 9357 2fc6 002B     		cmp	r3, #0	@ tmp117,
 9358 2fc8 01D1     		bne	.L589	@,
1482:parson.c      ****         return NULL;
 9359              		.loc 2 1482 0
 9360 2fca 0023     		movs	r3, #0	@ _1,
 9361 2fcc 19E0     		b	.L590	@
 9362              	.L589:
1483:parson.c      ****     }
1484:parson.c      ****     new_value->parent = NULL;
 9363              		.loc 2 1484 0
 9364 2fce 7B68     		ldr	r3, [r7, #4]	@ tmp118, new_value
 9365 2fd0 0022     		movs	r2, #0	@ tmp119,
 9366 2fd2 1A60     		str	r2, [r3]	@ tmp119, new_value_6->parent
1485:parson.c      ****     new_value->type = JSONArray;
 9367              		.loc 2 1485 0
 9368 2fd4 7B68     		ldr	r3, [r7, #4]	@ tmp120, new_value
 9369 2fd6 0522     		movs	r2, #5	@ tmp121,
 9370 2fd8 5A60     		str	r2, [r3, #4]	@ tmp121, new_value_6->type
1486:parson.c      ****     new_value->value.array = json_array_init(new_value);
 9371              		.loc 2 1486 0
 9372 2fda 7868     		ldr	r0, [r7, #4]	@, new_value
 9373 2fdc FDF71FFD 		bl	json_array_init	@
 9374 2fe0 0246     		mov	r2, r0	@ _11,
 9375 2fe2 7B68     		ldr	r3, [r7, #4]	@ tmp122, new_value
 9376 2fe4 9A60     		str	r2, [r3, #8]	@ _11, new_value_6->value.array
1487:parson.c      ****     if (!new_value->value.array) {
 9377              		.loc 2 1487 0
 9378 2fe6 7B68     		ldr	r3, [r7, #4]	@ tmp123, new_value
 9379 2fe8 9B68     		ldr	r3, [r3, #8]	@ _13, new_value_6->value.array
 9380 2fea 002B     		cmp	r3, #0	@ _13,
 9381 2fec 08D1     		bne	.L591	@,
1488:parson.c      ****         parson_free(new_value);
 9382              		.loc 2 1488 0
 9383 2fee 40F20003 		movw	r3, #:lower16:parson_free	@ tmp124,
 9384 2ff2 C0F20003 		movt	r3, #:upper16:parson_free	@ tmp124,
 9385 2ff6 1B68     		ldr	r3, [r3]	@ parson_free.177_14, parson_free
 9386 2ff8 7868     		ldr	r0, [r7, #4]	@, new_value
 9387 2ffa 9847     		blx	r3	@ parson_free.177_14
 9388              	.LVL33:
1489:parson.c      ****         return NULL;
 9389              		.loc 2 1489 0
 9390 2ffc 0023     		movs	r3, #0	@ _1,
 9391 2ffe 00E0     		b	.L590	@
 9392              	.L591:
1490:parson.c      ****     }
1491:parson.c      ****     return new_value;
 9393              		.loc 2 1491 0
 9394 3000 7B68     		ldr	r3, [r7, #4]	@ _1, new_value
 9395              	.L590:
1492:parson.c      **** }
 9396              		.loc 2 1492 0
 9397 3002 1846     		mov	r0, r3	@, <retval>
 9398 3004 0837     		adds	r7, r7, #8	@,,
 9399              	.LCFI398:
 9400              		.cfi_def_cfa_offset 8
 9401 3006 BD46     		mov	sp, r7	@,
 9402              	.LCFI399:
 9403              		.cfi_def_cfa_register 13
 9404              		@ sp needed	@
 9405 3008 80BD     		pop	{r7, pc}	@
 9406              		.cfi_endproc
 9407              	.LFE94:
 9409              		.align	1
 9410              		.global	json_value_init_string
 9411              		.syntax unified
 9412              		.thumb
 9413              		.thumb_func
 9414              		.fpu neon
 9416              	json_value_init_string:
 9417              	.LFB95:
1493:parson.c      **** 
1494:parson.c      **** JSON_Value *json_value_init_string(const char *string)
1495:parson.c      **** {
 9418              		.loc 2 1495 0
 9419              		.cfi_startproc
 9420              		@ args = 0, pretend = 0, frame = 24
 9421              		@ frame_needed = 1, uses_anonymous_args = 0
 9422 300a 80B5     		push	{r7, lr}	@
 9423              	.LCFI400:
 9424              		.cfi_def_cfa_offset 8
 9425              		.cfi_offset 7, -8
 9426              		.cfi_offset 14, -4
 9427 300c 86B0     		sub	sp, sp, #24	@,,
 9428              	.LCFI401:
 9429              		.cfi_def_cfa_offset 32
 9430 300e 00AF     		add	r7, sp, #0	@,,
 9431              	.LCFI402:
 9432              		.cfi_def_cfa_register 7
 9433 3010 7860     		str	r0, [r7, #4]	@ string, string
1496:parson.c      ****     char *copy = NULL;
 9434              		.loc 2 1496 0
 9435 3012 0023     		movs	r3, #0	@ tmp114,
 9436 3014 7B61     		str	r3, [r7, #20]	@ tmp114, copy
1497:parson.c      ****     JSON_Value *value;
1498:parson.c      ****     size_t string_len = 0;
 9437              		.loc 2 1498 0
 9438 3016 0023     		movs	r3, #0	@ tmp115,
 9439 3018 3B61     		str	r3, [r7, #16]	@ tmp115, string_len
1499:parson.c      ****     if (string == NULL) {
 9440              		.loc 2 1499 0
 9441 301a 7B68     		ldr	r3, [r7, #4]	@ tmp116, string
 9442 301c 002B     		cmp	r3, #0	@ tmp116,
 9443 301e 01D1     		bne	.L593	@,
1500:parson.c      ****         return NULL;
 9444              		.loc 2 1500 0
 9445 3020 0023     		movs	r3, #0	@ _1,
 9446 3022 25E0     		b	.L594	@
 9447              	.L593:
1501:parson.c      ****     }
1502:parson.c      ****     string_len = strlen(string);
 9448              		.loc 2 1502 0
 9449 3024 7868     		ldr	r0, [r7, #4]	@, string
 9450 3026 FFF7FEFF 		bl	strlen	@
 9451 302a 3861     		str	r0, [r7, #16]	@, string_len
1503:parson.c      ****     if (!is_valid_utf8(string, string_len)) {
 9452              		.loc 2 1503 0
 9453 302c 3969     		ldr	r1, [r7, #16]	@, string_len
 9454 302e 7868     		ldr	r0, [r7, #4]	@, string
 9455 3030 FDF7ABF9 		bl	is_valid_utf8	@
 9456 3034 0346     		mov	r3, r0	@ _11,
 9457 3036 002B     		cmp	r3, #0	@ _11,
 9458 3038 01D1     		bne	.L595	@,
1504:parson.c      ****         return NULL;
 9459              		.loc 2 1504 0
 9460 303a 0023     		movs	r3, #0	@ _1,
 9461 303c 18E0     		b	.L594	@
 9462              	.L595:
1505:parson.c      ****     }
1506:parson.c      ****     copy = parson_strndup(string, string_len);
 9463              		.loc 2 1506 0
 9464 303e 3969     		ldr	r1, [r7, #16]	@, string_len
 9465 3040 7868     		ldr	r0, [r7, #4]	@, string
 9466 3042 FCF7F1FF 		bl	parson_strndup	@
 9467 3046 7861     		str	r0, [r7, #20]	@, copy
1507:parson.c      ****     if (copy == NULL) {
 9468              		.loc 2 1507 0
 9469 3048 7B69     		ldr	r3, [r7, #20]	@ tmp117, copy
 9470 304a 002B     		cmp	r3, #0	@ tmp117,
 9471 304c 01D1     		bne	.L596	@,
1508:parson.c      ****         return NULL;
 9472              		.loc 2 1508 0
 9473 304e 0023     		movs	r3, #0	@ _1,
 9474 3050 0EE0     		b	.L594	@
 9475              	.L596:
1509:parson.c      ****     }
1510:parson.c      ****     value = json_value_init_string_no_copy(copy);
 9476              		.loc 2 1510 0
 9477 3052 7869     		ldr	r0, [r7, #20]	@, copy
 9478 3054 FDF7A8FD 		bl	json_value_init_string_no_copy	@
 9479 3058 F860     		str	r0, [r7, #12]	@, value
1511:parson.c      ****     if (value == NULL) {
 9480              		.loc 2 1511 0
 9481 305a FB68     		ldr	r3, [r7, #12]	@ tmp118, value
 9482 305c 002B     		cmp	r3, #0	@ tmp118,
 9483 305e 06D1     		bne	.L597	@,
1512:parson.c      ****         parson_free(copy);
 9484              		.loc 2 1512 0
 9485 3060 40F20003 		movw	r3, #:lower16:parson_free	@ tmp119,
 9486 3064 C0F20003 		movt	r3, #:upper16:parson_free	@ tmp119,
 9487 3068 1B68     		ldr	r3, [r3]	@ parson_free.178_18, parson_free
 9488 306a 7869     		ldr	r0, [r7, #20]	@, copy
 9489 306c 9847     		blx	r3	@ parson_free.178_18
 9490              	.LVL34:
 9491              	.L597:
1513:parson.c      ****     }
1514:parson.c      ****     return value;
 9492              		.loc 2 1514 0
 9493 306e FB68     		ldr	r3, [r7, #12]	@ _1, value
 9494              	.L594:
1515:parson.c      **** }
 9495              		.loc 2 1515 0
 9496 3070 1846     		mov	r0, r3	@, <retval>
 9497 3072 1837     		adds	r7, r7, #24	@,,
 9498              	.LCFI403:
 9499              		.cfi_def_cfa_offset 8
 9500 3074 BD46     		mov	sp, r7	@,
 9501              	.LCFI404:
 9502              		.cfi_def_cfa_register 13
 9503              		@ sp needed	@
 9504 3076 80BD     		pop	{r7, pc}	@
 9505              		.cfi_endproc
 9506              	.LFE95:
 9508              		.align	1
 9509              		.global	json_value_init_number
 9510              		.syntax unified
 9511              		.thumb
 9512              		.thumb_func
 9513              		.fpu neon
 9515              	json_value_init_number:
 9516              	.LFB96:
1516:parson.c      **** 
1517:parson.c      **** JSON_Value *json_value_init_number(double number)
1518:parson.c      **** {
 9517              		.loc 2 1518 0
 9518              		.cfi_startproc
 9519              		@ args = 0, pretend = 0, frame = 16
 9520              		@ frame_needed = 1, uses_anonymous_args = 0
 9521 3078 90B5     		push	{r4, r7, lr}	@
 9522              	.LCFI405:
 9523              		.cfi_def_cfa_offset 12
 9524              		.cfi_offset 4, -12
 9525              		.cfi_offset 7, -8
 9526              		.cfi_offset 14, -4
 9527 307a 85B0     		sub	sp, sp, #20	@,,
 9528              	.LCFI406:
 9529              		.cfi_def_cfa_offset 32
 9530 307c 00AF     		add	r7, sp, #0	@,,
 9531              	.LCFI407:
 9532              		.cfi_def_cfa_register 7
 9533 307e 87ED000B 		vstr.64	d0, [r7]	@ number, number
1519:parson.c      ****     JSON_Value *new_value = NULL;
 9534              		.loc 2 1519 0
 9535 3082 0023     		movs	r3, #0	@ tmp114,
 9536 3084 FB60     		str	r3, [r7, #12]	@ tmp114, new_value
1520:parson.c      ****     if ((number * 0.0) != 0.0) { /* nan and inf test */
 9537              		.loc 2 1520 0
 9538 3086 D7ED000B 		vldr.64	d16, [r7]	@ tmp115, number
 9539 308a DFED151B 		vldr.64	d17, .L602	@ tmp116,
 9540 308e 60EEA10B 		vmul.f64	d16, d16, d17	@ _5, tmp115, tmp116
 9541 3092 F5EE400B 		vcmp.f64	d16, #0	@ _5
 9542 3096 F1EE10FA 		vmrs	APSR_nzcv, FPSCR
 9543 309a 01D0     		beq	.L599	@,
1521:parson.c      ****         return NULL;
 9544              		.loc 2 1521 0
 9545 309c 0023     		movs	r3, #0	@ _1,
 9546 309e 18E0     		b	.L600	@
 9547              	.L599:
1522:parson.c      ****     }
1523:parson.c      ****     new_value = (JSON_Value *)parson_malloc(sizeof(JSON_Value));
 9548              		.loc 2 1523 0
 9549 30a0 40F20003 		movw	r3, #:lower16:parson_malloc	@ tmp117,
 9550 30a4 C0F20003 		movt	r3, #:upper16:parson_malloc	@ tmp117,
 9551 30a8 1B68     		ldr	r3, [r3]	@ parson_malloc.179_8, parson_malloc
 9552 30aa 1020     		movs	r0, #16	@,
 9553 30ac 9847     		blx	r3	@ parson_malloc.179_8
 9554              	.LVL35:
 9555 30ae F860     		str	r0, [r7, #12]	@, new_value
1524:parson.c      ****     if (new_value == NULL) {
 9556              		.loc 2 1524 0
 9557 30b0 FB68     		ldr	r3, [r7, #12]	@ tmp118, new_value
 9558 30b2 002B     		cmp	r3, #0	@ tmp118,
 9559 30b4 01D1     		bne	.L601	@,
1525:parson.c      ****         return NULL;
 9560              		.loc 2 1525 0
 9561 30b6 0023     		movs	r3, #0	@ _1,
 9562 30b8 0BE0     		b	.L600	@
 9563              	.L601:
1526:parson.c      ****     }
1527:parson.c      ****     new_value->parent = NULL;
 9564              		.loc 2 1527 0
 9565 30ba FB68     		ldr	r3, [r7, #12]	@ tmp119, new_value
 9566 30bc 0022     		movs	r2, #0	@ tmp120,
 9567 30be 1A60     		str	r2, [r3]	@ tmp120, new_value_10->parent
1528:parson.c      ****     new_value->type = JSONNumber;
 9568              		.loc 2 1528 0
 9569 30c0 FB68     		ldr	r3, [r7, #12]	@ tmp121, new_value
 9570 30c2 0322     		movs	r2, #3	@ tmp122,
 9571 30c4 5A60     		str	r2, [r3, #4]	@ tmp122, new_value_10->type
1529:parson.c      ****     new_value->value.number = number;
 9572              		.loc 2 1529 0
 9573 30c6 FA68     		ldr	r2, [r7, #12]	@ tmp123, new_value
 9574 30c8 D7E90034 		ldrd	r3, [r7]	@ tmp124, number
 9575 30cc C2E90234 		strd	r3, [r2, #8]	@ tmp124, tmp123,
1530:parson.c      ****     return new_value;
 9576              		.loc 2 1530 0
 9577 30d0 FB68     		ldr	r3, [r7, #12]	@ _1, new_value
 9578              	.L600:
1531:parson.c      **** }
 9579              		.loc 2 1531 0
 9580 30d2 1846     		mov	r0, r3	@, <retval>
 9581 30d4 1437     		adds	r7, r7, #20	@,,
 9582              	.LCFI408:
 9583              		.cfi_def_cfa_offset 12
 9584 30d6 BD46     		mov	sp, r7	@,
 9585              	.LCFI409:
 9586              		.cfi_def_cfa_register 13
 9587              		@ sp needed	@
 9588 30d8 90BD     		pop	{r4, r7, pc}	@
 9589              	.L603:
 9590 30da 00BFAFF3 		.align	3
 9590      0080
 9591              	.L602:
 9592 30e0 00000000 		.word	0
 9593 30e4 00000000 		.word	0
 9594              		.cfi_endproc
 9595              	.LFE96:
 9597              		.align	1
 9598              		.global	json_value_init_boolean
 9599              		.syntax unified
 9600              		.thumb
 9601              		.thumb_func
 9602              		.fpu neon
 9604              	json_value_init_boolean:
 9605              	.LFB97:
1532:parson.c      **** 
1533:parson.c      **** JSON_Value *json_value_init_boolean(int boolean)
1534:parson.c      **** {
 9606              		.loc 2 1534 0
 9607              		.cfi_startproc
 9608              		@ args = 0, pretend = 0, frame = 16
 9609              		@ frame_needed = 1, uses_anonymous_args = 0
 9610 30e8 80B5     		push	{r7, lr}	@
 9611              	.LCFI410:
 9612              		.cfi_def_cfa_offset 8
 9613              		.cfi_offset 7, -8
 9614              		.cfi_offset 14, -4
 9615 30ea 84B0     		sub	sp, sp, #16	@,,
 9616              	.LCFI411:
 9617              		.cfi_def_cfa_offset 24
 9618 30ec 00AF     		add	r7, sp, #0	@,,
 9619              	.LCFI412:
 9620              		.cfi_def_cfa_register 7
 9621 30ee 7860     		str	r0, [r7, #4]	@ boolean, boolean
1535:parson.c      ****     JSON_Value *new_value = (JSON_Value *)parson_malloc(sizeof(JSON_Value));
 9622              		.loc 2 1535 0
 9623 30f0 40F20003 		movw	r3, #:lower16:parson_malloc	@ tmp115,
 9624 30f4 C0F20003 		movt	r3, #:upper16:parson_malloc	@ tmp115,
 9625 30f8 1B68     		ldr	r3, [r3]	@ parson_malloc.180_4, parson_malloc
 9626 30fa 1020     		movs	r0, #16	@,
 9627 30fc 9847     		blx	r3	@ parson_malloc.180_4
 9628              	.LVL36:
 9629 30fe F860     		str	r0, [r7, #12]	@, new_value
1536:parson.c      ****     if (!new_value) {
 9630              		.loc 2 1536 0
 9631 3100 FB68     		ldr	r3, [r7, #12]	@ tmp116, new_value
 9632 3102 002B     		cmp	r3, #0	@ tmp116,
 9633 3104 01D1     		bne	.L605	@,
1537:parson.c      ****         return NULL;
 9634              		.loc 2 1537 0
 9635 3106 0023     		movs	r3, #0	@ _1,
 9636 3108 0FE0     		b	.L606	@
 9637              	.L605:
1538:parson.c      ****     }
1539:parson.c      ****     new_value->parent = NULL;
 9638              		.loc 2 1539 0
 9639 310a FB68     		ldr	r3, [r7, #12]	@ tmp117, new_value
 9640 310c 0022     		movs	r2, #0	@ tmp118,
 9641 310e 1A60     		str	r2, [r3]	@ tmp118, new_value_6->parent
1540:parson.c      ****     new_value->type = JSONBoolean;
 9642              		.loc 2 1540 0
 9643 3110 FB68     		ldr	r3, [r7, #12]	@ tmp119, new_value
 9644 3112 0622     		movs	r2, #6	@ tmp120,
 9645 3114 5A60     		str	r2, [r3, #4]	@ tmp120, new_value_6->type
1541:parson.c      ****     new_value->value.boolean = boolean ? 1 : 0;
 9646              		.loc 2 1541 0
 9647 3116 7B68     		ldr	r3, [r7, #4]	@ tmp122, boolean
 9648 3118 002B     		cmp	r3, #0	@ tmp122,
 9649 311a 14BF     		ite	ne
 9650 311c 0123     		movne	r3, #1	@ tmp123,
 9651 311e 0023     		moveq	r3, #0	@ tmp123,
 9652 3120 DBB2     		uxtb	r3, r3	@ _11, tmp121
 9653 3122 1A46     		mov	r2, r3	@ _12, _11
 9654 3124 FB68     		ldr	r3, [r7, #12]	@ tmp124, new_value
 9655 3126 9A60     		str	r2, [r3, #8]	@ _12, new_value_6->value.boolean
1542:parson.c      ****     return new_value;
 9656              		.loc 2 1542 0
 9657 3128 FB68     		ldr	r3, [r7, #12]	@ _1, new_value
 9658              	.L606:
1543:parson.c      **** }
 9659              		.loc 2 1543 0
 9660 312a 1846     		mov	r0, r3	@, <retval>
 9661 312c 1037     		adds	r7, r7, #16	@,,
 9662              	.LCFI413:
 9663              		.cfi_def_cfa_offset 8
 9664 312e BD46     		mov	sp, r7	@,
 9665              	.LCFI414:
 9666              		.cfi_def_cfa_register 13
 9667              		@ sp needed	@
 9668 3130 80BD     		pop	{r7, pc}	@
 9669              		.cfi_endproc
 9670              	.LFE97:
 9672              		.align	1
 9673              		.global	json_value_init_null
 9674              		.syntax unified
 9675              		.thumb
 9676              		.thumb_func
 9677              		.fpu neon
 9679              	json_value_init_null:
 9680              	.LFB98:
1544:parson.c      **** 
1545:parson.c      **** JSON_Value *json_value_init_null(void)
1546:parson.c      **** {
 9681              		.loc 2 1546 0
 9682              		.cfi_startproc
 9683              		@ args = 0, pretend = 0, frame = 8
 9684              		@ frame_needed = 1, uses_anonymous_args = 0
 9685 3132 80B5     		push	{r7, lr}	@
 9686              	.LCFI415:
 9687              		.cfi_def_cfa_offset 8
 9688              		.cfi_offset 7, -8
 9689              		.cfi_offset 14, -4
 9690 3134 82B0     		sub	sp, sp, #8	@,,
 9691              	.LCFI416:
 9692              		.cfi_def_cfa_offset 16
 9693 3136 00AF     		add	r7, sp, #0	@,,
 9694              	.LCFI417:
 9695              		.cfi_def_cfa_register 7
1547:parson.c      ****     JSON_Value *new_value = (JSON_Value *)parson_malloc(sizeof(JSON_Value));
 9696              		.loc 2 1547 0
 9697 3138 40F20003 		movw	r3, #:lower16:parson_malloc	@ tmp113,
 9698 313c C0F20003 		movt	r3, #:upper16:parson_malloc	@ tmp113,
 9699 3140 1B68     		ldr	r3, [r3]	@ parson_malloc.181_4, parson_malloc
 9700 3142 1020     		movs	r0, #16	@,
 9701 3144 9847     		blx	r3	@ parson_malloc.181_4
 9702              	.LVL37:
 9703 3146 7860     		str	r0, [r7, #4]	@, new_value
1548:parson.c      ****     if (!new_value) {
 9704              		.loc 2 1548 0
 9705 3148 7B68     		ldr	r3, [r7, #4]	@ tmp114, new_value
 9706 314a 002B     		cmp	r3, #0	@ tmp114,
 9707 314c 01D1     		bne	.L608	@,
1549:parson.c      ****         return NULL;
 9708              		.loc 2 1549 0
 9709 314e 0023     		movs	r3, #0	@ _1,
 9710 3150 06E0     		b	.L609	@
 9711              	.L608:
1550:parson.c      ****     }
1551:parson.c      ****     new_value->parent = NULL;
 9712              		.loc 2 1551 0
 9713 3152 7B68     		ldr	r3, [r7, #4]	@ tmp115, new_value
 9714 3154 0022     		movs	r2, #0	@ tmp116,
 9715 3156 1A60     		str	r2, [r3]	@ tmp116, new_value_6->parent
1552:parson.c      ****     new_value->type = JSONNull;
 9716              		.loc 2 1552 0
 9717 3158 7B68     		ldr	r3, [r7, #4]	@ tmp117, new_value
 9718 315a 0122     		movs	r2, #1	@ tmp118,
 9719 315c 5A60     		str	r2, [r3, #4]	@ tmp118, new_value_6->type
1553:parson.c      ****     return new_value;
 9720              		.loc 2 1553 0
 9721 315e 7B68     		ldr	r3, [r7, #4]	@ _1, new_value
 9722              	.L609:
1554:parson.c      **** }
 9723              		.loc 2 1554 0
 9724 3160 1846     		mov	r0, r3	@, <retval>
 9725 3162 0837     		adds	r7, r7, #8	@,,
 9726              	.LCFI418:
 9727              		.cfi_def_cfa_offset 8
 9728 3164 BD46     		mov	sp, r7	@,
 9729              	.LCFI419:
 9730              		.cfi_def_cfa_register 13
 9731              		@ sp needed	@
 9732 3166 80BD     		pop	{r7, pc}	@
 9733              		.cfi_endproc
 9734              	.LFE98:
 9736              		.align	1
 9737              		.global	json_value_deep_copy
 9738              		.syntax unified
 9739              		.thumb
 9740              		.thumb_func
 9741              		.fpu neon
 9743              	json_value_deep_copy:
 9744              	.LFB99:
1555:parson.c      **** 
1556:parson.c      **** JSON_Value *json_value_deep_copy(const JSON_Value *value)
1557:parson.c      **** {
 9745              		.loc 2 1557 0
 9746              		.cfi_startproc
 9747              		@ args = 0, pretend = 0, frame = 56
 9748              		@ frame_needed = 1, uses_anonymous_args = 0
 9749 3168 80B5     		push	{r7, lr}	@
 9750              	.LCFI420:
 9751              		.cfi_def_cfa_offset 8
 9752              		.cfi_offset 7, -8
 9753              		.cfi_offset 14, -4
 9754 316a 8EB0     		sub	sp, sp, #56	@,,
 9755              	.LCFI421:
 9756              		.cfi_def_cfa_offset 64
 9757 316c 00AF     		add	r7, sp, #0	@,,
 9758              	.LCFI422:
 9759              		.cfi_def_cfa_register 7
 9760 316e 7860     		str	r0, [r7, #4]	@ value, value
1558:parson.c      ****     size_t i = 0;
 9761              		.loc 2 1558 0
 9762 3170 0023     		movs	r3, #0	@ tmp120,
 9763 3172 7B63     		str	r3, [r7, #52]	@ tmp120, i
1559:parson.c      ****     JSON_Value *return_value = NULL, *temp_value_copy = NULL, *temp_value = NULL;
 9764              		.loc 2 1559 0
 9765 3174 0023     		movs	r3, #0	@ tmp121,
 9766 3176 3B63     		str	r3, [r7, #48]	@ tmp121, return_value
 9767 3178 0023     		movs	r3, #0	@ tmp122,
 9768 317a FB62     		str	r3, [r7, #44]	@ tmp122, temp_value_copy
 9769 317c 0023     		movs	r3, #0	@ tmp123,
 9770 317e BB62     		str	r3, [r7, #40]	@ tmp123, temp_value
1560:parson.c      ****     const char *temp_string = NULL, *temp_key = NULL;
 9771              		.loc 2 1560 0
 9772 3180 0023     		movs	r3, #0	@ tmp124,
 9773 3182 7B62     		str	r3, [r7, #36]	@ tmp124, temp_string
 9774 3184 0023     		movs	r3, #0	@ tmp125,
 9775 3186 3B62     		str	r3, [r7, #32]	@ tmp125, temp_key
1561:parson.c      ****     char *temp_string_copy = NULL;
 9776              		.loc 2 1561 0
 9777 3188 0023     		movs	r3, #0	@ tmp126,
 9778 318a FB61     		str	r3, [r7, #28]	@ tmp126, temp_string_copy
1562:parson.c      ****     JSON_Array *temp_array = NULL, *temp_array_copy = NULL;
 9779              		.loc 2 1562 0
 9780 318c 0023     		movs	r3, #0	@ tmp127,
 9781 318e BB61     		str	r3, [r7, #24]	@ tmp127, temp_array
 9782 3190 0023     		movs	r3, #0	@ tmp128,
 9783 3192 7B61     		str	r3, [r7, #20]	@ tmp128, temp_array_copy
1563:parson.c      ****     JSON_Object *temp_object = NULL, *temp_object_copy = NULL;
 9784              		.loc 2 1563 0
 9785 3194 0023     		movs	r3, #0	@ tmp129,
 9786 3196 3B61     		str	r3, [r7, #16]	@ tmp129, temp_object
 9787 3198 0023     		movs	r3, #0	@ tmp130,
 9788 319a FB60     		str	r3, [r7, #12]	@ tmp130, temp_object_copy
1564:parson.c      **** 
1565:parson.c      ****     switch (json_value_get_type(value)) {
 9789              		.loc 2 1565 0
 9790 319c 7868     		ldr	r0, [r7, #4]	@, value
 9791 319e FFF7FEFF 		bl	json_value_get_type	@
 9792 31a2 0346     		mov	r3, r0	@ _22,
 9793 31a4 0133     		adds	r3, r3, #1	@ tmp131, _22,
 9794 31a6 072B     		cmp	r3, #7	@ tmp131,
 9795 31a8 00F2D680 		bhi	.L611	@
 9796 31ac 01A2     		adr	r2, .L613	@ tmp149,
 9797 31ae 52F823F0 		ldr	pc, [r2, r3, lsl #2]	@ tmp149, tmp131
 9798 31b2 00BF     		.p2align 2
 9799              	.L613:
 9800 31b4 55330000 		.word	.L612+1
 9801 31b8 59330000 		.word	.L611+1
 9802 31bc 4D330000 		.word	.L614+1
 9803 31c0 09330000 		.word	.L615+1
 9804 31c4 F3320000 		.word	.L616+1
 9805 31c8 55320000 		.word	.L617+1
 9806 31cc D5310000 		.word	.L618+1
 9807 31d0 E1320000 		.word	.L619+1
 9808              		.p2align 1
 9809              	.L618:
1566:parson.c      ****     case JSONArray:
1567:parson.c      ****         temp_array = json_value_get_array(value);
 9810              		.loc 2 1567 0
 9811 31d4 7868     		ldr	r0, [r7, #4]	@, value
 9812 31d6 FFF7FEFF 		bl	json_value_get_array	@
 9813 31da B861     		str	r0, [r7, #24]	@, temp_array
1568:parson.c      ****         return_value = json_value_init_array();
 9814              		.loc 2 1568 0
 9815 31dc FFF7FEFF 		bl	json_value_init_array	@
 9816 31e0 3863     		str	r0, [r7, #48]	@, return_value
1569:parson.c      ****         if (return_value == NULL) {
 9817              		.loc 2 1569 0
 9818 31e2 3B6B     		ldr	r3, [r7, #48]	@ tmp132, return_value
 9819 31e4 002B     		cmp	r3, #0	@ tmp132,
 9820 31e6 01D1     		bne	.L620	@,
1570:parson.c      ****             return NULL;
 9821              		.loc 2 1570 0
 9822 31e8 0023     		movs	r3, #0	@ _3,
 9823 31ea B6E0     		b	.L621	@
 9824              	.L620:
1571:parson.c      ****         }
1572:parson.c      ****         temp_array_copy = json_value_get_array(return_value);
 9825              		.loc 2 1572 0
 9826 31ec 386B     		ldr	r0, [r7, #48]	@, return_value
 9827 31ee FFF7FEFF 		bl	json_value_get_array	@
 9828 31f2 7861     		str	r0, [r7, #20]	@, temp_array_copy
1573:parson.c      ****         for (i = 0; i < json_array_get_count(temp_array); i++) {
 9829              		.loc 2 1573 0
 9830 31f4 0023     		movs	r3, #0	@ tmp133,
 9831 31f6 7B63     		str	r3, [r7, #52]	@ tmp133, i
 9832 31f8 23E0     		b	.L622	@
 9833              	.L625:
1574:parson.c      ****             temp_value = json_array_get_value(temp_array, i);
 9834              		.loc 2 1574 0
 9835 31fa 796B     		ldr	r1, [r7, #52]	@, i
 9836 31fc B869     		ldr	r0, [r7, #24]	@, temp_array
 9837 31fe FFF7FEFF 		bl	json_array_get_value	@
 9838 3202 B862     		str	r0, [r7, #40]	@, temp_value
1575:parson.c      ****             temp_value_copy = json_value_deep_copy(temp_value);
 9839              		.loc 2 1575 0
 9840 3204 B86A     		ldr	r0, [r7, #40]	@, temp_value
 9841 3206 FFF7FEFF 		bl	json_value_deep_copy	@
 9842 320a F862     		str	r0, [r7, #44]	@, temp_value_copy
1576:parson.c      ****             if (temp_value_copy == NULL) {
 9843              		.loc 2 1576 0
 9844 320c FB6A     		ldr	r3, [r7, #44]	@ tmp134, temp_value_copy
 9845 320e 002B     		cmp	r3, #0	@ tmp134,
 9846 3210 04D1     		bne	.L623	@,
1577:parson.c      ****                 json_value_free(return_value);
 9847              		.loc 2 1577 0
 9848 3212 386B     		ldr	r0, [r7, #48]	@, return_value
 9849 3214 FFF7FEFF 		bl	json_value_free	@
1578:parson.c      ****                 return NULL;
 9850              		.loc 2 1578 0
 9851 3218 0023     		movs	r3, #0	@ _3,
 9852 321a 9EE0     		b	.L621	@
 9853              	.L623:
1579:parson.c      ****             }
1580:parson.c      ****             if (json_array_add(temp_array_copy, temp_value_copy) == JSONFailure) {
 9854              		.loc 2 1580 0
 9855 321c F96A     		ldr	r1, [r7, #44]	@, temp_value_copy
 9856 321e 7869     		ldr	r0, [r7, #20]	@, temp_array_copy
 9857 3220 FDF71FFC 		bl	json_array_add	@
 9858 3224 0346     		mov	r3, r0	@ _38,
 9859 3226 B3F1FF3F 		cmp	r3, #-1	@ _38,
 9860 322a 07D1     		bne	.L624	@,
1581:parson.c      ****                 json_value_free(return_value);
 9861              		.loc 2 1581 0
 9862 322c 386B     		ldr	r0, [r7, #48]	@, return_value
 9863 322e FFF7FEFF 		bl	json_value_free	@
1582:parson.c      ****                 json_value_free(temp_value_copy);
 9864              		.loc 2 1582 0
 9865 3232 F86A     		ldr	r0, [r7, #44]	@, temp_value_copy
 9866 3234 FFF7FEFF 		bl	json_value_free	@
1583:parson.c      ****                 return NULL;
 9867              		.loc 2 1583 0
 9868 3238 0023     		movs	r3, #0	@ _3,
 9869 323a 8EE0     		b	.L621	@
 9870              	.L624:
1573:parson.c      ****             temp_value = json_array_get_value(temp_array, i);
 9871              		.loc 2 1573 0 discriminator 2
 9872 323c 7B6B     		ldr	r3, [r7, #52]	@ tmp136, i
 9873 323e 0133     		adds	r3, r3, #1	@ tmp135, tmp136,
 9874 3240 7B63     		str	r3, [r7, #52]	@ tmp135, i
 9875              	.L622:
1573:parson.c      ****             temp_value = json_array_get_value(temp_array, i);
 9876              		.loc 2 1573 0 is_stmt 0 discriminator 1
 9877 3242 B869     		ldr	r0, [r7, #24]	@, temp_array
 9878 3244 FFF7FEFF 		bl	json_array_get_count	@
 9879 3248 0246     		mov	r2, r0	@ _32,
 9880 324a 7B6B     		ldr	r3, [r7, #52]	@ tmp137, i
 9881 324c 9A42     		cmp	r2, r3	@ _32, tmp137
 9882 324e D4D8     		bhi	.L625	@,
1584:parson.c      ****             }
1585:parson.c      ****         }
1586:parson.c      ****         return return_value;
 9883              		.loc 2 1586 0 is_stmt 1
 9884 3250 3B6B     		ldr	r3, [r7, #48]	@ _3, return_value
 9885 3252 82E0     		b	.L621	@
 9886              	.L617:
1587:parson.c      ****     case JSONObject:
1588:parson.c      ****         temp_object = json_value_get_object(value);
 9887              		.loc 2 1588 0
 9888 3254 7868     		ldr	r0, [r7, #4]	@, value
 9889 3256 FFF7FEFF 		bl	json_value_get_object	@
 9890 325a 3861     		str	r0, [r7, #16]	@, temp_object
1589:parson.c      ****         return_value = json_value_init_object();
 9891              		.loc 2 1589 0
 9892 325c FFF7FEFF 		bl	json_value_init_object	@
 9893 3260 3863     		str	r0, [r7, #48]	@, return_value
1590:parson.c      ****         if (return_value == NULL) {
 9894              		.loc 2 1590 0
 9895 3262 3B6B     		ldr	r3, [r7, #48]	@ tmp138, return_value
 9896 3264 002B     		cmp	r3, #0	@ tmp138,
 9897 3266 01D1     		bne	.L626	@,
1591:parson.c      ****             return NULL;
 9898              		.loc 2 1591 0
 9899 3268 0023     		movs	r3, #0	@ _3,
 9900 326a 76E0     		b	.L621	@
 9901              	.L626:
1592:parson.c      ****         }
1593:parson.c      ****         temp_object_copy = json_value_get_object(return_value);
 9902              		.loc 2 1593 0
 9903 326c 386B     		ldr	r0, [r7, #48]	@, return_value
 9904 326e FFF7FEFF 		bl	json_value_get_object	@
 9905 3272 F860     		str	r0, [r7, #12]	@, temp_object_copy
1594:parson.c      ****         for (i = 0; i < json_object_get_count(temp_object); i++) {
 9906              		.loc 2 1594 0
 9907 3274 0023     		movs	r3, #0	@ tmp139,
 9908 3276 7B63     		str	r3, [r7, #52]	@ tmp139, i
 9909 3278 29E0     		b	.L627	@
 9910              	.L630:
1595:parson.c      ****             temp_key = json_object_get_name(temp_object, i);
 9911              		.loc 2 1595 0
 9912 327a 796B     		ldr	r1, [r7, #52]	@, i
 9913 327c 3869     		ldr	r0, [r7, #16]	@, temp_object
 9914 327e FFF7FEFF 		bl	json_object_get_name	@
 9915 3282 3862     		str	r0, [r7, #32]	@, temp_key
1596:parson.c      ****             temp_value = json_object_get_value(temp_object, temp_key);
 9916              		.loc 2 1596 0
 9917 3284 396A     		ldr	r1, [r7, #32]	@, temp_key
 9918 3286 3869     		ldr	r0, [r7, #16]	@, temp_object
 9919 3288 FFF7FEFF 		bl	json_object_get_value	@
 9920 328c B862     		str	r0, [r7, #40]	@, temp_value
1597:parson.c      ****             temp_value_copy = json_value_deep_copy(temp_value);
 9921              		.loc 2 1597 0
 9922 328e B86A     		ldr	r0, [r7, #40]	@, temp_value
 9923 3290 FFF7FEFF 		bl	json_value_deep_copy	@
 9924 3294 F862     		str	r0, [r7, #44]	@, temp_value_copy
1598:parson.c      ****             if (temp_value_copy == NULL) {
 9925              		.loc 2 1598 0
 9926 3296 FB6A     		ldr	r3, [r7, #44]	@ tmp140, temp_value_copy
 9927 3298 002B     		cmp	r3, #0	@ tmp140,
 9928 329a 04D1     		bne	.L628	@,
1599:parson.c      ****                 json_value_free(return_value);
 9929              		.loc 2 1599 0
 9930 329c 386B     		ldr	r0, [r7, #48]	@, return_value
 9931 329e FFF7FEFF 		bl	json_value_free	@
1600:parson.c      ****                 return NULL;
 9932              		.loc 2 1600 0
 9933 32a2 0023     		movs	r3, #0	@ _3,
 9934 32a4 59E0     		b	.L621	@
 9935              	.L628:
1601:parson.c      ****             }
1602:parson.c      ****             if (json_object_add(temp_object_copy, temp_key, temp_value_copy) == JSONFailure) {
 9936              		.loc 2 1602 0
 9937 32a6 FA6A     		ldr	r2, [r7, #44]	@, temp_value_copy
 9938 32a8 396A     		ldr	r1, [r7, #32]	@, temp_key
 9939 32aa F868     		ldr	r0, [r7, #12]	@, temp_object_copy
 9940 32ac FDF77FF9 		bl	json_object_add	@
 9941 32b0 0346     		mov	r3, r0	@ _63,
 9942 32b2 B3F1FF3F 		cmp	r3, #-1	@ _63,
 9943 32b6 07D1     		bne	.L629	@,
1603:parson.c      ****                 json_value_free(return_value);
 9944              		.loc 2 1603 0
 9945 32b8 386B     		ldr	r0, [r7, #48]	@, return_value
 9946 32ba FFF7FEFF 		bl	json_value_free	@
1604:parson.c      ****                 json_value_free(temp_value_copy);
 9947              		.loc 2 1604 0
 9948 32be F86A     		ldr	r0, [r7, #44]	@, temp_value_copy
 9949 32c0 FFF7FEFF 		bl	json_value_free	@
1605:parson.c      ****                 return NULL;
 9950              		.loc 2 1605 0
 9951 32c4 0023     		movs	r3, #0	@ _3,
 9952 32c6 48E0     		b	.L621	@
 9953              	.L629:
1594:parson.c      ****             temp_key = json_object_get_name(temp_object, i);
 9954              		.loc 2 1594 0 discriminator 2
 9955 32c8 7B6B     		ldr	r3, [r7, #52]	@ tmp142, i
 9956 32ca 0133     		adds	r3, r3, #1	@ tmp141, tmp142,
 9957 32cc 7B63     		str	r3, [r7, #52]	@ tmp141, i
 9958              	.L627:
1594:parson.c      ****             temp_key = json_object_get_name(temp_object, i);
 9959              		.loc 2 1594 0 is_stmt 0 discriminator 1
 9960 32ce 3869     		ldr	r0, [r7, #16]	@, temp_object
 9961 32d0 FFF7FEFF 		bl	json_object_get_count	@
 9962 32d4 0246     		mov	r2, r0	@ _55,
 9963 32d6 7B6B     		ldr	r3, [r7, #52]	@ tmp143, i
 9964 32d8 9A42     		cmp	r2, r3	@ _55, tmp143
 9965 32da CED8     		bhi	.L630	@,
1606:parson.c      ****             }
1607:parson.c      ****         }
1608:parson.c      ****         return return_value;
 9966              		.loc 2 1608 0 is_stmt 1
 9967 32dc 3B6B     		ldr	r3, [r7, #48]	@ _3, return_value
 9968 32de 3CE0     		b	.L621	@
 9969              	.L619:
1609:parson.c      ****     case JSONBoolean:
1610:parson.c      ****         return json_value_init_boolean(json_value_get_boolean(value));
 9970              		.loc 2 1610 0
 9971 32e0 7868     		ldr	r0, [r7, #4]	@, value
 9972 32e2 FFF7FEFF 		bl	json_value_get_boolean	@
 9973 32e6 0346     		mov	r3, r0	@ _72,
 9974 32e8 1846     		mov	r0, r3	@, _72
 9975 32ea FFF7FEFF 		bl	json_value_init_boolean	@
 9976 32ee 0346     		mov	r3, r0	@ _3,
 9977 32f0 33E0     		b	.L621	@
 9978              	.L616:
1611:parson.c      ****     case JSONNumber:
1612:parson.c      ****         return json_value_init_number(json_value_get_number(value));
 9979              		.loc 2 1612 0
 9980 32f2 7868     		ldr	r0, [r7, #4]	@, value
 9981 32f4 FFF7FEFF 		bl	json_value_get_number	@
 9982 32f8 F0EE400B 		vmov.f64	d16, d0	@ _76,
 9983 32fc B0EE600B 		vmov.f64	d0, d16	@, _76
 9984 3300 FFF7FEFF 		bl	json_value_init_number	@
 9985 3304 0346     		mov	r3, r0	@ _3,
 9986 3306 28E0     		b	.L621	@
 9987              	.L615:
1613:parson.c      ****     case JSONString:
1614:parson.c      ****         temp_string = json_value_get_string(value);
 9988              		.loc 2 1614 0
 9989 3308 7868     		ldr	r0, [r7, #4]	@, value
 9990 330a FFF7FEFF 		bl	json_value_get_string	@
 9991 330e 7862     		str	r0, [r7, #36]	@, temp_string
1615:parson.c      ****         if (temp_string == NULL) {
 9992              		.loc 2 1615 0
 9993 3310 7B6A     		ldr	r3, [r7, #36]	@ tmp144, temp_string
 9994 3312 002B     		cmp	r3, #0	@ tmp144,
 9995 3314 01D1     		bne	.L631	@,
1616:parson.c      ****             return NULL;
 9996              		.loc 2 1616 0
 9997 3316 0023     		movs	r3, #0	@ _3,
 9998 3318 1FE0     		b	.L621	@
 9999              	.L631:
1617:parson.c      ****         }
1618:parson.c      ****         temp_string_copy = parson_strdup(temp_string);
 10000              		.loc 2 1618 0
 10001 331a 786A     		ldr	r0, [r7, #36]	@, temp_string
 10002 331c FCF7A7FE 		bl	parson_strdup	@
 10003 3320 F861     		str	r0, [r7, #28]	@, temp_string_copy
1619:parson.c      ****         if (temp_string_copy == NULL) {
 10004              		.loc 2 1619 0
 10005 3322 FB69     		ldr	r3, [r7, #28]	@ tmp145, temp_string_copy
 10006 3324 002B     		cmp	r3, #0	@ tmp145,
 10007 3326 01D1     		bne	.L632	@,
1620:parson.c      ****             return NULL;
 10008              		.loc 2 1620 0
 10009 3328 0023     		movs	r3, #0	@ _3,
 10010 332a 16E0     		b	.L621	@
 10011              	.L632:
1621:parson.c      ****         }
1622:parson.c      ****         return_value = json_value_init_string_no_copy(temp_string_copy);
 10012              		.loc 2 1622 0
 10013 332c F869     		ldr	r0, [r7, #28]	@, temp_string_copy
 10014 332e FDF73BFC 		bl	json_value_init_string_no_copy	@
 10015 3332 3863     		str	r0, [r7, #48]	@, return_value
1623:parson.c      ****         if (return_value == NULL) {
 10016              		.loc 2 1623 0
 10017 3334 3B6B     		ldr	r3, [r7, #48]	@ tmp146, return_value
 10018 3336 002B     		cmp	r3, #0	@ tmp146,
 10019 3338 06D1     		bne	.L633	@,
1624:parson.c      ****             parson_free(temp_string_copy);
 10020              		.loc 2 1624 0
 10021 333a 40F20003 		movw	r3, #:lower16:parson_free	@ tmp147,
 10022 333e C0F20003 		movt	r3, #:upper16:parson_free	@ tmp147,
 10023 3342 1B68     		ldr	r3, [r3]	@ parson_free.182_87, parson_free
 10024 3344 F869     		ldr	r0, [r7, #28]	@, temp_string_copy
 10025 3346 9847     		blx	r3	@ parson_free.182_87
 10026              	.LVL38:
 10027              	.L633:
1625:parson.c      ****         }
1626:parson.c      ****         return return_value;
 10028              		.loc 2 1626 0
 10029 3348 3B6B     		ldr	r3, [r7, #48]	@ _3, return_value
 10030 334a 06E0     		b	.L621	@
 10031              	.L614:
1627:parson.c      ****     case JSONNull:
1628:parson.c      ****         return json_value_init_null();
 10032              		.loc 2 1628 0
 10033 334c FFF7FEFF 		bl	json_value_init_null	@
 10034 3350 0346     		mov	r3, r0	@ _3,
 10035 3352 02E0     		b	.L621	@
 10036              	.L612:
1629:parson.c      ****     case JSONError:
1630:parson.c      ****         return NULL;
 10037              		.loc 2 1630 0
 10038 3354 0023     		movs	r3, #0	@ _3,
 10039 3356 00E0     		b	.L621	@
 10040              	.L611:
1631:parson.c      ****     default:
1632:parson.c      ****         return NULL;
 10041              		.loc 2 1632 0
 10042 3358 0023     		movs	r3, #0	@ _3,
 10043              	.L621:
1633:parson.c      ****     }
1634:parson.c      **** }
 10044              		.loc 2 1634 0
 10045 335a 1846     		mov	r0, r3	@, <retval>
 10046 335c 3837     		adds	r7, r7, #56	@,,
 10047              	.LCFI423:
 10048              		.cfi_def_cfa_offset 8
 10049 335e BD46     		mov	sp, r7	@,
 10050              	.LCFI424:
 10051              		.cfi_def_cfa_register 13
 10052              		@ sp needed	@
 10053 3360 80BD     		pop	{r7, pc}	@
 10054              		.cfi_endproc
 10055              	.LFE99:
 10057              		.align	1
 10058              		.global	json_serialization_size
 10059              		.syntax unified
 10060              		.thumb
 10061              		.thumb_func
 10062              		.fpu neon
 10064              	json_serialization_size:
 10065              	.LFB100:
1635:parson.c      **** 
1636:parson.c      **** size_t json_serialization_size(const JSON_Value *value)
1637:parson.c      **** {
 10066              		.loc 2 1637 0
 10067              		.cfi_startproc
 10068              		@ args = 0, pretend = 0, frame = 80
 10069              		@ frame_needed = 1, uses_anonymous_args = 0
 10070 3362 80B5     		push	{r7, lr}	@
 10071              	.LCFI425:
 10072              		.cfi_def_cfa_offset 8
 10073              		.cfi_offset 7, -8
 10074              		.cfi_offset 14, -4
 10075 3364 96B0     		sub	sp, sp, #88	@,,
 10076              	.LCFI426:
 10077              		.cfi_def_cfa_offset 96
 10078 3366 02AF     		add	r7, sp, #8	@,,
 10079              	.LCFI427:
 10080              		.cfi_def_cfa 7, 88
 10081 3368 7860     		str	r0, [r7, #4]	@ value, value
1638:parson.c      ****     char num_buf[NUM_BUF_SIZE]; /* recursively allocating buffer on stack is a bad idea, so let's d
1639:parson.c      ****                                    it only once */
1640:parson.c      ****     int res = json_serialize_to_buffer_r(value, NULL, 0, 0, num_buf);
 10082              		.loc 2 1640 0
 10083 336a 07F10C03 		add	r3, r7, #12	@ tmp113,,
 10084 336e 0093     		str	r3, [sp]	@ tmp113,
 10085 3370 0023     		movs	r3, #0	@,
 10086 3372 0022     		movs	r2, #0	@,
 10087 3374 0021     		movs	r1, #0	@,
 10088 3376 7868     		ldr	r0, [r7, #4]	@, value
 10089 3378 FEF766FA 		bl	json_serialize_to_buffer_r	@
 10090 337c F864     		str	r0, [r7, #76]	@, res
1641:parson.c      ****     return res < 0 ? 0 : (size_t)(res + 1);
 10091              		.loc 2 1641 0
 10092 337e FB6C     		ldr	r3, [r7, #76]	@ tmp114, res
 10093 3380 002B     		cmp	r3, #0	@ tmp114,
 10094 3382 02DB     		blt	.L635	@,
 10095              		.loc 2 1641 0 is_stmt 0 discriminator 1
 10096 3384 FB6C     		ldr	r3, [r7, #76]	@ tmp115, res
 10097 3386 0133     		adds	r3, r3, #1	@ _6, tmp115,
 10098 3388 00E0     		b	.L637	@
 10099              	.L635:
 10100              		.loc 2 1641 0 discriminator 2
 10101 338a 0023     		movs	r3, #0	@ iftmp.183_1,
 10102              	.L637:
1642:parson.c      **** }
 10103              		.loc 2 1642 0 is_stmt 1
 10104 338c 1846     		mov	r0, r3	@, <retval>
 10105 338e 5037     		adds	r7, r7, #80	@,,
 10106              	.LCFI428:
 10107              		.cfi_def_cfa_offset 8
 10108 3390 BD46     		mov	sp, r7	@,
 10109              	.LCFI429:
 10110              		.cfi_def_cfa_register 13
 10111              		@ sp needed	@
 10112 3392 80BD     		pop	{r7, pc}	@
 10113              		.cfi_endproc
 10114              	.LFE100:
 10116              		.align	1
 10117              		.global	json_serialize_to_buffer
 10118              		.syntax unified
 10119              		.thumb
 10120              		.thumb_func
 10121              		.fpu neon
 10123              	json_serialize_to_buffer:
 10124              	.LFB101:
1643:parson.c      **** 
1644:parson.c      **** JSON_Status json_serialize_to_buffer(const JSON_Value *value, char *buf, size_t buf_size_in_bytes)
1645:parson.c      **** {
 10125              		.loc 2 1645 0
 10126              		.cfi_startproc
 10127              		@ args = 0, pretend = 0, frame = 24
 10128              		@ frame_needed = 1, uses_anonymous_args = 0
 10129 3394 80B5     		push	{r7, lr}	@
 10130              	.LCFI430:
 10131              		.cfi_def_cfa_offset 8
 10132              		.cfi_offset 7, -8
 10133              		.cfi_offset 14, -4
 10134 3396 88B0     		sub	sp, sp, #32	@,,
 10135              	.LCFI431:
 10136              		.cfi_def_cfa_offset 40
 10137 3398 02AF     		add	r7, sp, #8	@,,
 10138              	.LCFI432:
 10139              		.cfi_def_cfa 7, 32
 10140 339a F860     		str	r0, [r7, #12]	@ value, value
 10141 339c B960     		str	r1, [r7, #8]	@ buf, buf
 10142 339e 7A60     		str	r2, [r7, #4]	@ buf_size_in_bytes, buf_size_in_bytes
1646:parson.c      ****     int written = -1;
 10143              		.loc 2 1646 0
 10144 33a0 4FF0FF33 		mov	r3, #-1	@ tmp112,
 10145 33a4 7B61     		str	r3, [r7, #20]	@ tmp112, written
1647:parson.c      ****     size_t needed_size_in_bytes = json_serialization_size(value);
 10146              		.loc 2 1647 0
 10147 33a6 F868     		ldr	r0, [r7, #12]	@, value
 10148 33a8 FFF7FEFF 		bl	json_serialization_size	@
 10149 33ac 3861     		str	r0, [r7, #16]	@, needed_size_in_bytes
1648:parson.c      ****     if (needed_size_in_bytes == 0 || buf_size_in_bytes < needed_size_in_bytes) {
 10150              		.loc 2 1648 0
 10151 33ae 3B69     		ldr	r3, [r7, #16]	@ tmp113, needed_size_in_bytes
 10152 33b0 002B     		cmp	r3, #0	@ tmp113,
 10153 33b2 03D0     		beq	.L639	@,
 10154              		.loc 2 1648 0 is_stmt 0 discriminator 1
 10155 33b4 7A68     		ldr	r2, [r7, #4]	@ tmp114, buf_size_in_bytes
 10156 33b6 3B69     		ldr	r3, [r7, #16]	@ tmp115, needed_size_in_bytes
 10157 33b8 9A42     		cmp	r2, r3	@ tmp114, tmp115
 10158 33ba 02D2     		bcs	.L640	@,
 10159              	.L639:
1649:parson.c      ****         return JSONFailure;
 10160              		.loc 2 1649 0 is_stmt 1
 10161 33bc 4FF0FF33 		mov	r3, #-1	@ _1,
 10162 33c0 0FE0     		b	.L641	@
 10163              	.L640:
1650:parson.c      ****     }
1651:parson.c      ****     written = json_serialize_to_buffer_r(value, buf, 0, 0, NULL);
 10164              		.loc 2 1651 0
 10165 33c2 0023     		movs	r3, #0	@ tmp116,
 10166 33c4 0093     		str	r3, [sp]	@ tmp116,
 10167 33c6 0023     		movs	r3, #0	@,
 10168 33c8 0022     		movs	r2, #0	@,
 10169 33ca B968     		ldr	r1, [r7, #8]	@, buf
 10170 33cc F868     		ldr	r0, [r7, #12]	@, value
 10171 33ce FEF73BFA 		bl	json_serialize_to_buffer_r	@
 10172 33d2 7861     		str	r0, [r7, #20]	@, written
1652:parson.c      ****     if (written < 0) {
 10173              		.loc 2 1652 0
 10174 33d4 7B69     		ldr	r3, [r7, #20]	@ tmp117, written
 10175 33d6 002B     		cmp	r3, #0	@ tmp117,
 10176 33d8 02DA     		bge	.L642	@,
1653:parson.c      ****         return JSONFailure;
 10177              		.loc 2 1653 0
 10178 33da 4FF0FF33 		mov	r3, #-1	@ _1,
 10179 33de 00E0     		b	.L641	@
 10180              	.L642:
1654:parson.c      ****     }
1655:parson.c      ****     return JSONSuccess;
 10181              		.loc 2 1655 0
 10182 33e0 0023     		movs	r3, #0	@ _1,
 10183              	.L641:
1656:parson.c      **** }
 10184              		.loc 2 1656 0
 10185 33e2 1846     		mov	r0, r3	@, <retval>
 10186 33e4 1837     		adds	r7, r7, #24	@,,
 10187              	.LCFI433:
 10188              		.cfi_def_cfa_offset 8
 10189 33e6 BD46     		mov	sp, r7	@,
 10190              	.LCFI434:
 10191              		.cfi_def_cfa_register 13
 10192              		@ sp needed	@
 10193 33e8 80BD     		pop	{r7, pc}	@
 10194              		.cfi_endproc
 10195              	.LFE101:
 10197              		.align	1
 10198              		.global	json_serialize_to_string
 10199              		.syntax unified
 10200              		.thumb
 10201              		.thumb_func
 10202              		.fpu neon
 10204              	json_serialize_to_string:
 10205              	.LFB102:
1657:parson.c      **** 
1658:parson.c      **** char *json_serialize_to_string(const JSON_Value *value)
1659:parson.c      **** {
 10206              		.loc 2 1659 0
 10207              		.cfi_startproc
 10208              		@ args = 0, pretend = 0, frame = 24
 10209              		@ frame_needed = 1, uses_anonymous_args = 0
 10210 33ea 80B5     		push	{r7, lr}	@
 10211              	.LCFI435:
 10212              		.cfi_def_cfa_offset 8
 10213              		.cfi_offset 7, -8
 10214              		.cfi_offset 14, -4
 10215 33ec 86B0     		sub	sp, sp, #24	@,,
 10216              	.LCFI436:
 10217              		.cfi_def_cfa_offset 32
 10218 33ee 00AF     		add	r7, sp, #0	@,,
 10219              	.LCFI437:
 10220              		.cfi_def_cfa_register 7
 10221 33f0 7860     		str	r0, [r7, #4]	@ value, value
1660:parson.c      ****     JSON_Status serialization_result = JSONFailure;
 10222              		.loc 2 1660 0
 10223 33f2 4FF0FF33 		mov	r3, #-1	@ tmp113,
 10224 33f6 7B61     		str	r3, [r7, #20]	@ tmp113, serialization_result
1661:parson.c      ****     size_t buf_size_bytes = json_serialization_size(value);
 10225              		.loc 2 1661 0
 10226 33f8 7868     		ldr	r0, [r7, #4]	@, value
 10227 33fa FFF7FEFF 		bl	json_serialization_size	@
 10228 33fe 3861     		str	r0, [r7, #16]	@, buf_size_bytes
1662:parson.c      ****     char *buf = NULL;
 10229              		.loc 2 1662 0
 10230 3400 0023     		movs	r3, #0	@ tmp114,
 10231 3402 FB60     		str	r3, [r7, #12]	@ tmp114, buf
1663:parson.c      ****     if (buf_size_bytes == 0) {
 10232              		.loc 2 1663 0
 10233 3404 3B69     		ldr	r3, [r7, #16]	@ tmp115, buf_size_bytes
 10234 3406 002B     		cmp	r3, #0	@ tmp115,
 10235 3408 01D1     		bne	.L644	@,
1664:parson.c      ****         return NULL;
 10236              		.loc 2 1664 0
 10237 340a 0023     		movs	r3, #0	@ _1,
 10238 340c 1CE0     		b	.L645	@
 10239              	.L644:
1665:parson.c      ****     }
1666:parson.c      ****     buf = (char *)parson_malloc(buf_size_bytes);
 10240              		.loc 2 1666 0
 10241 340e 40F20003 		movw	r3, #:lower16:parson_malloc	@ tmp116,
 10242 3412 C0F20003 		movt	r3, #:upper16:parson_malloc	@ tmp116,
 10243 3416 1B68     		ldr	r3, [r3]	@ parson_malloc.184_10, parson_malloc
 10244 3418 3869     		ldr	r0, [r7, #16]	@, buf_size_bytes
 10245 341a 9847     		blx	r3	@ parson_malloc.184_10
 10246              	.LVL39:
 10247 341c F860     		str	r0, [r7, #12]	@, buf
1667:parson.c      ****     if (buf == NULL) {
 10248              		.loc 2 1667 0
 10249 341e FB68     		ldr	r3, [r7, #12]	@ tmp117, buf
 10250 3420 002B     		cmp	r3, #0	@ tmp117,
 10251 3422 01D1     		bne	.L646	@,
1668:parson.c      ****         return NULL;
 10252              		.loc 2 1668 0
 10253 3424 0023     		movs	r3, #0	@ _1,
 10254 3426 0FE0     		b	.L645	@
 10255              	.L646:
1669:parson.c      ****     }
1670:parson.c      ****     serialization_result = json_serialize_to_buffer(value, buf, buf_size_bytes);
 10256              		.loc 2 1670 0
 10257 3428 3A69     		ldr	r2, [r7, #16]	@, buf_size_bytes
 10258 342a F968     		ldr	r1, [r7, #12]	@, buf
 10259 342c 7868     		ldr	r0, [r7, #4]	@, value
 10260 342e FFF7FEFF 		bl	json_serialize_to_buffer	@
 10261 3432 7861     		str	r0, [r7, #20]	@, serialization_result
1671:parson.c      ****     if (serialization_result == JSONFailure) {
 10262              		.loc 2 1671 0
 10263 3434 7B69     		ldr	r3, [r7, #20]	@ tmp118, serialization_result
 10264 3436 B3F1FF3F 		cmp	r3, #-1	@ tmp118,
 10265 343a 04D1     		bne	.L647	@,
1672:parson.c      ****         json_free_serialized_string(buf);
 10266              		.loc 2 1672 0
 10267 343c F868     		ldr	r0, [r7, #12]	@, buf
 10268 343e FFF7FEFF 		bl	json_free_serialized_string	@
1673:parson.c      ****         return NULL;
 10269              		.loc 2 1673 0
 10270 3442 0023     		movs	r3, #0	@ _1,
 10271 3444 00E0     		b	.L645	@
 10272              	.L647:
1674:parson.c      ****     }
1675:parson.c      ****     return buf;
 10273              		.loc 2 1675 0
 10274 3446 FB68     		ldr	r3, [r7, #12]	@ _1, buf
 10275              	.L645:
1676:parson.c      **** }
 10276              		.loc 2 1676 0
 10277 3448 1846     		mov	r0, r3	@, <retval>
 10278 344a 1837     		adds	r7, r7, #24	@,,
 10279              	.LCFI438:
 10280              		.cfi_def_cfa_offset 8
 10281 344c BD46     		mov	sp, r7	@,
 10282              	.LCFI439:
 10283              		.cfi_def_cfa_register 13
 10284              		@ sp needed	@
 10285 344e 80BD     		pop	{r7, pc}	@
 10286              		.cfi_endproc
 10287              	.LFE102:
 10289              		.align	1
 10290              		.global	json_serialization_size_pretty
 10291              		.syntax unified
 10292              		.thumb
 10293              		.thumb_func
 10294              		.fpu neon
 10296              	json_serialization_size_pretty:
 10297              	.LFB103:
1677:parson.c      **** 
1678:parson.c      **** size_t json_serialization_size_pretty(const JSON_Value *value)
1679:parson.c      **** {
 10298              		.loc 2 1679 0
 10299              		.cfi_startproc
 10300              		@ args = 0, pretend = 0, frame = 80
 10301              		@ frame_needed = 1, uses_anonymous_args = 0
 10302 3450 80B5     		push	{r7, lr}	@
 10303              	.LCFI440:
 10304              		.cfi_def_cfa_offset 8
 10305              		.cfi_offset 7, -8
 10306              		.cfi_offset 14, -4
 10307 3452 96B0     		sub	sp, sp, #88	@,,
 10308              	.LCFI441:
 10309              		.cfi_def_cfa_offset 96
 10310 3454 02AF     		add	r7, sp, #8	@,,
 10311              	.LCFI442:
 10312              		.cfi_def_cfa 7, 88
 10313 3456 7860     		str	r0, [r7, #4]	@ value, value
1680:parson.c      ****     char num_buf[NUM_BUF_SIZE]; /* recursively allocating buffer on stack is a bad idea, so let's d
1681:parson.c      ****                                    it only once */
1682:parson.c      ****     int res = json_serialize_to_buffer_r(value, NULL, 0, 1, num_buf);
 10314              		.loc 2 1682 0
 10315 3458 07F10C03 		add	r3, r7, #12	@ tmp113,,
 10316 345c 0093     		str	r3, [sp]	@ tmp113,
 10317 345e 0123     		movs	r3, #1	@,
 10318 3460 0022     		movs	r2, #0	@,
 10319 3462 0021     		movs	r1, #0	@,
 10320 3464 7868     		ldr	r0, [r7, #4]	@, value
 10321 3466 FEF7EFF9 		bl	json_serialize_to_buffer_r	@
 10322 346a F864     		str	r0, [r7, #76]	@, res
1683:parson.c      ****     return res < 0 ? 0 : (size_t)(res + 1);
 10323              		.loc 2 1683 0
 10324 346c FB6C     		ldr	r3, [r7, #76]	@ tmp114, res
 10325 346e 002B     		cmp	r3, #0	@ tmp114,
 10326 3470 02DB     		blt	.L649	@,
 10327              		.loc 2 1683 0 is_stmt 0 discriminator 1
 10328 3472 FB6C     		ldr	r3, [r7, #76]	@ tmp115, res
 10329 3474 0133     		adds	r3, r3, #1	@ _6, tmp115,
 10330 3476 00E0     		b	.L651	@
 10331              	.L649:
 10332              		.loc 2 1683 0 discriminator 2
 10333 3478 0023     		movs	r3, #0	@ iftmp.185_1,
 10334              	.L651:
1684:parson.c      **** }
 10335              		.loc 2 1684 0 is_stmt 1
 10336 347a 1846     		mov	r0, r3	@, <retval>
 10337 347c 5037     		adds	r7, r7, #80	@,,
 10338              	.LCFI443:
 10339              		.cfi_def_cfa_offset 8
 10340 347e BD46     		mov	sp, r7	@,
 10341              	.LCFI444:
 10342              		.cfi_def_cfa_register 13
 10343              		@ sp needed	@
 10344 3480 80BD     		pop	{r7, pc}	@
 10345              		.cfi_endproc
 10346              	.LFE103:
 10348              		.align	1
 10349              		.global	json_serialize_to_buffer_pretty
 10350              		.syntax unified
 10351              		.thumb
 10352              		.thumb_func
 10353              		.fpu neon
 10355              	json_serialize_to_buffer_pretty:
 10356              	.LFB104:
1685:parson.c      **** 
1686:parson.c      **** JSON_Status json_serialize_to_buffer_pretty(const JSON_Value *value, char *buf,
1687:parson.c      ****                                             size_t buf_size_in_bytes)
1688:parson.c      **** {
 10357              		.loc 2 1688 0
 10358              		.cfi_startproc
 10359              		@ args = 0, pretend = 0, frame = 24
 10360              		@ frame_needed = 1, uses_anonymous_args = 0
 10361 3482 80B5     		push	{r7, lr}	@
 10362              	.LCFI445:
 10363              		.cfi_def_cfa_offset 8
 10364              		.cfi_offset 7, -8
 10365              		.cfi_offset 14, -4
 10366 3484 88B0     		sub	sp, sp, #32	@,,
 10367              	.LCFI446:
 10368              		.cfi_def_cfa_offset 40
 10369 3486 02AF     		add	r7, sp, #8	@,,
 10370              	.LCFI447:
 10371              		.cfi_def_cfa 7, 32
 10372 3488 F860     		str	r0, [r7, #12]	@ value, value
 10373 348a B960     		str	r1, [r7, #8]	@ buf, buf
 10374 348c 7A60     		str	r2, [r7, #4]	@ buf_size_in_bytes, buf_size_in_bytes
1689:parson.c      ****     int written = -1;
 10375              		.loc 2 1689 0
 10376 348e 4FF0FF33 		mov	r3, #-1	@ tmp112,
 10377 3492 7B61     		str	r3, [r7, #20]	@ tmp112, written
1690:parson.c      ****     size_t needed_size_in_bytes = json_serialization_size_pretty(value);
 10378              		.loc 2 1690 0
 10379 3494 F868     		ldr	r0, [r7, #12]	@, value
 10380 3496 FFF7FEFF 		bl	json_serialization_size_pretty	@
 10381 349a 3861     		str	r0, [r7, #16]	@, needed_size_in_bytes
1691:parson.c      ****     if (needed_size_in_bytes == 0 || buf_size_in_bytes < needed_size_in_bytes) {
 10382              		.loc 2 1691 0
 10383 349c 3B69     		ldr	r3, [r7, #16]	@ tmp113, needed_size_in_bytes
 10384 349e 002B     		cmp	r3, #0	@ tmp113,
 10385 34a0 03D0     		beq	.L653	@,
 10386              		.loc 2 1691 0 is_stmt 0 discriminator 1
 10387 34a2 7A68     		ldr	r2, [r7, #4]	@ tmp114, buf_size_in_bytes
 10388 34a4 3B69     		ldr	r3, [r7, #16]	@ tmp115, needed_size_in_bytes
 10389 34a6 9A42     		cmp	r2, r3	@ tmp114, tmp115
 10390 34a8 02D2     		bcs	.L654	@,
 10391              	.L653:
1692:parson.c      ****         return JSONFailure;
 10392              		.loc 2 1692 0 is_stmt 1
 10393 34aa 4FF0FF33 		mov	r3, #-1	@ _1,
 10394 34ae 0FE0     		b	.L655	@
 10395              	.L654:
1693:parson.c      ****     }
1694:parson.c      ****     written = json_serialize_to_buffer_r(value, buf, 0, 1, NULL);
 10396              		.loc 2 1694 0
 10397 34b0 0023     		movs	r3, #0	@ tmp116,
 10398 34b2 0093     		str	r3, [sp]	@ tmp116,
 10399 34b4 0123     		movs	r3, #1	@,
 10400 34b6 0022     		movs	r2, #0	@,
 10401 34b8 B968     		ldr	r1, [r7, #8]	@, buf
 10402 34ba F868     		ldr	r0, [r7, #12]	@, value
 10403 34bc FEF7C4F9 		bl	json_serialize_to_buffer_r	@
 10404 34c0 7861     		str	r0, [r7, #20]	@, written
1695:parson.c      ****     if (written < 0) {
 10405              		.loc 2 1695 0
 10406 34c2 7B69     		ldr	r3, [r7, #20]	@ tmp117, written
 10407 34c4 002B     		cmp	r3, #0	@ tmp117,
 10408 34c6 02DA     		bge	.L656	@,
1696:parson.c      ****         return JSONFailure;
 10409              		.loc 2 1696 0
 10410 34c8 4FF0FF33 		mov	r3, #-1	@ _1,
 10411 34cc 00E0     		b	.L655	@
 10412              	.L656:
1697:parson.c      ****     }
1698:parson.c      ****     return JSONSuccess;
 10413              		.loc 2 1698 0
 10414 34ce 0023     		movs	r3, #0	@ _1,
 10415              	.L655:
1699:parson.c      **** }
 10416              		.loc 2 1699 0
 10417 34d0 1846     		mov	r0, r3	@, <retval>
 10418 34d2 1837     		adds	r7, r7, #24	@,,
 10419              	.LCFI448:
 10420              		.cfi_def_cfa_offset 8
 10421 34d4 BD46     		mov	sp, r7	@,
 10422              	.LCFI449:
 10423              		.cfi_def_cfa_register 13
 10424              		@ sp needed	@
 10425 34d6 80BD     		pop	{r7, pc}	@
 10426              		.cfi_endproc
 10427              	.LFE104:
 10429              		.align	1
 10430              		.global	json_serialize_to_string_pretty
 10431              		.syntax unified
 10432              		.thumb
 10433              		.thumb_func
 10434              		.fpu neon
 10436              	json_serialize_to_string_pretty:
 10437              	.LFB105:
1700:parson.c      **** 
1701:parson.c      **** char *json_serialize_to_string_pretty(const JSON_Value *value)
1702:parson.c      **** {
 10438              		.loc 2 1702 0
 10439              		.cfi_startproc
 10440              		@ args = 0, pretend = 0, frame = 24
 10441              		@ frame_needed = 1, uses_anonymous_args = 0
 10442 34d8 80B5     		push	{r7, lr}	@
 10443              	.LCFI450:
 10444              		.cfi_def_cfa_offset 8
 10445              		.cfi_offset 7, -8
 10446              		.cfi_offset 14, -4
 10447 34da 86B0     		sub	sp, sp, #24	@,,
 10448              	.LCFI451:
 10449              		.cfi_def_cfa_offset 32
 10450 34dc 00AF     		add	r7, sp, #0	@,,
 10451              	.LCFI452:
 10452              		.cfi_def_cfa_register 7
 10453 34de 7860     		str	r0, [r7, #4]	@ value, value
1703:parson.c      ****     JSON_Status serialization_result = JSONFailure;
 10454              		.loc 2 1703 0
 10455 34e0 4FF0FF33 		mov	r3, #-1	@ tmp113,
 10456 34e4 7B61     		str	r3, [r7, #20]	@ tmp113, serialization_result
1704:parson.c      ****     size_t buf_size_bytes = json_serialization_size_pretty(value);
 10457              		.loc 2 1704 0
 10458 34e6 7868     		ldr	r0, [r7, #4]	@, value
 10459 34e8 FFF7FEFF 		bl	json_serialization_size_pretty	@
 10460 34ec 3861     		str	r0, [r7, #16]	@, buf_size_bytes
1705:parson.c      ****     char *buf = NULL;
 10461              		.loc 2 1705 0
 10462 34ee 0023     		movs	r3, #0	@ tmp114,
 10463 34f0 FB60     		str	r3, [r7, #12]	@ tmp114, buf
1706:parson.c      ****     if (buf_size_bytes == 0) {
 10464              		.loc 2 1706 0
 10465 34f2 3B69     		ldr	r3, [r7, #16]	@ tmp115, buf_size_bytes
 10466 34f4 002B     		cmp	r3, #0	@ tmp115,
 10467 34f6 01D1     		bne	.L658	@,
1707:parson.c      ****         return NULL;
 10468              		.loc 2 1707 0
 10469 34f8 0023     		movs	r3, #0	@ _1,
 10470 34fa 1CE0     		b	.L659	@
 10471              	.L658:
1708:parson.c      ****     }
1709:parson.c      ****     buf = (char *)parson_malloc(buf_size_bytes);
 10472              		.loc 2 1709 0
 10473 34fc 40F20003 		movw	r3, #:lower16:parson_malloc	@ tmp116,
 10474 3500 C0F20003 		movt	r3, #:upper16:parson_malloc	@ tmp116,
 10475 3504 1B68     		ldr	r3, [r3]	@ parson_malloc.186_10, parson_malloc
 10476 3506 3869     		ldr	r0, [r7, #16]	@, buf_size_bytes
 10477 3508 9847     		blx	r3	@ parson_malloc.186_10
 10478              	.LVL40:
 10479 350a F860     		str	r0, [r7, #12]	@, buf
1710:parson.c      ****     if (buf == NULL) {
 10480              		.loc 2 1710 0
 10481 350c FB68     		ldr	r3, [r7, #12]	@ tmp117, buf
 10482 350e 002B     		cmp	r3, #0	@ tmp117,
 10483 3510 01D1     		bne	.L660	@,
1711:parson.c      ****         return NULL;
 10484              		.loc 2 1711 0
 10485 3512 0023     		movs	r3, #0	@ _1,
 10486 3514 0FE0     		b	.L659	@
 10487              	.L660:
1712:parson.c      ****     }
1713:parson.c      ****     serialization_result = json_serialize_to_buffer_pretty(value, buf, buf_size_bytes);
 10488              		.loc 2 1713 0
 10489 3516 3A69     		ldr	r2, [r7, #16]	@, buf_size_bytes
 10490 3518 F968     		ldr	r1, [r7, #12]	@, buf
 10491 351a 7868     		ldr	r0, [r7, #4]	@, value
 10492 351c FFF7FEFF 		bl	json_serialize_to_buffer_pretty	@
 10493 3520 7861     		str	r0, [r7, #20]	@, serialization_result
1714:parson.c      ****     if (serialization_result == JSONFailure) {
 10494              		.loc 2 1714 0
 10495 3522 7B69     		ldr	r3, [r7, #20]	@ tmp118, serialization_result
 10496 3524 B3F1FF3F 		cmp	r3, #-1	@ tmp118,
 10497 3528 04D1     		bne	.L661	@,
1715:parson.c      ****         json_free_serialized_string(buf);
 10498              		.loc 2 1715 0
 10499 352a F868     		ldr	r0, [r7, #12]	@, buf
 10500 352c FFF7FEFF 		bl	json_free_serialized_string	@
1716:parson.c      ****         return NULL;
 10501              		.loc 2 1716 0
 10502 3530 0023     		movs	r3, #0	@ _1,
 10503 3532 00E0     		b	.L659	@
 10504              	.L661:
1717:parson.c      ****     }
1718:parson.c      ****     return buf;
 10505              		.loc 2 1718 0
 10506 3534 FB68     		ldr	r3, [r7, #12]	@ _1, buf
 10507              	.L659:
1719:parson.c      **** }
 10508              		.loc 2 1719 0
 10509 3536 1846     		mov	r0, r3	@, <retval>
 10510 3538 1837     		adds	r7, r7, #24	@,,
 10511              	.LCFI453:
 10512              		.cfi_def_cfa_offset 8
 10513 353a BD46     		mov	sp, r7	@,
 10514              	.LCFI454:
 10515              		.cfi_def_cfa_register 13
 10516              		@ sp needed	@
 10517 353c 80BD     		pop	{r7, pc}	@
 10518              		.cfi_endproc
 10519              	.LFE105:
 10521              		.align	1
 10522              		.global	json_free_serialized_string
 10523              		.syntax unified
 10524              		.thumb
 10525              		.thumb_func
 10526              		.fpu neon
 10528              	json_free_serialized_string:
 10529              	.LFB106:
1720:parson.c      **** 
1721:parson.c      **** void json_free_serialized_string(char *string)
1722:parson.c      **** {
 10530              		.loc 2 1722 0
 10531              		.cfi_startproc
 10532              		@ args = 0, pretend = 0, frame = 8
 10533              		@ frame_needed = 1, uses_anonymous_args = 0
 10534 353e 80B5     		push	{r7, lr}	@
 10535              	.LCFI455:
 10536              		.cfi_def_cfa_offset 8
 10537              		.cfi_offset 7, -8
 10538              		.cfi_offset 14, -4
 10539 3540 82B0     		sub	sp, sp, #8	@,,
 10540              	.LCFI456:
 10541              		.cfi_def_cfa_offset 16
 10542 3542 00AF     		add	r7, sp, #0	@,,
 10543              	.LCFI457:
 10544              		.cfi_def_cfa_register 7
 10545 3544 7860     		str	r0, [r7, #4]	@ string, string
1723:parson.c      ****     parson_free(string);
 10546              		.loc 2 1723 0
 10547 3546 40F20003 		movw	r3, #:lower16:parson_free	@ tmp111,
 10548 354a C0F20003 		movt	r3, #:upper16:parson_free	@ tmp111,
 10549 354e 1B68     		ldr	r3, [r3]	@ parson_free.187_2, parson_free
 10550 3550 7868     		ldr	r0, [r7, #4]	@, string
 10551 3552 9847     		blx	r3	@ parson_free.187_2
 10552              	.LVL41:
1724:parson.c      **** }
 10553              		.loc 2 1724 0
 10554 3554 00BF     		nop
 10555 3556 0837     		adds	r7, r7, #8	@,,
 10556              	.LCFI458:
 10557              		.cfi_def_cfa_offset 8
 10558 3558 BD46     		mov	sp, r7	@,
 10559              	.LCFI459:
 10560              		.cfi_def_cfa_register 13
 10561              		@ sp needed	@
 10562 355a 80BD     		pop	{r7, pc}	@
 10563              		.cfi_endproc
 10564              	.LFE106:
 10566              		.align	1
 10567              		.global	json_array_remove
 10568              		.syntax unified
 10569              		.thumb
 10570              		.thumb_func
 10571              		.fpu neon
 10573              	json_array_remove:
 10574              	.LFB107:
1725:parson.c      **** 
1726:parson.c      **** JSON_Status json_array_remove(JSON_Array *array, size_t ix)
1727:parson.c      **** {
 10575              		.loc 2 1727 0
 10576              		.cfi_startproc
 10577              		@ args = 0, pretend = 0, frame = 16
 10578              		@ frame_needed = 1, uses_anonymous_args = 0
 10579 355c 80B5     		push	{r7, lr}	@
 10580              	.LCFI460:
 10581              		.cfi_def_cfa_offset 8
 10582              		.cfi_offset 7, -8
 10583              		.cfi_offset 14, -4
 10584 355e 84B0     		sub	sp, sp, #16	@,,
 10585              	.LCFI461:
 10586              		.cfi_def_cfa_offset 24
 10587 3560 00AF     		add	r7, sp, #0	@,,
 10588              	.LCFI462:
 10589              		.cfi_def_cfa_register 7
 10590 3562 7860     		str	r0, [r7, #4]	@ array, array
 10591 3564 3960     		str	r1, [r7]	@ ix, ix
1728:parson.c      ****     size_t to_move_bytes = 0;
 10592              		.loc 2 1728 0
 10593 3566 0023     		movs	r3, #0	@ tmp126,
 10594 3568 FB60     		str	r3, [r7, #12]	@ tmp126, to_move_bytes
1729:parson.c      ****     if (array == NULL || ix >= json_array_get_count(array)) {
 10595              		.loc 2 1729 0
 10596 356a 7B68     		ldr	r3, [r7, #4]	@ tmp127, array
 10597 356c 002B     		cmp	r3, #0	@ tmp127,
 10598 356e 06D0     		beq	.L664	@,
 10599              		.loc 2 1729 0 is_stmt 0 discriminator 1
 10600 3570 7868     		ldr	r0, [r7, #4]	@, array
 10601 3572 FFF7FEFF 		bl	json_array_get_count	@
 10602 3576 0246     		mov	r2, r0	@ _8,
 10603 3578 3B68     		ldr	r3, [r7]	@ tmp128, ix
 10604 357a 9A42     		cmp	r2, r3	@ _8, tmp128
 10605 357c 02D8     		bhi	.L665	@,
 10606              	.L664:
1730:parson.c      ****         return JSONFailure;
 10607              		.loc 2 1730 0 is_stmt 1
 10608 357e 4FF0FF33 		mov	r3, #-1	@ _1,
 10609 3582 27E0     		b	.L666	@
 10610              	.L665:
1731:parson.c      ****     }
1732:parson.c      ****     json_value_free(json_array_get_value(array, ix));
 10611              		.loc 2 1732 0
 10612 3584 3968     		ldr	r1, [r7]	@, ix
 10613 3586 7868     		ldr	r0, [r7, #4]	@, array
 10614 3588 FFF7FEFF 		bl	json_array_get_value	@
 10615 358c 0346     		mov	r3, r0	@ _11,
 10616 358e 1846     		mov	r0, r3	@, _11
 10617 3590 FFF7FEFF 		bl	json_value_free	@
1733:parson.c      ****     to_move_bytes = (json_array_get_count(array) - 1 - ix) * sizeof(JSON_Value *);
 10618              		.loc 2 1733 0
 10619 3594 7868     		ldr	r0, [r7, #4]	@, array
 10620 3596 FFF7FEFF 		bl	json_array_get_count	@
 10621 359a 0246     		mov	r2, r0	@ _14,
 10622 359c 3B68     		ldr	r3, [r7]	@ tmp129, ix
 10623 359e D31A     		subs	r3, r2, r3	@ _15, _14, tmp129
 10624 35a0 03F18043 		add	r3, r3, #1073741824	@ _16, _15,
 10625 35a4 013B     		subs	r3, r3, #1	@ _16, _16,
 10626 35a6 9B00     		lsls	r3, r3, #2	@ tmp130, _16,
 10627 35a8 FB60     		str	r3, [r7, #12]	@ tmp130, to_move_bytes
1734:parson.c      ****     memmove(array->items + ix, array->items + ix + 1, to_move_bytes);
 10628              		.loc 2 1734 0
 10629 35aa 7B68     		ldr	r3, [r7, #4]	@ tmp131, array
 10630 35ac 5A68     		ldr	r2, [r3, #4]	@ _18, array_5(D)->items
 10631 35ae 3B68     		ldr	r3, [r7]	@ tmp132, ix
 10632 35b0 9B00     		lsls	r3, r3, #2	@ _19, tmp132,
 10633 35b2 D018     		adds	r0, r2, r3	@ _20, _18, _19
 10634 35b4 7B68     		ldr	r3, [r7, #4]	@ tmp133, array
 10635 35b6 5A68     		ldr	r2, [r3, #4]	@ _21, array_5(D)->items
 10636 35b8 3B68     		ldr	r3, [r7]	@ tmp134, ix
 10637 35ba 0133     		adds	r3, r3, #1	@ _22, tmp134,
 10638 35bc 9B00     		lsls	r3, r3, #2	@ _23, _22,
 10639 35be 1344     		add	r3, r3, r2	@ _24, _21
 10640 35c0 FA68     		ldr	r2, [r7, #12]	@, to_move_bytes
 10641 35c2 1946     		mov	r1, r3	@, _24
 10642 35c4 FFF7FEFF 		bl	memmove	@
1735:parson.c      ****     array->count -= 1;
 10643              		.loc 2 1735 0
 10644 35c8 7B68     		ldr	r3, [r7, #4]	@ tmp135, array
 10645 35ca 9B68     		ldr	r3, [r3, #8]	@ _26, array_5(D)->count
 10646 35cc 5A1E     		subs	r2, r3, #1	@ _27, _26,
 10647 35ce 7B68     		ldr	r3, [r7, #4]	@ tmp136, array
 10648 35d0 9A60     		str	r2, [r3, #8]	@ _27, array_5(D)->count
1736:parson.c      ****     return JSONSuccess;
 10649              		.loc 2 1736 0
 10650 35d2 0023     		movs	r3, #0	@ _1,
 10651              	.L666:
1737:parson.c      **** }
 10652              		.loc 2 1737 0
 10653 35d4 1846     		mov	r0, r3	@, <retval>
 10654 35d6 1037     		adds	r7, r7, #16	@,,
 10655              	.LCFI463:
 10656              		.cfi_def_cfa_offset 8
 10657 35d8 BD46     		mov	sp, r7	@,
 10658              	.LCFI464:
 10659              		.cfi_def_cfa_register 13
 10660              		@ sp needed	@
 10661 35da 80BD     		pop	{r7, pc}	@
 10662              		.cfi_endproc
 10663              	.LFE107:
 10665              		.align	1
 10666              		.global	json_array_replace_value
 10667              		.syntax unified
 10668              		.thumb
 10669              		.thumb_func
 10670              		.fpu neon
 10672              	json_array_replace_value:
 10673              	.LFB108:
1738:parson.c      **** 
1739:parson.c      **** JSON_Status json_array_replace_value(JSON_Array *array, size_t ix, JSON_Value *value)
1740:parson.c      **** {
 10674              		.loc 2 1740 0
 10675              		.cfi_startproc
 10676              		@ args = 0, pretend = 0, frame = 16
 10677              		@ frame_needed = 1, uses_anonymous_args = 0
 10678 35dc 80B5     		push	{r7, lr}	@
 10679              	.LCFI465:
 10680              		.cfi_def_cfa_offset 8
 10681              		.cfi_offset 7, -8
 10682              		.cfi_offset 14, -4
 10683 35de 84B0     		sub	sp, sp, #16	@,,
 10684              	.LCFI466:
 10685              		.cfi_def_cfa_offset 24
 10686 35e0 00AF     		add	r7, sp, #0	@,,
 10687              	.LCFI467:
 10688              		.cfi_def_cfa_register 7
 10689 35e2 F860     		str	r0, [r7, #12]	@ array, array
 10690 35e4 B960     		str	r1, [r7, #8]	@ ix, ix
 10691 35e6 7A60     		str	r2, [r7, #4]	@ value, value
1741:parson.c      ****     if (array == NULL || value == NULL || value->parent != NULL ||
 10692              		.loc 2 1741 0
 10693 35e8 FB68     		ldr	r3, [r7, #12]	@ tmp119, array
 10694 35ea 002B     		cmp	r3, #0	@ tmp119,
 10695 35ec 0DD0     		beq	.L668	@,
 10696              		.loc 2 1741 0 is_stmt 0 discriminator 1
 10697 35ee 7B68     		ldr	r3, [r7, #4]	@ tmp120, value
 10698 35f0 002B     		cmp	r3, #0	@ tmp120,
 10699 35f2 0AD0     		beq	.L668	@,
 10700              		.loc 2 1741 0 discriminator 2
 10701 35f4 7B68     		ldr	r3, [r7, #4]	@ tmp121, value
 10702 35f6 1B68     		ldr	r3, [r3]	@ _7, value_6(D)->parent
 10703 35f8 002B     		cmp	r3, #0	@ _7,
 10704 35fa 06D1     		bne	.L668	@,
1742:parson.c      ****         ix >= json_array_get_count(array)) {
 10705              		.loc 2 1742 0 is_stmt 1 discriminator 3
 10706 35fc F868     		ldr	r0, [r7, #12]	@, array
 10707 35fe FFF7FEFF 		bl	json_array_get_count	@
 10708 3602 0246     		mov	r2, r0	@ _9,
1741:parson.c      ****     if (array == NULL || value == NULL || value->parent != NULL ||
 10709              		.loc 2 1741 0 discriminator 3
 10710 3604 BB68     		ldr	r3, [r7, #8]	@ tmp122, ix
 10711 3606 9A42     		cmp	r2, r3	@ _9, tmp122
 10712 3608 02D8     		bhi	.L669	@,
 10713              	.L668:
1743:parson.c      ****         return JSONFailure;
 10714              		.loc 2 1743 0
 10715 360a 4FF0FF33 		mov	r3, #-1	@ _1,
 10716 360e 15E0     		b	.L670	@
 10717              	.L669:
1744:parson.c      ****     }
1745:parson.c      ****     json_value_free(json_array_get_value(array, ix));
 10718              		.loc 2 1745 0
 10719 3610 B968     		ldr	r1, [r7, #8]	@, ix
 10720 3612 F868     		ldr	r0, [r7, #12]	@, array
 10721 3614 FFF7FEFF 		bl	json_array_get_value	@
 10722 3618 0346     		mov	r3, r0	@ _12,
 10723 361a 1846     		mov	r0, r3	@, _12
 10724 361c FFF7FEFF 		bl	json_value_free	@
1746:parson.c      ****     value->parent = json_array_get_wrapping_value(array);
 10725              		.loc 2 1746 0
 10726 3620 F868     		ldr	r0, [r7, #12]	@, array
 10727 3622 FFF7FEFF 		bl	json_array_get_wrapping_value	@
 10728 3626 0246     		mov	r2, r0	@ _15,
 10729 3628 7B68     		ldr	r3, [r7, #4]	@ tmp123, value
 10730 362a 1A60     		str	r2, [r3]	@ _15, value_6(D)->parent
1747:parson.c      ****     array->items[ix] = value;
 10731              		.loc 2 1747 0
 10732 362c FB68     		ldr	r3, [r7, #12]	@ tmp124, array
 10733 362e 5A68     		ldr	r2, [r3, #4]	@ _17, array_4(D)->items
 10734 3630 BB68     		ldr	r3, [r7, #8]	@ tmp125, ix
 10735 3632 9B00     		lsls	r3, r3, #2	@ _18, tmp125,
 10736 3634 1344     		add	r3, r3, r2	@ _19, _17
 10737 3636 7A68     		ldr	r2, [r7, #4]	@ tmp126, value
 10738 3638 1A60     		str	r2, [r3]	@ tmp126, *_19
1748:parson.c      ****     return JSONSuccess;
 10739              		.loc 2 1748 0
 10740 363a 0023     		movs	r3, #0	@ _1,
 10741              	.L670:
1749:parson.c      **** }
 10742              		.loc 2 1749 0
 10743 363c 1846     		mov	r0, r3	@, <retval>
 10744 363e 1037     		adds	r7, r7, #16	@,,
 10745              	.LCFI468:
 10746              		.cfi_def_cfa_offset 8
 10747 3640 BD46     		mov	sp, r7	@,
 10748              	.LCFI469:
 10749              		.cfi_def_cfa_register 13
 10750              		@ sp needed	@
 10751 3642 80BD     		pop	{r7, pc}	@
 10752              		.cfi_endproc
 10753              	.LFE108:
 10755              		.align	1
 10756              		.global	json_array_replace_string
 10757              		.syntax unified
 10758              		.thumb
 10759              		.thumb_func
 10760              		.fpu neon
 10762              	json_array_replace_string:
 10763              	.LFB109:
1750:parson.c      **** 
1751:parson.c      **** JSON_Status json_array_replace_string(JSON_Array *array, size_t i, const char *string)
1752:parson.c      **** {
 10764              		.loc 2 1752 0
 10765              		.cfi_startproc
 10766              		@ args = 0, pretend = 0, frame = 24
 10767              		@ frame_needed = 1, uses_anonymous_args = 0
 10768 3644 80B5     		push	{r7, lr}	@
 10769              	.LCFI470:
 10770              		.cfi_def_cfa_offset 8
 10771              		.cfi_offset 7, -8
 10772              		.cfi_offset 14, -4
 10773 3646 86B0     		sub	sp, sp, #24	@,,
 10774              	.LCFI471:
 10775              		.cfi_def_cfa_offset 32
 10776 3648 00AF     		add	r7, sp, #0	@,,
 10777              	.LCFI472:
 10778              		.cfi_def_cfa_register 7
 10779 364a F860     		str	r0, [r7, #12]	@ array, array
 10780 364c B960     		str	r1, [r7, #8]	@ i, i
 10781 364e 7A60     		str	r2, [r7, #4]	@ string, string
1753:parson.c      ****     JSON_Value *value = json_value_init_string(string);
 10782              		.loc 2 1753 0
 10783 3650 7868     		ldr	r0, [r7, #4]	@, string
 10784 3652 FFF7FEFF 		bl	json_value_init_string	@
 10785 3656 7861     		str	r0, [r7, #20]	@, value
1754:parson.c      ****     if (value == NULL) {
 10786              		.loc 2 1754 0
 10787 3658 7B69     		ldr	r3, [r7, #20]	@ tmp113, value
 10788 365a 002B     		cmp	r3, #0	@ tmp113,
 10789 365c 02D1     		bne	.L672	@,
1755:parson.c      ****         return JSONFailure;
 10790              		.loc 2 1755 0
 10791 365e 4FF0FF33 		mov	r3, #-1	@ _1,
 10792 3662 0FE0     		b	.L673	@
 10793              	.L672:
1756:parson.c      ****     }
1757:parson.c      ****     if (json_array_replace_value(array, i, value) == JSONFailure) {
 10794              		.loc 2 1757 0
 10795 3664 7A69     		ldr	r2, [r7, #20]	@, value
 10796 3666 B968     		ldr	r1, [r7, #8]	@, i
 10797 3668 F868     		ldr	r0, [r7, #12]	@, array
 10798 366a FFF7FEFF 		bl	json_array_replace_value	@
 10799 366e 0346     		mov	r3, r0	@ _11,
 10800 3670 B3F1FF3F 		cmp	r3, #-1	@ _11,
 10801 3674 05D1     		bne	.L674	@,
1758:parson.c      ****         json_value_free(value);
 10802              		.loc 2 1758 0
 10803 3676 7869     		ldr	r0, [r7, #20]	@, value
 10804 3678 FFF7FEFF 		bl	json_value_free	@
1759:parson.c      ****         return JSONFailure;
 10805              		.loc 2 1759 0
 10806 367c 4FF0FF33 		mov	r3, #-1	@ _1,
 10807 3680 00E0     		b	.L673	@
 10808              	.L674:
1760:parson.c      ****     }
1761:parson.c      ****     return JSONSuccess;
 10809              		.loc 2 1761 0
 10810 3682 0023     		movs	r3, #0	@ _1,
 10811              	.L673:
1762:parson.c      **** }
 10812              		.loc 2 1762 0
 10813 3684 1846     		mov	r0, r3	@, <retval>
 10814 3686 1837     		adds	r7, r7, #24	@,,
 10815              	.LCFI473:
 10816              		.cfi_def_cfa_offset 8
 10817 3688 BD46     		mov	sp, r7	@,
 10818              	.LCFI474:
 10819              		.cfi_def_cfa_register 13
 10820              		@ sp needed	@
 10821 368a 80BD     		pop	{r7, pc}	@
 10822              		.cfi_endproc
 10823              	.LFE109:
 10825              		.align	1
 10826              		.global	json_array_replace_number
 10827              		.syntax unified
 10828              		.thumb
 10829              		.thumb_func
 10830              		.fpu neon
 10832              	json_array_replace_number:
 10833              	.LFB110:
1763:parson.c      **** 
1764:parson.c      **** JSON_Status json_array_replace_number(JSON_Array *array, size_t i, double number)
1765:parson.c      **** {
 10834              		.loc 2 1765 0
 10835              		.cfi_startproc
 10836              		@ args = 0, pretend = 0, frame = 24
 10837              		@ frame_needed = 1, uses_anonymous_args = 0
 10838 368c 80B5     		push	{r7, lr}	@
 10839              	.LCFI475:
 10840              		.cfi_def_cfa_offset 8
 10841              		.cfi_offset 7, -8
 10842              		.cfi_offset 14, -4
 10843 368e 86B0     		sub	sp, sp, #24	@,,
 10844              	.LCFI476:
 10845              		.cfi_def_cfa_offset 32
 10846 3690 00AF     		add	r7, sp, #0	@,,
 10847              	.LCFI477:
 10848              		.cfi_def_cfa_register 7
 10849 3692 F860     		str	r0, [r7, #12]	@ array, array
 10850 3694 B960     		str	r1, [r7, #8]	@ i, i
 10851 3696 87ED000B 		vstr.64	d0, [r7]	@ number, number
1766:parson.c      ****     JSON_Value *value = json_value_init_number(number);
 10852              		.loc 2 1766 0
 10853 369a 97ED000B 		vldr.64	d0, [r7]	@, number
 10854 369e FFF7FEFF 		bl	json_value_init_number	@
 10855 36a2 7861     		str	r0, [r7, #20]	@, value
1767:parson.c      ****     if (value == NULL) {
 10856              		.loc 2 1767 0
 10857 36a4 7B69     		ldr	r3, [r7, #20]	@ tmp113, value
 10858 36a6 002B     		cmp	r3, #0	@ tmp113,
 10859 36a8 02D1     		bne	.L676	@,
1768:parson.c      ****         return JSONFailure;
 10860              		.loc 2 1768 0
 10861 36aa 4FF0FF33 		mov	r3, #-1	@ _1,
 10862 36ae 0FE0     		b	.L677	@
 10863              	.L676:
1769:parson.c      ****     }
1770:parson.c      ****     if (json_array_replace_value(array, i, value) == JSONFailure) {
 10864              		.loc 2 1770 0
 10865 36b0 7A69     		ldr	r2, [r7, #20]	@, value
 10866 36b2 B968     		ldr	r1, [r7, #8]	@, i
 10867 36b4 F868     		ldr	r0, [r7, #12]	@, array
 10868 36b6 FFF7FEFF 		bl	json_array_replace_value	@
 10869 36ba 0346     		mov	r3, r0	@ _11,
 10870 36bc B3F1FF3F 		cmp	r3, #-1	@ _11,
 10871 36c0 05D1     		bne	.L678	@,
1771:parson.c      ****         json_value_free(value);
 10872              		.loc 2 1771 0
 10873 36c2 7869     		ldr	r0, [r7, #20]	@, value
 10874 36c4 FFF7FEFF 		bl	json_value_free	@
1772:parson.c      ****         return JSONFailure;
 10875              		.loc 2 1772 0
 10876 36c8 4FF0FF33 		mov	r3, #-1	@ _1,
 10877 36cc 00E0     		b	.L677	@
 10878              	.L678:
1773:parson.c      ****     }
1774:parson.c      ****     return JSONSuccess;
 10879              		.loc 2 1774 0
 10880 36ce 0023     		movs	r3, #0	@ _1,
 10881              	.L677:
1775:parson.c      **** }
 10882              		.loc 2 1775 0
 10883 36d0 1846     		mov	r0, r3	@, <retval>
 10884 36d2 1837     		adds	r7, r7, #24	@,,
 10885              	.LCFI478:
 10886              		.cfi_def_cfa_offset 8
 10887 36d4 BD46     		mov	sp, r7	@,
 10888              	.LCFI479:
 10889              		.cfi_def_cfa_register 13
 10890              		@ sp needed	@
 10891 36d6 80BD     		pop	{r7, pc}	@
 10892              		.cfi_endproc
 10893              	.LFE110:
 10895              		.align	1
 10896              		.global	json_array_replace_boolean
 10897              		.syntax unified
 10898              		.thumb
 10899              		.thumb_func
 10900              		.fpu neon
 10902              	json_array_replace_boolean:
 10903              	.LFB111:
1776:parson.c      **** 
1777:parson.c      **** JSON_Status json_array_replace_boolean(JSON_Array *array, size_t i, int boolean)
1778:parson.c      **** {
 10904              		.loc 2 1778 0
 10905              		.cfi_startproc
 10906              		@ args = 0, pretend = 0, frame = 24
 10907              		@ frame_needed = 1, uses_anonymous_args = 0
 10908 36d8 80B5     		push	{r7, lr}	@
 10909              	.LCFI480:
 10910              		.cfi_def_cfa_offset 8
 10911              		.cfi_offset 7, -8
 10912              		.cfi_offset 14, -4
 10913 36da 86B0     		sub	sp, sp, #24	@,,
 10914              	.LCFI481:
 10915              		.cfi_def_cfa_offset 32
 10916 36dc 00AF     		add	r7, sp, #0	@,,
 10917              	.LCFI482:
 10918              		.cfi_def_cfa_register 7
 10919 36de F860     		str	r0, [r7, #12]	@ array, array
 10920 36e0 B960     		str	r1, [r7, #8]	@ i, i
 10921 36e2 7A60     		str	r2, [r7, #4]	@ boolean, boolean
1779:parson.c      ****     JSON_Value *value = json_value_init_boolean(boolean);
 10922              		.loc 2 1779 0
 10923 36e4 7868     		ldr	r0, [r7, #4]	@, boolean
 10924 36e6 FFF7FEFF 		bl	json_value_init_boolean	@
 10925 36ea 7861     		str	r0, [r7, #20]	@, value
1780:parson.c      ****     if (value == NULL) {
 10926              		.loc 2 1780 0
 10927 36ec 7B69     		ldr	r3, [r7, #20]	@ tmp113, value
 10928 36ee 002B     		cmp	r3, #0	@ tmp113,
 10929 36f0 02D1     		bne	.L680	@,
1781:parson.c      ****         return JSONFailure;
 10930              		.loc 2 1781 0
 10931 36f2 4FF0FF33 		mov	r3, #-1	@ _1,
 10932 36f6 0FE0     		b	.L681	@
 10933              	.L680:
1782:parson.c      ****     }
1783:parson.c      ****     if (json_array_replace_value(array, i, value) == JSONFailure) {
 10934              		.loc 2 1783 0
 10935 36f8 7A69     		ldr	r2, [r7, #20]	@, value
 10936 36fa B968     		ldr	r1, [r7, #8]	@, i
 10937 36fc F868     		ldr	r0, [r7, #12]	@, array
 10938 36fe FFF7FEFF 		bl	json_array_replace_value	@
 10939 3702 0346     		mov	r3, r0	@ _11,
 10940 3704 B3F1FF3F 		cmp	r3, #-1	@ _11,
 10941 3708 05D1     		bne	.L682	@,
1784:parson.c      ****         json_value_free(value);
 10942              		.loc 2 1784 0
 10943 370a 7869     		ldr	r0, [r7, #20]	@, value
 10944 370c FFF7FEFF 		bl	json_value_free	@
1785:parson.c      ****         return JSONFailure;
 10945              		.loc 2 1785 0
 10946 3710 4FF0FF33 		mov	r3, #-1	@ _1,
 10947 3714 00E0     		b	.L681	@
 10948              	.L682:
1786:parson.c      ****     }
1787:parson.c      ****     return JSONSuccess;
 10949              		.loc 2 1787 0
 10950 3716 0023     		movs	r3, #0	@ _1,
 10951              	.L681:
1788:parson.c      **** }
 10952              		.loc 2 1788 0
 10953 3718 1846     		mov	r0, r3	@, <retval>
 10954 371a 1837     		adds	r7, r7, #24	@,,
 10955              	.LCFI483:
 10956              		.cfi_def_cfa_offset 8
 10957 371c BD46     		mov	sp, r7	@,
 10958              	.LCFI484:
 10959              		.cfi_def_cfa_register 13
 10960              		@ sp needed	@
 10961 371e 80BD     		pop	{r7, pc}	@
 10962              		.cfi_endproc
 10963              	.LFE111:
 10965              		.align	1
 10966              		.global	json_array_replace_null
 10967              		.syntax unified
 10968              		.thumb
 10969              		.thumb_func
 10970              		.fpu neon
 10972              	json_array_replace_null:
 10973              	.LFB112:
1789:parson.c      **** 
1790:parson.c      **** JSON_Status json_array_replace_null(JSON_Array *array, size_t i)
1791:parson.c      **** {
 10974              		.loc 2 1791 0
 10975              		.cfi_startproc
 10976              		@ args = 0, pretend = 0, frame = 16
 10977              		@ frame_needed = 1, uses_anonymous_args = 0
 10978 3720 80B5     		push	{r7, lr}	@
 10979              	.LCFI485:
 10980              		.cfi_def_cfa_offset 8
 10981              		.cfi_offset 7, -8
 10982              		.cfi_offset 14, -4
 10983 3722 84B0     		sub	sp, sp, #16	@,,
 10984              	.LCFI486:
 10985              		.cfi_def_cfa_offset 24
 10986 3724 00AF     		add	r7, sp, #0	@,,
 10987              	.LCFI487:
 10988              		.cfi_def_cfa_register 7
 10989 3726 7860     		str	r0, [r7, #4]	@ array, array
 10990 3728 3960     		str	r1, [r7]	@ i, i
1792:parson.c      ****     JSON_Value *value = json_value_init_null();
 10991              		.loc 2 1792 0
 10992 372a FFF7FEFF 		bl	json_value_init_null	@
 10993 372e F860     		str	r0, [r7, #12]	@, value
1793:parson.c      ****     if (value == NULL) {
 10994              		.loc 2 1793 0
 10995 3730 FB68     		ldr	r3, [r7, #12]	@ tmp113, value
 10996 3732 002B     		cmp	r3, #0	@ tmp113,
 10997 3734 02D1     		bne	.L684	@,
1794:parson.c      ****         return JSONFailure;
 10998              		.loc 2 1794 0
 10999 3736 4FF0FF33 		mov	r3, #-1	@ _1,
 11000 373a 0FE0     		b	.L685	@
 11001              	.L684:
1795:parson.c      ****     }
1796:parson.c      ****     if (json_array_replace_value(array, i, value) == JSONFailure) {
 11002              		.loc 2 1796 0
 11003 373c FA68     		ldr	r2, [r7, #12]	@, value
 11004 373e 3968     		ldr	r1, [r7]	@, i
 11005 3740 7868     		ldr	r0, [r7, #4]	@, array
 11006 3742 FFF7FEFF 		bl	json_array_replace_value	@
 11007 3746 0346     		mov	r3, r0	@ _10,
 11008 3748 B3F1FF3F 		cmp	r3, #-1	@ _10,
 11009 374c 05D1     		bne	.L686	@,
1797:parson.c      ****         json_value_free(value);
 11010              		.loc 2 1797 0
 11011 374e F868     		ldr	r0, [r7, #12]	@, value
 11012 3750 FFF7FEFF 		bl	json_value_free	@
1798:parson.c      ****         return JSONFailure;
 11013              		.loc 2 1798 0
 11014 3754 4FF0FF33 		mov	r3, #-1	@ _1,
 11015 3758 00E0     		b	.L685	@
 11016              	.L686:
1799:parson.c      ****     }
1800:parson.c      ****     return JSONSuccess;
 11017              		.loc 2 1800 0
 11018 375a 0023     		movs	r3, #0	@ _1,
 11019              	.L685:
1801:parson.c      **** }
 11020              		.loc 2 1801 0
 11021 375c 1846     		mov	r0, r3	@, <retval>
 11022 375e 1037     		adds	r7, r7, #16	@,,
 11023              	.LCFI488:
 11024              		.cfi_def_cfa_offset 8
 11025 3760 BD46     		mov	sp, r7	@,
 11026              	.LCFI489:
 11027              		.cfi_def_cfa_register 13
 11028              		@ sp needed	@
 11029 3762 80BD     		pop	{r7, pc}	@
 11030              		.cfi_endproc
 11031              	.LFE112:
 11033              		.align	1
 11034              		.global	json_array_clear
 11035              		.syntax unified
 11036              		.thumb
 11037              		.thumb_func
 11038              		.fpu neon
 11040              	json_array_clear:
 11041              	.LFB113:
1802:parson.c      **** 
1803:parson.c      **** JSON_Status json_array_clear(JSON_Array *array)
1804:parson.c      **** {
 11042              		.loc 2 1804 0
 11043              		.cfi_startproc
 11044              		@ args = 0, pretend = 0, frame = 16
 11045              		@ frame_needed = 1, uses_anonymous_args = 0
 11046 3764 80B5     		push	{r7, lr}	@
 11047              	.LCFI490:
 11048              		.cfi_def_cfa_offset 8
 11049              		.cfi_offset 7, -8
 11050              		.cfi_offset 14, -4
 11051 3766 84B0     		sub	sp, sp, #16	@,,
 11052              	.LCFI491:
 11053              		.cfi_def_cfa_offset 24
 11054 3768 00AF     		add	r7, sp, #0	@,,
 11055              	.LCFI492:
 11056              		.cfi_def_cfa_register 7
 11057 376a 7860     		str	r0, [r7, #4]	@ array, array
1805:parson.c      ****     size_t i = 0;
 11058              		.loc 2 1805 0
 11059 376c 0023     		movs	r3, #0	@ tmp114,
 11060 376e FB60     		str	r3, [r7, #12]	@ tmp114, i
1806:parson.c      ****     if (array == NULL) {
 11061              		.loc 2 1806 0
 11062 3770 7B68     		ldr	r3, [r7, #4]	@ tmp115, array
 11063 3772 002B     		cmp	r3, #0	@ tmp115,
 11064 3774 02D1     		bne	.L688	@,
1807:parson.c      ****         return JSONFailure;
 11065              		.loc 2 1807 0
 11066 3776 4FF0FF33 		mov	r3, #-1	@ _2,
 11067 377a 18E0     		b	.L689	@
 11068              	.L688:
1808:parson.c      ****     }
1809:parson.c      ****     for (i = 0; i < json_array_get_count(array); i++) {
 11069              		.loc 2 1809 0
 11070 377c 0023     		movs	r3, #0	@ tmp116,
 11071 377e FB60     		str	r3, [r7, #12]	@ tmp116, i
 11072 3780 0AE0     		b	.L690	@
 11073              	.L691:
1810:parson.c      ****         json_value_free(json_array_get_value(array, i));
 11074              		.loc 2 1810 0 discriminator 3
 11075 3782 F968     		ldr	r1, [r7, #12]	@, i
 11076 3784 7868     		ldr	r0, [r7, #4]	@, array
 11077 3786 FFF7FEFF 		bl	json_array_get_value	@
 11078 378a 0346     		mov	r3, r0	@ _13,
 11079 378c 1846     		mov	r0, r3	@, _13
 11080 378e FFF7FEFF 		bl	json_value_free	@
1809:parson.c      ****         json_value_free(json_array_get_value(array, i));
 11081              		.loc 2 1809 0 discriminator 3
 11082 3792 FB68     		ldr	r3, [r7, #12]	@ tmp118, i
 11083 3794 0133     		adds	r3, r3, #1	@ tmp117, tmp118,
 11084 3796 FB60     		str	r3, [r7, #12]	@ tmp117, i
 11085              	.L690:
1809:parson.c      ****         json_value_free(json_array_get_value(array, i));
 11086              		.loc 2 1809 0 is_stmt 0 discriminator 1
 11087 3798 7868     		ldr	r0, [r7, #4]	@, array
 11088 379a FFF7FEFF 		bl	json_array_get_count	@
 11089 379e 0246     		mov	r2, r0	@ _11,
 11090 37a0 FB68     		ldr	r3, [r7, #12]	@ tmp119, i
 11091 37a2 9A42     		cmp	r2, r3	@ _11, tmp119
 11092 37a4 EDD8     		bhi	.L691	@,
1811:parson.c      ****     }
1812:parson.c      ****     array->count = 0;
 11093              		.loc 2 1812 0 is_stmt 1
 11094 37a6 7B68     		ldr	r3, [r7, #4]	@ tmp120, array
 11095 37a8 0022     		movs	r2, #0	@ tmp121,
 11096 37aa 9A60     		str	r2, [r3, #8]	@ tmp121, array_6(D)->count
1813:parson.c      ****     return JSONSuccess;
 11097              		.loc 2 1813 0
 11098 37ac 0023     		movs	r3, #0	@ _2,
 11099              	.L689:
1814:parson.c      **** }
 11100              		.loc 2 1814 0
 11101 37ae 1846     		mov	r0, r3	@, <retval>
 11102 37b0 1037     		adds	r7, r7, #16	@,,
 11103              	.LCFI493:
 11104              		.cfi_def_cfa_offset 8
 11105 37b2 BD46     		mov	sp, r7	@,
 11106              	.LCFI494:
 11107              		.cfi_def_cfa_register 13
 11108              		@ sp needed	@
 11109 37b4 80BD     		pop	{r7, pc}	@
 11110              		.cfi_endproc
 11111              	.LFE113:
 11113              		.align	1
 11114              		.global	json_array_append_value
 11115              		.syntax unified
 11116              		.thumb
 11117              		.thumb_func
 11118              		.fpu neon
 11120              	json_array_append_value:
 11121              	.LFB114:
1815:parson.c      **** 
1816:parson.c      **** JSON_Status json_array_append_value(JSON_Array *array, JSON_Value *value)
1817:parson.c      **** {
 11122              		.loc 2 1817 0
 11123              		.cfi_startproc
 11124              		@ args = 0, pretend = 0, frame = 8
 11125              		@ frame_needed = 1, uses_anonymous_args = 0
 11126 37b6 80B5     		push	{r7, lr}	@
 11127              	.LCFI495:
 11128              		.cfi_def_cfa_offset 8
 11129              		.cfi_offset 7, -8
 11130              		.cfi_offset 14, -4
 11131 37b8 82B0     		sub	sp, sp, #8	@,,
 11132              	.LCFI496:
 11133              		.cfi_def_cfa_offset 16
 11134 37ba 00AF     		add	r7, sp, #0	@,,
 11135              	.LCFI497:
 11136              		.cfi_def_cfa_register 7
 11137 37bc 7860     		str	r0, [r7, #4]	@ array, array
 11138 37be 3960     		str	r1, [r7]	@ value, value
1818:parson.c      ****     if (array == NULL || value == NULL || value->parent != NULL) {
 11139              		.loc 2 1818 0
 11140 37c0 7B68     		ldr	r3, [r7, #4]	@ tmp113, array
 11141 37c2 002B     		cmp	r3, #0	@ tmp113,
 11142 37c4 06D0     		beq	.L693	@,
 11143              		.loc 2 1818 0 is_stmt 0 discriminator 1
 11144 37c6 3B68     		ldr	r3, [r7]	@ tmp114, value
 11145 37c8 002B     		cmp	r3, #0	@ tmp114,
 11146 37ca 03D0     		beq	.L693	@,
 11147              		.loc 2 1818 0 discriminator 2
 11148 37cc 3B68     		ldr	r3, [r7]	@ tmp115, value
 11149 37ce 1B68     		ldr	r3, [r3]	@ _6, value_4(D)->parent
 11150 37d0 002B     		cmp	r3, #0	@ _6,
 11151 37d2 02D0     		beq	.L694	@,
 11152              	.L693:
1819:parson.c      ****         return JSONFailure;
 11153              		.loc 2 1819 0 is_stmt 1
 11154 37d4 4FF0FF33 		mov	r3, #-1	@ _1,
 11155 37d8 04E0     		b	.L695	@
 11156              	.L694:
1820:parson.c      ****     }
1821:parson.c      ****     return json_array_add(array, value);
 11157              		.loc 2 1821 0
 11158 37da 3968     		ldr	r1, [r7]	@, value
 11159 37dc 7868     		ldr	r0, [r7, #4]	@, array
 11160 37de FDF740F9 		bl	json_array_add	@
 11161 37e2 0346     		mov	r3, r0	@ _1,
 11162              	.L695:
1822:parson.c      **** }
 11163              		.loc 2 1822 0
 11164 37e4 1846     		mov	r0, r3	@, <retval>
 11165 37e6 0837     		adds	r7, r7, #8	@,,
 11166              	.LCFI498:
 11167              		.cfi_def_cfa_offset 8
 11168 37e8 BD46     		mov	sp, r7	@,
 11169              	.LCFI499:
 11170              		.cfi_def_cfa_register 13
 11171              		@ sp needed	@
 11172 37ea 80BD     		pop	{r7, pc}	@
 11173              		.cfi_endproc
 11174              	.LFE114:
 11176              		.align	1
 11177              		.global	json_array_append_string
 11178              		.syntax unified
 11179              		.thumb
 11180              		.thumb_func
 11181              		.fpu neon
 11183              	json_array_append_string:
 11184              	.LFB115:
1823:parson.c      **** 
1824:parson.c      **** JSON_Status json_array_append_string(JSON_Array *array, const char *string)
1825:parson.c      **** {
 11185              		.loc 2 1825 0
 11186              		.cfi_startproc
 11187              		@ args = 0, pretend = 0, frame = 16
 11188              		@ frame_needed = 1, uses_anonymous_args = 0
 11189 37ec 80B5     		push	{r7, lr}	@
 11190              	.LCFI500:
 11191              		.cfi_def_cfa_offset 8
 11192              		.cfi_offset 7, -8
 11193              		.cfi_offset 14, -4
 11194 37ee 84B0     		sub	sp, sp, #16	@,,
 11195              	.LCFI501:
 11196              		.cfi_def_cfa_offset 24
 11197 37f0 00AF     		add	r7, sp, #0	@,,
 11198              	.LCFI502:
 11199              		.cfi_def_cfa_register 7
 11200 37f2 7860     		str	r0, [r7, #4]	@ array, array
 11201 37f4 3960     		str	r1, [r7]	@ string, string
1826:parson.c      ****     JSON_Value *value = json_value_init_string(string);
 11202              		.loc 2 1826 0
 11203 37f6 3868     		ldr	r0, [r7]	@, string
 11204 37f8 FFF7FEFF 		bl	json_value_init_string	@
 11205 37fc F860     		str	r0, [r7, #12]	@, value
1827:parson.c      ****     if (value == NULL) {
 11206              		.loc 2 1827 0
 11207 37fe FB68     		ldr	r3, [r7, #12]	@ tmp113, value
 11208 3800 002B     		cmp	r3, #0	@ tmp113,
 11209 3802 02D1     		bne	.L697	@,
1828:parson.c      ****         return JSONFailure;
 11210              		.loc 2 1828 0
 11211 3804 4FF0FF33 		mov	r3, #-1	@ _1,
 11212 3808 0EE0     		b	.L698	@
 11213              	.L697:
1829:parson.c      ****     }
1830:parson.c      ****     if (json_array_append_value(array, value) == JSONFailure) {
 11214              		.loc 2 1830 0
 11215 380a F968     		ldr	r1, [r7, #12]	@, value
 11216 380c 7868     		ldr	r0, [r7, #4]	@, array
 11217 380e FFF7FEFF 		bl	json_array_append_value	@
 11218 3812 0346     		mov	r3, r0	@ _10,
 11219 3814 B3F1FF3F 		cmp	r3, #-1	@ _10,
 11220 3818 05D1     		bne	.L699	@,
1831:parson.c      ****         json_value_free(value);
 11221              		.loc 2 1831 0
 11222 381a F868     		ldr	r0, [r7, #12]	@, value
 11223 381c FFF7FEFF 		bl	json_value_free	@
1832:parson.c      ****         return JSONFailure;
 11224              		.loc 2 1832 0
 11225 3820 4FF0FF33 		mov	r3, #-1	@ _1,
 11226 3824 00E0     		b	.L698	@
 11227              	.L699:
1833:parson.c      ****     }
1834:parson.c      ****     return JSONSuccess;
 11228              		.loc 2 1834 0
 11229 3826 0023     		movs	r3, #0	@ _1,
 11230              	.L698:
1835:parson.c      **** }
 11231              		.loc 2 1835 0
 11232 3828 1846     		mov	r0, r3	@, <retval>
 11233 382a 1037     		adds	r7, r7, #16	@,,
 11234              	.LCFI503:
 11235              		.cfi_def_cfa_offset 8
 11236 382c BD46     		mov	sp, r7	@,
 11237              	.LCFI504:
 11238              		.cfi_def_cfa_register 13
 11239              		@ sp needed	@
 11240 382e 80BD     		pop	{r7, pc}	@
 11241              		.cfi_endproc
 11242              	.LFE115:
 11244              		.align	1
 11245              		.global	json_array_append_number
 11246              		.syntax unified
 11247              		.thumb
 11248              		.thumb_func
 11249              		.fpu neon
 11251              	json_array_append_number:
 11252              	.LFB116:
1836:parson.c      **** 
1837:parson.c      **** JSON_Status json_array_append_number(JSON_Array *array, double number)
1838:parson.c      **** {
 11253              		.loc 2 1838 0
 11254              		.cfi_startproc
 11255              		@ args = 0, pretend = 0, frame = 24
 11256              		@ frame_needed = 1, uses_anonymous_args = 0
 11257 3830 80B5     		push	{r7, lr}	@
 11258              	.LCFI505:
 11259              		.cfi_def_cfa_offset 8
 11260              		.cfi_offset 7, -8
 11261              		.cfi_offset 14, -4
 11262 3832 86B0     		sub	sp, sp, #24	@,,
 11263              	.LCFI506:
 11264              		.cfi_def_cfa_offset 32
 11265 3834 00AF     		add	r7, sp, #0	@,,
 11266              	.LCFI507:
 11267              		.cfi_def_cfa_register 7
 11268 3836 F860     		str	r0, [r7, #12]	@ array, array
 11269 3838 87ED000B 		vstr.64	d0, [r7]	@ number, number
1839:parson.c      ****     JSON_Value *value = json_value_init_number(number);
 11270              		.loc 2 1839 0
 11271 383c 97ED000B 		vldr.64	d0, [r7]	@, number
 11272 3840 FFF7FEFF 		bl	json_value_init_number	@
 11273 3844 7861     		str	r0, [r7, #20]	@, value
1840:parson.c      ****     if (value == NULL) {
 11274              		.loc 2 1840 0
 11275 3846 7B69     		ldr	r3, [r7, #20]	@ tmp113, value
 11276 3848 002B     		cmp	r3, #0	@ tmp113,
 11277 384a 02D1     		bne	.L701	@,
1841:parson.c      ****         return JSONFailure;
 11278              		.loc 2 1841 0
 11279 384c 4FF0FF33 		mov	r3, #-1	@ _1,
 11280 3850 0EE0     		b	.L702	@
 11281              	.L701:
1842:parson.c      ****     }
1843:parson.c      ****     if (json_array_append_value(array, value) == JSONFailure) {
 11282              		.loc 2 1843 0
 11283 3852 7969     		ldr	r1, [r7, #20]	@, value
 11284 3854 F868     		ldr	r0, [r7, #12]	@, array
 11285 3856 FFF7FEFF 		bl	json_array_append_value	@
 11286 385a 0346     		mov	r3, r0	@ _10,
 11287 385c B3F1FF3F 		cmp	r3, #-1	@ _10,
 11288 3860 05D1     		bne	.L703	@,
1844:parson.c      ****         json_value_free(value);
 11289              		.loc 2 1844 0
 11290 3862 7869     		ldr	r0, [r7, #20]	@, value
 11291 3864 FFF7FEFF 		bl	json_value_free	@
1845:parson.c      ****         return JSONFailure;
 11292              		.loc 2 1845 0
 11293 3868 4FF0FF33 		mov	r3, #-1	@ _1,
 11294 386c 00E0     		b	.L702	@
 11295              	.L703:
1846:parson.c      ****     }
1847:parson.c      ****     return JSONSuccess;
 11296              		.loc 2 1847 0
 11297 386e 0023     		movs	r3, #0	@ _1,
 11298              	.L702:
1848:parson.c      **** }
 11299              		.loc 2 1848 0
 11300 3870 1846     		mov	r0, r3	@, <retval>
 11301 3872 1837     		adds	r7, r7, #24	@,,
 11302              	.LCFI508:
 11303              		.cfi_def_cfa_offset 8
 11304 3874 BD46     		mov	sp, r7	@,
 11305              	.LCFI509:
 11306              		.cfi_def_cfa_register 13
 11307              		@ sp needed	@
 11308 3876 80BD     		pop	{r7, pc}	@
 11309              		.cfi_endproc
 11310              	.LFE116:
 11312              		.align	1
 11313              		.global	json_array_append_boolean
 11314              		.syntax unified
 11315              		.thumb
 11316              		.thumb_func
 11317              		.fpu neon
 11319              	json_array_append_boolean:
 11320              	.LFB117:
1849:parson.c      **** 
1850:parson.c      **** JSON_Status json_array_append_boolean(JSON_Array *array, int boolean)
1851:parson.c      **** {
 11321              		.loc 2 1851 0
 11322              		.cfi_startproc
 11323              		@ args = 0, pretend = 0, frame = 16
 11324              		@ frame_needed = 1, uses_anonymous_args = 0
 11325 3878 80B5     		push	{r7, lr}	@
 11326              	.LCFI510:
 11327              		.cfi_def_cfa_offset 8
 11328              		.cfi_offset 7, -8
 11329              		.cfi_offset 14, -4
 11330 387a 84B0     		sub	sp, sp, #16	@,,
 11331              	.LCFI511:
 11332              		.cfi_def_cfa_offset 24
 11333 387c 00AF     		add	r7, sp, #0	@,,
 11334              	.LCFI512:
 11335              		.cfi_def_cfa_register 7
 11336 387e 7860     		str	r0, [r7, #4]	@ array, array
 11337 3880 3960     		str	r1, [r7]	@ boolean, boolean
1852:parson.c      ****     JSON_Value *value = json_value_init_boolean(boolean);
 11338              		.loc 2 1852 0
 11339 3882 3868     		ldr	r0, [r7]	@, boolean
 11340 3884 FFF7FEFF 		bl	json_value_init_boolean	@
 11341 3888 F860     		str	r0, [r7, #12]	@, value
1853:parson.c      ****     if (value == NULL) {
 11342              		.loc 2 1853 0
 11343 388a FB68     		ldr	r3, [r7, #12]	@ tmp113, value
 11344 388c 002B     		cmp	r3, #0	@ tmp113,
 11345 388e 02D1     		bne	.L705	@,
1854:parson.c      ****         return JSONFailure;
 11346              		.loc 2 1854 0
 11347 3890 4FF0FF33 		mov	r3, #-1	@ _1,
 11348 3894 0EE0     		b	.L706	@
 11349              	.L705:
1855:parson.c      ****     }
1856:parson.c      ****     if (json_array_append_value(array, value) == JSONFailure) {
 11350              		.loc 2 1856 0
 11351 3896 F968     		ldr	r1, [r7, #12]	@, value
 11352 3898 7868     		ldr	r0, [r7, #4]	@, array
 11353 389a FFF7FEFF 		bl	json_array_append_value	@
 11354 389e 0346     		mov	r3, r0	@ _10,
 11355 38a0 B3F1FF3F 		cmp	r3, #-1	@ _10,
 11356 38a4 05D1     		bne	.L707	@,
1857:parson.c      ****         json_value_free(value);
 11357              		.loc 2 1857 0
 11358 38a6 F868     		ldr	r0, [r7, #12]	@, value
 11359 38a8 FFF7FEFF 		bl	json_value_free	@
1858:parson.c      ****         return JSONFailure;
 11360              		.loc 2 1858 0
 11361 38ac 4FF0FF33 		mov	r3, #-1	@ _1,
 11362 38b0 00E0     		b	.L706	@
 11363              	.L707:
1859:parson.c      ****     }
1860:parson.c      ****     return JSONSuccess;
 11364              		.loc 2 1860 0
 11365 38b2 0023     		movs	r3, #0	@ _1,
 11366              	.L706:
1861:parson.c      **** }
 11367              		.loc 2 1861 0
 11368 38b4 1846     		mov	r0, r3	@, <retval>
 11369 38b6 1037     		adds	r7, r7, #16	@,,
 11370              	.LCFI513:
 11371              		.cfi_def_cfa_offset 8
 11372 38b8 BD46     		mov	sp, r7	@,
 11373              	.LCFI514:
 11374              		.cfi_def_cfa_register 13
 11375              		@ sp needed	@
 11376 38ba 80BD     		pop	{r7, pc}	@
 11377              		.cfi_endproc
 11378              	.LFE117:
 11380              		.align	1
 11381              		.global	json_array_append_null
 11382              		.syntax unified
 11383              		.thumb
 11384              		.thumb_func
 11385              		.fpu neon
 11387              	json_array_append_null:
 11388              	.LFB118:
1862:parson.c      **** 
1863:parson.c      **** JSON_Status json_array_append_null(JSON_Array *array)
1864:parson.c      **** {
 11389              		.loc 2 1864 0
 11390              		.cfi_startproc
 11391              		@ args = 0, pretend = 0, frame = 16
 11392              		@ frame_needed = 1, uses_anonymous_args = 0
 11393 38bc 80B5     		push	{r7, lr}	@
 11394              	.LCFI515:
 11395              		.cfi_def_cfa_offset 8
 11396              		.cfi_offset 7, -8
 11397              		.cfi_offset 14, -4
 11398 38be 84B0     		sub	sp, sp, #16	@,,
 11399              	.LCFI516:
 11400              		.cfi_def_cfa_offset 24
 11401 38c0 00AF     		add	r7, sp, #0	@,,
 11402              	.LCFI517:
 11403              		.cfi_def_cfa_register 7
 11404 38c2 7860     		str	r0, [r7, #4]	@ array, array
1865:parson.c      ****     JSON_Value *value = json_value_init_null();
 11405              		.loc 2 1865 0
 11406 38c4 FFF7FEFF 		bl	json_value_init_null	@
 11407 38c8 F860     		str	r0, [r7, #12]	@, value
1866:parson.c      ****     if (value == NULL) {
 11408              		.loc 2 1866 0
 11409 38ca FB68     		ldr	r3, [r7, #12]	@ tmp113, value
 11410 38cc 002B     		cmp	r3, #0	@ tmp113,
 11411 38ce 02D1     		bne	.L709	@,
1867:parson.c      ****         return JSONFailure;
 11412              		.loc 2 1867 0
 11413 38d0 4FF0FF33 		mov	r3, #-1	@ _1,
 11414 38d4 0EE0     		b	.L710	@
 11415              	.L709:
1868:parson.c      ****     }
1869:parson.c      ****     if (json_array_append_value(array, value) == JSONFailure) {
 11416              		.loc 2 1869 0
 11417 38d6 F968     		ldr	r1, [r7, #12]	@, value
 11418 38d8 7868     		ldr	r0, [r7, #4]	@, array
 11419 38da FFF7FEFF 		bl	json_array_append_value	@
 11420 38de 0346     		mov	r3, r0	@ _9,
 11421 38e0 B3F1FF3F 		cmp	r3, #-1	@ _9,
 11422 38e4 05D1     		bne	.L711	@,
1870:parson.c      ****         json_value_free(value);
 11423              		.loc 2 1870 0
 11424 38e6 F868     		ldr	r0, [r7, #12]	@, value
 11425 38e8 FFF7FEFF 		bl	json_value_free	@
1871:parson.c      ****         return JSONFailure;
 11426              		.loc 2 1871 0
 11427 38ec 4FF0FF33 		mov	r3, #-1	@ _1,
 11428 38f0 00E0     		b	.L710	@
 11429              	.L711:
1872:parson.c      ****     }
1873:parson.c      ****     return JSONSuccess;
 11430              		.loc 2 1873 0
 11431 38f2 0023     		movs	r3, #0	@ _1,
 11432              	.L710:
1874:parson.c      **** }
 11433              		.loc 2 1874 0
 11434 38f4 1846     		mov	r0, r3	@, <retval>
 11435 38f6 1037     		adds	r7, r7, #16	@,,
 11436              	.LCFI518:
 11437              		.cfi_def_cfa_offset 8
 11438 38f8 BD46     		mov	sp, r7	@,
 11439              	.LCFI519:
 11440              		.cfi_def_cfa_register 13
 11441              		@ sp needed	@
 11442 38fa 80BD     		pop	{r7, pc}	@
 11443              		.cfi_endproc
 11444              	.LFE118:
 11446              		.align	1
 11447              		.global	json_object_set_value
 11448              		.syntax unified
 11449              		.thumb
 11450              		.thumb_func
 11451              		.fpu neon
 11453              	json_object_set_value:
 11454              	.LFB119:
1875:parson.c      **** 
1876:parson.c      **** JSON_Status json_object_set_value(JSON_Object *object, const char *name, JSON_Value *value)
1877:parson.c      **** {
 11455              		.loc 2 1877 0
 11456              		.cfi_startproc
 11457              		@ args = 0, pretend = 0, frame = 24
 11458              		@ frame_needed = 1, uses_anonymous_args = 0
 11459 38fc 80B5     		push	{r7, lr}	@
 11460              	.LCFI520:
 11461              		.cfi_def_cfa_offset 8
 11462              		.cfi_offset 7, -8
 11463              		.cfi_offset 14, -4
 11464 38fe 86B0     		sub	sp, sp, #24	@,,
 11465              	.LCFI521:
 11466              		.cfi_def_cfa_offset 32
 11467 3900 00AF     		add	r7, sp, #0	@,,
 11468              	.LCFI522:
 11469              		.cfi_def_cfa_register 7
 11470 3902 F860     		str	r0, [r7, #12]	@ object, object
 11471 3904 B960     		str	r1, [r7, #8]	@ name, name
 11472 3906 7A60     		str	r2, [r7, #4]	@ value, value
1878:parson.c      ****     size_t i = 0;
 11473              		.loc 2 1878 0
 11474 3908 0023     		movs	r3, #0	@ tmp123,
 11475 390a 7B61     		str	r3, [r7, #20]	@ tmp123, i
1879:parson.c      ****     JSON_Value *old_value;
1880:parson.c      ****     if (object == NULL || name == NULL || value == NULL || value->parent != NULL) {
 11476              		.loc 2 1880 0
 11477 390c FB68     		ldr	r3, [r7, #12]	@ tmp124, object
 11478 390e 002B     		cmp	r3, #0	@ tmp124,
 11479 3910 09D0     		beq	.L713	@,
 11480              		.loc 2 1880 0 is_stmt 0 discriminator 1
 11481 3912 BB68     		ldr	r3, [r7, #8]	@ tmp125, name
 11482 3914 002B     		cmp	r3, #0	@ tmp125,
 11483 3916 06D0     		beq	.L713	@,
 11484              		.loc 2 1880 0 discriminator 2
 11485 3918 7B68     		ldr	r3, [r7, #4]	@ tmp126, value
 11486 391a 002B     		cmp	r3, #0	@ tmp126,
 11487 391c 03D0     		beq	.L713	@,
 11488              		.loc 2 1880 0 discriminator 3
 11489 391e 7B68     		ldr	r3, [r7, #4]	@ tmp127, value
 11490 3920 1B68     		ldr	r3, [r3]	@ _11, value_9(D)->parent
 11491 3922 002B     		cmp	r3, #0	@ _11,
 11492 3924 02D0     		beq	.L714	@,
 11493              	.L713:
1881:parson.c      ****         return JSONFailure;
 11494              		.loc 2 1881 0 is_stmt 1
 11495 3926 4FF0FF33 		mov	r3, #-1	@ _2,
 11496 392a 39E0     		b	.L715	@
 11497              	.L714:
1882:parson.c      ****     }
1883:parson.c      ****     old_value = json_object_get_value(object, name);
 11498              		.loc 2 1883 0
 11499 392c B968     		ldr	r1, [r7, #8]	@, name
 11500 392e F868     		ldr	r0, [r7, #12]	@, object
 11501 3930 FFF7FEFF 		bl	json_object_get_value	@
 11502 3934 3861     		str	r0, [r7, #16]	@, old_value
1884:parson.c      ****     if (old_value != NULL) { /* free and overwrite old value */
 11503              		.loc 2 1884 0
 11504 3936 3B69     		ldr	r3, [r7, #16]	@ tmp128, old_value
 11505 3938 002B     		cmp	r3, #0	@ tmp128,
 11506 393a 2BD0     		beq	.L716	@,
1885:parson.c      ****         json_value_free(old_value);
 11507              		.loc 2 1885 0
 11508 393c 3869     		ldr	r0, [r7, #16]	@, old_value
 11509 393e FFF7FEFF 		bl	json_value_free	@
1886:parson.c      ****         for (i = 0; i < json_object_get_count(object); i++) {
 11510              		.loc 2 1886 0
 11511 3942 0023     		movs	r3, #0	@ tmp129,
 11512 3944 7B61     		str	r3, [r7, #20]	@ tmp129, i
 11513 3946 1EE0     		b	.L717	@
 11514              	.L719:
1887:parson.c      ****             if (strcmp(object->names[i], name) == 0) {
 11515              		.loc 2 1887 0
 11516 3948 FB68     		ldr	r3, [r7, #12]	@ tmp130, object
 11517 394a 5A68     		ldr	r2, [r3, #4]	@ _18, object_7(D)->names
 11518 394c 7B69     		ldr	r3, [r7, #20]	@ tmp131, i
 11519 394e 9B00     		lsls	r3, r3, #2	@ _19, tmp131,
 11520 3950 1344     		add	r3, r3, r2	@ _20, _18
 11521 3952 1B68     		ldr	r3, [r3]	@ _21, *_20
 11522 3954 B968     		ldr	r1, [r7, #8]	@, name
 11523 3956 1846     		mov	r0, r3	@, _21
 11524 3958 FFF7FEFF 		bl	strcmp	@
 11525 395c 0346     		mov	r3, r0	@ _22,
 11526 395e 002B     		cmp	r3, #0	@ _22,
 11527 3960 0ED1     		bne	.L718	@,
1888:parson.c      ****                 value->parent = json_object_get_wrapping_value(object);
 11528              		.loc 2 1888 0
 11529 3962 F868     		ldr	r0, [r7, #12]	@, object
 11530 3964 FFF7FEFF 		bl	json_object_get_wrapping_value	@
 11531 3968 0246     		mov	r2, r0	@ _25,
 11532 396a 7B68     		ldr	r3, [r7, #4]	@ tmp132, value
 11533 396c 1A60     		str	r2, [r3]	@ _25, value_9(D)->parent
1889:parson.c      ****                 object->values[i] = value;
 11534              		.loc 2 1889 0
 11535 396e FB68     		ldr	r3, [r7, #12]	@ tmp133, object
 11536 3970 9A68     		ldr	r2, [r3, #8]	@ _27, object_7(D)->values
 11537 3972 7B69     		ldr	r3, [r7, #20]	@ tmp134, i
 11538 3974 9B00     		lsls	r3, r3, #2	@ _28, tmp134,
 11539 3976 1344     		add	r3, r3, r2	@ _29, _27
 11540 3978 7A68     		ldr	r2, [r7, #4]	@ tmp135, value
 11541 397a 1A60     		str	r2, [r3]	@ tmp135, *_29
1890:parson.c      ****                 return JSONSuccess;
 11542              		.loc 2 1890 0
 11543 397c 0023     		movs	r3, #0	@ _2,
 11544 397e 0FE0     		b	.L715	@
 11545              	.L718:
1886:parson.c      ****             if (strcmp(object->names[i], name) == 0) {
 11546              		.loc 2 1886 0 discriminator 2
 11547 3980 7B69     		ldr	r3, [r7, #20]	@ tmp137, i
 11548 3982 0133     		adds	r3, r3, #1	@ tmp136, tmp137,
 11549 3984 7B61     		str	r3, [r7, #20]	@ tmp136, i
 11550              	.L717:
1886:parson.c      ****             if (strcmp(object->names[i], name) == 0) {
 11551              		.loc 2 1886 0 is_stmt 0 discriminator 1
 11552 3986 F868     		ldr	r0, [r7, #12]	@, object
 11553 3988 FFF7FEFF 		bl	json_object_get_count	@
 11554 398c 0246     		mov	r2, r0	@ _17,
 11555 398e 7B69     		ldr	r3, [r7, #20]	@ tmp138, i
 11556 3990 9A42     		cmp	r2, r3	@ _17, tmp138
 11557 3992 D9D8     		bhi	.L719	@,
 11558              	.L716:
1891:parson.c      ****             }
1892:parson.c      ****         }
1893:parson.c      ****     }
1894:parson.c      ****     /* add new key value pair */
1895:parson.c      ****     return json_object_add(object, name, value);
 11559              		.loc 2 1895 0 is_stmt 1
 11560 3994 7A68     		ldr	r2, [r7, #4]	@, value
 11561 3996 B968     		ldr	r1, [r7, #8]	@, name
 11562 3998 F868     		ldr	r0, [r7, #12]	@, object
 11563 399a FCF708FE 		bl	json_object_add	@
 11564 399e 0346     		mov	r3, r0	@ _2,
 11565              	.L715:
1896:parson.c      **** }
 11566              		.loc 2 1896 0
 11567 39a0 1846     		mov	r0, r3	@, <retval>
 11568 39a2 1837     		adds	r7, r7, #24	@,,
 11569              	.LCFI523:
 11570              		.cfi_def_cfa_offset 8
 11571 39a4 BD46     		mov	sp, r7	@,
 11572              	.LCFI524:
 11573              		.cfi_def_cfa_register 13
 11574              		@ sp needed	@
 11575 39a6 80BD     		pop	{r7, pc}	@
 11576              		.cfi_endproc
 11577              	.LFE119:
 11579              		.align	1
 11580              		.global	json_object_set_string
 11581              		.syntax unified
 11582              		.thumb
 11583              		.thumb_func
 11584              		.fpu neon
 11586              	json_object_set_string:
 11587              	.LFB120:
1897:parson.c      **** 
1898:parson.c      **** JSON_Status json_object_set_string(JSON_Object *object, const char *name, const char *string)
1899:parson.c      **** {
 11588              		.loc 2 1899 0
 11589              		.cfi_startproc
 11590              		@ args = 0, pretend = 0, frame = 16
 11591              		@ frame_needed = 1, uses_anonymous_args = 0
 11592 39a8 80B5     		push	{r7, lr}	@
 11593              	.LCFI525:
 11594              		.cfi_def_cfa_offset 8
 11595              		.cfi_offset 7, -8
 11596              		.cfi_offset 14, -4
 11597 39aa 84B0     		sub	sp, sp, #16	@,,
 11598              	.LCFI526:
 11599              		.cfi_def_cfa_offset 24
 11600 39ac 00AF     		add	r7, sp, #0	@,,
 11601              	.LCFI527:
 11602              		.cfi_def_cfa_register 7
 11603 39ae F860     		str	r0, [r7, #12]	@ object, object
 11604 39b0 B960     		str	r1, [r7, #8]	@ name, name
 11605 39b2 7A60     		str	r2, [r7, #4]	@ string, string
1900:parson.c      ****     return json_object_set_value(object, name, json_value_init_string(string));
 11606              		.loc 2 1900 0
 11607 39b4 7868     		ldr	r0, [r7, #4]	@, string
 11608 39b6 FFF7FEFF 		bl	json_value_init_string	@
 11609 39ba 0346     		mov	r3, r0	@ _4,
 11610 39bc 1A46     		mov	r2, r3	@, _4
 11611 39be B968     		ldr	r1, [r7, #8]	@, name
 11612 39c0 F868     		ldr	r0, [r7, #12]	@, object
 11613 39c2 FFF7FEFF 		bl	json_object_set_value	@
 11614 39c6 0346     		mov	r3, r0	@ _8,
1901:parson.c      **** }
 11615              		.loc 2 1901 0
 11616 39c8 1846     		mov	r0, r3	@, <retval>
 11617 39ca 1037     		adds	r7, r7, #16	@,,
 11618              	.LCFI528:
 11619              		.cfi_def_cfa_offset 8
 11620 39cc BD46     		mov	sp, r7	@,
 11621              	.LCFI529:
 11622              		.cfi_def_cfa_register 13
 11623              		@ sp needed	@
 11624 39ce 80BD     		pop	{r7, pc}	@
 11625              		.cfi_endproc
 11626              	.LFE120:
 11628              		.align	1
 11629              		.global	json_object_set_number
 11630              		.syntax unified
 11631              		.thumb
 11632              		.thumb_func
 11633              		.fpu neon
 11635              	json_object_set_number:
 11636              	.LFB121:
1902:parson.c      **** 
1903:parson.c      **** JSON_Status json_object_set_number(JSON_Object *object, const char *name, double number)
1904:parson.c      **** {
 11637              		.loc 2 1904 0
 11638              		.cfi_startproc
 11639              		@ args = 0, pretend = 0, frame = 16
 11640              		@ frame_needed = 1, uses_anonymous_args = 0
 11641 39d0 80B5     		push	{r7, lr}	@
 11642              	.LCFI530:
 11643              		.cfi_def_cfa_offset 8
 11644              		.cfi_offset 7, -8
 11645              		.cfi_offset 14, -4
 11646 39d2 84B0     		sub	sp, sp, #16	@,,
 11647              	.LCFI531:
 11648              		.cfi_def_cfa_offset 24
 11649 39d4 00AF     		add	r7, sp, #0	@,,
 11650              	.LCFI532:
 11651              		.cfi_def_cfa_register 7
 11652 39d6 F860     		str	r0, [r7, #12]	@ object, object
 11653 39d8 B960     		str	r1, [r7, #8]	@ name, name
 11654 39da 87ED000B 		vstr.64	d0, [r7]	@ number, number
1905:parson.c      ****     return json_object_set_value(object, name, json_value_init_number(number));
 11655              		.loc 2 1905 0
 11656 39de 97ED000B 		vldr.64	d0, [r7]	@, number
 11657 39e2 FFF7FEFF 		bl	json_value_init_number	@
 11658 39e6 0346     		mov	r3, r0	@ _4,
 11659 39e8 1A46     		mov	r2, r3	@, _4
 11660 39ea B968     		ldr	r1, [r7, #8]	@, name
 11661 39ec F868     		ldr	r0, [r7, #12]	@, object
 11662 39ee FFF7FEFF 		bl	json_object_set_value	@
 11663 39f2 0346     		mov	r3, r0	@ _8,
1906:parson.c      **** }
 11664              		.loc 2 1906 0
 11665 39f4 1846     		mov	r0, r3	@, <retval>
 11666 39f6 1037     		adds	r7, r7, #16	@,,
 11667              	.LCFI533:
 11668              		.cfi_def_cfa_offset 8
 11669 39f8 BD46     		mov	sp, r7	@,
 11670              	.LCFI534:
 11671              		.cfi_def_cfa_register 13
 11672              		@ sp needed	@
 11673 39fa 80BD     		pop	{r7, pc}	@
 11674              		.cfi_endproc
 11675              	.LFE121:
 11677              		.align	1
 11678              		.global	json_object_set_boolean
 11679              		.syntax unified
 11680              		.thumb
 11681              		.thumb_func
 11682              		.fpu neon
 11684              	json_object_set_boolean:
 11685              	.LFB122:
1907:parson.c      **** 
1908:parson.c      **** JSON_Status json_object_set_boolean(JSON_Object *object, const char *name, int boolean)
1909:parson.c      **** {
 11686              		.loc 2 1909 0
 11687              		.cfi_startproc
 11688              		@ args = 0, pretend = 0, frame = 16
 11689              		@ frame_needed = 1, uses_anonymous_args = 0
 11690 39fc 80B5     		push	{r7, lr}	@
 11691              	.LCFI535:
 11692              		.cfi_def_cfa_offset 8
 11693              		.cfi_offset 7, -8
 11694              		.cfi_offset 14, -4
 11695 39fe 84B0     		sub	sp, sp, #16	@,,
 11696              	.LCFI536:
 11697              		.cfi_def_cfa_offset 24
 11698 3a00 00AF     		add	r7, sp, #0	@,,
 11699              	.LCFI537:
 11700              		.cfi_def_cfa_register 7
 11701 3a02 F860     		str	r0, [r7, #12]	@ object, object
 11702 3a04 B960     		str	r1, [r7, #8]	@ name, name
 11703 3a06 7A60     		str	r2, [r7, #4]	@ boolean, boolean
1910:parson.c      ****     return json_object_set_value(object, name, json_value_init_boolean(boolean));
 11704              		.loc 2 1910 0
 11705 3a08 7868     		ldr	r0, [r7, #4]	@, boolean
 11706 3a0a FFF7FEFF 		bl	json_value_init_boolean	@
 11707 3a0e 0346     		mov	r3, r0	@ _4,
 11708 3a10 1A46     		mov	r2, r3	@, _4
 11709 3a12 B968     		ldr	r1, [r7, #8]	@, name
 11710 3a14 F868     		ldr	r0, [r7, #12]	@, object
 11711 3a16 FFF7FEFF 		bl	json_object_set_value	@
 11712 3a1a 0346     		mov	r3, r0	@ _8,
1911:parson.c      **** }
 11713              		.loc 2 1911 0
 11714 3a1c 1846     		mov	r0, r3	@, <retval>
 11715 3a1e 1037     		adds	r7, r7, #16	@,,
 11716              	.LCFI538:
 11717              		.cfi_def_cfa_offset 8
 11718 3a20 BD46     		mov	sp, r7	@,
 11719              	.LCFI539:
 11720              		.cfi_def_cfa_register 13
 11721              		@ sp needed	@
 11722 3a22 80BD     		pop	{r7, pc}	@
 11723              		.cfi_endproc
 11724              	.LFE122:
 11726              		.align	1
 11727              		.global	json_object_set_null
 11728              		.syntax unified
 11729              		.thumb
 11730              		.thumb_func
 11731              		.fpu neon
 11733              	json_object_set_null:
 11734              	.LFB123:
1912:parson.c      **** 
1913:parson.c      **** JSON_Status json_object_set_null(JSON_Object *object, const char *name)
1914:parson.c      **** {
 11735              		.loc 2 1914 0
 11736              		.cfi_startproc
 11737              		@ args = 0, pretend = 0, frame = 8
 11738              		@ frame_needed = 1, uses_anonymous_args = 0
 11739 3a24 80B5     		push	{r7, lr}	@
 11740              	.LCFI540:
 11741              		.cfi_def_cfa_offset 8
 11742              		.cfi_offset 7, -8
 11743              		.cfi_offset 14, -4
 11744 3a26 82B0     		sub	sp, sp, #8	@,,
 11745              	.LCFI541:
 11746              		.cfi_def_cfa_offset 16
 11747 3a28 00AF     		add	r7, sp, #0	@,,
 11748              	.LCFI542:
 11749              		.cfi_def_cfa_register 7
 11750 3a2a 7860     		str	r0, [r7, #4]	@ object, object
 11751 3a2c 3960     		str	r1, [r7]	@ name, name
1915:parson.c      ****     return json_object_set_value(object, name, json_value_init_null());
 11752              		.loc 2 1915 0
 11753 3a2e FFF7FEFF 		bl	json_value_init_null	@
 11754 3a32 0346     		mov	r3, r0	@ _3,
 11755 3a34 1A46     		mov	r2, r3	@, _3
 11756 3a36 3968     		ldr	r1, [r7]	@, name
 11757 3a38 7868     		ldr	r0, [r7, #4]	@, object
 11758 3a3a FFF7FEFF 		bl	json_object_set_value	@
 11759 3a3e 0346     		mov	r3, r0	@ _7,
1916:parson.c      **** }
 11760              		.loc 2 1916 0
 11761 3a40 1846     		mov	r0, r3	@, <retval>
 11762 3a42 0837     		adds	r7, r7, #8	@,,
 11763              	.LCFI543:
 11764              		.cfi_def_cfa_offset 8
 11765 3a44 BD46     		mov	sp, r7	@,
 11766              	.LCFI544:
 11767              		.cfi_def_cfa_register 13
 11768              		@ sp needed	@
 11769 3a46 80BD     		pop	{r7, pc}	@
 11770              		.cfi_endproc
 11771              	.LFE123:
 11773              		.align	1
 11774              		.global	json_object_dotset_value
 11775              		.syntax unified
 11776              		.thumb
 11777              		.thumb_func
 11778              		.fpu neon
 11780              	json_object_dotset_value:
 11781              	.LFB124:
1917:parson.c      **** 
1918:parson.c      **** JSON_Status json_object_dotset_value(JSON_Object *object, const char *name, JSON_Value *value)
1919:parson.c      **** {
 11782              		.loc 2 1919 0
 11783              		.cfi_startproc
 11784              		@ args = 0, pretend = 0, frame = 48
 11785              		@ frame_needed = 1, uses_anonymous_args = 0
 11786 3a48 80B5     		push	{r7, lr}	@
 11787              	.LCFI545:
 11788              		.cfi_def_cfa_offset 8
 11789              		.cfi_offset 7, -8
 11790              		.cfi_offset 14, -4
 11791 3a4a 8CB0     		sub	sp, sp, #48	@,,
 11792              	.LCFI546:
 11793              		.cfi_def_cfa_offset 56
 11794 3a4c 00AF     		add	r7, sp, #0	@,,
 11795              	.LCFI547:
 11796              		.cfi_def_cfa_register 7
 11797 3a4e F860     		str	r0, [r7, #12]	@ object, object
 11798 3a50 B960     		str	r1, [r7, #8]	@ name, name
 11799 3a52 7A60     		str	r2, [r7, #4]	@ value, value
1920:parson.c      ****     const char *dot_pos = NULL;
 11800              		.loc 2 1920 0
 11801 3a54 0023     		movs	r3, #0	@ tmp119,
 11802 3a56 FB62     		str	r3, [r7, #44]	@ tmp119, dot_pos
1921:parson.c      ****     JSON_Value *temp_value = NULL, *new_value = NULL;
 11803              		.loc 2 1921 0
 11804 3a58 0023     		movs	r3, #0	@ tmp120,
 11805 3a5a BB62     		str	r3, [r7, #40]	@ tmp120, temp_value
 11806 3a5c 0023     		movs	r3, #0	@ tmp121,
 11807 3a5e 7B62     		str	r3, [r7, #36]	@ tmp121, new_value
1922:parson.c      ****     JSON_Object *temp_object = NULL, *new_object = NULL;
 11808              		.loc 2 1922 0
 11809 3a60 0023     		movs	r3, #0	@ tmp122,
 11810 3a62 3B62     		str	r3, [r7, #32]	@ tmp122, temp_object
 11811 3a64 0023     		movs	r3, #0	@ tmp123,
 11812 3a66 FB61     		str	r3, [r7, #28]	@ tmp123, new_object
1923:parson.c      ****     JSON_Status status = JSONFailure;
 11813              		.loc 2 1923 0
 11814 3a68 4FF0FF33 		mov	r3, #-1	@ tmp124,
 11815 3a6c BB61     		str	r3, [r7, #24]	@ tmp124, status
1924:parson.c      ****     size_t name_len = 0;
 11816              		.loc 2 1924 0
 11817 3a6e 0023     		movs	r3, #0	@ tmp125,
 11818 3a70 7B61     		str	r3, [r7, #20]	@ tmp125, name_len
1925:parson.c      ****     if (object == NULL || name == NULL || value == NULL) {
 11819              		.loc 2 1925 0
 11820 3a72 FB68     		ldr	r3, [r7, #12]	@ tmp126, object
 11821 3a74 002B     		cmp	r3, #0	@ tmp126,
 11822 3a76 05D0     		beq	.L729	@,
 11823              		.loc 2 1925 0 is_stmt 0 discriminator 1
 11824 3a78 BB68     		ldr	r3, [r7, #8]	@ tmp127, name
 11825 3a7a 002B     		cmp	r3, #0	@ tmp127,
 11826 3a7c 02D0     		beq	.L729	@,
 11827              		.loc 2 1925 0 discriminator 2
 11828 3a7e 7B68     		ldr	r3, [r7, #4]	@ tmp128, value
 11829 3a80 002B     		cmp	r3, #0	@ tmp128,
 11830 3a82 02D1     		bne	.L730	@,
 11831              	.L729:
1926:parson.c      ****         return JSONFailure;
 11832              		.loc 2 1926 0 is_stmt 1
 11833 3a84 4FF0FF33 		mov	r3, #-1	@ _1,
 11834 3a88 67E0     		b	.L731	@
 11835              	.L730:
1927:parson.c      ****     }
1928:parson.c      ****     dot_pos = strchr(name, '.');
 11836              		.loc 2 1928 0
 11837 3a8a 2E21     		movs	r1, #46	@,
 11838 3a8c B868     		ldr	r0, [r7, #8]	@, name
 11839 3a8e FFF7FEFF 		bl	strchr	@
 11840 3a92 F862     		str	r0, [r7, #44]	@, dot_pos
1929:parson.c      ****     if (dot_pos == NULL) {
 11841              		.loc 2 1929 0
 11842 3a94 FB6A     		ldr	r3, [r7, #44]	@ tmp129, dot_pos
 11843 3a96 002B     		cmp	r3, #0	@ tmp129,
 11844 3a98 06D1     		bne	.L732	@,
1930:parson.c      ****         return json_object_set_value(object, name, value);
 11845              		.loc 2 1930 0
 11846 3a9a 7A68     		ldr	r2, [r7, #4]	@, value
 11847 3a9c B968     		ldr	r1, [r7, #8]	@, name
 11848 3a9e F868     		ldr	r0, [r7, #12]	@, object
 11849 3aa0 FFF7FEFF 		bl	json_object_set_value	@
 11850 3aa4 0346     		mov	r3, r0	@ _1,
 11851 3aa6 58E0     		b	.L731	@
 11852              	.L732:
1931:parson.c      ****     }
1932:parson.c      ****     name_len = (size_t)(dot_pos - name);
 11853              		.loc 2 1932 0
 11854 3aa8 FA6A     		ldr	r2, [r7, #44]	@ dot_pos.188_17, dot_pos
 11855 3aaa BB68     		ldr	r3, [r7, #8]	@ name.189_18, name
 11856 3aac D31A     		subs	r3, r2, r3	@ _19, dot_pos.188_17, name.189_18
 11857 3aae 7B61     		str	r3, [r7, #20]	@ _19, name_len
1933:parson.c      ****     temp_value = json_object_getn_value(object, name, name_len);
 11858              		.loc 2 1933 0
 11859 3ab0 7A69     		ldr	r2, [r7, #20]	@, name_len
 11860 3ab2 B968     		ldr	r1, [r7, #8]	@, name
 11861 3ab4 F868     		ldr	r0, [r7, #12]	@, object
 11862 3ab6 FCF780FE 		bl	json_object_getn_value	@
 11863 3aba B862     		str	r0, [r7, #40]	@, temp_value
1934:parson.c      ****     if (temp_value) {
 11864              		.loc 2 1934 0
 11865 3abc BB6A     		ldr	r3, [r7, #40]	@ tmp130, temp_value
 11866 3abe 002B     		cmp	r3, #0	@ tmp130,
 11867 3ac0 15D0     		beq	.L733	@,
1935:parson.c      ****         /* Don't overwrite existing non-object (unlike json_object_set_value, but it shouldn't be
1936:parson.c      ****          * changed at this point) */
1937:parson.c      ****         if (json_value_get_type(temp_value) != JSONObject) {
 11868              		.loc 2 1937 0
 11869 3ac2 B86A     		ldr	r0, [r7, #40]	@, temp_value
 11870 3ac4 FFF7FEFF 		bl	json_value_get_type	@
 11871 3ac8 0346     		mov	r3, r0	@ _24,
 11872 3aca 042B     		cmp	r3, #4	@ _24,
 11873 3acc 02D0     		beq	.L734	@,
1938:parson.c      ****             return JSONFailure;
 11874              		.loc 2 1938 0
 11875 3ace 4FF0FF33 		mov	r3, #-1	@ _1,
 11876 3ad2 42E0     		b	.L731	@
 11877              	.L734:
1939:parson.c      ****         }
1940:parson.c      ****         temp_object = json_value_get_object(temp_value);
 11878              		.loc 2 1940 0
 11879 3ad4 B86A     		ldr	r0, [r7, #40]	@, temp_value
 11880 3ad6 FFF7FEFF 		bl	json_value_get_object	@
 11881 3ada 3862     		str	r0, [r7, #32]	@, temp_object
1941:parson.c      ****         return json_object_dotset_value(temp_object, dot_pos + 1, value);
 11882              		.loc 2 1941 0
 11883 3adc FB6A     		ldr	r3, [r7, #44]	@ tmp131, dot_pos
 11884 3ade 0133     		adds	r3, r3, #1	@ _28, tmp131,
 11885 3ae0 7A68     		ldr	r2, [r7, #4]	@, value
 11886 3ae2 1946     		mov	r1, r3	@, _28
 11887 3ae4 386A     		ldr	r0, [r7, #32]	@, temp_object
 11888 3ae6 FFF7FEFF 		bl	json_object_dotset_value	@
 11889 3aea 0346     		mov	r3, r0	@ _1,
 11890 3aec 35E0     		b	.L731	@
 11891              	.L733:
1942:parson.c      ****     }
1943:parson.c      ****     new_value = json_value_init_object();
 11892              		.loc 2 1943 0
 11893 3aee FFF7FEFF 		bl	json_value_init_object	@
 11894 3af2 7862     		str	r0, [r7, #36]	@, new_value
1944:parson.c      ****     if (new_value == NULL) {
 11895              		.loc 2 1944 0
 11896 3af4 7B6A     		ldr	r3, [r7, #36]	@ tmp132, new_value
 11897 3af6 002B     		cmp	r3, #0	@ tmp132,
 11898 3af8 02D1     		bne	.L735	@,
1945:parson.c      ****         return JSONFailure;
 11899              		.loc 2 1945 0
 11900 3afa 4FF0FF33 		mov	r3, #-1	@ _1,
 11901 3afe 2CE0     		b	.L731	@
 11902              	.L735:
1946:parson.c      ****     }
1947:parson.c      ****     new_object = json_value_get_object(new_value);
 11903              		.loc 2 1947 0
 11904 3b00 786A     		ldr	r0, [r7, #36]	@, new_value
 11905 3b02 FFF7FEFF 		bl	json_value_get_object	@
 11906 3b06 F861     		str	r0, [r7, #28]	@, new_object
1948:parson.c      ****     status = json_object_dotset_value(new_object, dot_pos + 1, value);
 11907              		.loc 2 1948 0
 11908 3b08 FB6A     		ldr	r3, [r7, #44]	@ tmp133, dot_pos
 11909 3b0a 0133     		adds	r3, r3, #1	@ _36, tmp133,
 11910 3b0c 7A68     		ldr	r2, [r7, #4]	@, value
 11911 3b0e 1946     		mov	r1, r3	@, _36
 11912 3b10 F869     		ldr	r0, [r7, #28]	@, new_object
 11913 3b12 FFF7FEFF 		bl	json_object_dotset_value	@
 11914 3b16 B861     		str	r0, [r7, #24]	@, status
1949:parson.c      ****     if (status != JSONSuccess) {
 11915              		.loc 2 1949 0
 11916 3b18 BB69     		ldr	r3, [r7, #24]	@ tmp134, status
 11917 3b1a 002B     		cmp	r3, #0	@ tmp134,
 11918 3b1c 05D0     		beq	.L736	@,
1950:parson.c      ****         json_value_free(new_value);
 11919              		.loc 2 1950 0
 11920 3b1e 786A     		ldr	r0, [r7, #36]	@, new_value
 11921 3b20 FFF7FEFF 		bl	json_value_free	@
1951:parson.c      ****         return JSONFailure;
 11922              		.loc 2 1951 0
 11923 3b24 4FF0FF33 		mov	r3, #-1	@ _1,
 11924 3b28 17E0     		b	.L731	@
 11925              	.L736:
1952:parson.c      ****     }
1953:parson.c      ****     status = json_object_addn(object, name, name_len, new_value);
 11926              		.loc 2 1953 0
 11927 3b2a 7B6A     		ldr	r3, [r7, #36]	@, new_value
 11928 3b2c 7A69     		ldr	r2, [r7, #20]	@, name_len
 11929 3b2e B968     		ldr	r1, [r7, #8]	@, name
 11930 3b30 F868     		ldr	r0, [r7, #12]	@, object
 11931 3b32 FCF756FD 		bl	json_object_addn	@
 11932 3b36 B861     		str	r0, [r7, #24]	@, status
1954:parson.c      ****     if (status != JSONSuccess) {
 11933              		.loc 2 1954 0
 11934 3b38 BB69     		ldr	r3, [r7, #24]	@ tmp135, status
 11935 3b3a 002B     		cmp	r3, #0	@ tmp135,
 11936 3b3c 0CD0     		beq	.L737	@,
1955:parson.c      ****         json_object_dotremove_internal(new_object, dot_pos + 1, 0);
 11937              		.loc 2 1955 0
 11938 3b3e FB6A     		ldr	r3, [r7, #44]	@ tmp136, dot_pos
 11939 3b40 0133     		adds	r3, r3, #1	@ _43, tmp136,
 11940 3b42 0022     		movs	r2, #0	@,
 11941 3b44 1946     		mov	r1, r3	@, _43
 11942 3b46 F869     		ldr	r0, [r7, #28]	@, new_object
 11943 3b48 FCF7ECFE 		bl	json_object_dotremove_internal	@
1956:parson.c      ****         json_value_free(new_value);
 11944              		.loc 2 1956 0
 11945 3b4c 786A     		ldr	r0, [r7, #36]	@, new_value
 11946 3b4e FFF7FEFF 		bl	json_value_free	@
1957:parson.c      ****         return JSONFailure;
 11947              		.loc 2 1957 0
 11948 3b52 4FF0FF33 		mov	r3, #-1	@ _1,
 11949 3b56 00E0     		b	.L731	@
 11950              	.L737:
1958:parson.c      ****     }
1959:parson.c      ****     return JSONSuccess;
 11951              		.loc 2 1959 0
 11952 3b58 0023     		movs	r3, #0	@ _1,
 11953              	.L731:
1960:parson.c      **** }
 11954              		.loc 2 1960 0
 11955 3b5a 1846     		mov	r0, r3	@, <retval>
 11956 3b5c 3037     		adds	r7, r7, #48	@,,
 11957              	.LCFI548:
 11958              		.cfi_def_cfa_offset 8
 11959 3b5e BD46     		mov	sp, r7	@,
 11960              	.LCFI549:
 11961              		.cfi_def_cfa_register 13
 11962              		@ sp needed	@
 11963 3b60 80BD     		pop	{r7, pc}	@
 11964              		.cfi_endproc
 11965              	.LFE124:
 11967              		.align	1
 11968              		.global	json_object_dotset_string
 11969              		.syntax unified
 11970              		.thumb
 11971              		.thumb_func
 11972              		.fpu neon
 11974              	json_object_dotset_string:
 11975              	.LFB125:
1961:parson.c      **** 
1962:parson.c      **** JSON_Status json_object_dotset_string(JSON_Object *object, const char *name, const char *string)
1963:parson.c      **** {
 11976              		.loc 2 1963 0
 11977              		.cfi_startproc
 11978              		@ args = 0, pretend = 0, frame = 24
 11979              		@ frame_needed = 1, uses_anonymous_args = 0
 11980 3b62 80B5     		push	{r7, lr}	@
 11981              	.LCFI550:
 11982              		.cfi_def_cfa_offset 8
 11983              		.cfi_offset 7, -8
 11984              		.cfi_offset 14, -4
 11985 3b64 86B0     		sub	sp, sp, #24	@,,
 11986              	.LCFI551:
 11987              		.cfi_def_cfa_offset 32
 11988 3b66 00AF     		add	r7, sp, #0	@,,
 11989              	.LCFI552:
 11990              		.cfi_def_cfa_register 7
 11991 3b68 F860     		str	r0, [r7, #12]	@ object, object
 11992 3b6a B960     		str	r1, [r7, #8]	@ name, name
 11993 3b6c 7A60     		str	r2, [r7, #4]	@ string, string
1964:parson.c      ****     JSON_Value *value = json_value_init_string(string);
 11994              		.loc 2 1964 0
 11995 3b6e 7868     		ldr	r0, [r7, #4]	@, string
 11996 3b70 FFF7FEFF 		bl	json_value_init_string	@
 11997 3b74 7861     		str	r0, [r7, #20]	@, value
1965:parson.c      ****     if (value == NULL) {
 11998              		.loc 2 1965 0
 11999 3b76 7B69     		ldr	r3, [r7, #20]	@ tmp113, value
 12000 3b78 002B     		cmp	r3, #0	@ tmp113,
 12001 3b7a 02D1     		bne	.L739	@,
1966:parson.c      ****         return JSONFailure;
 12002              		.loc 2 1966 0
 12003 3b7c 4FF0FF33 		mov	r3, #-1	@ _1,
 12004 3b80 0FE0     		b	.L740	@
 12005              	.L739:
1967:parson.c      ****     }
1968:parson.c      ****     if (json_object_dotset_value(object, name, value) == JSONFailure) {
 12006              		.loc 2 1968 0
 12007 3b82 7A69     		ldr	r2, [r7, #20]	@, value
 12008 3b84 B968     		ldr	r1, [r7, #8]	@, name
 12009 3b86 F868     		ldr	r0, [r7, #12]	@, object
 12010 3b88 FFF7FEFF 		bl	json_object_dotset_value	@
 12011 3b8c 0346     		mov	r3, r0	@ _11,
 12012 3b8e B3F1FF3F 		cmp	r3, #-1	@ _11,
 12013 3b92 05D1     		bne	.L741	@,
1969:parson.c      ****         json_value_free(value);
 12014              		.loc 2 1969 0
 12015 3b94 7869     		ldr	r0, [r7, #20]	@, value
 12016 3b96 FFF7FEFF 		bl	json_value_free	@
1970:parson.c      ****         return JSONFailure;
 12017              		.loc 2 1970 0
 12018 3b9a 4FF0FF33 		mov	r3, #-1	@ _1,
 12019 3b9e 00E0     		b	.L740	@
 12020              	.L741:
1971:parson.c      ****     }
1972:parson.c      ****     return JSONSuccess;
 12021              		.loc 2 1972 0
 12022 3ba0 0023     		movs	r3, #0	@ _1,
 12023              	.L740:
1973:parson.c      **** }
 12024              		.loc 2 1973 0
 12025 3ba2 1846     		mov	r0, r3	@, <retval>
 12026 3ba4 1837     		adds	r7, r7, #24	@,,
 12027              	.LCFI553:
 12028              		.cfi_def_cfa_offset 8
 12029 3ba6 BD46     		mov	sp, r7	@,
 12030              	.LCFI554:
 12031              		.cfi_def_cfa_register 13
 12032              		@ sp needed	@
 12033 3ba8 80BD     		pop	{r7, pc}	@
 12034              		.cfi_endproc
 12035              	.LFE125:
 12037              		.align	1
 12038              		.global	json_object_dotset_number
 12039              		.syntax unified
 12040              		.thumb
 12041              		.thumb_func
 12042              		.fpu neon
 12044              	json_object_dotset_number:
 12045              	.LFB126:
1974:parson.c      **** 
1975:parson.c      **** JSON_Status json_object_dotset_number(JSON_Object *object, const char *name, double number)
1976:parson.c      **** {
 12046              		.loc 2 1976 0
 12047              		.cfi_startproc
 12048              		@ args = 0, pretend = 0, frame = 24
 12049              		@ frame_needed = 1, uses_anonymous_args = 0
 12050 3baa 80B5     		push	{r7, lr}	@
 12051              	.LCFI555:
 12052              		.cfi_def_cfa_offset 8
 12053              		.cfi_offset 7, -8
 12054              		.cfi_offset 14, -4
 12055 3bac 86B0     		sub	sp, sp, #24	@,,
 12056              	.LCFI556:
 12057              		.cfi_def_cfa_offset 32
 12058 3bae 00AF     		add	r7, sp, #0	@,,
 12059              	.LCFI557:
 12060              		.cfi_def_cfa_register 7
 12061 3bb0 F860     		str	r0, [r7, #12]	@ object, object
 12062 3bb2 B960     		str	r1, [r7, #8]	@ name, name
 12063 3bb4 87ED000B 		vstr.64	d0, [r7]	@ number, number
1977:parson.c      ****     JSON_Value *value = json_value_init_number(number);
 12064              		.loc 2 1977 0
 12065 3bb8 97ED000B 		vldr.64	d0, [r7]	@, number
 12066 3bbc FFF7FEFF 		bl	json_value_init_number	@
 12067 3bc0 7861     		str	r0, [r7, #20]	@, value
1978:parson.c      ****     if (value == NULL) {
 12068              		.loc 2 1978 0
 12069 3bc2 7B69     		ldr	r3, [r7, #20]	@ tmp113, value
 12070 3bc4 002B     		cmp	r3, #0	@ tmp113,
 12071 3bc6 02D1     		bne	.L743	@,
1979:parson.c      ****         return JSONFailure;
 12072              		.loc 2 1979 0
 12073 3bc8 4FF0FF33 		mov	r3, #-1	@ _1,
 12074 3bcc 0FE0     		b	.L744	@
 12075              	.L743:
1980:parson.c      ****     }
1981:parson.c      ****     if (json_object_dotset_value(object, name, value) == JSONFailure) {
 12076              		.loc 2 1981 0
 12077 3bce 7A69     		ldr	r2, [r7, #20]	@, value
 12078 3bd0 B968     		ldr	r1, [r7, #8]	@, name
 12079 3bd2 F868     		ldr	r0, [r7, #12]	@, object
 12080 3bd4 FFF7FEFF 		bl	json_object_dotset_value	@
 12081 3bd8 0346     		mov	r3, r0	@ _11,
 12082 3bda B3F1FF3F 		cmp	r3, #-1	@ _11,
 12083 3bde 05D1     		bne	.L745	@,
1982:parson.c      ****         json_value_free(value);
 12084              		.loc 2 1982 0
 12085 3be0 7869     		ldr	r0, [r7, #20]	@, value
 12086 3be2 FFF7FEFF 		bl	json_value_free	@
1983:parson.c      ****         return JSONFailure;
 12087              		.loc 2 1983 0
 12088 3be6 4FF0FF33 		mov	r3, #-1	@ _1,
 12089 3bea 00E0     		b	.L744	@
 12090              	.L745:
1984:parson.c      ****     }
1985:parson.c      ****     return JSONSuccess;
 12091              		.loc 2 1985 0
 12092 3bec 0023     		movs	r3, #0	@ _1,
 12093              	.L744:
1986:parson.c      **** }
 12094              		.loc 2 1986 0
 12095 3bee 1846     		mov	r0, r3	@, <retval>
 12096 3bf0 1837     		adds	r7, r7, #24	@,,
 12097              	.LCFI558:
 12098              		.cfi_def_cfa_offset 8
 12099 3bf2 BD46     		mov	sp, r7	@,
 12100              	.LCFI559:
 12101              		.cfi_def_cfa_register 13
 12102              		@ sp needed	@
 12103 3bf4 80BD     		pop	{r7, pc}	@
 12104              		.cfi_endproc
 12105              	.LFE126:
 12107              		.align	1
 12108              		.global	json_object_dotset_boolean
 12109              		.syntax unified
 12110              		.thumb
 12111              		.thumb_func
 12112              		.fpu neon
 12114              	json_object_dotset_boolean:
 12115              	.LFB127:
1987:parson.c      **** 
1988:parson.c      **** JSON_Status json_object_dotset_boolean(JSON_Object *object, const char *name, int boolean)
1989:parson.c      **** {
 12116              		.loc 2 1989 0
 12117              		.cfi_startproc
 12118              		@ args = 0, pretend = 0, frame = 24
 12119              		@ frame_needed = 1, uses_anonymous_args = 0
 12120 3bf6 80B5     		push	{r7, lr}	@
 12121              	.LCFI560:
 12122              		.cfi_def_cfa_offset 8
 12123              		.cfi_offset 7, -8
 12124              		.cfi_offset 14, -4
 12125 3bf8 86B0     		sub	sp, sp, #24	@,,
 12126              	.LCFI561:
 12127              		.cfi_def_cfa_offset 32
 12128 3bfa 00AF     		add	r7, sp, #0	@,,
 12129              	.LCFI562:
 12130              		.cfi_def_cfa_register 7
 12131 3bfc F860     		str	r0, [r7, #12]	@ object, object
 12132 3bfe B960     		str	r1, [r7, #8]	@ name, name
 12133 3c00 7A60     		str	r2, [r7, #4]	@ boolean, boolean
1990:parson.c      ****     JSON_Value *value = json_value_init_boolean(boolean);
 12134              		.loc 2 1990 0
 12135 3c02 7868     		ldr	r0, [r7, #4]	@, boolean
 12136 3c04 FFF7FEFF 		bl	json_value_init_boolean	@
 12137 3c08 7861     		str	r0, [r7, #20]	@, value
1991:parson.c      ****     if (value == NULL) {
 12138              		.loc 2 1991 0
 12139 3c0a 7B69     		ldr	r3, [r7, #20]	@ tmp113, value
 12140 3c0c 002B     		cmp	r3, #0	@ tmp113,
 12141 3c0e 02D1     		bne	.L747	@,
1992:parson.c      ****         return JSONFailure;
 12142              		.loc 2 1992 0
 12143 3c10 4FF0FF33 		mov	r3, #-1	@ _1,
 12144 3c14 0FE0     		b	.L748	@
 12145              	.L747:
1993:parson.c      ****     }
1994:parson.c      ****     if (json_object_dotset_value(object, name, value) == JSONFailure) {
 12146              		.loc 2 1994 0
 12147 3c16 7A69     		ldr	r2, [r7, #20]	@, value
 12148 3c18 B968     		ldr	r1, [r7, #8]	@, name
 12149 3c1a F868     		ldr	r0, [r7, #12]	@, object
 12150 3c1c FFF7FEFF 		bl	json_object_dotset_value	@
 12151 3c20 0346     		mov	r3, r0	@ _11,
 12152 3c22 B3F1FF3F 		cmp	r3, #-1	@ _11,
 12153 3c26 05D1     		bne	.L749	@,
1995:parson.c      ****         json_value_free(value);
 12154              		.loc 2 1995 0
 12155 3c28 7869     		ldr	r0, [r7, #20]	@, value
 12156 3c2a FFF7FEFF 		bl	json_value_free	@
1996:parson.c      ****         return JSONFailure;
 12157              		.loc 2 1996 0
 12158 3c2e 4FF0FF33 		mov	r3, #-1	@ _1,
 12159 3c32 00E0     		b	.L748	@
 12160              	.L749:
1997:parson.c      ****     }
1998:parson.c      ****     return JSONSuccess;
 12161              		.loc 2 1998 0
 12162 3c34 0023     		movs	r3, #0	@ _1,
 12163              	.L748:
1999:parson.c      **** }
 12164              		.loc 2 1999 0
 12165 3c36 1846     		mov	r0, r3	@, <retval>
 12166 3c38 1837     		adds	r7, r7, #24	@,,
 12167              	.LCFI563:
 12168              		.cfi_def_cfa_offset 8
 12169 3c3a BD46     		mov	sp, r7	@,
 12170              	.LCFI564:
 12171              		.cfi_def_cfa_register 13
 12172              		@ sp needed	@
 12173 3c3c 80BD     		pop	{r7, pc}	@
 12174              		.cfi_endproc
 12175              	.LFE127:
 12177              		.align	1
 12178              		.global	json_object_dotset_null
 12179              		.syntax unified
 12180              		.thumb
 12181              		.thumb_func
 12182              		.fpu neon
 12184              	json_object_dotset_null:
 12185              	.LFB128:
2000:parson.c      **** 
2001:parson.c      **** JSON_Status json_object_dotset_null(JSON_Object *object, const char *name)
2002:parson.c      **** {
 12186              		.loc 2 2002 0
 12187              		.cfi_startproc
 12188              		@ args = 0, pretend = 0, frame = 16
 12189              		@ frame_needed = 1, uses_anonymous_args = 0
 12190 3c3e 80B5     		push	{r7, lr}	@
 12191              	.LCFI565:
 12192              		.cfi_def_cfa_offset 8
 12193              		.cfi_offset 7, -8
 12194              		.cfi_offset 14, -4
 12195 3c40 84B0     		sub	sp, sp, #16	@,,
 12196              	.LCFI566:
 12197              		.cfi_def_cfa_offset 24
 12198 3c42 00AF     		add	r7, sp, #0	@,,
 12199              	.LCFI567:
 12200              		.cfi_def_cfa_register 7
 12201 3c44 7860     		str	r0, [r7, #4]	@ object, object
 12202 3c46 3960     		str	r1, [r7]	@ name, name
2003:parson.c      ****     JSON_Value *value = json_value_init_null();
 12203              		.loc 2 2003 0
 12204 3c48 FFF7FEFF 		bl	json_value_init_null	@
 12205 3c4c F860     		str	r0, [r7, #12]	@, value
2004:parson.c      ****     if (value == NULL) {
 12206              		.loc 2 2004 0
 12207 3c4e FB68     		ldr	r3, [r7, #12]	@ tmp113, value
 12208 3c50 002B     		cmp	r3, #0	@ tmp113,
 12209 3c52 02D1     		bne	.L751	@,
2005:parson.c      ****         return JSONFailure;
 12210              		.loc 2 2005 0
 12211 3c54 4FF0FF33 		mov	r3, #-1	@ _1,
 12212 3c58 0FE0     		b	.L752	@
 12213              	.L751:
2006:parson.c      ****     }
2007:parson.c      ****     if (json_object_dotset_value(object, name, value) == JSONFailure) {
 12214              		.loc 2 2007 0
 12215 3c5a FA68     		ldr	r2, [r7, #12]	@, value
 12216 3c5c 3968     		ldr	r1, [r7]	@, name
 12217 3c5e 7868     		ldr	r0, [r7, #4]	@, object
 12218 3c60 FFF7FEFF 		bl	json_object_dotset_value	@
 12219 3c64 0346     		mov	r3, r0	@ _10,
 12220 3c66 B3F1FF3F 		cmp	r3, #-1	@ _10,
 12221 3c6a 05D1     		bne	.L753	@,
2008:parson.c      ****         json_value_free(value);
 12222              		.loc 2 2008 0
 12223 3c6c F868     		ldr	r0, [r7, #12]	@, value
 12224 3c6e FFF7FEFF 		bl	json_value_free	@
2009:parson.c      ****         return JSONFailure;
 12225              		.loc 2 2009 0
 12226 3c72 4FF0FF33 		mov	r3, #-1	@ _1,
 12227 3c76 00E0     		b	.L752	@
 12228              	.L753:
2010:parson.c      ****     }
2011:parson.c      ****     return JSONSuccess;
 12229              		.loc 2 2011 0
 12230 3c78 0023     		movs	r3, #0	@ _1,
 12231              	.L752:
2012:parson.c      **** }
 12232              		.loc 2 2012 0
 12233 3c7a 1846     		mov	r0, r3	@, <retval>
 12234 3c7c 1037     		adds	r7, r7, #16	@,,
 12235              	.LCFI568:
 12236              		.cfi_def_cfa_offset 8
 12237 3c7e BD46     		mov	sp, r7	@,
 12238              	.LCFI569:
 12239              		.cfi_def_cfa_register 13
 12240              		@ sp needed	@
 12241 3c80 80BD     		pop	{r7, pc}	@
 12242              		.cfi_endproc
 12243              	.LFE128:
 12245              		.align	1
 12246              		.global	json_object_remove
 12247              		.syntax unified
 12248              		.thumb
 12249              		.thumb_func
 12250              		.fpu neon
 12252              	json_object_remove:
 12253              	.LFB129:
2013:parson.c      **** 
2014:parson.c      **** JSON_Status json_object_remove(JSON_Object *object, const char *name)
2015:parson.c      **** {
 12254              		.loc 2 2015 0
 12255              		.cfi_startproc
 12256              		@ args = 0, pretend = 0, frame = 8
 12257              		@ frame_needed = 1, uses_anonymous_args = 0
 12258 3c82 80B5     		push	{r7, lr}	@
 12259              	.LCFI570:
 12260              		.cfi_def_cfa_offset 8
 12261              		.cfi_offset 7, -8
 12262              		.cfi_offset 14, -4
 12263 3c84 82B0     		sub	sp, sp, #8	@,,
 12264              	.LCFI571:
 12265              		.cfi_def_cfa_offset 16
 12266 3c86 00AF     		add	r7, sp, #0	@,,
 12267              	.LCFI572:
 12268              		.cfi_def_cfa_register 7
 12269 3c88 7860     		str	r0, [r7, #4]	@ object, object
 12270 3c8a 3960     		str	r1, [r7]	@ name, name
2016:parson.c      ****     return json_object_remove_internal(object, name, 1);
 12271              		.loc 2 2016 0
 12272 3c8c 0122     		movs	r2, #1	@,
 12273 3c8e 3968     		ldr	r1, [r7]	@, name
 12274 3c90 7868     		ldr	r0, [r7, #4]	@, object
 12275 3c92 FCF7CEFD 		bl	json_object_remove_internal	@
 12276 3c96 0346     		mov	r3, r0	@ _5,
2017:parson.c      **** }
 12277              		.loc 2 2017 0
 12278 3c98 1846     		mov	r0, r3	@, <retval>
 12279 3c9a 0837     		adds	r7, r7, #8	@,,
 12280              	.LCFI573:
 12281              		.cfi_def_cfa_offset 8
 12282 3c9c BD46     		mov	sp, r7	@,
 12283              	.LCFI574:
 12284              		.cfi_def_cfa_register 13
 12285              		@ sp needed	@
 12286 3c9e 80BD     		pop	{r7, pc}	@
 12287              		.cfi_endproc
 12288              	.LFE129:
 12290              		.align	1
 12291              		.global	json_object_dotremove
 12292              		.syntax unified
 12293              		.thumb
 12294              		.thumb_func
 12295              		.fpu neon
 12297              	json_object_dotremove:
 12298              	.LFB130:
2018:parson.c      **** 
2019:parson.c      **** JSON_Status json_object_dotremove(JSON_Object *object, const char *name)
2020:parson.c      **** {
 12299              		.loc 2 2020 0
 12300              		.cfi_startproc
 12301              		@ args = 0, pretend = 0, frame = 8
 12302              		@ frame_needed = 1, uses_anonymous_args = 0
 12303 3ca0 80B5     		push	{r7, lr}	@
 12304              	.LCFI575:
 12305              		.cfi_def_cfa_offset 8
 12306              		.cfi_offset 7, -8
 12307              		.cfi_offset 14, -4
 12308 3ca2 82B0     		sub	sp, sp, #8	@,,
 12309              	.LCFI576:
 12310              		.cfi_def_cfa_offset 16
 12311 3ca4 00AF     		add	r7, sp, #0	@,,
 12312              	.LCFI577:
 12313              		.cfi_def_cfa_register 7
 12314 3ca6 7860     		str	r0, [r7, #4]	@ object, object
 12315 3ca8 3960     		str	r1, [r7]	@ name, name
2021:parson.c      ****     return json_object_dotremove_internal(object, name, 1);
 12316              		.loc 2 2021 0
 12317 3caa 0122     		movs	r2, #1	@,
 12318 3cac 3968     		ldr	r1, [r7]	@, name
 12319 3cae 7868     		ldr	r0, [r7, #4]	@, object
 12320 3cb0 FCF738FE 		bl	json_object_dotremove_internal	@
 12321 3cb4 0346     		mov	r3, r0	@ _5,
2022:parson.c      **** }
 12322              		.loc 2 2022 0
 12323 3cb6 1846     		mov	r0, r3	@, <retval>
 12324 3cb8 0837     		adds	r7, r7, #8	@,,
 12325              	.LCFI578:
 12326              		.cfi_def_cfa_offset 8
 12327 3cba BD46     		mov	sp, r7	@,
 12328              	.LCFI579:
 12329              		.cfi_def_cfa_register 13
 12330              		@ sp needed	@
 12331 3cbc 80BD     		pop	{r7, pc}	@
 12332              		.cfi_endproc
 12333              	.LFE130:
 12335              		.align	1
 12336              		.global	json_object_clear
 12337              		.syntax unified
 12338              		.thumb
 12339              		.thumb_func
 12340              		.fpu neon
 12342              	json_object_clear:
 12343              	.LFB131:
2023:parson.c      **** 
2024:parson.c      **** JSON_Status json_object_clear(JSON_Object *object)
2025:parson.c      **** {
 12344              		.loc 2 2025 0
 12345              		.cfi_startproc
 12346              		@ args = 0, pretend = 0, frame = 16
 12347              		@ frame_needed = 1, uses_anonymous_args = 0
 12348 3cbe 80B5     		push	{r7, lr}	@
 12349              	.LCFI580:
 12350              		.cfi_def_cfa_offset 8
 12351              		.cfi_offset 7, -8
 12352              		.cfi_offset 14, -4
 12353 3cc0 84B0     		sub	sp, sp, #16	@,,
 12354              	.LCFI581:
 12355              		.cfi_def_cfa_offset 24
 12356 3cc2 00AF     		add	r7, sp, #0	@,,
 12357              	.LCFI582:
 12358              		.cfi_def_cfa_register 7
 12359 3cc4 7860     		str	r0, [r7, #4]	@ object, object
2026:parson.c      ****     size_t i = 0;
 12360              		.loc 2 2026 0
 12361 3cc6 0023     		movs	r3, #0	@ tmp122,
 12362 3cc8 FB60     		str	r3, [r7, #12]	@ tmp122, i
2027:parson.c      ****     if (object == NULL) {
 12363              		.loc 2 2027 0
 12364 3cca 7B68     		ldr	r3, [r7, #4]	@ tmp123, object
 12365 3ccc 002B     		cmp	r3, #0	@ tmp123,
 12366 3cce 02D1     		bne	.L759	@,
2028:parson.c      ****         return JSONFailure;
 12367              		.loc 2 2028 0
 12368 3cd0 4FF0FF33 		mov	r3, #-1	@ _2,
 12369 3cd4 26E0     		b	.L760	@
 12370              	.L759:
2029:parson.c      ****     }
2030:parson.c      ****     for (i = 0; i < json_object_get_count(object); i++) {
 12371              		.loc 2 2030 0
 12372 3cd6 0023     		movs	r3, #0	@ tmp124,
 12373 3cd8 FB60     		str	r3, [r7, #12]	@ tmp124, i
 12374 3cda 18E0     		b	.L761	@
 12375              	.L762:
2031:parson.c      ****         parson_free(object->names[i]);
 12376              		.loc 2 2031 0 discriminator 3
 12377 3cdc 40F20003 		movw	r3, #:lower16:parson_free	@ tmp125,
 12378 3ce0 C0F20003 		movt	r3, #:upper16:parson_free	@ tmp125,
 12379 3ce4 1B68     		ldr	r3, [r3]	@ parson_free.190_12, parson_free
 12380 3ce6 7A68     		ldr	r2, [r7, #4]	@ tmp126, object
 12381 3ce8 5168     		ldr	r1, [r2, #4]	@ _13, object_6(D)->names
 12382 3cea FA68     		ldr	r2, [r7, #12]	@ tmp127, i
 12383 3cec 9200     		lsls	r2, r2, #2	@ _14, tmp127,
 12384 3cee 0A44     		add	r2, r2, r1	@ _15, _13
 12385 3cf0 1268     		ldr	r2, [r2]	@ _16, *_15
 12386 3cf2 1046     		mov	r0, r2	@, _16
 12387 3cf4 9847     		blx	r3	@ parson_free.190_12
 12388              	.LVL42:
2032:parson.c      ****         json_value_free(object->values[i]);
 12389              		.loc 2 2032 0 discriminator 3
 12390 3cf6 7B68     		ldr	r3, [r7, #4]	@ tmp128, object
 12391 3cf8 9A68     		ldr	r2, [r3, #8]	@ _18, object_6(D)->values
 12392 3cfa FB68     		ldr	r3, [r7, #12]	@ tmp129, i
 12393 3cfc 9B00     		lsls	r3, r3, #2	@ _19, tmp129,
 12394 3cfe 1344     		add	r3, r3, r2	@ _20, _18
 12395 3d00 1B68     		ldr	r3, [r3]	@ _21, *_20
 12396 3d02 1846     		mov	r0, r3	@, _21
 12397 3d04 FFF7FEFF 		bl	json_value_free	@
2030:parson.c      ****         parson_free(object->names[i]);
 12398              		.loc 2 2030 0 discriminator 3
 12399 3d08 FB68     		ldr	r3, [r7, #12]	@ tmp131, i
 12400 3d0a 0133     		adds	r3, r3, #1	@ tmp130, tmp131,
 12401 3d0c FB60     		str	r3, [r7, #12]	@ tmp130, i
 12402              	.L761:
2030:parson.c      ****         parson_free(object->names[i]);
 12403              		.loc 2 2030 0 is_stmt 0 discriminator 1
 12404 3d0e 7868     		ldr	r0, [r7, #4]	@, object
 12405 3d10 FFF7FEFF 		bl	json_object_get_count	@
 12406 3d14 0246     		mov	r2, r0	@ _11,
 12407 3d16 FB68     		ldr	r3, [r7, #12]	@ tmp132, i
 12408 3d18 9A42     		cmp	r2, r3	@ _11, tmp132
 12409 3d1a DFD8     		bhi	.L762	@,
2033:parson.c      ****     }
2034:parson.c      ****     object->count = 0;
 12410              		.loc 2 2034 0 is_stmt 1
 12411 3d1c 7B68     		ldr	r3, [r7, #4]	@ tmp133, object
 12412 3d1e 0022     		movs	r2, #0	@ tmp134,
 12413 3d20 DA60     		str	r2, [r3, #12]	@ tmp134, object_6(D)->count
2035:parson.c      ****     return JSONSuccess;
 12414              		.loc 2 2035 0
 12415 3d22 0023     		movs	r3, #0	@ _2,
 12416              	.L760:
2036:parson.c      **** }
 12417              		.loc 2 2036 0
 12418 3d24 1846     		mov	r0, r3	@, <retval>
 12419 3d26 1037     		adds	r7, r7, #16	@,,
 12420              	.LCFI583:
 12421              		.cfi_def_cfa_offset 8
 12422 3d28 BD46     		mov	sp, r7	@,
 12423              	.LCFI584:
 12424              		.cfi_def_cfa_register 13
 12425              		@ sp needed	@
 12426 3d2a 80BD     		pop	{r7, pc}	@
 12427              		.cfi_endproc
 12428              	.LFE131:
 12430              		.align	1
 12431              		.global	json_validate
 12432              		.syntax unified
 12433              		.thumb
 12434              		.thumb_func
 12435              		.fpu neon
 12437              	json_validate:
 12438              	.LFB132:
2037:parson.c      **** 
2038:parson.c      **** JSON_Status json_validate(const JSON_Value *schema, const JSON_Value *value)
2039:parson.c      **** {
 12439              		.loc 2 2039 0
 12440              		.cfi_startproc
 12441              		@ args = 0, pretend = 0, frame = 56
 12442              		@ frame_needed = 1, uses_anonymous_args = 0
 12443 3d2c 80B5     		push	{r7, lr}	@
 12444              	.LCFI585:
 12445              		.cfi_def_cfa_offset 8
 12446              		.cfi_offset 7, -8
 12447              		.cfi_offset 14, -4
 12448 3d2e 8EB0     		sub	sp, sp, #56	@,,
 12449              	.LCFI586:
 12450              		.cfi_def_cfa_offset 64
 12451 3d30 00AF     		add	r7, sp, #0	@,,
 12452              	.LCFI587:
 12453              		.cfi_def_cfa_register 7
 12454 3d32 7860     		str	r0, [r7, #4]	@ schema, schema
 12455 3d34 3960     		str	r1, [r7]	@ value, value
2040:parson.c      ****     JSON_Value *temp_schema_value = NULL, *temp_value = NULL;
 12456              		.loc 2 2040 0
 12457 3d36 0023     		movs	r3, #0	@ tmp116,
 12458 3d38 3B63     		str	r3, [r7, #48]	@ tmp116, temp_schema_value
 12459 3d3a 0023     		movs	r3, #0	@ tmp117,
 12460 3d3c FB62     		str	r3, [r7, #44]	@ tmp117, temp_value
2041:parson.c      ****     JSON_Array *schema_array = NULL, *value_array = NULL;
 12461              		.loc 2 2041 0
 12462 3d3e 0023     		movs	r3, #0	@ tmp118,
 12463 3d40 BB62     		str	r3, [r7, #40]	@ tmp118, schema_array
 12464 3d42 0023     		movs	r3, #0	@ tmp119,
 12465 3d44 7B62     		str	r3, [r7, #36]	@ tmp119, value_array
2042:parson.c      ****     JSON_Object *schema_object = NULL, *value_object = NULL;
 12466              		.loc 2 2042 0
 12467 3d46 0023     		movs	r3, #0	@ tmp120,
 12468 3d48 3B62     		str	r3, [r7, #32]	@ tmp120, schema_object
 12469 3d4a 0023     		movs	r3, #0	@ tmp121,
 12470 3d4c FB61     		str	r3, [r7, #28]	@ tmp121, value_object
2043:parson.c      ****     JSON_Value_Type schema_type = JSONError, value_type = JSONError;
 12471              		.loc 2 2043 0
 12472 3d4e 4FF0FF33 		mov	r3, #-1	@ tmp122,
 12473 3d52 BB61     		str	r3, [r7, #24]	@ tmp122, schema_type
 12474 3d54 4FF0FF33 		mov	r3, #-1	@ tmp123,
 12475 3d58 7B61     		str	r3, [r7, #20]	@ tmp123, value_type
2044:parson.c      ****     const char *key = NULL;
 12476              		.loc 2 2044 0
 12477 3d5a 0023     		movs	r3, #0	@ tmp124,
 12478 3d5c 3B61     		str	r3, [r7, #16]	@ tmp124, key
2045:parson.c      ****     size_t i = 0, count = 0;
 12479              		.loc 2 2045 0
 12480 3d5e 0023     		movs	r3, #0	@ tmp125,
 12481 3d60 7B63     		str	r3, [r7, #52]	@ tmp125, i
 12482 3d62 0023     		movs	r3, #0	@ tmp126,
 12483 3d64 FB60     		str	r3, [r7, #12]	@ tmp126, count
2046:parson.c      ****     if (schema == NULL || value == NULL) {
 12484              		.loc 2 2046 0
 12485 3d66 7B68     		ldr	r3, [r7, #4]	@ tmp127, schema
 12486 3d68 002B     		cmp	r3, #0	@ tmp127,
 12487 3d6a 02D0     		beq	.L764	@,
 12488              		.loc 2 2046 0 is_stmt 0 discriminator 1
 12489 3d6c 3B68     		ldr	r3, [r7]	@ tmp128, value
 12490 3d6e 002B     		cmp	r3, #0	@ tmp128,
 12491 3d70 02D1     		bne	.L765	@,
 12492              	.L764:
2047:parson.c      ****         return JSONFailure;
 12493              		.loc 2 2047 0 is_stmt 1
 12494 3d72 4FF0FF33 		mov	r3, #-1	@ _3,
 12495 3d76 A5E0     		b	.L766	@
 12496              	.L765:
2048:parson.c      ****     }
2049:parson.c      ****     schema_type = json_value_get_type(schema);
 12497              		.loc 2 2049 0
 12498 3d78 7868     		ldr	r0, [r7, #4]	@, schema
 12499 3d7a FFF7FEFF 		bl	json_value_get_type	@
 12500 3d7e B861     		str	r0, [r7, #24]	@, schema_type
2050:parson.c      ****     value_type = json_value_get_type(value);
 12501              		.loc 2 2050 0
 12502 3d80 3868     		ldr	r0, [r7]	@, value
 12503 3d82 FFF7FEFF 		bl	json_value_get_type	@
 12504 3d86 7861     		str	r0, [r7, #20]	@, value_type
2051:parson.c      ****     if (schema_type != value_type && schema_type != JSONNull) { /* null represents all values */
 12505              		.loc 2 2051 0
 12506 3d88 BA69     		ldr	r2, [r7, #24]	@ tmp129, schema_type
 12507 3d8a 7B69     		ldr	r3, [r7, #20]	@ tmp130, value_type
 12508 3d8c 9A42     		cmp	r2, r3	@ tmp129, tmp130
 12509 3d8e 05D0     		beq	.L767	@,
 12510              		.loc 2 2051 0 is_stmt 0 discriminator 1
 12511 3d90 BB69     		ldr	r3, [r7, #24]	@ tmp131, schema_type
 12512 3d92 012B     		cmp	r3, #1	@ tmp131,
 12513 3d94 02D0     		beq	.L767	@,
2052:parson.c      ****         return JSONFailure;
 12514              		.loc 2 2052 0 is_stmt 1
 12515 3d96 4FF0FF33 		mov	r3, #-1	@ _3,
 12516 3d9a 93E0     		b	.L766	@
 12517              	.L767:
2053:parson.c      ****     }
2054:parson.c      ****     switch (schema_type) {
 12518              		.loc 2 2054 0
 12519 3d9c BB69     		ldr	r3, [r7, #24]	@ tmp132, schema_type
 12520 3d9e 013B     		subs	r3, r3, #1	@ tmp133, tmp132,
 12521 3da0 052B     		cmp	r3, #5	@ tmp133,
 12522 3da2 00F28D80 		bhi	.L768	@
 12523 3da6 01A2     		adr	r2, .L770	@ tmp148,
 12524 3da8 52F823F0 		ldr	pc, [r2, r3, lsl #2]	@ tmp148, tmp133
 12525              		.p2align 2
 12526              	.L770:
 12527 3dac BD3E0000 		.word	.L769+1
 12528 3db0 BD3E0000 		.word	.L769+1
 12529 3db4 BD3E0000 		.word	.L769+1
 12530 3db8 2F3E0000 		.word	.L771+1
 12531 3dbc C53D0000 		.word	.L772+1
 12532 3dc0 BD3E0000 		.word	.L769+1
 12533              		.p2align 1
 12534              	.L772:
2055:parson.c      ****     case JSONArray:
2056:parson.c      ****         schema_array = json_value_get_array(schema);
 12535              		.loc 2 2056 0
 12536 3dc4 7868     		ldr	r0, [r7, #4]	@, schema
 12537 3dc6 FFF7FEFF 		bl	json_value_get_array	@
 12538 3dca B862     		str	r0, [r7, #40]	@, schema_array
2057:parson.c      ****         value_array = json_value_get_array(value);
 12539              		.loc 2 2057 0
 12540 3dcc 3868     		ldr	r0, [r7]	@, value
 12541 3dce FFF7FEFF 		bl	json_value_get_array	@
 12542 3dd2 7862     		str	r0, [r7, #36]	@, value_array
2058:parson.c      ****         count = json_array_get_count(schema_array);
 12543              		.loc 2 2058 0
 12544 3dd4 B86A     		ldr	r0, [r7, #40]	@, schema_array
 12545 3dd6 FFF7FEFF 		bl	json_array_get_count	@
 12546 3dda F860     		str	r0, [r7, #12]	@, count
2059:parson.c      ****         if (count == 0) {
 12547              		.loc 2 2059 0
 12548 3ddc FB68     		ldr	r3, [r7, #12]	@ tmp134, count
 12549 3dde 002B     		cmp	r3, #0	@ tmp134,
 12550 3de0 01D1     		bne	.L773	@,
2060:parson.c      ****             return JSONSuccess; /* Empty array allows all types */
 12551              		.loc 2 2060 0
 12552 3de2 0023     		movs	r3, #0	@ _3,
 12553 3de4 6EE0     		b	.L766	@
 12554              	.L773:
2061:parson.c      ****         }
2062:parson.c      ****         /* Get first value from array, rest is ignored */
2063:parson.c      ****         temp_schema_value = json_array_get_value(schema_array, 0);
 12555              		.loc 2 2063 0
 12556 3de6 0021     		movs	r1, #0	@,
 12557 3de8 B86A     		ldr	r0, [r7, #40]	@, schema_array
 12558 3dea FFF7FEFF 		bl	json_array_get_value	@
 12559 3dee 3863     		str	r0, [r7, #48]	@, temp_schema_value
2064:parson.c      ****         for (i = 0; i < json_array_get_count(value_array); i++) {
 12560              		.loc 2 2064 0
 12561 3df0 0023     		movs	r3, #0	@ tmp135,
 12562 3df2 7B63     		str	r3, [r7, #52]	@ tmp135, i
 12563 3df4 12E0     		b	.L774	@
 12564              	.L776:
2065:parson.c      ****             temp_value = json_array_get_value(value_array, i);
 12565              		.loc 2 2065 0
 12566 3df6 796B     		ldr	r1, [r7, #52]	@, i
 12567 3df8 786A     		ldr	r0, [r7, #36]	@, value_array
 12568 3dfa FFF7FEFF 		bl	json_array_get_value	@
 12569 3dfe F862     		str	r0, [r7, #44]	@, temp_value
2066:parson.c      ****             if (json_validate(temp_schema_value, temp_value) == JSONFailure) {
 12570              		.loc 2 2066 0
 12571 3e00 F96A     		ldr	r1, [r7, #44]	@, temp_value
 12572 3e02 386B     		ldr	r0, [r7, #48]	@, temp_schema_value
 12573 3e04 FFF7FEFF 		bl	json_validate	@
 12574 3e08 0346     		mov	r3, r0	@ _41,
 12575 3e0a B3F1FF3F 		cmp	r3, #-1	@ _41,
 12576 3e0e 02D1     		bne	.L775	@,
2067:parson.c      ****                 return JSONFailure;
 12577              		.loc 2 2067 0
 12578 3e10 4FF0FF33 		mov	r3, #-1	@ _3,
 12579 3e14 56E0     		b	.L766	@
 12580              	.L775:
2064:parson.c      ****             temp_value = json_array_get_value(value_array, i);
 12581              		.loc 2 2064 0 discriminator 2
 12582 3e16 7B6B     		ldr	r3, [r7, #52]	@ tmp137, i
 12583 3e18 0133     		adds	r3, r3, #1	@ tmp136, tmp137,
 12584 3e1a 7B63     		str	r3, [r7, #52]	@ tmp136, i
 12585              	.L774:
2064:parson.c      ****             temp_value = json_array_get_value(value_array, i);
 12586              		.loc 2 2064 0 is_stmt 0 discriminator 1
 12587 3e1c 786A     		ldr	r0, [r7, #36]	@, value_array
 12588 3e1e FFF7FEFF 		bl	json_array_get_count	@
 12589 3e22 0246     		mov	r2, r0	@ _37,
 12590 3e24 7B6B     		ldr	r3, [r7, #52]	@ tmp138, i
 12591 3e26 9A42     		cmp	r2, r3	@ _37, tmp138
 12592 3e28 E5D8     		bhi	.L776	@,
2068:parson.c      ****             }
2069:parson.c      ****         }
2070:parson.c      ****         return JSONSuccess;
 12593              		.loc 2 2070 0 is_stmt 1
 12594 3e2a 0023     		movs	r3, #0	@ _3,
 12595 3e2c 4AE0     		b	.L766	@
 12596              	.L771:
2071:parson.c      ****     case JSONObject:
2072:parson.c      ****         schema_object = json_value_get_object(schema);
 12597              		.loc 2 2072 0
 12598 3e2e 7868     		ldr	r0, [r7, #4]	@, schema
 12599 3e30 FFF7FEFF 		bl	json_value_get_object	@
 12600 3e34 3862     		str	r0, [r7, #32]	@, schema_object
2073:parson.c      ****         value_object = json_value_get_object(value);
 12601              		.loc 2 2073 0
 12602 3e36 3868     		ldr	r0, [r7]	@, value
 12603 3e38 FFF7FEFF 		bl	json_value_get_object	@
 12604 3e3c F861     		str	r0, [r7, #28]	@, value_object
2074:parson.c      ****         count = json_object_get_count(schema_object);
 12605              		.loc 2 2074 0
 12606 3e3e 386A     		ldr	r0, [r7, #32]	@, schema_object
 12607 3e40 FFF7FEFF 		bl	json_object_get_count	@
 12608 3e44 F860     		str	r0, [r7, #12]	@, count
2075:parson.c      ****         if (count == 0) {
 12609              		.loc 2 2075 0
 12610 3e46 FB68     		ldr	r3, [r7, #12]	@ tmp139, count
 12611 3e48 002B     		cmp	r3, #0	@ tmp139,
 12612 3e4a 01D1     		bne	.L777	@,
2076:parson.c      ****             return JSONSuccess; /* Empty object allows all objects */
 12613              		.loc 2 2076 0
 12614 3e4c 0023     		movs	r3, #0	@ _3,
 12615 3e4e 39E0     		b	.L766	@
 12616              	.L777:
2077:parson.c      ****         } else if (json_object_get_count(value_object) < count) {
 12617              		.loc 2 2077 0
 12618 3e50 F869     		ldr	r0, [r7, #28]	@, value_object
 12619 3e52 FFF7FEFF 		bl	json_object_get_count	@
 12620 3e56 0246     		mov	r2, r0	@ _53,
 12621 3e58 FB68     		ldr	r3, [r7, #12]	@ tmp140, count
 12622 3e5a 9A42     		cmp	r2, r3	@ _53, tmp140
 12623 3e5c 02D2     		bcs	.L778	@,
2078:parson.c      ****             return JSONFailure; /* Tested object mustn't have less name-value pairs than schema */
 12624              		.loc 2 2078 0
 12625 3e5e 4FF0FF33 		mov	r3, #-1	@ _3,
 12626 3e62 2FE0     		b	.L766	@
 12627              	.L778:
2079:parson.c      ****         }
2080:parson.c      ****         for (i = 0; i < count; i++) {
 12628              		.loc 2 2080 0
 12629 3e64 0023     		movs	r3, #0	@ tmp141,
 12630 3e66 7B63     		str	r3, [r7, #52]	@ tmp141, i
 12631 3e68 22E0     		b	.L779	@
 12632              	.L782:
2081:parson.c      ****             key = json_object_get_name(schema_object, i);
 12633              		.loc 2 2081 0
 12634 3e6a 796B     		ldr	r1, [r7, #52]	@, i
 12635 3e6c 386A     		ldr	r0, [r7, #32]	@, schema_object
 12636 3e6e FFF7FEFF 		bl	json_object_get_name	@
 12637 3e72 3861     		str	r0, [r7, #16]	@, key
2082:parson.c      ****             temp_schema_value = json_object_get_value(schema_object, key);
 12638              		.loc 2 2082 0
 12639 3e74 3969     		ldr	r1, [r7, #16]	@, key
 12640 3e76 386A     		ldr	r0, [r7, #32]	@, schema_object
 12641 3e78 FFF7FEFF 		bl	json_object_get_value	@
 12642 3e7c 3863     		str	r0, [r7, #48]	@, temp_schema_value
2083:parson.c      ****             temp_value = json_object_get_value(value_object, key);
 12643              		.loc 2 2083 0
 12644 3e7e 3969     		ldr	r1, [r7, #16]	@, key
 12645 3e80 F869     		ldr	r0, [r7, #28]	@, value_object
 12646 3e82 FFF7FEFF 		bl	json_object_get_value	@
 12647 3e86 F862     		str	r0, [r7, #44]	@, temp_value
2084:parson.c      ****             if (temp_value == NULL) {
 12648              		.loc 2 2084 0
 12649 3e88 FB6A     		ldr	r3, [r7, #44]	@ tmp142, temp_value
 12650 3e8a 002B     		cmp	r3, #0	@ tmp142,
 12651 3e8c 02D1     		bne	.L780	@,
2085:parson.c      ****                 return JSONFailure;
 12652              		.loc 2 2085 0
 12653 3e8e 4FF0FF33 		mov	r3, #-1	@ _3,
 12654 3e92 17E0     		b	.L766	@
 12655              	.L780:
2086:parson.c      ****             }
2087:parson.c      ****             if (json_validate(temp_schema_value, temp_value) == JSONFailure) {
 12656              		.loc 2 2087 0
 12657 3e94 F96A     		ldr	r1, [r7, #44]	@, temp_value
 12658 3e96 386B     		ldr	r0, [r7, #48]	@, temp_schema_value
 12659 3e98 FFF7FEFF 		bl	json_validate	@
 12660 3e9c 0346     		mov	r3, r0	@ _63,
 12661 3e9e B3F1FF3F 		cmp	r3, #-1	@ _63,
 12662 3ea2 02D1     		bne	.L781	@,
2088:parson.c      ****                 return JSONFailure;
 12663              		.loc 2 2088 0
 12664 3ea4 4FF0FF33 		mov	r3, #-1	@ _3,
 12665 3ea8 0CE0     		b	.L766	@
 12666              	.L781:
2080:parson.c      ****             key = json_object_get_name(schema_object, i);
 12667              		.loc 2 2080 0 discriminator 2
 12668 3eaa 7B6B     		ldr	r3, [r7, #52]	@ tmp144, i
 12669 3eac 0133     		adds	r3, r3, #1	@ tmp143, tmp144,
 12670 3eae 7B63     		str	r3, [r7, #52]	@ tmp143, i
 12671              	.L779:
2080:parson.c      ****             key = json_object_get_name(schema_object, i);
 12672              		.loc 2 2080 0 is_stmt 0 discriminator 1
 12673 3eb0 7A6B     		ldr	r2, [r7, #52]	@ tmp145, i
 12674 3eb2 FB68     		ldr	r3, [r7, #12]	@ tmp146, count
 12675 3eb4 9A42     		cmp	r2, r3	@ tmp145, tmp146
 12676 3eb6 D8D3     		bcc	.L782	@,
2089:parson.c      ****             }
2090:parson.c      ****         }
2091:parson.c      ****         return JSONSuccess;
 12677              		.loc 2 2091 0 is_stmt 1
 12678 3eb8 0023     		movs	r3, #0	@ _3,
 12679 3eba 03E0     		b	.L766	@
 12680              	.L769:
2092:parson.c      ****     case JSONString:
2093:parson.c      ****     case JSONNumber:
2094:parson.c      ****     case JSONBoolean:
2095:parson.c      ****     case JSONNull:
2096:parson.c      ****         return JSONSuccess; /* equality already tested before switch */
 12681              		.loc 2 2096 0
 12682 3ebc 0023     		movs	r3, #0	@ _3,
 12683 3ebe 01E0     		b	.L766	@
 12684              	.L768:
2097:parson.c      ****     case JSONError:
2098:parson.c      ****     default:
2099:parson.c      ****         return JSONFailure;
 12685              		.loc 2 2099 0
 12686 3ec0 4FF0FF33 		mov	r3, #-1	@ _3,
 12687              	.L766:
2100:parson.c      ****     }
2101:parson.c      **** }
 12688              		.loc 2 2101 0
 12689 3ec4 1846     		mov	r0, r3	@, <retval>
 12690 3ec6 3837     		adds	r7, r7, #56	@,,
 12691              	.LCFI588:
 12692              		.cfi_def_cfa_offset 8
 12693 3ec8 BD46     		mov	sp, r7	@,
 12694              	.LCFI589:
 12695              		.cfi_def_cfa_register 13
 12696              		@ sp needed	@
 12697 3eca 80BD     		pop	{r7, pc}	@
 12698              		.cfi_endproc
 12699              	.LFE132:
 12701              		.align	1
 12702              		.global	json_value_equals
 12703              		.syntax unified
 12704              		.thumb
 12705              		.thumb_func
 12706              		.fpu neon
 12708              	json_value_equals:
 12709              	.LFB133:
2102:parson.c      **** 
2103:parson.c      **** int json_value_equals(const JSON_Value *a, const JSON_Value *b)
2104:parson.c      **** {
 12710              		.loc 2 2104 0
 12711              		.cfi_startproc
 12712              		@ args = 0, pretend = 0, frame = 56
 12713              		@ frame_needed = 1, uses_anonymous_args = 0
 12714 3ecc 90B5     		push	{r4, r7, lr}	@
 12715              	.LCFI590:
 12716              		.cfi_def_cfa_offset 12
 12717              		.cfi_offset 4, -12
 12718              		.cfi_offset 7, -8
 12719              		.cfi_offset 14, -4
 12720 3ece 2DED028B 		vpush.64	{d8}	@
 12721              	.LCFI591:
 12722              		.cfi_def_cfa_offset 20
 12723              		.cfi_offset 80, -20
 12724              		.cfi_offset 81, -16
 12725 3ed2 8FB0     		sub	sp, sp, #60	@,,
 12726              	.LCFI592:
 12727              		.cfi_def_cfa_offset 80
 12728 3ed4 00AF     		add	r7, sp, #0	@,,
 12729              	.LCFI593:
 12730              		.cfi_def_cfa_register 7
 12731 3ed6 7860     		str	r0, [r7, #4]	@ a, a
 12732 3ed8 3960     		str	r1, [r7]	@ b, b
2105:parson.c      ****     JSON_Object *a_object = NULL, *b_object = NULL;
 12733              		.loc 2 2105 0
 12734 3eda 0023     		movs	r3, #0	@ tmp128,
 12735 3edc 3B63     		str	r3, [r7, #48]	@ tmp128, a_object
 12736 3ede 0023     		movs	r3, #0	@ tmp129,
 12737 3ee0 FB62     		str	r3, [r7, #44]	@ tmp129, b_object
2106:parson.c      ****     JSON_Array *a_array = NULL, *b_array = NULL;
 12738              		.loc 2 2106 0
 12739 3ee2 0023     		movs	r3, #0	@ tmp130,
 12740 3ee4 BB62     		str	r3, [r7, #40]	@ tmp130, a_array
 12741 3ee6 0023     		movs	r3, #0	@ tmp131,
 12742 3ee8 7B62     		str	r3, [r7, #36]	@ tmp131, b_array
2107:parson.c      ****     const char *a_string = NULL, *b_string = NULL;
 12743              		.loc 2 2107 0
 12744 3eea 0023     		movs	r3, #0	@ tmp132,
 12745 3eec 3B62     		str	r3, [r7, #32]	@ tmp132, a_string
 12746 3eee 0023     		movs	r3, #0	@ tmp133,
 12747 3ef0 FB61     		str	r3, [r7, #28]	@ tmp133, b_string
2108:parson.c      ****     const char *key = NULL;
 12748              		.loc 2 2108 0
 12749 3ef2 0023     		movs	r3, #0	@ tmp134,
 12750 3ef4 BB61     		str	r3, [r7, #24]	@ tmp134, key
2109:parson.c      ****     size_t a_count = 0, b_count = 0, i = 0;
 12751              		.loc 2 2109 0
 12752 3ef6 0023     		movs	r3, #0	@ tmp135,
 12753 3ef8 7B61     		str	r3, [r7, #20]	@ tmp135, a_count
 12754 3efa 0023     		movs	r3, #0	@ tmp136,
 12755 3efc 3B61     		str	r3, [r7, #16]	@ tmp136, b_count
 12756 3efe 0023     		movs	r3, #0	@ tmp137,
 12757 3f00 7B63     		str	r3, [r7, #52]	@ tmp137, i
2110:parson.c      ****     JSON_Value_Type a_type, b_type;
2111:parson.c      ****     a_type = json_value_get_type(a);
 12758              		.loc 2 2111 0
 12759 3f02 7868     		ldr	r0, [r7, #4]	@, a
 12760 3f04 FFF7FEFF 		bl	json_value_get_type	@
 12761 3f08 F860     		str	r0, [r7, #12]	@, a_type
2112:parson.c      ****     b_type = json_value_get_type(b);
 12762              		.loc 2 2112 0
 12763 3f0a 3868     		ldr	r0, [r7]	@, b
 12764 3f0c FFF7FEFF 		bl	json_value_get_type	@
 12765 3f10 B860     		str	r0, [r7, #8]	@, b_type
2113:parson.c      ****     if (a_type != b_type) {
 12766              		.loc 2 2113 0
 12767 3f12 FA68     		ldr	r2, [r7, #12]	@ tmp138, a_type
 12768 3f14 BB68     		ldr	r3, [r7, #8]	@ tmp139, b_type
 12769 3f16 9A42     		cmp	r2, r3	@ tmp138, tmp139
 12770 3f18 01D0     		beq	.L784	@,
2114:parson.c      ****         return 0;
 12771              		.loc 2 2114 0
 12772 3f1a 0023     		movs	r3, #0	@ _3,
 12773 3f1c CEE0     		b	.L785	@
 12774              	.L784:
2115:parson.c      ****     }
2116:parson.c      ****     switch (a_type) {
 12775              		.loc 2 2116 0
 12776 3f1e FB68     		ldr	r3, [r7, #12]	@ tmp140, a_type
 12777 3f20 0133     		adds	r3, r3, #1	@ tmp141, tmp140,
 12778 3f22 072B     		cmp	r3, #7	@ tmp141,
 12779 3f24 00F2C980 		bhi	.L786	@
 12780 3f28 01A2     		adr	r2, .L788	@ tmp166,
 12781 3f2a 52F823F0 		ldr	pc, [r2, r3, lsl #2]	@ tmp166, tmp141
 12782 3f2e 00BF     		.p2align 2
 12783              	.L788:
 12784 3f30 B3400000 		.word	.L787+1
 12785 3f34 BB400000 		.word	.L786+1
 12786 3f38 B7400000 		.word	.L789+1
 12787 3f3c 2F400000 		.word	.L790+1
 12788 3f40 81400000 		.word	.L791+1
 12789 3f44 BB3F0000 		.word	.L792+1
 12790 3f48 513F0000 		.word	.L793+1
 12791 3f4c 65400000 		.word	.L794+1
 12792              		.p2align 1
 12793              	.L793:
2117:parson.c      ****     case JSONArray:
2118:parson.c      ****         a_array = json_value_get_array(a);
 12794              		.loc 2 2118 0
 12795 3f50 7868     		ldr	r0, [r7, #4]	@, a
 12796 3f52 FFF7FEFF 		bl	json_value_get_array	@
 12797 3f56 B862     		str	r0, [r7, #40]	@, a_array
2119:parson.c      ****         b_array = json_value_get_array(b);
 12798              		.loc 2 2119 0
 12799 3f58 3868     		ldr	r0, [r7]	@, b
 12800 3f5a FFF7FEFF 		bl	json_value_get_array	@
 12801 3f5e 7862     		str	r0, [r7, #36]	@, b_array
2120:parson.c      ****         a_count = json_array_get_count(a_array);
 12802              		.loc 2 2120 0
 12803 3f60 B86A     		ldr	r0, [r7, #40]	@, a_array
 12804 3f62 FFF7FEFF 		bl	json_array_get_count	@
 12805 3f66 7861     		str	r0, [r7, #20]	@, a_count
2121:parson.c      ****         b_count = json_array_get_count(b_array);
 12806              		.loc 2 2121 0
 12807 3f68 786A     		ldr	r0, [r7, #36]	@, b_array
 12808 3f6a FFF7FEFF 		bl	json_array_get_count	@
 12809 3f6e 3861     		str	r0, [r7, #16]	@, b_count
2122:parson.c      ****         if (a_count != b_count) {
 12810              		.loc 2 2122 0
 12811 3f70 7A69     		ldr	r2, [r7, #20]	@ tmp142, a_count
 12812 3f72 3B69     		ldr	r3, [r7, #16]	@ tmp143, b_count
 12813 3f74 9A42     		cmp	r2, r3	@ tmp142, tmp143
 12814 3f76 01D0     		beq	.L795	@,
2123:parson.c      ****             return 0;
 12815              		.loc 2 2123 0
 12816 3f78 0023     		movs	r3, #0	@ _3,
 12817 3f7a 9FE0     		b	.L785	@
 12818              	.L795:
2124:parson.c      ****         }
2125:parson.c      ****         for (i = 0; i < a_count; i++) {
 12819              		.loc 2 2125 0
 12820 3f7c 0023     		movs	r3, #0	@ tmp144,
 12821 3f7e 7B63     		str	r3, [r7, #52]	@ tmp144, i
 12822 3f80 15E0     		b	.L796	@
 12823              	.L798:
2126:parson.c      ****             if (!json_value_equals(json_array_get_value(a_array, i),
 12824              		.loc 2 2126 0
 12825 3f82 796B     		ldr	r1, [r7, #52]	@, i
 12826 3f84 B86A     		ldr	r0, [r7, #40]	@, a_array
 12827 3f86 FFF7FEFF 		bl	json_array_get_value	@
 12828 3f8a 0446     		mov	r4, r0	@ _36,
2127:parson.c      ****                                    json_array_get_value(b_array, i))) {
 12829              		.loc 2 2127 0
 12830 3f8c 796B     		ldr	r1, [r7, #52]	@, i
 12831 3f8e 786A     		ldr	r0, [r7, #36]	@, b_array
 12832 3f90 FFF7FEFF 		bl	json_array_get_value	@
 12833 3f94 0346     		mov	r3, r0	@ _38,
2126:parson.c      ****             if (!json_value_equals(json_array_get_value(a_array, i),
 12834              		.loc 2 2126 0
 12835 3f96 1946     		mov	r1, r3	@, _38
 12836 3f98 2046     		mov	r0, r4	@, _36
 12837 3f9a FFF7FEFF 		bl	json_value_equals	@
 12838 3f9e 0346     		mov	r3, r0	@ _40,
 12839 3fa0 002B     		cmp	r3, #0	@ _40,
 12840 3fa2 01D1     		bne	.L797	@,
2128:parson.c      ****                 return 0;
 12841              		.loc 2 2128 0
 12842 3fa4 0023     		movs	r3, #0	@ _3,
 12843 3fa6 89E0     		b	.L785	@
 12844              	.L797:
2125:parson.c      ****             if (!json_value_equals(json_array_get_value(a_array, i),
 12845              		.loc 2 2125 0 discriminator 2
 12846 3fa8 7B6B     		ldr	r3, [r7, #52]	@ tmp146, i
 12847 3faa 0133     		adds	r3, r3, #1	@ tmp145, tmp146,
 12848 3fac 7B63     		str	r3, [r7, #52]	@ tmp145, i
 12849              	.L796:
2125:parson.c      ****             if (!json_value_equals(json_array_get_value(a_array, i),
 12850              		.loc 2 2125 0 is_stmt 0 discriminator 1
 12851 3fae 7A6B     		ldr	r2, [r7, #52]	@ tmp147, i
 12852 3fb0 7B69     		ldr	r3, [r7, #20]	@ tmp148, a_count
 12853 3fb2 9A42     		cmp	r2, r3	@ tmp147, tmp148
 12854 3fb4 E5D3     		bcc	.L798	@,
2129:parson.c      ****             }
2130:parson.c      ****         }
2131:parson.c      ****         return 1;
 12855              		.loc 2 2131 0 is_stmt 1
 12856 3fb6 0123     		movs	r3, #1	@ _3,
 12857 3fb8 80E0     		b	.L785	@
 12858              	.L792:
2132:parson.c      ****     case JSONObject:
2133:parson.c      ****         a_object = json_value_get_object(a);
 12859              		.loc 2 2133 0
 12860 3fba 7868     		ldr	r0, [r7, #4]	@, a
 12861 3fbc FFF7FEFF 		bl	json_value_get_object	@
 12862 3fc0 3863     		str	r0, [r7, #48]	@, a_object
2134:parson.c      ****         b_object = json_value_get_object(b);
 12863              		.loc 2 2134 0
 12864 3fc2 3868     		ldr	r0, [r7]	@, b
 12865 3fc4 FFF7FEFF 		bl	json_value_get_object	@
 12866 3fc8 F862     		str	r0, [r7, #44]	@, b_object
2135:parson.c      ****         a_count = json_object_get_count(a_object);
 12867              		.loc 2 2135 0
 12868 3fca 386B     		ldr	r0, [r7, #48]	@, a_object
 12869 3fcc FFF7FEFF 		bl	json_object_get_count	@
 12870 3fd0 7861     		str	r0, [r7, #20]	@, a_count
2136:parson.c      ****         b_count = json_object_get_count(b_object);
 12871              		.loc 2 2136 0
 12872 3fd2 F86A     		ldr	r0, [r7, #44]	@, b_object
 12873 3fd4 FFF7FEFF 		bl	json_object_get_count	@
 12874 3fd8 3861     		str	r0, [r7, #16]	@, b_count
2137:parson.c      ****         if (a_count != b_count) {
 12875              		.loc 2 2137 0
 12876 3fda 7A69     		ldr	r2, [r7, #20]	@ tmp149, a_count
 12877 3fdc 3B69     		ldr	r3, [r7, #16]	@ tmp150, b_count
 12878 3fde 9A42     		cmp	r2, r3	@ tmp149, tmp150
 12879 3fe0 01D0     		beq	.L799	@,
2138:parson.c      ****             return 0;
 12880              		.loc 2 2138 0
 12881 3fe2 0023     		movs	r3, #0	@ _3,
 12882 3fe4 6AE0     		b	.L785	@
 12883              	.L799:
2139:parson.c      ****         }
2140:parson.c      ****         for (i = 0; i < a_count; i++) {
 12884              		.loc 2 2140 0
 12885 3fe6 0023     		movs	r3, #0	@ tmp151,
 12886 3fe8 7B63     		str	r3, [r7, #52]	@ tmp151, i
 12887 3fea 1AE0     		b	.L800	@
 12888              	.L802:
2141:parson.c      ****             key = json_object_get_name(a_object, i);
 12889              		.loc 2 2141 0
 12890 3fec 796B     		ldr	r1, [r7, #52]	@, i
 12891 3fee 386B     		ldr	r0, [r7, #48]	@, a_object
 12892 3ff0 FFF7FEFF 		bl	json_object_get_name	@
 12893 3ff4 B861     		str	r0, [r7, #24]	@, key
2142:parson.c      ****             if (!json_value_equals(json_object_get_value(a_object, key),
 12894              		.loc 2 2142 0
 12895 3ff6 B969     		ldr	r1, [r7, #24]	@, key
 12896 3ff8 386B     		ldr	r0, [r7, #48]	@, a_object
 12897 3ffa FFF7FEFF 		bl	json_object_get_value	@
 12898 3ffe 0446     		mov	r4, r0	@ _57,
2143:parson.c      ****                                    json_object_get_value(b_object, key))) {
 12899              		.loc 2 2143 0
 12900 4000 B969     		ldr	r1, [r7, #24]	@, key
 12901 4002 F86A     		ldr	r0, [r7, #44]	@, b_object
 12902 4004 FFF7FEFF 		bl	json_object_get_value	@
 12903 4008 0346     		mov	r3, r0	@ _59,
2142:parson.c      ****             if (!json_value_equals(json_object_get_value(a_object, key),
 12904              		.loc 2 2142 0
 12905 400a 1946     		mov	r1, r3	@, _59
 12906 400c 2046     		mov	r0, r4	@, _57
 12907 400e FFF7FEFF 		bl	json_value_equals	@
 12908 4012 0346     		mov	r3, r0	@ _61,
 12909 4014 002B     		cmp	r3, #0	@ _61,
 12910 4016 01D1     		bne	.L801	@,
2144:parson.c      ****                 return 0;
 12911              		.loc 2 2144 0
 12912 4018 0023     		movs	r3, #0	@ _3,
 12913 401a 4FE0     		b	.L785	@
 12914              	.L801:
2140:parson.c      ****             key = json_object_get_name(a_object, i);
 12915              		.loc 2 2140 0 discriminator 2
 12916 401c 7B6B     		ldr	r3, [r7, #52]	@ tmp153, i
 12917 401e 0133     		adds	r3, r3, #1	@ tmp152, tmp153,
 12918 4020 7B63     		str	r3, [r7, #52]	@ tmp152, i
 12919              	.L800:
2140:parson.c      ****             key = json_object_get_name(a_object, i);
 12920              		.loc 2 2140 0 is_stmt 0 discriminator 1
 12921 4022 7A6B     		ldr	r2, [r7, #52]	@ tmp154, i
 12922 4024 7B69     		ldr	r3, [r7, #20]	@ tmp155, a_count
 12923 4026 9A42     		cmp	r2, r3	@ tmp154, tmp155
 12924 4028 E0D3     		bcc	.L802	@,
2145:parson.c      ****             }
2146:parson.c      ****         }
2147:parson.c      ****         return 1;
 12925              		.loc 2 2147 0 is_stmt 1
 12926 402a 0123     		movs	r3, #1	@ _3,
 12927 402c 46E0     		b	.L785	@
 12928              	.L790:
2148:parson.c      ****     case JSONString:
2149:parson.c      ****         a_string = json_value_get_string(a);
 12929              		.loc 2 2149 0
 12930 402e 7868     		ldr	r0, [r7, #4]	@, a
 12931 4030 FFF7FEFF 		bl	json_value_get_string	@
 12932 4034 3862     		str	r0, [r7, #32]	@, a_string
2150:parson.c      ****         b_string = json_value_get_string(b);
 12933              		.loc 2 2150 0
 12934 4036 3868     		ldr	r0, [r7]	@, b
 12935 4038 FFF7FEFF 		bl	json_value_get_string	@
 12936 403c F861     		str	r0, [r7, #28]	@, b_string
2151:parson.c      ****         if (a_string == NULL || b_string == NULL) {
 12937              		.loc 2 2151 0
 12938 403e 3B6A     		ldr	r3, [r7, #32]	@ tmp156, a_string
 12939 4040 002B     		cmp	r3, #0	@ tmp156,
 12940 4042 02D0     		beq	.L803	@,
 12941              		.loc 2 2151 0 is_stmt 0 discriminator 1
 12942 4044 FB69     		ldr	r3, [r7, #28]	@ tmp157, b_string
 12943 4046 002B     		cmp	r3, #0	@ tmp157,
 12944 4048 01D1     		bne	.L804	@,
 12945              	.L803:
2152:parson.c      ****             return 0; /* shouldn't happen */
 12946              		.loc 2 2152 0 is_stmt 1
 12947 404a 0023     		movs	r3, #0	@ _3,
 12948 404c 36E0     		b	.L785	@
 12949              	.L804:
2153:parson.c      ****         }
2154:parson.c      ****         return strcmp(a_string, b_string) == 0;
 12950              		.loc 2 2154 0
 12951 404e F969     		ldr	r1, [r7, #28]	@, b_string
 12952 4050 386A     		ldr	r0, [r7, #32]	@, a_string
 12953 4052 FFF7FEFF 		bl	strcmp	@
 12954 4056 0346     		mov	r3, r0	@ _69,
 12955 4058 002B     		cmp	r3, #0	@ _69,
 12956 405a 0CBF     		ite	eq
 12957 405c 0123     		moveq	r3, #1	@ tmp159,
 12958 405e 0023     		movne	r3, #0	@ tmp159,
 12959 4060 DBB2     		uxtb	r3, r3	@ _70, tmp158
 12960 4062 2BE0     		b	.L785	@
 12961              	.L794:
2155:parson.c      ****     case JSONBoolean:
2156:parson.c      ****         return json_value_get_boolean(a) == json_value_get_boolean(b);
 12962              		.loc 2 2156 0
 12963 4064 7868     		ldr	r0, [r7, #4]	@, a
 12964 4066 FFF7FEFF 		bl	json_value_get_boolean	@
 12965 406a 0446     		mov	r4, r0	@ _74,
 12966 406c 3868     		ldr	r0, [r7]	@, b
 12967 406e FFF7FEFF 		bl	json_value_get_boolean	@
 12968 4072 0346     		mov	r3, r0	@ _76,
 12969 4074 9C42     		cmp	r4, r3	@ _74, _76
 12970 4076 0CBF     		ite	eq
 12971 4078 0123     		moveq	r3, #1	@ tmp161,
 12972 407a 0023     		movne	r3, #0	@ tmp161,
 12973 407c DBB2     		uxtb	r3, r3	@ _77, tmp160
 12974 407e 1DE0     		b	.L785	@
 12975              	.L791:
2157:parson.c      ****     case JSONNumber:
2158:parson.c      ****         return fabs(json_value_get_number(a) - json_value_get_number(b)) < 0.000001; /* EPSILON */
 12976              		.loc 2 2158 0
 12977 4080 7868     		ldr	r0, [r7, #4]	@, a
 12978 4082 FFF7FEFF 		bl	json_value_get_number	@
 12979 4086 B0EE408B 		vmov.f64	d8, d0	@ _80,
 12980 408a 3868     		ldr	r0, [r7]	@, b
 12981 408c FFF7FEFF 		bl	json_value_get_number	@
 12982 4090 F0EE400B 		vmov.f64	d16, d0	@ _82,
 12983 4094 78EE600B 		vsub.f64	d16, d8, d16	@ _83, _80, _82
 12984 4098 F0EEE00B 		vabs.f64	d16, d16	@ _84, _83
 12985 409c DFED0A1B 		vldr.64	d17, .L805	@ tmp163,
 12986 40a0 F4EEE10B 		vcmpe.f64	d16, d17	@ _84, tmp163
 12987 40a4 F1EE10FA 		vmrs	APSR_nzcv, FPSCR
 12988 40a8 4CBF     		ite	mi
 12989 40aa 0123     		movmi	r3, #1	@ tmp164,
 12990 40ac 0023     		movpl	r3, #0	@ tmp164,
 12991 40ae DBB2     		uxtb	r3, r3	@ _85, tmp162
 12992 40b0 04E0     		b	.L785	@
 12993              	.L787:
2159:parson.c      ****     case JSONError:
2160:parson.c      ****         return 1;
 12994              		.loc 2 2160 0
 12995 40b2 0123     		movs	r3, #1	@ _3,
 12996 40b4 02E0     		b	.L785	@
 12997              	.L789:
2161:parson.c      ****     case JSONNull:
2162:parson.c      ****         return 1;
 12998              		.loc 2 2162 0
 12999 40b6 0123     		movs	r3, #1	@ _3,
 13000 40b8 00E0     		b	.L785	@
 13001              	.L786:
2163:parson.c      ****     default:
2164:parson.c      ****         return 1;
 13002              		.loc 2 2164 0
 13003 40ba 0123     		movs	r3, #1	@ _3,
 13004              	.L785:
2165:parson.c      ****     }
2166:parson.c      **** }
 13005              		.loc 2 2166 0
 13006 40bc 1846     		mov	r0, r3	@, <retval>
 13007 40be 3C37     		adds	r7, r7, #60	@,,
 13008              	.LCFI594:
 13009              		.cfi_def_cfa_offset 20
 13010 40c0 BD46     		mov	sp, r7	@,
 13011              	.LCFI595:
 13012              		.cfi_def_cfa_register 13
 13013              		@ sp needed	@
 13014 40c2 BDEC028B 		vldm	sp!, {d8}	@
 13015              	.LCFI596:
 13016              		.cfi_restore 80
 13017              		.cfi_restore 81
 13018              		.cfi_def_cfa_offset 12
 13019 40c6 90BD     		pop	{r4, r7, pc}	@
 13020              	.L806:
 13021              		.align	3
 13022              	.L805:
 13023 40c8 8DEDB5A0 		.word	-1598689907
 13024 40cc F7C6B03E 		.word	1051772663
 13025              		.cfi_endproc
 13026              	.LFE133:
 13028              		.align	1
 13029              		.global	json_type
 13030              		.syntax unified
 13031              		.thumb
 13032              		.thumb_func
 13033              		.fpu neon
 13035              	json_type:
 13036              	.LFB134:
2167:parson.c      **** 
2168:parson.c      **** JSON_Value_Type json_type(const JSON_Value *value)
2169:parson.c      **** {
 13037              		.loc 2 2169 0
 13038              		.cfi_startproc
 13039              		@ args = 0, pretend = 0, frame = 8
 13040              		@ frame_needed = 1, uses_anonymous_args = 0
 13041 40d0 80B5     		push	{r7, lr}	@
 13042              	.LCFI597:
 13043              		.cfi_def_cfa_offset 8
 13044              		.cfi_offset 7, -8
 13045              		.cfi_offset 14, -4
 13046 40d2 82B0     		sub	sp, sp, #8	@,,
 13047              	.LCFI598:
 13048              		.cfi_def_cfa_offset 16
 13049 40d4 00AF     		add	r7, sp, #0	@,,
 13050              	.LCFI599:
 13051              		.cfi_def_cfa_register 7
 13052 40d6 7860     		str	r0, [r7, #4]	@ value, value
2170:parson.c      ****     return json_value_get_type(value);
 13053              		.loc 2 2170 0
 13054 40d8 7868     		ldr	r0, [r7, #4]	@, value
 13055 40da FFF7FEFF 		bl	json_value_get_type	@
 13056 40de 0346     		mov	r3, r0	@ _4,
2171:parson.c      **** }
 13057              		.loc 2 2171 0
 13058 40e0 1846     		mov	r0, r3	@, <retval>
 13059 40e2 0837     		adds	r7, r7, #8	@,,
 13060              	.LCFI600:
 13061              		.cfi_def_cfa_offset 8
 13062 40e4 BD46     		mov	sp, r7	@,
 13063              	.LCFI601:
 13064              		.cfi_def_cfa_register 13
 13065              		@ sp needed	@
 13066 40e6 80BD     		pop	{r7, pc}	@
 13067              		.cfi_endproc
 13068              	.LFE134:
 13070              		.align	1
 13071              		.global	json_object
 13072              		.syntax unified
 13073              		.thumb
 13074              		.thumb_func
 13075              		.fpu neon
 13077              	json_object:
 13078              	.LFB135:
2172:parson.c      **** 
2173:parson.c      **** JSON_Object *json_object(const JSON_Value *value)
2174:parson.c      **** {
 13079              		.loc 2 2174 0
 13080              		.cfi_startproc
 13081              		@ args = 0, pretend = 0, frame = 8
 13082              		@ frame_needed = 1, uses_anonymous_args = 0
 13083 40e8 80B5     		push	{r7, lr}	@
 13084              	.LCFI602:
 13085              		.cfi_def_cfa_offset 8
 13086              		.cfi_offset 7, -8
 13087              		.cfi_offset 14, -4
 13088 40ea 82B0     		sub	sp, sp, #8	@,,
 13089              	.LCFI603:
 13090              		.cfi_def_cfa_offset 16
 13091 40ec 00AF     		add	r7, sp, #0	@,,
 13092              	.LCFI604:
 13093              		.cfi_def_cfa_register 7
 13094 40ee 7860     		str	r0, [r7, #4]	@ value, value
2175:parson.c      ****     return json_value_get_object(value);
 13095              		.loc 2 2175 0
 13096 40f0 7868     		ldr	r0, [r7, #4]	@, value
 13097 40f2 FFF7FEFF 		bl	json_value_get_object	@
 13098 40f6 0346     		mov	r3, r0	@ _4,
2176:parson.c      **** }
 13099              		.loc 2 2176 0
 13100 40f8 1846     		mov	r0, r3	@, <retval>
 13101 40fa 0837     		adds	r7, r7, #8	@,,
 13102              	.LCFI605:
 13103              		.cfi_def_cfa_offset 8
 13104 40fc BD46     		mov	sp, r7	@,
 13105              	.LCFI606:
 13106              		.cfi_def_cfa_register 13
 13107              		@ sp needed	@
 13108 40fe 80BD     		pop	{r7, pc}	@
 13109              		.cfi_endproc
 13110              	.LFE135:
 13112              		.align	1
 13113              		.global	json_array
 13114              		.syntax unified
 13115              		.thumb
 13116              		.thumb_func
 13117              		.fpu neon
 13119              	json_array:
 13120              	.LFB136:
2177:parson.c      **** 
2178:parson.c      **** JSON_Array *json_array(const JSON_Value *value)
2179:parson.c      **** {
 13121              		.loc 2 2179 0
 13122              		.cfi_startproc
 13123              		@ args = 0, pretend = 0, frame = 8
 13124              		@ frame_needed = 1, uses_anonymous_args = 0
 13125 4100 80B5     		push	{r7, lr}	@
 13126              	.LCFI607:
 13127              		.cfi_def_cfa_offset 8
 13128              		.cfi_offset 7, -8
 13129              		.cfi_offset 14, -4
 13130 4102 82B0     		sub	sp, sp, #8	@,,
 13131              	.LCFI608:
 13132              		.cfi_def_cfa_offset 16
 13133 4104 00AF     		add	r7, sp, #0	@,,
 13134              	.LCFI609:
 13135              		.cfi_def_cfa_register 7
 13136 4106 7860     		str	r0, [r7, #4]	@ value, value
2180:parson.c      ****     return json_value_get_array(value);
 13137              		.loc 2 2180 0
 13138 4108 7868     		ldr	r0, [r7, #4]	@, value
 13139 410a FFF7FEFF 		bl	json_value_get_array	@
 13140 410e 0346     		mov	r3, r0	@ _4,
2181:parson.c      **** }
 13141              		.loc 2 2181 0
 13142 4110 1846     		mov	r0, r3	@, <retval>
 13143 4112 0837     		adds	r7, r7, #8	@,,
 13144              	.LCFI610:
 13145              		.cfi_def_cfa_offset 8
 13146 4114 BD46     		mov	sp, r7	@,
 13147              	.LCFI611:
 13148              		.cfi_def_cfa_register 13
 13149              		@ sp needed	@
 13150 4116 80BD     		pop	{r7, pc}	@
 13151              		.cfi_endproc
 13152              	.LFE136:
 13154              		.align	1
 13155              		.global	json_string
 13156              		.syntax unified
 13157              		.thumb
 13158              		.thumb_func
 13159              		.fpu neon
 13161              	json_string:
 13162              	.LFB137:
2182:parson.c      **** 
2183:parson.c      **** const char *json_string(const JSON_Value *value)
2184:parson.c      **** {
 13163              		.loc 2 2184 0
 13164              		.cfi_startproc
 13165              		@ args = 0, pretend = 0, frame = 8
 13166              		@ frame_needed = 1, uses_anonymous_args = 0
 13167 4118 80B5     		push	{r7, lr}	@
 13168              	.LCFI612:
 13169              		.cfi_def_cfa_offset 8
 13170              		.cfi_offset 7, -8
 13171              		.cfi_offset 14, -4
 13172 411a 82B0     		sub	sp, sp, #8	@,,
 13173              	.LCFI613:
 13174              		.cfi_def_cfa_offset 16
 13175 411c 00AF     		add	r7, sp, #0	@,,
 13176              	.LCFI614:
 13177              		.cfi_def_cfa_register 7
 13178 411e 7860     		str	r0, [r7, #4]	@ value, value
2185:parson.c      ****     return json_value_get_string(value);
 13179              		.loc 2 2185 0
 13180 4120 7868     		ldr	r0, [r7, #4]	@, value
 13181 4122 FFF7FEFF 		bl	json_value_get_string	@
 13182 4126 0346     		mov	r3, r0	@ _4,
2186:parson.c      **** }
 13183              		.loc 2 2186 0
 13184 4128 1846     		mov	r0, r3	@, <retval>
 13185 412a 0837     		adds	r7, r7, #8	@,,
 13186              	.LCFI615:
 13187              		.cfi_def_cfa_offset 8
 13188 412c BD46     		mov	sp, r7	@,
 13189              	.LCFI616:
 13190              		.cfi_def_cfa_register 13
 13191              		@ sp needed	@
 13192 412e 80BD     		pop	{r7, pc}	@
 13193              		.cfi_endproc
 13194              	.LFE137:
 13196              		.align	1
 13197              		.global	json_number
 13198              		.syntax unified
 13199              		.thumb
 13200              		.thumb_func
 13201              		.fpu neon
 13203              	json_number:
 13204              	.LFB138:
2187:parson.c      **** 
2188:parson.c      **** double json_number(const JSON_Value *value)
2189:parson.c      **** {
 13205              		.loc 2 2189 0
 13206              		.cfi_startproc
 13207              		@ args = 0, pretend = 0, frame = 8
 13208              		@ frame_needed = 1, uses_anonymous_args = 0
 13209 4130 80B5     		push	{r7, lr}	@
 13210              	.LCFI617:
 13211              		.cfi_def_cfa_offset 8
 13212              		.cfi_offset 7, -8
 13213              		.cfi_offset 14, -4
 13214 4132 82B0     		sub	sp, sp, #8	@,,
 13215              	.LCFI618:
 13216              		.cfi_def_cfa_offset 16
 13217 4134 00AF     		add	r7, sp, #0	@,,
 13218              	.LCFI619:
 13219              		.cfi_def_cfa_register 7
 13220 4136 7860     		str	r0, [r7, #4]	@ value, value
2190:parson.c      ****     return json_value_get_number(value);
 13221              		.loc 2 2190 0
 13222 4138 7868     		ldr	r0, [r7, #4]	@, value
 13223 413a FFF7FEFF 		bl	json_value_get_number	@
 13224 413e F0EE400B 		vmov.f64	d16, d0	@ _4,
2191:parson.c      **** }
 13225              		.loc 2 2191 0
 13226 4142 B0EE600B 		vmov.f64	d0, d16	@, <retval>
 13227 4146 0837     		adds	r7, r7, #8	@,,
 13228              	.LCFI620:
 13229              		.cfi_def_cfa_offset 8
 13230 4148 BD46     		mov	sp, r7	@,
 13231              	.LCFI621:
 13232              		.cfi_def_cfa_register 13
 13233              		@ sp needed	@
 13234 414a 80BD     		pop	{r7, pc}	@
 13235              		.cfi_endproc
 13236              	.LFE138:
 13238              		.align	1
 13239              		.global	json_boolean
 13240              		.syntax unified
 13241              		.thumb
 13242              		.thumb_func
 13243              		.fpu neon
 13245              	json_boolean:
 13246              	.LFB139:
2192:parson.c      **** 
2193:parson.c      **** int json_boolean(const JSON_Value *value)
2194:parson.c      **** {
 13247              		.loc 2 2194 0
 13248              		.cfi_startproc
 13249              		@ args = 0, pretend = 0, frame = 8
 13250              		@ frame_needed = 1, uses_anonymous_args = 0
 13251 414c 80B5     		push	{r7, lr}	@
 13252              	.LCFI622:
 13253              		.cfi_def_cfa_offset 8
 13254              		.cfi_offset 7, -8
 13255              		.cfi_offset 14, -4
 13256 414e 82B0     		sub	sp, sp, #8	@,,
 13257              	.LCFI623:
 13258              		.cfi_def_cfa_offset 16
 13259 4150 00AF     		add	r7, sp, #0	@,,
 13260              	.LCFI624:
 13261              		.cfi_def_cfa_register 7
 13262 4152 7860     		str	r0, [r7, #4]	@ value, value
2195:parson.c      ****     return json_value_get_boolean(value);
 13263              		.loc 2 2195 0
 13264 4154 7868     		ldr	r0, [r7, #4]	@, value
 13265 4156 FFF7FEFF 		bl	json_value_get_boolean	@
 13266 415a 0346     		mov	r3, r0	@ _4,
2196:parson.c      **** }
 13267              		.loc 2 2196 0
 13268 415c 1846     		mov	r0, r3	@, <retval>
 13269 415e 0837     		adds	r7, r7, #8	@,,
 13270              	.LCFI625:
 13271              		.cfi_def_cfa_offset 8
 13272 4160 BD46     		mov	sp, r7	@,
 13273              	.LCFI626:
 13274              		.cfi_def_cfa_register 13
 13275              		@ sp needed	@
 13276 4162 80BD     		pop	{r7, pc}	@
 13277              		.cfi_endproc
 13278              	.LFE139:
 13280              		.align	1
 13281              		.global	json_set_allocation_functions
 13282              		.syntax unified
 13283              		.thumb
 13284              		.thumb_func
 13285              		.fpu neon
 13287              	json_set_allocation_functions:
 13288              	.LFB140:
2197:parson.c      **** 
2198:parson.c      **** void json_set_allocation_functions(JSON_Malloc_Function malloc_fun, JSON_Free_Function free_fun)
2199:parson.c      **** {
 13289              		.loc 2 2199 0
 13290              		.cfi_startproc
 13291              		@ args = 0, pretend = 0, frame = 8
 13292              		@ frame_needed = 1, uses_anonymous_args = 0
 13293              		@ link register save eliminated.
 13294 4164 80B4     		push	{r7}	@
 13295              	.LCFI627:
 13296              		.cfi_def_cfa_offset 4
 13297              		.cfi_offset 7, -4
 13298 4166 83B0     		sub	sp, sp, #12	@,,
 13299              	.LCFI628:
 13300              		.cfi_def_cfa_offset 16
 13301 4168 00AF     		add	r7, sp, #0	@,,
 13302              	.LCFI629:
 13303              		.cfi_def_cfa_register 7
 13304 416a 7860     		str	r0, [r7, #4]	@ malloc_fun, malloc_fun
 13305 416c 3960     		str	r1, [r7]	@ free_fun, free_fun
2200:parson.c      ****     parson_malloc = malloc_fun;
 13306              		.loc 2 2200 0
 13307 416e 40F20003 		movw	r3, #:lower16:parson_malloc	@ tmp110,
 13308 4172 C0F20003 		movt	r3, #:upper16:parson_malloc	@ tmp110,
 13309 4176 7A68     		ldr	r2, [r7, #4]	@ tmp111, malloc_fun
 13310 4178 1A60     		str	r2, [r3]	@ tmp111, parson_malloc
2201:parson.c      ****     parson_free = free_fun;
 13311              		.loc 2 2201 0
 13312 417a 40F20003 		movw	r3, #:lower16:parson_free	@ tmp112,
 13313 417e C0F20003 		movt	r3, #:upper16:parson_free	@ tmp112,
 13314 4182 3A68     		ldr	r2, [r7]	@ tmp113, free_fun
 13315 4184 1A60     		str	r2, [r3]	@ tmp113, parson_free
2202:parson.c      **** }
 13316              		.loc 2 2202 0
 13317 4186 00BF     		nop
 13318 4188 0C37     		adds	r7, r7, #12	@,,
 13319              	.LCFI630:
 13320              		.cfi_def_cfa_offset 4
 13321 418a BD46     		mov	sp, r7	@,
 13322              	.LCFI631:
 13323              		.cfi_def_cfa_register 13
 13324              		@ sp needed	@
 13325 418c 5DF8047B 		ldr	r7, [sp], #4	@,
 13326              	.LCFI632:
 13327              		.cfi_restore 7
 13328              		.cfi_def_cfa_offset 0
 13329 4190 7047     		bx	lr	@
 13330              		.cfi_endproc
 13331              	.LFE140:
 13333              	.Letext0:
 13334              		.file 3 "c:\\program files (x86)\\microsoft azure sphere sdk\\sysroot\\usr\\include\\bits\\alltype
 13335              		.file 4 "parson.h"
 13336              		.file 5 "c:\\program files (x86)\\microsoft azure sphere sdk\\sysroot\\usr\\include\\stdio.h"
