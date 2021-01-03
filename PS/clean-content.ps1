
# Create variables
Set-Location = $PSScriptRoot
$cleanCommitTag = "vCleanCommit"

CreateInitialCleanCommit -tagName $cleanCommitTag
function CreateInitialCleanCommit {
    param ([string]$tagName)

    if($null -eq  (git tag -l $tagName)){
        Clean
        git commit -m "clean release content"
        git push
        git tag -a $tagName  -m -join("Tag ", $tagName,  " provides a clean commit")
        Write-Host -join("Created tag ",  $tagName)
        git push origin $tagName 
    }
    else{
        Write-Host "Initial Clean Commit and Tag already created"
    } 
}

function Clean {

    $scriptsFolder = "..\Scripts\"
    $scriptFiles = -Join($scriptsFolder, "*.sql")
    $csvFile = "..\CSV\ScriptList.csv"

    # Clear contents from Scriptlist.csv
    Write-Host "Clear contents from ScriptList.csv",
    Clear-Content $csvFile

    # Remove all .sql files
    Set-Location $scriptsFolder
    if (Test-Path -Path $scriptFiles) {
        Write-Host "Remove .sql files"
        git rm *.sql
    } else{
        Write-Host "No .sql files found"
    } 
}
