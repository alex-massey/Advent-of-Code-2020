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

    $global:lat += $global:waypoint.N * $Magnitude
    $global:long += $global:waypoint.E * $Magnitude
    $global:lat -= $global:waypoint.S * $Magnitude
    $global:long -= $global:waypoint.W * $Magnitude
}

function Set-Waypoint {
    [CmdletBinding()]
    param (
        [Parameter()]
        [hashtable]
        $CurrentWaypoint,
        [int]
        $RotationAmt,
        [char]
        $RotationDir
    )

    $global:waypoint = @{"N"=0;"E"=0;"S"=0;"W"=0}

    if ($RotationDir -eq "R") {
        if ($RotationAmt -eq 90){
            $global:waypoint.N = $CurrentWaypoint.W
            $global:waypoint.E = $CurrentWaypoint.N
            $global:waypoint.S = $CurrentWaypoint.E
            $global:waypoint.W = $CurrentWaypoint.S
        } elseif ($RotationAmt -eq 180){
            $global:waypoint.N = $CurrentWaypoint.S
            $global:waypoint.E = $CurrentWaypoint.W
            $global:waypoint.S = $CurrentWaypoint.N
            $global:waypoint.W = $CurrentWaypoint.E
        } elseif ($RotationAmt -eq 270){
            $global:waypoint.N = $CurrentWaypoint.E
            $global:waypoint.E = $CurrentWaypoint.S
            $global:waypoint.S = $CurrentWaypoint.W
            $global:waypoint.W = $CurrentWaypoint.N
        }
    }
    elseif ($RotationDir -eq "L") {
        if ($RotationAmt -eq 90){
            $global:waypoint.N = $CurrentWaypoint.E
            $global:waypoint.E = $CurrentWaypoint.S
            $global:waypoint.S = $CurrentWaypoint.W
            $global:waypoint.W = $CurrentWaypoint.N
        } elseif ($RotationAmt -eq 180){
            $global:waypoint.N = $CurrentWaypoint.S
            $global:waypoint.E = $CurrentWaypoint.W
            $global:waypoint.S = $CurrentWaypoint.N
            $global:waypoint.W = $CurrentWaypoint.E
        } elseif ($RotationAmt -eq 270){
            $global:waypoint.N = $CurrentWaypoint.W
            $global:waypoint.E = $CurrentWaypoint.N
            $global:waypoint.S = $CurrentWaypoint.E
            $global:waypoint.W = $CurrentWaypoint.S
        }
    }
}

$global:lat = 0
$global:long = 0
$global:waypoint = @{"N"=1;"E"=10;"S"=0;"W"=0}

foreach ($line in $inputData) {
    $cmd = $line[0]
    $amt = $line.Substring(1, $line.Length - 1)

    if (($cmd -eq "R") -or ($cmd -eq "L")) {
        Set-Waypoint -CurrentWaypoint $global:waypoint -RotationDir $cmd -RotationAmt $amt
    }
    elseif ($NESW -contains $cmd) {
        switch ($cmd) {
            "N" { $global:waypoint.N += $amt }
            "E" { $global:waypoint.E += $amt }
            "S" { $global:waypoint.S += $amt }
            "W" { $global:waypoint.W += $amt }
        }
    }
    elseif ($cmd = "F") {
        Move-Ship -Magnitude $amt
    }
}

"Lat: $global:lat"
"Long: $global:long"

$dist = [Math]::Abs($global:lat) + [Math]::Abs($global:long)

Write-Output "Manhattan distance: $dist"