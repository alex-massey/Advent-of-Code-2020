##
## https://adventofcode.com/2020/day/11
##
## Very inefficient :(
## ~ 2 min 40 sec execution time
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

    $occupiedSeatCount = 0
    $i = 1
    while (($Seat - $i -ge 0) -and ($Row - $i -ge 0)) {
        $seatToCheck = $seatsTable.($Row - $i)[$Seat - $i]
        if ($seatToCheck -ne ".") {
            if ($seatToCheck -eq "#") {
                $occupiedSeatCount++
            }
            break
        }
        else { $i++ }
    }
    $i = 1
    while ($Row - $i -ge 0) {
        $seatToCheck = $seatsTable.($Row - $i)[$Seat]
        if ($seatToCheck -ne ".") {
            if ($seatToCheck -eq "#") {
                $occupiedSeatCount++
            }
            break
        }
        else { $i++ }
    }
    $i = 1
    while (($Row - $i -ge 0) -and ($Seat + $i -lt $seatsTable.($Row).Length)) {
        $seatToCheck = $seatsTable.($Row - $i)[$Seat + $i]
        if ($seatToCheck -ne ".") {
            if ($seatToCheck -eq "#") {
                $occupiedSeatCount++
            }
            break
        }
        else { $i++ }
    }
    $i = 1
    while ($Seat - $i -ge 0) {
        $seatToCheck = $seatsTable.($Row)[$Seat - $i]
        if ($seatToCheck -ne ".") {
            if ($seatToCheck -eq "#") {
                $occupiedSeatCount++
            }
            break
        }
        else { $i++ }
    }
    $i = 1
    while ($Seat + $i -lt $seatsTable.($Row).Length) {
        $seatToCheck = $seatsTable.($Row)[$Seat + $i]
        if ($seatToCheck -ne ".") {
            if ($seatToCheck -eq "#") {
                $occupiedSeatCount++
            }
            break
        }
        else { $i++ }
    }
    $i = 1
    while (($Seat - $i -ge 0) -and ($Row + $i -lt $seatsTable.Count)) {
        $seatToCheck = $seatsTable.($Row + $i)[$Seat - $i]
        if ($seatToCheck -ne ".") {
            if ($seatToCheck -eq "#") {
                $occupiedSeatCount++
            }
            break
        }
        else { $i++ }
    }
    $i = 1
    while ($Row + $i -lt $seatsTable.Count) {
        $seatToCheck = $seatsTable.($Row + $i)[$Seat]
        if ($seatToCheck -ne ".") {
            if ($seatToCheck -eq "#") {
                $occupiedSeatCount++
            }
            break
        }
        else { $i++ }
    }
    $i = 1
    while (($Seat + $i -lt $seatsTable.($Row).Length) -and ($Row + $i -lt $seatsTable.Count)) {
        $seatToCheck = $seatsTable.($Row + $i)[$Seat + $i]
        if ($seatToCheck -ne ".") {
            if ($seatToCheck -eq "#") {
                $occupiedSeatCount++
            }
            break
        }
        else { $i++ }
    }

    return $occupiedSeatCount
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
                if ($occupiedAdjacentSeats -ge 5) {
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