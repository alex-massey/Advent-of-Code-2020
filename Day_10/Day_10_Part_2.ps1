##
## https://adventofcode.com/2020/day/10
##

$inputData = Get-Content $PSScriptRoot\input.txt

# Add rating for outlet
$inputData += "0"

# Convert input strings to int and sort
$sortedAdapterRatings = $inputData | Sort-Object @{e={ $_ -as [int] } }

# Add the rating difference for your device
$sortedAdapterRatings += [int]$sortedAdapterRatings[-1]+3

$possibleCombinations = @{}

Function Test-Branch {
    [CmdletBinding()]
    param (
        [Parameter()]
        [array]
        $adapterList,
        [int]
        $startingIndex
    )
    
    if ($startingIndex -eq $sortedAdapterRatings.Length - 1){
        return 1
    }
    if ($possibleCombinations.Contains($startingIndex)){
        return $possibleCombinations[$startingIndex]
    }
    $combinations = 0
    for ($i = $startingIndex+1;$i -lt $sortedAdapterRatings.Length; $i++){
        if (($sortedAdapterRatings[$i] - $sortedAdapterRatings[$startingIndex]) -le 3){
            $combinations += Test-Branch -startingIndex $i -adapterList $sortedAdapterRatings
        }
    }
    $possibleCombinations[$startingIndex] = $combinations
    return $combinations
}

$diffArray = @()

# Loop through adapters and store diff between each one and the next
foreach ($adapter in $sortedAdapterRatings){
    $adapterIndex = $sortedAdapterRatings.IndexOf($adapter)
    [int]$diff = [int]$sortedAdapterRatings[$adapterIndex + 1] - [int]$adapter
    $diffArray += $diff
    # Break when last entry is reached, accounting for the outlet and device being added to the array
    if ($adapterIndex -eq ($sortedAdapterRatings.count - 2)){
        break
    }
}

$Ones = $diffArray.where( { $_ -eq 1 }).count
$Threes = $diffArray.where( { $_ -eq 3 }).count

"Ones x Threes: $($Ones*$Threes)"

$totalCombinations = Test-Branch -adapterList $sortedAdapterRatings -startingIndex 0

"Total Combinations: $totalCombinations"
