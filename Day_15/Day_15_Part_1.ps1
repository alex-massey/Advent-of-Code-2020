##
## https://adventofcode.com/2020/day/15
##

$inputData = Get-Content $PSScriptRoot\input.txt

$rounds = @{}
# Keys are numbers, Values are times spoken
$nums = @{}
$i = 1
foreach ($number in $inputData.split(",")) {
    $rounds.$i = $number
    $nums.$number = [PSCustomObject]@{
        TimesSpoken     = 0
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
    "Round $count"
    "Previous round: $prevRound"
    $nextNumSpoken = $nums["$prevNum"].TimesSpoken
    $rounds.$count = $nextNumSpoken
    "The last number spoken was $($rounds.$prevRound)"
    "It was spoken $nextNumSpoken times already, which is the number to be spoken this round"
    #$rounds.$count = $nextNumSpoken
    if ($nums.contains("$nextNumSpoken")) {
        "This has been spoken before"
        $diff = $prevRound - $nums[$prevRound].RoundLastSpoken
        "The difference between the last round and the previous time it was spoken is $diff"
        "Which will be the next word spoken"
        $nextNumSpoken = $diff
        $nums["$nextNumSpoken"].TimesSpoken = $nums["$nextNumSpoken"].TimesSpoken + 1
    }
    else {
        "This has not been spoken before. Adding to nums."
        $nums.$number = [PSCustomObject]@{
            TimesSpoken     = 0
            RoundLastSpoken = $count
        }
    }
} until ($count -ge 2020)
