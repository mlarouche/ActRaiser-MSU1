@ECHO OFF
del actraiser_msu1.sfc

copy actraiser_original.sfc actraiser_msu1.sfc

set BASS_ARG=
if "%~1" == "emu" set BASS_ARG=-d EMULATOR_VOLUME

bass %BASS_ARG% -o actraiser_msu1.sfc actraiser_msu1.asm
