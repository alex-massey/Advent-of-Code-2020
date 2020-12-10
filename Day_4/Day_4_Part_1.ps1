##
## https://adventofcode.com/2020/day/4
##

$BlankNewline = "

"
$InputData = Get-Content $PSScriptRoot\input.txt -Delimiter $BlankNewline

$ValidPassportCount = 0

Class PassportData {
    [string]$byr
    [string]$iyr
    [string]$eyr
    [string]$hgt
    [string]$hcl
    [string]$ecl
    [string]$passid
    [string]$cid
}

Function Test-PassportByr {
    [CmdletBinding()]
    param (
        [Parameter()]
        [string]
        $String
    )

    $byr = ([regex]::Matches($item,"byr:\w*\W*")).value
    if ($byr){
        $byr = $byr.split(":")[1]
        #Write-Host "byr = $byr"
        return $byr
    }
}

Function Test-PassportIyr {
    [CmdletBinding()]
    param (
        [Parameter()]
        [string]
        $String
    )

    $iyr = ([regex]::Matches($item,"iyr:\w*\W*")).value
    if ($iyr){
        $iyr = $iyr.split(":")[1]
        #Write-Host "iyr = $iyr"
        return $iyr
    }
}

Function Test-PassportEyr {
    [CmdletBinding()]
    param (
        [Parameter()]
        [string]
        $String
    )

    $eyr = ([regex]::Matches($item,"eyr:\w*\W*")).value
    if ($eyr){
        $eyr = $eyr.split(":")[1]
        #Write-Host "eyr = $eyr"
        return $eyr
    }
}

Function Test-PassportHgt {
    [CmdletBinding()]
    param (
        [Parameter()]
        [string]
        $String
    )

    $hgt = ([regex]::Matches($item,"hgt:\w*\W*")).value
    if ($hgt){
        $hgt = $hgt.split(":")[1]
        #Write-Host "hgt = $hgt"
        return $hgt
    }
}

Function Test-PassportHcl {
    [CmdletBinding()]
    param (
        [Parameter()]
        [string]
        $String
    )

    $hcl = ([regex]::Matches($item,"hcl:\w*\W*")).value
    if ($hcl){
        $hcl = $hcl.split(":")[1]
        #Write-Host "hcl = $hcl"
        return $hcl
    }
}

Function Test-PassportEcl {
    [CmdletBinding()]
    param (
        [Parameter()]
        [string]
        $String
    )

    $ecl = ([regex]::Matches($item,"ecl:\w*\W*")).value
    if ($ecl){
        $ecl = $ecl.split(":")[1]
        #Write-Host "ecl = $ecl"
        return $ecl
    }
}

Function Test-PassportPassid {
    [CmdletBinding()]
    param (
        [Parameter()]
        [string]
        $String
    )

$passid = ([regex]::Matches($item,"pid:\w*\W*")).value
    if ($passid){
        $passid = $passid.split(":")[1]
        #Write-Host "passid = $passid"
        return $passid
    }
}

Function Test-PassportCid {
    [CmdletBinding()]
    param (
        [Parameter()]
        [string]
        $String
    )

    $cid = ([regex]::Matches($item,"cid:\w*\W*")).value
    if ($cid){
        $cid = $cid.split(":")[1]
        #Write-Host "cid = $cid"
        return $cid
    }
}

foreach ($item in $InputData){

    $PassportData = [PassportData]::new()
    $PassportData.byr = Test-PassportByr $item
    $PassportData.iyr = Test-PassportIyr $item
    $PassportData.eyr = Test-PassportEyr $item
    $PassportData.hgt = Test-PassportHgt $item
    $PassportData.hcl = Test-PassportHcl $item
    $PassportData.ecl = Test-PassportEcl $item
    $PassportData.passid = Test-PassportPassid $item
    $PassportData.cid = Test-PassportCid $item

    if ($PassportData.byr -and
        $PassportData.iyr -and
        $PassportData.eyr -and
        $PassportData.hgt -and
        $PassportData.hcl -and
        $PassportData.ecl -and
        $PassportData.passid){

        $ValidPassportCount += 1
    }
}

return $ValidPassportCount