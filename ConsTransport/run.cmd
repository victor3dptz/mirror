@echo off
dir /b D:\ConsTransport\INCOMING\ > dir1
"D:\ConsTransport\wget\bin\wget.exe" --cache=off -A *.rar -nd -v -l1 -P D:\ConsTransport\INCOMING --http-user=USER --http-password=PASS http://private.URL/update/
dir /b D:\ConsTransport\INCOMING\ > dir2

fc /L dir1 dir2 >fc
if %errorlevel% == 1 goto UPDATE
goto end
:UPDATE
rem d:\consultant\CREG.EXE
FOR /f "skip=2 tokens=1 delims=," %%i in ('find ".rar" d:\ConsTransport\wget\bin\fc') do d:\consultant\rar.exe e -y d:\constransport\incoming\%%i d:\consultant\receive
del /q /f d:\consultant\receive\*.res
d:\consultant\cons.exe /adm /receive /base*
del /q /f d:\consultant\receive\*.ans
del /q /f d:\consultant\receive\*.rgt
rem d:\consultant\CREG.EXE
:END
exit