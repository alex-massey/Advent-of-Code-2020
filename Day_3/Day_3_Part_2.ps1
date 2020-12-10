##
## https://adventofcode.com/2020/day/3
##

$InputData = Get-Content $PSScriptRoot\input.txt

$LineHash = @{}

foreach ($Line in $InputData) {
    $LineNum = $InputData.IndexOf($Line)
    $LineHash[$LineNum] = $Line.ToCharArray()
}

Function Get-SlopeTreeCount {
    [CmdletBinding()]
    param (
        [Parameter()]
        [int]
        $Right,
        [Parameter()]
        [int]
        $Down
    )

    $IterRight = $Right
    $IterDown = $Down
    $RowPos = 0
    $ColPos = 0
    $RowLen = $InputData[0].Length
    $TreeCount = 0
    Do {
        $RowPos += $IterDown
        $ColPos += $IterRight
        if ($ColPos -ge $RowLen) {
            $ColPos = $ColPos % $RowLen
        }
        #Write-Host "Col:$ColPos, Row:$RowPos = $($LineHash[$RowPos][$ColPos])"
        if ($LineHash[$RowPos][$ColPos] -eq "#") {
            $TreeCount += 1
        }
    } Until ($RowPos -ge $LineHash.count - 1)
    return $TreeCount

}

#Slope 3:1
$OneOne = Get-SlopeTreeCount -Right 1 -Down 1
$ThreeOne = Get-SlopeTreeCount -Right 3 -Down 1
$FiveOne = Get-SlopeTreeCount -Right 5 -Down 1
$SevenOne = Get-SlopeTreeCount -Right 7 -Down 1
$OneTwo = Get-SlopeTreeCount -Right 1 -Down 2

return $OneOne * $ThreeOne * $FiveOne * $SevenOne * $OneTwo