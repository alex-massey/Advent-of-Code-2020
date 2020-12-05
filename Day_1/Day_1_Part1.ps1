$input_nums= Get-Content .\input_numbers.txt

foreach ($number1 in $input_nums){
    foreach ($number2 in $input_nums){
        if ($number1 -eq $number2){
            #skip when same number is found in inner loop
            continue
        }
        foreach ($number3 in $input_nums){
            if ($number2 -eq $number3){
                #skip when same number is found in inner loop
                continue
            }
            else {
                $sum = [int]$number1 + [int]$number2 + [int]$number3
                if ($sum -eq 2020){
                    Write-Output "Found $number1 and $number2 and $number3"
                    return [int]$number1 * [int]$number2 * [int]$number3
                }
            }
        }
    }
}