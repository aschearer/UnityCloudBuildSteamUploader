# This will run the publish script manually so you can confirm it 
# works and fix any issues with Steam Guard.

$configFile = Read-Host 'Config File Name'

$pwd = $PSScriptRoot

$config = Get-Content "configs/$configFile" | ConvertFrom-Json

$steamUsername = $config.steam.username
$steamPassword = $config.steam.password
$steamAppId = $config.steam.app_id
$steamAppScript = $config.steam.app_script
$steamExe = $pwd + "\" + $config.steam.exe_path


# This crazy thing is to make sure ^ and other special characters get through
$passArg = @"
"$steamPassword"
"@

Write-Host "Invoking Steamworks SDK"

& ".\Steamworks_SDK\Publish-Build.bat" $steamUsername $passArg $steamAppId $steamAppScript $steamExe