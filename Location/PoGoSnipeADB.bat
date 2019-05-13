@echo off
SET /A COUNTER=1

:start
echo Give new location or type '?q' to stop.

set /p location="Latitude,Longitude: "

if "%location%"=="?q" (
	goto stop_sniping
) else (
	FOR /F "tokens=1,2 delims=," %%a IN ("%location%") do (
		START /B /WAIT adb shell am start -a android.intent.action.MAIN -c android.intent.category.HOME
		START /B /WAIT adb shell settings put secure location_providers_allowed -gps
		START /B /WAIT adb shell am startservice -a theappninjas.gpsjoystick.TELEPORT --ef lat %%a --ef lng %%b
		START /B /WAIT adb shell settings put secure location_providers_allowed +gps
		START /B /WAIT adb shell am start -n com.nianticlabs.pokemongo/com.nianticproject.holoholo.libholoholo.unity.UnityMainActivity
		set /A COUNTER=COUNTER+1
	)
	echo[
	echo Counter: %COUNTER%
	echo[
	goto start
)

:stop_sniping
echo[
set /p qenter="Press enter to quit... "
quit
