#--- Mathew Bray (mathew.bray@gmail.com)

#--- Window Title
$host.ui.RawUI.WindowTitle = “Cisco Config Dumper”

#--- Date/Time 
$datetime = (get-date -f yyyy-MM-dd-HHmm-ss)

#--- GET GENERATED DEVICE LIST
$allDevices = "C:\CyberTransport\Applications\SCOI_Terminal_Client\hta\ciscoconfigdumper\plink\alldevices.txt"

cd C:\CyberTransport\Applications\SCOI_Terminal_Client\hta\ciscoconfigdumper\

#--- CREATE DESKTOP DIRECTORY
New-Item -Force -ItemType directory -Path "$($env:USERPROFILE)\Desktop\Cisco-Config-Dumper-Output\"
$directoryOutput = "$($env:USERPROFILE)\Desktop\Cisco-Config-Dumper-Output\"

Clear-Host
Write-Host ""

#--- ENTER CREDENTIALS
$username = read-host ' Enter Username' 
$pword = read-host ' Enter Password' -AsSecureString
$BSTR=[System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($pword)
$password = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)

Clear-Host

#--- GET CONFIGS
(Get-Content $allDevices) | foreach {
    Write-Host "" 
    Write-Host " Connecting to $_" -ForegroundColor Green
    Write-Host "      Negotiating... "
    echo Y | C:\CyberTransport\Applications\SCOI_Terminal_Client\hta\ciscoconfigdumper\plink\plink.exe -ssh -2 -l $username -pw "$password" $_ -m C:\CyberTransport\Applications\SCOI_Terminal_Client\hta\ciscoconfigdumper\plink\exit.txt | Out-Null 
    Write-Host "      Retrieving Config... "
    C:\CyberTransport\Applications\SCOI_Terminal_Client\hta\ciscoconfigdumper\plink\plink.exe -ssh -2 -l $username -pw "$password" -batch $_ -m C:\CyberTransport\Applications\SCOI_Terminal_Client\hta\ciscoconfigdumper\plink\show-run.txt | Out-File "$($env:USERPROFILE)\Desktop\Cisco-Config-Dumper-Output\$_-$datetime-Config.txt" -Force -Append
    Write-Host "                       Done!"
    }
    
#--- NOTIFY FINISHED
$wshell = New-Object -ComObject Wscript.Shell
$wshell.Popup("Done dumping!!  :) ",0,"Cisco Config Dumper",0x1)

#--- OPEN DIRECTORY
explorer $directoryOutput