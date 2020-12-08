###
### What a mess.
### Output is close, but off by 4.
### Spent hours going through each step, but I can't see where it's going wrong.
### :(
###



$InputData = Get-Content $PSScriptRoot\input.txt

$ValidBags = @()
$Bags = @()

$global:countedBags = @()

Class Bag {
    [string]$Color
    [array]$ValidContainerBags
}

##
## Fill out array object storing the bag data
##
foreach ($line in $InputData) {
    $newBag = [Bag]::new()
    $newBag.Color = ($line -split " bags ")[0]
    $ValidBagsText = (($line -split " contain ")[1].Replace(".", "")) -Split ", "
    foreach ($bag in $ValidBagsText) {
        $number = $bag[0]
        $color = ($bag | Select-String -Pattern "\D*\s" -AllMatches | ForEach-Object { $_.Matches }).value.trim()
        $ValidBags = [PSCustomObject]@{
            Number = $number
            Color  = $Color
        }
        $newBag.ValidContainerBags += $ValidBags
    }
    $Bags += $newBag
}

function Get-BagCount {
    [CmdletBinding()]
    param (
        [Parameter()]
        [object]
        $bagsContainingColor
    )

    #Write-Host "Count: $($global:CountedBags.count)" -ForegroundColor Red
    #Write-Host $bagsContainingColor.color -ForegroundColor Green

    foreach ($bagColor in $bagsContainingColor.color){
        <#if (($bagColor -eq "no other") -or ($bagColor -eq "shiny gold")){
            continue
        }#>
        #Write-Host "Searching for parent bags of $bagColor" -ForegroundColor Yellow
        $bagsContainingColor = $bags.where({$_.validcontainerbags.color -contains $bagColor})
        #Write-Host "Bags containing $bagColor : $($bagsContainingColor.color)"
        foreach ($bag in $bagsContainingColor){
            if ($global:countedBags -contains $bag.color){
                Write-Host "$($bag.color) already counted. Skipping.."
                continue
            } else {
                $global:countedBags += $bag.color
            }
        }
        Get-BagCount $bagsContainingColor
    }
}




$bagsContainingShinyGold = $bags.where({$_.validcontainerbags.color -contains "shiny gold"})

Get-BagCount $bagsContainingShinyGold

$global:countedBags.Count