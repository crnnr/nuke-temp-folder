param(
    [Parameter(Mandatory=$true, HelpMessage="Path to the temp folder, which content should be wiped to oblivion", ValueFromPipeline=$false)] 
    [string]
    $Path
)
$ErrorActionPreference = "SilentlyContinue"
$Items = Get-ChildItem -LiteralPath $Path -Force
foreach ($Item in $Items) {
    Write-Host "Removing $($Item.FullName)"
    Remove-Item -LiteralPath $Item.FullName -Force -Recurse
}