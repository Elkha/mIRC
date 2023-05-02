chcp 65001

: 설치 방법
: 1. 폴더 생성한다.
: 2. https://raw.githubusercontent.com/Elkha/mIRC/main/캡쳐.bat 내용을 복사한다.
: 3. 메모장을 열고 캡쳐.bat 으로 생성했던 폴더에 저장한다. (이름 무관)
: 4. 실행
: 제작 환경: windows 10 x64

curl http://www.nirsoft.net/utils/nircmd-x64.zip --output nircmd-x64.zip

mkdir nircmd-x64

tar -xf ./nircmd-x64.zip --directory nircmd-x64/

del nircmd-x64.zip




@echo off

echo ; mIRC 에서 Alt + R 키를 눌러 이 내용을 추가합니다.>"%cd%\install.txt"
echo ; 명령어: /캡쳐>>"%cd%\install.txt"
echo alias 캡쳐 {>>"%cd%\install.txt"
echo   if ($exists(%cd%\capture.txt)) /remove %cd%\capture.txt>>"%cd%\install.txt"
echo   if ($exists(%cd%\capture.png)) /remove %cd%\capture.png>>"%cd%\install.txt"
echo   /run "%cd%\nircmd-x64\nircmd.exe" cmdwait 0 savescreenshot "%cd%\capture.png">>"%cd%\install.txt"
echo   /run curl -o "%cd%\capture.txt" -F image=@%cd%\capture.png http://cs406.iptime.org/>>"%cd%\install.txt"
echo   /캡쳐_결과 5 >>"%cd%\install.txt"
echo }>>"%cd%\install.txt"
echo alias 캡쳐_결과 {>>"%cd%\install.txt"
echo   if ($exists(%cd%\capture.txt)) {>>"%cd%\install.txt"
echo     editbox -b $read(%cd%\capture.txt, 1)>>"%cd%\install.txt"
echo     var %%total_lines $lines(%cd%\capture.txt)>>"%cd%\install.txt"
echo     var %%i 2 >>"%cd%\install.txt"
echo     while (%%i ^<= %%total_lines) {>>"%cd%\install.txt"
echo      echo -a $read(%cd%\capture.txt, %%i)>>"%cd%\install.txt"
echo      inc %%i>>"%cd%\install.txt"
echo     }>>"%cd%\install.txt"
echo     .timer 1 1 remove %cd%\capture.txt>>"%cd%\install.txt"
echo   }>>"%cd%\install.txt"
echo   elseif ($1 ^> 0) {>>"%cd%\install.txt"
echo     .timer 1 1 캡쳐_결과 $calc($1 - 1)>>"%cd%\install.txt"
echo   }>>"%cd%\install.txt"
echo   else {>>"%cd%\install.txt"
echo     echo -a Error: Failed to read the capture.txt file after multiple retries>>"%cd%\install.txt"
echo   }>>"%cd%\install.txt"
echo }>>"%cd%\install.txt"



start /B notepad "%cd%\install.txt"
