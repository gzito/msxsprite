; MSX ROM BASIC BIOS calls
CHKRAM:     EQU      0000H
SYNCHR:     EQU      0008H
RDSLT:      EQU      000CH
CHRGTR:     EQU      0010H
WRSLT:      EQU      0014H
OUTDO:      EQU      0018H
CALSLT:     EQU      001CH
DCOMPR:     EQU      0020H
ENASLT:     EQU      0024H
GETYPR:     EQU      0028H
CALLF:      EQU      0030H
KEYINT:     EQU      0038H
INITIO:     EQU      003BH
INIFNK:     EQU      003EH
DISSCR:     EQU      0041H    ; disables screen display
ENASCR:     EQU      0044H    ; enables screen display
WRTVDP:     EQU      0047H    ; write a byte to any VDP register
RDVRM:      EQU      004AH    ; read VRAM addressed using [HL]
WRTVRM:     EQU      004DH    ; write VRAM addressed using [HL]
SETRD:      EQU      0050H    ; sets up VDP for read
SETWRT:     EQU      0053H    ; sets up VDP for write
FILVRM:     EQU      0056H    ; fill VRAM with specified data
LDIRMV:     EQU      0059H    ; moves block of data from VRAM to memory
LDIRVM:     EQU      005CH    ; moves block of data from memory to VRAM
CHGMOD:     EQU      005FH    ; change screen mode of VDP to [SCRMOD]
CHGCLR:     EQU      0062H    ; change foreground, background, border color
NMI:        EQU      0066H    ; handler for non-maskable interrupt
CLRSPR:     EQU      0069H    ; init sprite data
INITXT:     EQU      006CH    ; init VDP for 40 x 24 text mode (SCREEN 0)
INIT32:     EQU      006FH    ; init VDP for 32 x 24 text mode (SCREEN 1)
INIGRP:     EQU      0072H    ; init VDP for High resolution mode (SCREEN 2)
INIMLT:     EQU      0075H    ; init VDP for Multi color mode (SCREEN 3)
SETTXT:     EQU      0078H    ; sets VDP to display 40 x 24 text mode
SETT32:     EQU      007BH    ; sets VDP to display 32 x 24 text mode
SETGRP:     EQU      007EH    ; sets VDP to display High-res mode
SETMLT:     EQU      0081H    ; sets VDP to display Multi color mode
CALPAT:     EQU      0084H    ; get address of sprite pattern table
CALATR:     EQU      0087H    ; get address of sprite attribute table
GSPSIZ:     EQU      008AH    ; returns current sprite size
GRPPRT:     EQU      008DH    ; print a character on the graphic screen
GICINI:     EQU      0090H
WRTPSG:     EQU      0093H
RDPSG:      EQU      0096H
STRTMS:     EQU      0099H
CHSNS:      EQU      009CH
CHGET:      EQU      009FH
CHPUT:      EQU      00A2H
LPTOUT:     EQU      00A5H
LPTSTT:     EQU      00A8H
CNVCHR:     EQU      00ABH
PINLIN:     EQU      00AEH
INLIN:      EQU      00B1H
QINLIN:     EQU      00B4H
BREAKX:     EQU      00B7H
ISCNTC:     EQU      00BAH
CKCNTC:     EQU      00BDH
BEEP:       EQU      00C0H
CLS:        EQU      00C3H    ; clear screen
POSIT:      EQU      00C6H
FNKSB:      EQU      00C9H
ERAFNK:     EQU      00CCH
DSPFNK:     EQU      00CFH
TOTEXT:     EQU      00D2H
GTSTCK:     EQU      00D5H    ; return status of joystick
GTTRIG:     EQU      00D8H    ; read joystick trigger button
GTPAD:      EQU      00DBH
GTPDL:      EQU      00DEH
TAPION:     EQU      00E1H
TAPIN:      EQU      00E4H
TAPIOF:     EQU      00E7H
TAPOON:     EQU      00EAH
TAPOUT:     EQU      00EDH
TAPOOF:     EQU      00F0H
STMOTR:     EQU      00F3H
LFTQ:       EQU      00F6H
PUTQ:       EQU      00F9H
RIGHTC:     EQU      00FCH
LEFTC:      EQU      00FFH
UPC:        EQU      0102H
TUPC:       EQU      0105H
DOWNC:      EQU      0108H
TDOWNC:     EQU      010BH
SCALXY:     EQU      010EH
MAPXY:      EQU      0111H
FETCHC:     EQU      0114H
STOREC:     EQU      0117H
SETATR:     EQU      011AH
READC:      EQU      011DH
SETC:       EQU      0120H
NSETCX:     EQU      0123H
GTASPC:     EQU      0126H
PNTINI:     EQU      0129H
SCANR:      EQU      012CH
SCANL:      EQU      012FH
CHGCAP:     EQU      0132H
CHGSND:     EQU      0135H
RSLREG:     EQU      0138H
WSLREG:     EQU      013BH
RDVDP:      EQU      013EH
SNSMAT:     EQU      0141H
PHYDIO:     EQU      0144H
FORMAT:     EQU      0147H
ISFLIO:     EQU      014AH
OUTDLP:     EQU      014DH
GETVCP:     EQU      0150H
GETVC2:     EQU      0153H
KILBUF:     EQU      0156H
CALBAS:     EQU      0159H
