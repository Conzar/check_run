@ECHO OFF
set filename=%1

# create a file echo > test.txt
REM test if fielname exists

IF EXIST %filename% (
	exit 0;
) ELSE (
	exit 1;
)