##
## https://adventofcode.com/2020/day/5
##

$InputData = Get-Content $PSScriptRoot\input.txt

$AssignedSeatIDs = @()

$AllSeats = @()

foreach ($i in Get-range 0 127){
    foreach ($j in Get-Range 0 7){
        $AllSeats += $i * 8 + $j
    }
}


foreach ($item in $InputData){
    $RowMax = 127
    $RowMin = 0
    $ColMax = 7
    $ColMin = 0
    $RowData = $item.ToCharArray()[0..6]
    $ColData = $item.ToCharArray()[7..9]
    $Row = 0
    $Col = 0

    foreach ($char in $RowData){
        $Half = [Math]::Round(($RowMax-$RowMin)/2, [System.MidpointRounding]::AwayFromZero)
        if ($char -eq "F"){
            if ($Half -eq 1){
                $Row = $RowMin
            } else {
                $RowMax = [Math]::Floor($RowMax - $Half)
            }
        }
        elseif ($char -eq "B") {
            if ($Half -eq 1){
                $Row = $RowMax
            } else{
                $RowMin = [Math]::Floor($RowMin + $Half)
            }
        }
    }

    #Write-Host "Row: $Row" -ForegroundColor green

    foreach ($char in $ColData){
        $Half = [Math]::Round(($ColMax-$ColMin)/2, [System.MidpointRounding]::AwayFromZero)
        if ($char -eq "L"){
            if ($Half -eq 1){
                $Col = $ColMin
            } else {
                $ColMax = [Math]::Floor($ColMax - $Half)
            }
        }
        elseif ($char -eq "R") {
            if ($Half -eq 1){
                $Col = $ColMax
            } else{
                $ColMin = [Math]::Floor($ColMin + $Half)
            }
        }
    }
    #Write-Host "Col: $Col" -ForegroundColor Green
    $SeatID = $Row * 8 + $Col
    #Write-Host "SeatID = $SeatID" -ForegroundColor Green

    $AssignedSeatIDs += $SeatID
}

$HighestSeatID = ($AssignedSeatIDs | Sort-Object )[-1]
Write-Output "Highest Seat ID: $HighestSeatID"

foreach ($seat in $AllSeats){
    if ($AssignedSeatIDs -notcontains $seat){
        if (($AssignedSeatIDs -contains $seat+1) -and ($AssignedSeatIDs -contains $seat-1)){
            return "My Seat ID: $seat"
        }
    }
}