##
## https://adventofcode.com/2020/day/10
##
## Pretty inefficient :(
## ~2 min execution time
##

$inputData = Get-Content $PSScriptRoot\input.txt

function Get-AdjacentOccupancy {
    [CmdletBinding()]
    param (
        [Parameter()]
        [int]
        $Row,
        [int]
        $Seat
    )

    $upperLeft, $upper, $upperRight, $right, $left, $lowerLeft, $lower, $lowerRight = $null
    $adjacentSeats = @()
    if (($Seat - 1 -ge 0) -and ($Row - 1 -ge 0)) {
        $upperLeft = $seatsTable.($row - 1)[$Seat - 1]
    }
    if (($Row - 1 -ge 0)) {
        $upper = $seatsTable.($Row - 1)[$Seat]
    }
    if (($Row - 1 -ge 0) -and ($Seat + 1 -lt $seatsTable.($Row).Length)) {
        $upperRight = $seatsTable.($Row - 1)[$Seat + 1]
    }
    if ($Seat - 1 -ge 0) {
        $left = $seatsTable.($Row)[$Seat - 1]
    }
    if ($Seat + 1 -lt $seatsTable.($Row).Length) {
        $right = $seatsTable.($Row)[$Seat + 1]
    }
    if (($Seat - 1 -ge 0) -and ($Row + 1 -lt $seatsTable.Count)) {
        $lowerLeft = $seatsTable.($Row + 1)[$Seat - 1]
    }
    if ($Row + 1 -lt $seatsTable.Count) {
        $lower = $seatsTable.($Row + 1)[$Seat]
    }
    if (($Seat + 1 -lt $seatsTable.($Row).Length) -and ($Row + 1 -lt $seatsTable.Count)) {
        $lowerRight = $seatsTable.($Row + 1)[$Seat + 1]
    }

    $adjacentSeats += $upperLeft, $upper, $upperRight, $right, $left, $lowerLeft, $lower, $lowerRight
    $occupiedAdjacentSeats = $adjacentSeats.where( { $_ -eq "#" }).count
    return $occupiedAdjacentSeats
}

function Move-PeopleToSeats {
    [CmdletBinding()]
    param (
        [Parameter()]
        [array]
        $InputArray
    )

    $seatsTable = @{}

    $i = 0
    foreach ($line in $InputArray) {
        $line = $line.ToCharArray()
        $row = @()
        foreach ($char in $line) {
            if ($char -eq ".") {
                $row += "."
            }
            elseif ($char -eq "L") {
                $row += "L"
            }
            elseif ($char -eq "#") {
                $row += "#"
            }
        }
        $seatsTable.($i) = $row
        $i++
    }

    $changes = 0
    $totalOccupiedSeats = 0
    $newTableArray = @()
    for ($i = 0; $i -lt $seatsTable.count; $i++) {
        $lineString = ""
        for ($j = 0; $j -lt $seatsTable.($i).count; $j++) {
            $character = $seatsTable.($i)[$j]
            if ($character -eq ".") {
                $lineString += "."
                continue
            }
            $occupiedAdjacentSeats = Get-AdjacentOccupancy -Row $i -Seat $j
            if ($character -eq "#") {
                $totalOccupiedSeats++
                if ($occupiedAdjacentSeats -ge 4) {
                    $lineString += "L"
                    $changes++
                }
                else {
                    $lineString += "#"
                }
            }
            elseif ($character -eq "L") {
                if ($occupiedAdjacentSeats -eq 0) {
                    $lineString += "#"
                    $changes++
                }
                else {
                    $lineString += "L"
                }
            }
        }
        $newTableArray += $lineString
    }

    if ($changes -eq 0) {
        return $totalOccupiedSeats
    }
    else {
        Move-PeopleToSeats -inputArray $newTableArray
    }
}

Move-PeopleToSeats -inputArray $inputData