$InputData = Get-Content $PSScriptRoot\input.txt

#Password object class that will be created from input text data
Class Password{
    [int]$RequiredMin
    [int]$RequiredMax
    [string]$RequiredLetter
    [string]$Password
}

#Array to store password objects
$PasswordsList = @()

#Fill out array with password objects created from input data
foreach ($item in $InputData){
    $PasswordObject = [Password]::new()
    $PasswordObject.RequiredMin = $item.split(":")[0].split(" ")[0].split("-")[0].trim()
    $PasswordObject.RequiredMax = $item.split(":")[0].split(" ")[0].split("-")[1].trim()
    $PasswordObject.RequiredLetter = $item.split(":")[0].split(" ")[1].trim()
    $PasswordObject.Password = $item.split(":")[1].trim()
    $PasswordsList += $PasswordObject
}

$ValidPasswordCount = 0

foreach ($PasswordObj in $PasswordsList){
    $RequiredLetterCount = ([regex]::Matches($PasswordObj.password, $PasswordObj.RequiredLetter)).count
    if (($RequiredLetterCount -ge $PasswordObj.RequiredMin) -and ($RequiredLetterCount -le $PasswordObj.RequiredMax)){
        #Write-Output "Password $($PasswordObj.Password) contains $($PasswordObj.RequiredLetter) the required number of times."
        $ValidPasswordCount += 1
    }
}

return $ValidPasswordCount