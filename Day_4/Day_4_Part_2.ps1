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

    $byr = ([regex]::Matches($item,"byr:\d{4}")).value
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

    $iyr = ([regex]::Matches($item,"iyr:\d{4}")).value
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

    $eyr = ([regex]::Matches($item,"eyr:\d{4}")).value
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

    $hgt = ([regex]::Matches($item,"hgt:\d*cm|hgt:\d*in")).value
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

    $hcl = ([regex]::Matches($item,"hcl:#[0-9a-z]{6}")).value
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

    $ecl = ([regex]::Matches($item,"ecl:\w{3}")).value
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

$passid = ([regex]::Matches($item,"pid:[0-9]{9}")).value
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
    $Check = 0

    $PassportData = [PassportData]::new()
    $PassportData.byr = Test-PassportByr $item
    $PassportData.iyr = Test-PassportIyr $item
    $PassportData.eyr = Test-PassportEyr $item
    $PassportData.hgt = Test-PassportHgt $item
    $PassportData.hcl = Test-PassportHcl $item
    $PassportData.ecl = Test-PassportEcl $item
    $PassportData.passid = Test-PassportPassid $item
    $PassportData.cid = Test-PassportCid $item

    if ($PassportData.byr -in 1920..2002) {$Check += 1}
    if ($PassportData.iyr -in 2010..2020) {$Check += 1}
    if ($PassportData.eyr -in 2020..2030) {$Check += 1}
    if ($PassportData.hgt -match "cm"){
        if ($PassportData.hgt.replace("cm","") -in 150..193){
            $Check += 1
        }
    } elseif ($PassportData.hgt -match "in") {
        if ($PassportData.hgt.replace("in","") -in 59..76){
            $Check += 1
        }
    }
    if ($PassportData.hcl) {$Check += 1}
    if ($PassportData.ecl -match "amb|blu|brn|gry|grn|hzl|oth") {$Check += 1}
    if ($PassportData.passid) {$Check += 1}

    if ($Check -eq 7){
        $ValidPassportCount++
    }
}


return $ValidPassportCount