<#	
  .Synopsis
    Import Powershell Module into C:\Program Files\WindowsPowerShell\Modules
  .NOTES
    Created:   	    July, 2020
    Created by:	    Phil Helmling, @philhelmling
    Organization:   VMware, Inc.
    Filename:       ImportPSModule.ps1
	.DESCRIPTION
    Copy modules in same directory as this script, then import Powershell Module into C:\Program Files\WindowsPowerShell\Modules
  .EXAMPLE
    powershell.exe -executionpolicy bypass -file .\ImportPSModule.ps1
#>
$to = ""$env:ProgramFiles\WindowsPowerShell\Modules\""

$current_path = $PSScriptRoot;
if($PSScriptRoot -eq ""){
    #PSScriptRoot only popuates if the script is being run.  Default to default location if empty
    $current_path = "C:\Temp";
}

$module = Get-ChildItem -Path $current_path -Include *.psm1* -Recurse -ErrorAction SilentlyContinue | % {

    $modulename = $module.FullName

    New-Item -Path $to\$modulename -ItemType 
    
    Copy-Item -Path $module -Destination $to -Force

    Import-Module -Name $modulename

    if (!(Get-Module -Name $modulename)) {
        return 1
    }
}

