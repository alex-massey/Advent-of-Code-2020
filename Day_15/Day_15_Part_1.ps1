##
## https://adventofcode.com/2020/day/15
## Convoluted and inefficient
##

$inputData = Get-Content $PSScriptRoot\input.txt

$finalRound = 2020

$rounds = [object[]]::new($finalRound + 1)
$nums = [System.Collections.ArrayList][object[]]::new($finalRound + 1)
$i = 1
<<<<<<< HEAD
$numbers = $inputData.split(",") | foreach-object {([int]::parse($_))}
foreach ($number in $numbers) {
    $rounds.$i = $number
    if ($number -eq $numbers[-1]){
        $timesSpoken = 0
    } else {
        $timesSpoken = 1
    }
    $nums.$number = [PSCustomObject]@{
        TimesSpoken     = $timesSpoken
        RoundLastSpoken = $i
    }
=======
$numbers = $inputData.split(",") | ForEach-Object { ([int]::parse($_)) }
foreach ($number in $numbers) {
    $rounds[$i] = $number
    $nums[$number] = $i
>>>>>>> af97555dada9dd4fe83b590b44cfa5c2e507c9d4
    $i++
}

$count = $numbers.Count + 1
$rounds[$count] = 0
do {
    $count++
    $prevRound = $count - 1
<<<<<<< HEAD
    $prevNum = $rounds.$prevRound

    if ($nums.contains($prevNum)){
        $nums.$prevNum.TimesSpoken++
        if ($nums.$prevNum.TimesSpoken -eq 1){
            $nextNumSpoken = 0
        } else {
            $lastRoundSpoken = $nums.$prevNum.RoundLastSpoken
            $diff = $prevRound - $lastRoundSpoken
            $nextNumSpoken = $diff
        }
        $nums.$prevNum.RoundLastSpoken = $prevRound
    } else {
        $obj = [PSCustomObject]@{
            TimesSpoken     = 1
            RoundLastSpoken = $prevRound
        }
        $nums.add($nextNumSpoken,$obj)
        $nextNumSpoken = 0
    }
    $rounds.$count = $nextNumSpoken

} until ($count -ge 2020)

return $nextNumSpoken
=======
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

>>>>>>> af97555dada9dd4fe83b590b44cfa5c2e507c9d4
