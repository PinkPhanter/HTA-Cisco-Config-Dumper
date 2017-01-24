#--- Mathew Bray (mathew.bray@gmail.com)

.\Ping-IPrange.ps1

#--- START SCRIPT - Ping the range and extract only IPAddress info, then dump to csv
Ping-IPRange -StartAddress 132.33.48.1 -EndAddress 132.33.49.254 -Interval 10 | 
Select-Object IPAddress | 
Export-Csv .\pingoutput.txt -NoTypeInformation -Force

#--- Sort the active IP list
Import-Csv .\pingoutput.txt | Sort-Object {"{0:d3}.{1:d3}.{2:d3}.{3:d3}" -f @([int[]]$_.IPAddress.split('.'))} | Export-Csv .\pingoutput2.txt -Force -NoTypeInformation

#--- Extract column from csv and remove the header
Import-Csv .\pingoutput2.txt | Select-Object IPAddress | ForEach-Object {$_.IPAddress}  | Out-File .\pingoutput3.txt 

#Invoke-Item .\pingoutput.txt
#Invoke-Item .\pingoutput2.txt
#Invoke-Item .\pingoutput3.txt



#--- START SCRIPT - Ping the range and extract only IPAddress info, then dump to csv
Ping-IPRange -StartAddress 132.33.91.2 -EndAddress 132.33.91.60 -Interval 10 | 
Select-Object IPAddress | 
Export-Csv .\pingoutput4.txt -NoTypeInformation -Force

#--- Sort the active IP list
Import-Csv .\pingoutput4.txt | Sort-Object {"{0:d3}.{1:d3}.{2:d3}.{3:d3}" -f @([int[]]$_.IPAddress.split('.'))} | Export-Csv .\pingoutput5.txt -Force -NoTypeInformation

#--- Extract column from csv and remove the header and APPEND to previous file
Import-Csv .\pingoutput5.txt | Select-Object IPAddress | ForEach-Object {$_.IPAddress}  | Out-File .\pingoutput3.txt -Append


#Invoke-Item .\pingoutput3.txt



#--- START SCRIPT - Ping the range and extract only IPAddress info, then dump to csv
Ping-IPRange -StartAddress 132.33.22.37 -EndAddress 132.33.22.37 -Interval 10 | 
Select-Object IPAddress | 
Export-Csv .\pingoutput4.txt -NoTypeInformation -Force

#--- Sort the active IP list
Import-Csv .\pingoutput4.txt | Sort-Object {"{0:d3}.{1:d3}.{2:d3}.{3:d3}" -f @([int[]]$_.IPAddress.split('.'))} | Export-Csv .\pingoutput5.txt -Force -NoTypeInformation

#--- Extract column from csv and remove the header and APPEND to previous file
Import-Csv .\pingoutput5.txt | Select-Object IPAddress | ForEach-Object {$_.IPAddress}  | Out-File .\pingoutput3.txt -Append


#Invoke-Item .\pingoutput3.txt

Copy-Item .\pingoutput3.txt .\alldevices.txt -Force

#Convert the file to UTF-8 w/o BOM
$OldFile = ".\ebns.txt"
$NewFile = Get-Content $OldFile
[System.IO.File]::WriteAllLines($OldFile, $NewFile)