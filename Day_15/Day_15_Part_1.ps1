##
## https://adventofcode.com/2020/day/15
## Convoluted and inefficient
##

$inputData = Get-Content $PSScriptRoot\input.txt

$rounds = @{}
# Keys are numbers, Values are times spoken
$nums = @{}
$i = 1
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
    $i++
}

$count = $nums.Count
$nextNumSpoken = $number
do {
    $count++
    $prevRound = $count - 1
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