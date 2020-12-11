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
$Twos = $diffArray.where( { $_ -eq 2 }).count
$Threes = $diffArray.where( { $_ -eq 3 }).count

"Ones: $Ones"
"Twos: $Twos"
"Threes: $Threes"

"Answer: $($Ones*$Threes)"
