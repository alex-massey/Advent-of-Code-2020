$InputData = Get-Content $PSScriptRoot\input.txt

$LineHash = @{}

foreach ($Line in $InputData){
    $LineNum = $InputData.IndexOf($Line)
    $LineHash[$LineNum] = $Line.ToCharArray()
}

$IterRight = 3
$IterDown = 1
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
    if ($LineHash[$RowPos][$ColPos] -eq "#"){
        $TreeCount += 1
    }
} Until ($RowPos -ge $LineHash.count - 1)

return $TreeCount