##
## https://adventofcode.com/2020/day/6
##

$InputData = Get-Content $PSScriptRoot\input.txt -Raw

$groups = $InputData -split "\n\r"
$count = 0

foreach ($group in $groups) {
    $members = ($group -split '\n' | Where-Object {-not [string]::IsNullOrWhiteSpace($_)}).count
    $letters = ($group.ToCharArray() | Group-Object | Where-Object {($_.name -match '[a-z]') -and ($_.count -eq $members)}).name
    $allanswers = $letters.count
    $count += $allanswers
}

return $count