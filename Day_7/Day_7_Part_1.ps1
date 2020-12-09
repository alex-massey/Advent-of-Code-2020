###
### https://adventofcode.com/2020/day/7
###
### What a mess!
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

    ##
    ## recurse through all bags and add to count variable if contained in another bag
    ##
    foreach ($bagColor in $bagsContainingColor.color){
        if (($bagColor -eq "no other") -or ($bagColor -eq "shiny gold")){
            continue
        }
        $bagsContainingColor = $bags.where({$_.validcontainerbags.color -contains $bagColor})
        foreach ($bag in $bagsContainingColor){
            Write-Host $bag.color -fore Green
            if ($global:countedBags -contains $bag.color){
                continue
            } else {
                $global:countedBags += $bag.color
            }
        }
        Get-BagCount $bagsContainingColor
    }
}

$bagsContainingShinyGold = $bags.where({$_.validcontainerbags.color -contains "shiny gold"})
$global:countedBags += $bagsContainingShinyGold.color

Get-BagCount $bagsContainingShinyGold

$global:countedBags.Count
