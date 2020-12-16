##
## https://adventofcode.com/2020/day/14
##

$inputData = Get-Content $PSScriptRoot\input.txt

# hashtable of memory addresses and values
$mem = @{}

function Expand-MemoryAddresses {
    [CmdletBinding()]
    param (
        [Parameter()]
        [array]
        $MaskedMemoryAddresses
    )
    
    # Create new array for memory address values
    $newAddresses = @()

    # Create new strings where 1 and 0 replace the first X and add to array
    foreach ($address in $MaskedMemoryAddresses) {
        if ($null -eq $address) {
            continue
        }
        if ($address.contains("X")) {
            $i = $address.IndexOf("X")
            $start = $address.Substring(0, $i)
            $end = $address.Substring($i + 1, $address.Length - ($i + 1))
            $newAddr0 = $start + "0" + $end
            $newAddr1 = $start + "1" + $end
            $newAddresses += $newAddr0
            $newAddresses += $newAddr1
        }
        else {
            $newAddresses += $address
        }
    }

    # Recursively call the function until the array no longer
    # contains any addresses with an X
    if ($newAddresses -match "X") {
        Expand-MemoryAddresses $newAddresses
    }
    else {
        return $newAddresses
    }
}   


foreach ($line in $inputData) {
    $memAddr = ""

    if ($line -match "mask") {
        $mask = $line.split()[-1]
    }
    elseif ($line -match "mem") {
        [string]$memAddr += $line.split(" = ")[0].split("[]")[1]
        $memValue = $line.split(" = ")[-1]
        $binValue = [System.Convert]::ToString($memAddr, 2)
        if ($binValue.Length -lt $mask.Length) {
            $diff = $mask.Length - $binValue.Length
            $binValue = ("0" * $diff) + $binValue
        }
        $maskedMemAddr = ""
        for ($i = 0; $i -lt $mask.Length; $i++) {
            if ($mask[$i] -eq "0") {
                [string]$maskedMemAddr += $binValue[$i]
            }
            elseif ($mask[$i] -eq "1") {
                [string]$maskedMemAddr += "1"
            }
            elseif ($mask[$i] -eq "X") {
                [string]$maskedMemAddr += "X"
            }
        }

        # Get all addresses from floating bits
        $memaddresses = Expand-MemoryAddresses $maskedMemAddr
       
        # Convert binary addresses to int and store values
        foreach ($address in $memaddresses) {
            $intAddress = [System.Convert]::ToInt64($address, 2)
            $mem.$intAddress = $memValue
        }        
    }
}

($mem.values | Measure-Object -Sum).Sum
