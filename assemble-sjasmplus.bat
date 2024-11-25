@echo off
rem add sjasmplus executable to your path, e.g.:
rem   set path=C:\Users\g.zito\Apps\retrocomputing\msx\sjasmplus-1.20.3.win;%path%
sjasmplus msxsprite.asm --raw=msxsprite.bin
pause

