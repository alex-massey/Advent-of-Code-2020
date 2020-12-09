##
## https://adventofcode.com/2020/day/8
##

$inputData = Get-Content $PSScriptRoot\input.txt

$accumulator = 0
$i = 0

while ($i -lt $inputData.Length){
    $line = $inputData[$i]
    if ($line -eq "exec"){
        break
    }
    $inputData[$i] = "exec"
    $words = $line.split()
    $cmd = $words[0]
    $value = [int]$words[1]
    if ($cmd -eq "acc"){
        $accumulator += $value
    }
    elseif ($cmd -like "jmp"){
        $i += $value
        continue
    }
    $i++
}



$accumulator