##
## https://adventofcode.com/2020/day/1
##

$input_nums = Get-Content $PSScriptRoot\input_numbers.txt

foreach ($number1 in $input_nums){
    foreach ($number2 in $input_nums){
        if ($number1 -eq $number2) {
            #skip when same number is found in inner loop
            continue
        } else{
            $remainder = 2020 - [int]$number1 - [int]$number2
            if ($input_nums -contains $remainder){
                Write-Output "Found $number1, $number2, and $remainder"
                return [int]$number1 * [int]$number2 * [int]$remainder
            }

        }

    }
}


