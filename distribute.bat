@ECHO OFF

del /q ActRaiser_MSU1.zip
del /q ActRaiser_MSU1_Music.7z

mkdir ActRaiser_MSU1
ucon64 -q --snes --chk actraiser_msu1.sfc
ucon64 -q --mki=actraiser_original.sfc actraiser_msu1.sfc
copy actraiser_msu1.ips ActRaiser_MSU1
copy README.txt ActRaiser_MSU1
copy actraiser_msu1.msu ActRaiser_MSU1
copy actraiser_msu1.xml ActRaiser_MSU1
copy manifest.bml ActRaiser_MSU1

"C:\Program Files\7-Zip\7z" a -r ActRaiser_MSU1.zip ActRaiser_MSU1

"C:\Program Files\7-Zip\7z" a ActRaiser_MSU1_Music.7z *.pcm

del /q actraiser_msu1.ips
rmdir /s /q ActRaiser_MSU1