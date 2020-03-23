if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit }
$camera = $null
$camera = (Get-PnpDevice -Class "Camera" -ErrorAction SilentlyContinue)
if($null -ne $camera){
$camera = $camera[0]
if ($camera.Status.ToLower() -eq "ok"){
Write-Host "$($camera.FriendlyName)" is currently enabled.
}

elseif ($camera.Status.ToLower() -eq "error"){
Write-Host "$($camera.FriendlyName)" is currently disabled.
}else{
Write-Host Current status of "$($camera.FriendlyName)" - $($camera.Status).
}
}else{
Write-Host No camera found!
Write-Host Exiting...
}

Start-Sleep -s 5