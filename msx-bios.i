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

;
; MSX ROM BASIC BIOS calls
;

CHKRAM:     EQU      0000H    ;Finds all connected RAM and cartridges
SYNCHR:     EQU      0008H    ;Check byte following the RST 8, see if equal to the byte pointed by HL
RDSLT:      EQU      000CH    ;Read a byte from another slot 
CHRGTR:     EQU      0010H    ;Fetch next char from BASIC text
WRSLT:      EQU      0014H    ;Write a byte to another slot
OUTDO:      EQU      0018H    ;Output a char to the Console or printer
CALSLT:     EQU      001CH    ;Perform Inter-slot call
DCOMPR:     EQU      0020H    ;Compares [HL] to [DE]
ENASLT:     EQU      0024H    ;Permanently enables a slot
GETYPR:     EQU      0028H    ;Returns the [FAC] type
CALLF:      EQU      0030H    ;Performs Far-call (i.e., Inter-slot)
KEYINT:     EQU      0038H    ;Handlers for hardware interrupt
INITIO:     EQU      003BH    ;Do device initialization
INIFNK:     EQU      003EH    ;Reset all function key's text
DISSCR:     EQU      0041H    ;Disables screen display
ENASCR:     EQU      0044H    ;Enables screen display
WRTVDP:     EQU      0047H    ;Write a byte to any VDP register
RDVRM:      EQU      004AH    ;Read VRAM addressed using [HL]
WRTVRM:     EQU      004DH    ;Write VRAM addressed using [HL]
SETRD:      EQU      0050H    ;Sets up VDP for read
SETWRT:     EQU      0053H    ;Sets up VDP for write
FILVRM:     EQU      0056H    ;Fill VRAM with specified data
LDIRMV:     EQU      0059H    ;Moves block of data from VRAM to memory
LDIRVM:     EQU      005CH    ;Moves block of data from memory to VRAM
CHGMOD:     EQU      005FH    ;Change screen mode of VDP to [SCRMOD]
CHGCLR:     EQU      0062H    ;Change foreground, background, border color
NMI:        EQU      0066H    ;Handler for non-maskable interrupt
CLRSPR:     EQU      0069H    ;Init sprite data
INITXT:     EQU      006CH    ;Init VDP for 40 x 24 text mode (SCREEN 0)
INIT32:     EQU      006FH    ;Init VDP for 32 x 24 text mode (SCREEN 1)
INIGRP:     EQU      0072H    ;Init VDP for High resolution mode (SCREEN 2)
INIMLT:     EQU      0075H    ;Init VDP for Multi color mode (SCREEN 3)
SETTXT:     EQU      0078H    ;Sets VDP to display 40 x 24 text mode
SETT32:     EQU      007BH    ;Sets VDP to display 32 x 24 text mode
SETGRP:     EQU      007EH    ;Sets VDP to display High-res mode
SETMLT:     EQU      0081H    ;Sets VDP to display Multi color mode
CALPAT:     EQU      0084H    ;Get address of sprite pattern table
CALATR:     EQU      0087H    ;Get address of sprite attribute table
GSPSIZ:     EQU      008AH    ;Returns current sprite size
GRPPRT:     EQU      008DH    ;Print a character on the graphic screen
GICINI:     EQU      0090H    ;Init PSG, and static data for PLAY
WRTPSG:     EQU      0093H    ;Write data to PSG
RDPSG:      EQU      0096H    ;Read data from PSG
STRTMS:     EQU      0099H    ;Checks and start background task for PLAY
CHSNS:      EQU      009CH    ;Checks status of keyboard status
CHGET:      EQU      009FH    ;Return char typed, with wait
CHPUT:      EQU      00A2H    ;Output character to console
LPTOUT:     EQU      00A5H    ;Output character to printer, if possible
LPTSTT:     EQU      00A8H    ;Checks status of line printer
CNVCHR:     EQU      00ABH    ;Checks for graphic header byte and convert code
PINLIN:     EQU      00AEH    ;Read line from keyboard to buffer
INLIN:      EQU      00B1H    ;Same as above, except In case of AUTFLG is set
QINLIN:     EQU      00B4H    ;Print a "?", then jump to INLIN
BREAKX:     EQU      00B7H    ;[Control-STOP] pressed??
ISCNTC:     EQU      00BAH    ;[Shift-STOP] pressed??
CKCNTC:     EQU      00BDH    ;Same as ISCNTC, but used by BASIC
BEEP:       EQU      00C0H    ;Buzz
CLS:        EQU      00C3H    ;Clear screen
POSIT:      EQU      00C6H    ;Place cursor at Column [H], Row [L]
FNKSB:      EQU      00C9H    ;Display Function key, if necessary
ERAFNK:     EQU      00CCH    ;Stop displaying the Function keys
DSPFNK:     EQU      00CFH    ;Enable Function key display
TOTEXT:     EQU      00D2H    ;Force screen to text mode
GTSTCK:     EQU      00D5H    ;Return status of joystick
GTTRIG:     EQU      00D8H    ;Read joystick trigger button
GTPAD:      EQU      00DBH    ;Returns status of graphic pad
GTPDL:      EQU      00DEH    ;Read paddle
TAPION:     EQU      00E1H    ;Turn on motor and read tape header
TAPIN:      EQU      00E4H    ;Read tape data
TAPIOF:     EQU      00E7H    ;Stops reading from tape
TAPOON:     EQU      00EAH    ;Turn on motor and write tape header
TAPOUT:     EQU      00EDH    ;Write data to tape
TAPOFF:     EQU      00F0H    ;Stops writing to tape
STMOTR:     EQU      00F3H    ;Start, stop cassette motor, or flip motor(on to off, off to on)
LFTQ:       EQU      00F6H    ;Bytes left in queue
PUTQ:       EQU      00F9H    ;Send a byte to queue
RIGHTC:     EQU      00FCH    ;Moves one pixel right
LEFTC:      EQU      00FFH    ;Moves one pixel left
UPC:        EQU      0102H    ;Moves one pixel up
TUPC:       EQU      0105H    ;Moves one pixel up
DOWNC:      EQU      0108H    ;Moves one pixel down
TDOWNC:     EQU      010BH    ;Moves one pixel down
SCALXY:     EQU      010EH    ;Scales X Y cordinates
MAPXYC:     EQU      0111H    ;Maps cordinates to physical address
FETCHC:     EQU      0114H    ;Get current physical address and mask pattern
STOREC:     EQU      0117H    ;Put current physical address and mask pattern
SETATR:     EQU      011AH    ;Sets the color attribute byte
READC:      EQU      011DH    ;Reads attribute of current pixel
SETC:       EQU      0120H    ;Sets current pixel to specified attribute
NSETCX:     EQU      0123H    ;Sets pixel horizontally
GTASPC:     EQU      0126H    ;Returns aspect ratio
PNTINI:     EQU      0129H    ;Do paint initialization
SCANR:      EQU      012CH    ;Scan pixels to the right
SCANL:      EQU      012FH    ;Scan pixels to the left
CHGCAP:     EQU      0132H    ;Turn [CAPSLOCK] light, on/off
CHGSND:     EQU      0135H    ;Change status of 1 bit sound port
RSLREG:     EQU      0138H    ;Return output of primary slot register
WSLREG:     EQU      013BH    ;Write to primary slot register
RDVDP:      EQU      013EH    ;Read VDP status register
SNSMAT:     EQU      0141H    ;Read a specified row in the keyboard matrix
PHYDIO:     EQU      0144H    ;Performs operation for mass storage devices (such as disks)
FORMAT:     EQU      0147H    ;Initialize mass storage device
ISFLIO:     EQU      014AH    ;Are we doing device I/O
OUTDLP:     EQU      014DH    ;Output to line printer
GETVCP:     EQU      0150H    ;Used by Music background tasking
GETVC2:     EQU      0153H    ;Used by Music background tasking
KILBUF:     EQU      0156H    ;Clear the keyboard buffer
CALBAS:     EQU      0159H    ;Performs far-call into BASIC
