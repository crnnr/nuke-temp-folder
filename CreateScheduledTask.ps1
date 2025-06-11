
$ErrorActionPreference = "Stop"

param(
    [Parameter(Mandatory=$true, HelpMessage="Path to the nukeTempFolder.ps1 script")]
    [string]$ScriptPath,
    
    [Parameter(Mandatory=$true, HelpMessage="Path to the temp folder to clean")]
    [string]$TempFolderPath,
    
    [Parameter(Mandatory=$false, HelpMessage="Name of the scheduled task")]
    [string]$TaskName = "NukeTempFolder"
)

# Check if script exists
if (-not (Test-Path $ScriptPath)) {
    Write-Error "Script not found at: $ScriptPath"
}

if (-not (Test-Path $TempFolderPath)) {
    Write-Error "Temp folder not found at: $TempFolderPath"
}

try {

    $Action = New-ScheduledTaskAction -Execute "PowerShell.exe" -Argument "-ExecutionPolicy Bypass -File `"$ScriptPath`" -Path `"$TempFolderPath`""
    $Trigger = New-ScheduledTaskTrigger -AtLogon
    $User = New-ScheduledTaskPrincipal -UserId $env:USERNAME -LogonType Interactive
       
    $Task = New-ScheduledTask -Action $Action -Trigger $Trigger -Principal $User -Settings $Settings -Description "Automatically clean temp folder at user logon"
    Register-ScheduledTask -TaskName $TaskName -InputObject $Task -Force
    
    # Chck scheduled task
    Get-ScheduledTask -TaskName $TaskName | Format-List TaskName, State, Description
}
catch {
    Write-Error "Error creating scheduled task: $_)"
    exit 1
}