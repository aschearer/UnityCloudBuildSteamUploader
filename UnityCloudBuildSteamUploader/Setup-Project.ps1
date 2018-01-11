# Sets up the Steamworks SDK so it's ready to be run.
$displayName = Read-Host 'Project Name'
$appId = Read-Host 'Steam App Id'
$depotId = Read-Host 'Steam Depot Id'
$buildDescription = Read-Host 'Steam Build Description (Internal Only)'
$buildBranch = Read-Host 'Steam Build Branch (Blank uploads to Default)'
$exeName = Read-Host 'Executable Name'
$steamUsername = Read-Host 'Steam username'
$steamPassword = Read-Host 'Steam password' -AsSecureString

# Prompts for information needed to scan Unity Cloud Build and upload to Steamworks.
# Stores the necessary information in config.json.

$cloudBuildAPIKey = Read-Host 'Unity Cloud Build API Key'
$cloudBuildOrgId = Read-Host 'Unity Cloud Build Organization Name'
$cloudBuildProject = Read-Host 'Unity Cloud Build Project Name'
$cloudBuildTargetName = Read-Host 'Unity Cloud Build Target Name'

$steamworksDir = 'Steamworks_SDK'
$scriptsDir = "${steamworksDir}\scripts"
$projectPrefix = "${cloudBuildProject}_${cloudBuildTargetName}"
$appScriptName = "${projectPrefix}_app_build_${appId}.vdf"
$depotScriptName = "${projectPrefix}_depot_build_depot_build_${depotId}"
$contentDir = "${steamworksDir}\content\${projectPrefix}_content"

Write-Host "Creating App Script"
Set-Content "$scriptsDir/$appScriptName" @"
"appbuild"
{
    "appid"	"$appId"
    "desc" "$buildDescription" // description for this build
    "buildoutput" "..\output\" // build output folder for .log, .csm & .csd files, relative to location of this file
    "contentroot" "..\content\" // root content folder, relative to location of this file
    "setlive"	"$buildBranch" // branch to set live after successful build, non if empty
    "preview" "0" // to enable preview builds
    "local"	""	// set to flie path of local content server 
    
    "depots"
    {
        "$depotId" "$depotScriptName.vdf"
    }
}
"@

Write-Host "Creating Depot Script"
Set-Content "$scriptsDir\$depotScriptName.vdf" @"
"DepotBuildConfig"
{
    // Set your assigned depot ID here
    "DepotID" "$depotId"

    // include all files recursivley
  "FileMapping"
  {
    // This can be a full path, or a path relative to ContentRoot
    "LocalPath" ".\${projectPrefix}_content\*"
    
    // This is a path relative to the install folder of your game
    "DepotPath" "."
    
    // If LocalPath contains wildcards, setting this means that all
    // matching files within subdirectories of LocalPath will also
    // be included.
    "recursive" "1"
  }

    // but exclude all symbol files  
    // This can be a full path, or a path relative to ContentRoot
  "FileExclusion" "*.pdb"
}
"@

Write-Host "Creating Steamworks Content Directory"
New-Item -ItemType Directory -Path $contentDir

$BSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($steamPassword)
$plainPassword = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)

# We must escape the content dir otherwise the JSON will not be valid
$in = '\'
$out = '\\'
$jsonContentDir = $contentDir -replace [RegEx]::Escape($in), "$out"
Set-Content "configs/${projectPrefix}_config.json" @"
{
    "unity": {
        "api_key": "$cloudBuildAPIKey",
        "org_id": "$cloudBuildOrgId",
        "project": "$cloudBuildProject",
        "target": "$cloudBuildTargetName"
    },
    "steam": {
        "app_id": "$appId",
        "display_name": "$displayName",
        "branch_name": "$buildBranch",
        "username": "$steamUsername",
        "password": "$plainPassword",
        "app_script": "$appScriptName",
        "content_dir": "$jsonContentDir",
        "exe_path": "$jsonContentDir\\$exeName"
    }
}
"@
Write-Host "Configuration information written to config.json"
Write-Host "Project setup is complete."