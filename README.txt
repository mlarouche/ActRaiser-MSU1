ActRaiser MSU-1
Version 1.0
by DarkShock

This hack adds CD quality audio to Turtle in Time using the MSU-1 chip invented by byuu.
The hack has been tested on SD2SNES, BSNES 075, bsnes-plus 073.1b and higan 094.
The patched ROM needs to be named tmnt4_msu1.sfc.

===============
= Using BSNES =
===============
1. Patch the ROM
2. Generate the .pcm
3. Launch the game

===============
= Using higan =
===============
1. Patch the ROM
2. Launch it using higan
3. Go to %USERPROFILE%\Emulation\Super Famicom\tmnt4_msu1.sfc in Windows Explorer.
4. Copy manifest.bml and the .pcm file there
5. Run the game

====================
= Using on SD2SNES =
====================
Drop the ROM file, som_msu1.msu and the .pcm files in any folder. (I really suggest creating a folder)
Launch the game and voilà, enjoy !

===========
= Credits =
===========
* DarkShock - ASM hacking & coding, Music editing

=========
= Music =
=========


=============
= Compiling =
=============
Source is availabe on GitHub: https://github.com/mlarouche/ActRaiser-MSU1

To compile the hack you need

* bass v14 (http://www.byuu.org/tool/bass/)
* wav2msu (https://github.com/mlarouche/wav2msu)

To distribute the hack you need

* uCON64 (http://ucon64.sourceforge.net/)
* 7-Zip (http://www.7-zip.org/)

make.bat assemble the patch
create_pcm.bat create the .pcm from the WAV files
distribute.bat distribute the patch
make_all.bat does everything
