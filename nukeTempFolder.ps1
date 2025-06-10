param(
    [Parameter(HelpMessage="Path to the temp folder, which content should be wiped to oblivion", ValueFromPipeline=$false)] 
    [string]
    $Path = "C:\temp"
)

function Remove-File($FileItem) {
    Remove-Item -LiteralPath $FileItem.FullName -Force -Recurse
}

function Remove-Folder($FolderItem) {
    $folderChildItems = Get-ChildItem -LiteralPath $FolderItem.FullName -Force
    foreach ($folderChildItem in $folderChildItems) {
        Remove-FileOrFolder($folderChildItem)
    }
    Remove-Item $FolderItem.Delete() -Recurse
}

function Remove-FileOrFolder($Item) {
    if (Test-Path -Path $Item.FullName -PathType Container) {
        Remove-Folder($Item)
    }
    else {
        Remove-File($Item)
    }
}

function Main {
    $Items = Get-ChildItem -LiteralPath $Path -Force
    foreach ($Item in $Items) {
        Write-Output "Removeing $($Item.FullName)"
        Remove-FileOrFolder($Item)
    }
}

$ErrorActionPreference = "SilentlyContinue"
Main
