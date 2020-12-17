##
## https://adventofcode.com/2020/day/15
##

$inputData = Get-Content $PSScriptRoot\input.txt

$finalRound = 2020

$rounds = [object[]]::new($finalRound + 1)
$nums = [System.Collections.ArrayList][object[]]::new($finalRound + 1)
$i = 1
$numbers = $inputData.split(",") | ForEach-Object { ([int]::parse($_)) }
foreach ($number in $numbers) {
    $rounds[$i] = $number
    $nums[$number] = $i
    $i++
}

$count = $numbers.Count + 1
$rounds[$count] = 0
do {
    $count++
    $prevRound = $count - 1
    $prevNum = $rounds[$prevRound]

    if ($nums[$prevNum]) {
        $lastRoundSpoken = $nums[$prevNum]
        $diff = $prevRound - $lastRoundSpoken
        $nextNumSpoken = $diff
    }
    else {
        $nums[$nextNumSpoken] = $prevRound
        $nextNumSpoken = 0
    }
    $rounds[$count] = $nextNumSpoken
    $nums[$prevNum] = $prevRound

} until ($count -ge $finalRound)

return $nextNumSpoken

