##
## https://adventofcode.com/2020/day/2
##

$InputData = Get-Content $PSScriptRoot\input.txt

#Password object class that will be created from input text data
Class Password{
    [int]$Index1
    [int]$Index2
    [string]$RequiredLetter
    [string]$Password
}

#Array to store password objects
$PasswordsList = @()

#Fill out array with password objects created from input data
foreach ($item in $InputData){
    $PasswordObject = [Password]::new()
    $PasswordObject.Index1 = $item.split(":")[0].split(" ")[0].split("-")[0].trim()
    $PasswordObject.Index2 = $item.split(":")[0].split(" ")[0].split("-")[1].trim()
    $PasswordObject.RequiredLetter = $item.split(":")[0].split(" ")[1].trim()
    $PasswordObject.Password = $item.split(":")[1].trim()
    $PasswordsList += $PasswordObject
}

$ValidPasswordCount = 0

foreach ($PasswordObj in $PasswordsList){
    $Index1 = $PasswordObj.password[$PasswordObj.Index1 - 1]
    $Index2 = $PasswordObj.password[$PasswordObj.Index2 - 1]
    if (($Index1 -eq $PasswordObj.RequiredLetter) -xor ($Index2 -eq $PasswordObj.RequiredLetter)){
        #Write-Output "Password $($PasswordObj.Password) is valid."
        $ValidPasswordCount += 1
    }
}

return $ValidPasswordCount