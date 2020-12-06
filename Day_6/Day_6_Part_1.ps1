$InputData = Get-Content $PSScriptRoot\input.txt -Raw

$groups = $InputData -split "\n\r"
$count = 0

foreach ($group in $groups) {
    $letters = $group.ToCharArray() | Sort-Object -Unique | Where-Object {$_ -match '[a-z]'}
    $count += $letters.count
}

return $count