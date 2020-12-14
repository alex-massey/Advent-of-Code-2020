##
## https://adventofcode.com/2020/day/14
##

$inputData = Get-Content $PSScriptRoot\input.txt

$mem = @{}

foreach ($line in $inputData){
    if ($line -match "mask"){
        $mask = $line.split()[-1]
    } elseif ($line -match "mem") {
        $memAddr = $line.split(" = ")[0].split("[]")[1]
        $memValue = $line.split(" = ")[-1]
        $binValue = [System.Convert]::ToString($memValue,2)
        if ($binValue.Length -lt $mask.Length) {
            $diff = $mask.Length - $binValue.Length
            $binValue = ("0" * $diff) + $binValue
        }

        $writeValue = ""
        for ($i = 0; $i -lt $mask.Length; $i++) {
            if ($mask[$i] -eq "X") {
                $writeValue += $binValue[$i]
            }
            else {
                $writeValue += $mask[$i]
            }
        }
        $mem.$memAddr = [System.Convert]::ToInt64($writeValue, 2)
    }
}

($mem.values | Measure-Object -Sum).Sum
