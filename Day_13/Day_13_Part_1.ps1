##
## https://adventofcode.com/2020/day/13
##

$inputData = Get-Content $PSScriptRoot\input.txt

[int]$dt0 = $inputData[0]
[System.Int32[]]$busIDs = $inputData[1].Split(",").where({$_ -ne "x"})
$i = 0
$remainder = $null

while ($remainder -ne 0){
    $dt1 = $dt0+$i
    foreach ($bus in $busIDs){
        $remainder = $dt1 % $bus
        if ($remainder -eq 0){
            return ($dt1 - $dt0) * $bus
        }
    }
    $i++
}

