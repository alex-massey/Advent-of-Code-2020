##
## https://adventofcode.com/2020/day/9
##

$inputData = Get-Content $PSScriptRoot\input.txt

$numList = [System.Collections.Generic.List[System.Object]]($inputData[0..24])

$startingIndex = 25
$sums = @{}

function Write-SumsTable {
    param (
        [object]$NumberList,
        [hashtable]$SumsTable
    )

    foreach ($number in $NumberList) {
        $numIndex = $NumberList.IndexOf($number)
        for ($i = 0; $i -lt $NumberList.Count; $i++) {
            if ($i -eq $numIndex) {
                continue
            }
            $sumString1 = "$number,$($NumberList[$i])"
            $sumString2 = "$($NumberList[$i]),$number"
            if ($SumsTable.contains($sumString1) -or $SumsTable.Contains($sumString2)) {
                continue
            }
            else {
                $SumsTable."$number,$($NumberList[$i])" = [int]$number + [int]$NumberList[$i]
            }
        }
    }
}

for ($i = $startingIndex; $i -lt $inputData.Length; $i++) {
    $num = $inputData[$i]
    Write-SumsTable -NumberList $numList -SumsTable $sums
    if ($sums.Values -contains $num) {
    }
    else {
        Write-Output "$num is invalid"
        break
    }
    $numList.RemoveAt(0)
    $numList.Add($num)
}
