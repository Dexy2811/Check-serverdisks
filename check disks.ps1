# Starts script as local administrator
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit }
#checks how much storage there is left on a storage disk remotely.
#as long a user has correct permissions.
Invoke-Command -ComputerName "server1","server2" -Credential domain\user {Get-PSDrive | Where {$_.Free -gt 0}} | Select psComputerName,Root,@{Name="Used (GB)";expression={ "{0:N2}" -f ($_.used / 1gb) }}, @{Name="Total (GB)";expression={ "{0:N2}" -f (($_.used + $_.free)/1gb) }}, @{Name="Free (GB)";expression={ "{0:N2}" -f ($_.used / 1gb) }}
# Pauses script so you get to read the output.
pause