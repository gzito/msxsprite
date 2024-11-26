;
; Simple sprite example for MSX written using Z80 assembly language
; Assembled with sjasmplus (https://github.com/z00m128/sjasmplus)
;

; Copyright (c) 2024 Giovanni Zito
;
; Permission is hereby granted, free of charge, to any person obtaining a copy
; of this software and associated documentation files (the "Software"), to deal
; in the Software without restriction, including without limitation the rights
; to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
; copies of the Software, and to permit persons to whom the Software is
; furnished to do so, subject to the following conditions:
;
; The above copyright notice and this permission notice shall be included in all
; copies or substantial portions of the Software.
;
; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
; IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
; FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
; AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
; LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
; OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
; SOFTWARE.

; MSX ROM BASIC BIOS calls
WRTVDP      EQU      0047H    ; write a byte to any VDP register
RDVRM       EQU      004AH    ; read VRAM addressed using [HL]
WRTVRM      EQU      004DH    ; write VRAM addressed using [HL]
SETRD       EQU      0050H    ; sets up VDP for read
SETWRT      EQU      0053H    ; sets up VDP for write
FILVRM      EQU      0056H    ; fill VRAM with specified data
LDIRMV      EQU      0059H    ; moves block of data from VRAM to memory
LDIRVM      EQU      005CH    ; moves block of data from memory to VRAM
CHGMOD      EQU      005FH    ; change screen mode of VDP to [SCRMOD]
CHGCLR      EQU      0062H    ; change foreground, background, border color
CALPAT      EQU      0084H    ; get address of sprite pattern table
CALATR      EQU      0087H    ; get address of sprite attribute table
GRPPRT      EQU      008DH    ; print a character ob the graphics screen
CLS         EQU      00C3H    ; clear screen
GTSTCK      EQU      00D5H    ; return status of joystick
GTTRIG      EQU      00D8H    ; read joystick trigger button

; BIN header
      DB    0FEH     ; magic number
      DW    BEGIN    ; begin address of the program
      DW    THEEND   ; end address of the program
      DW    BEGIN    ; program execution address (for ,R option)

      ORG   0E000H   ; The program start at E000h in the MSX's RAM

BEGIN:
      ; install my HTIMI hook at 0FD9FH
      DI                   ; disable interrupts, just in case this interrupt would be called while changing the hook
      LD    A,0C3H         ; JP opcode
      LD    (0FD9FH),A     ; 
      LD    HL,MYINTH      ; JP operand
      LD    (0FD9FH+1),HL  ; 
      EI                   ; enable interrupt

      ; set screen 2
      LD    A,2
      CALL  CHGMOD

      ; change screen colours
      LD    IX,0F3E9H
      LD    (IX),15        ; foreground white
      LD    (IX+1),1       ; background black
      LD    (IX+2),1       ; border col black
      CALL  CHGCLR
      
      ; clear the screen
      XOR   A
      CALL  CLS

       ;  uncomment the following lines to set magnified sprites
;      LD    C,1            ; VDP register number -> C
;      LD    A,(0F3E0H)     ; current VPD register 1 value
;      OR    1              ; set bit 0 - magnified sprites
;      LD    B,A            ; VDP data -> B
;      CALL  WRTVDP         ; write VDP register

      ; get sprite pattern start addr for pattern 0
      LD    A,0
      CALL  CALPAT
      LD    (SPR0PT_VRAMPTR),HL

      ; get sprite attribute table start addr for plane 0
      LD    A,0
      CALL  CALATR
      LD    (SPR0AT_VRAMPTR),HL

      ; write sprite pattern in VRAM
      LD    HL,SPR0PT
      LD    DE,(SPR0PT_VRAMPTR)
      LD    BC,8
      CALL  LDIRVM

      CALL  UPDATE_SPR0ATTR

LOOP: 
      ; check for spacebar
      LD    A,0      ; space
      CALL  GTTRIG   ; GTTRIG
      CP    0FFH     ; pressed?
      JR    Z,EXIT
     
      ; every 1/50th sec
      LD    A,(TICKER)
      CP    1
      JR    NC,MOVEIT
      JR    LOOP

MOVEIT:
      ; check joy
      LD    A,0      ; cursor keys
      CALL  GTSTCK   ; GTSTCK
      CP    3        ; right?
      JR    Z,RIGHT
      CP    7        ; left?
      JR    Z,LEFT
      JR    LOOP

LEFT:
      LD    HL, SPR0AT+1
      DEC   (HL)
      CALL  UPDATE_SPR0ATTR
      LD    HL,TICKER
      LD    (HL),0
      JR    LOOP

RIGHT:
      LD    HL, SPR0AT+1
      INC   (HL)
      CALL  UPDATE_SPR0ATTR
      LD    HL,TICKER
      LD    (HL),0
      JR    LOOP


UPDATE_SPR0ATTR:
      ; write sprite attributes in VRAM
      LD    HL,SPR0AT
      LD    DE,(SPR0AT_VRAMPTR)
      LD    BC,4
      CALL  LDIRVM
      RET

EXIT: RET

; sprite pattern (8 bytes)
SPR0PT: DB    018H, 03CH, 0FFH, 099H, 099H, 0FFH, 0C3H, 0FFH
; sprite attributes (posy, posx, plane, color)
SPR0AT: DB    192/2, 256/2, 0, 08H

SPR0PT_VRAMPTR: DW   0
SPR0AT_VRAMPTR: DW   0

TICKER:         DB   0

; my HTIMI interrupt routine
MYINTH:
      PUSH  HL
      LD    HL,TICKER
      INC   (HL)
      POP   HL
      RET

THEEND:  END
