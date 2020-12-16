##
## https://adventofcode.com/2020/day/13
##
## Brute force solution that's very inefficient, but works on all test cases and should work on real input
## I just didn't feel like letting it run for 242 days (est) :)
##


$inputData = Get-Content $PSScriptRoot\input.txt
$timestamps = @{}
for ($i = 1; $i -le $inputData[1].split(",").count; $i++) {
    $timestamps.$i = $inputData[1].split(",")[$i - 1]
}
$busOffset = @{}
$busIDs = $timestamps.values.where( { $_ -ne "x" })

$offset = 0
for ($i = $timestamps.count; $i -gt 0; $i--) {
    if ($timestamps.$i -ne "x") {
        $bus = $timestamps.$i
        $busOffset.$bus = $offset
    }
    $offset++
}

$upperBound = 1
foreach ($bus in $busIDs) {
    $upperBound *= $bus
}

[int]$firstbus = $timestamps.1

$max = ($busIDs | Measure-Object -Maximum).maximum

for ($i = $max; $i -le 1000000; $i += $max) {
    $success = 0
    foreach ($bus in $busIDs){
        if ($bussoffset."$max" -gt $busoffset.$bus){
            $offset = $busoffset.$bus + $busoffset."$max"
        } else {
            $offset = $busoffset."$max" - $busoffset.$bus
        }
        $j = $i + $offset
        if ($j % $bus -eq 0){
            $success++
        } else {
            break
        }
    }
    if ($success -eq $busIDs.count){
        return ($i - $busoffset."$firstbus")
    }
}
