if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit }
$camera = $null
$camera = (Get-PnpDevice -Class "Camera" -ErrorAction SilentlyContinue)
if($null -ne $camera){
$camera = $camera[0]
if ($camera.Status.ToLower() -eq "ok"){
Write-Host "$($camera.FriendlyName)" is currently enabled.
Write-Host The device will now be disabled.
Disable-PnpDevice -InstanceId $camera.InstanceId -confirm:$false
Write-Host Complete!
}

if ($camera.Status.ToLower() -eq "error"){
Write-Host "$($camera.FriendlyName)" is currently disabled.
Write-Host The device will now be enabled.
Enable-PnpDevice -InstanceId $camera.InstanceId -confirm:$false
Write-Host Complete!
}
}else{
Write-Host No camera found!
Write-Host Exiting...
}

Start-Sleep -s 5