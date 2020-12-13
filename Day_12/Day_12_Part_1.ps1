##
## https://adventofcode.com/2020/day/12
##

$inputData = Get-Content $PSScriptRoot\input.txt

function Move-Ship {
    [CmdletBinding()]
    param (
        [Parameter()]
        [char]
        $Direction,
        [int]
        $Magnitude
    )

    switch ($Direction) {
        "N" {
            $global:lat += $Magnitude
        }
        "E" {
            $global:long += $Magnitude
        }
        "S" {
            $global:lat -= $Magnitude
        }
        "W" {
            $global:long -= $Magnitude
        }
    }
}

function Set-Vector {
    [CmdletBinding()]
    param (
        [Parameter()]
        [int]
        $CurrentVector,
        [int]
        $RotationAmt,
        [char]
        $RotationDir
    )

    if ($RotationDir -eq "R") {
        $newVector = $CurrentVector + $RotationAmt
        if ($newVector -ge 360) {
            $newVector -= 360
        }
    }
    elseif ($RotationDir -eq "L") {
        $newVector = $CurrentVector - $RotationAmt
        if ($newVector -lt 0) {
            $newVector += 360
        }
    }
    return $newVector
}

$dir = "E"
$vec = 90
$NESW = "N","E","S","W"
$global:lat = 0
$global:long = 0

foreach ($line in $inputData) {
    $cmd = $line[0]
    $amt = $line.Substring(1, $line.Length - 1)


    if (($cmd -eq "R") -or ($cmd -eq "L")) {
        $vec = Set-Vector -CurrentVector $vec -RotationDir $cmd -RotationAmt $amt
        switch ($vec) {
            0 { $dir = "N" }
            90 { $dir = "E" }
            180 { $dir = "S" }
            270 { $dir = "W" }
        }
    }
    elseif ($NESW -contains $cmd) {
        switch ($cmd) {
            "N" { Move-Ship -Direction "N" -Magnitude $amt }
            "E" { Move-Ship -Direction "E" -Magnitude $amt }
            "S" { Move-Ship -Direction "S" -Magnitude $amt }
            "W" { Move-Ship -Direction "W" -Magnitude $amt }
        }
    }
    elseif ($cmd = "F") {
        Move-Ship -Direction $dir -Magnitude $amt
    }
}

"Lat: $global:lat"
"Long: $global:long"

$dist = [Math]::Abs($global:lat) + [Math]::Abs($global:long)

Write-Output "Manhattan distance: $dist"