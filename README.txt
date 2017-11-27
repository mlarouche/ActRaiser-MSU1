ActRaiser MSU-1
Version 1.0
by DarkShock

This hack adds CD quality audio to ActRaiser using the MSU-1 chip invented by byuu.
The hack has been tested on SD2SNES, bsnes-plus 073.1b and higan 094.
The patched ROM needs to be named actraiser_msu1.sfc.

The music pack can be found here: http://www.mediafire.com/file/biiqxaf3jncd9vi/ActRaiser_MSU1_Music.7z

Original ROM specs:
ACTRAISER-USA
1048576 Bytes (8.0000 Mb)
Padded: Maybe, 32768 Bytes (0.2500 Mb)
Interleaved/Swapped: No
Backup unit/emulator header: No
Internal size: 8 Mb
Version: 1.0
Checksum: Ok, 0x83db (calculated) == 0x83db (internal)
Inverse checksum: Ok, 0x7c24 (calculated) == 0x7c24 (internal)
Checksum (CRC32): 0xeac3358d

===============
= Using BSNES =
===============
1. Patch the ROM
2. Unzip the .pcm
3. Launch the game

===============
= Using higan =
===============
1. Patch the ROM
2. Launch it using higan
3. Go to %USERPROFILE%\Emulation\Super Famicom\actraiser_msu1.sfc in Windows Explorer.
4. Copy manifest.bml and the .pcm file there
5. Run the game

====================
= Using on SD2SNES =
====================
Drop the ROM file, actraiser_msu1.msu and the .pcm files in any folder. (I really suggest creating a folder)
Launch the game and voilà, enjoy !

===========
= Credits =
===========
* DarkShock - ASM hacking & coding, Music editing
* Abyss Rebirth - Music reorchestration (https://www.youtube.com/watch?v=svWGSOT17XA)

=========
= Music =
=========
00 = Fillmore
01 = Sky Palace
02 = Bloodpool ~ Casandora
03 = The Beast Appears (Boss Battle 1)
05 = Aitos ~ Temple
06 = Powerful Enemy (Boss Battle 2)
07 = Opening
08 = Descent
09 = Piramid ~ Marana
10 = Birth of the People
12 = North Wall
13 = All over the World
14 = Satan
15 = Silence (name of the track, not actual silence) (No Loop)
16 = Sacrifices
19 = Peaceful World
21 = Ending (Long Track)

=============
= Compiling =
=============
Source is availabe on GitHub: https://github.com/mlarouche/ActRaiser-MSU1

To compile the hack you need

* bass v14 (http://files.byuu.org/download/bass_v14.tar.xz)
* msupcm (https://github.com/qwertymodo/msupcmplusplus)

To distribute the hack you need

* uCON64 (http://ucon64.sourceforge.net/)
* 7-Zip (http://www.7-zip.org/)

make.bat assemble the patch
distribute.bat distribute the patch
make_all.bat does everything
