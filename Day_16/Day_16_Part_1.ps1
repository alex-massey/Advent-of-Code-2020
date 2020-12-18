##
## https://adventofcode.com/2020/day/15
##

$inputData = Get-Content $PSScriptRoot\input.txt

$blanks = 0
$fields = @{}
$otherTickets = @{}
$allValidNums = @()

foreach ($line in $inputData) {
    if ($line -eq "") {
        $blanks++
        continue
    }
    if ($blanks -eq 0) {
        $line = $line.split(":").trim()
        $field = $line[0]
        $validRanges = @($line.split(" or ")[-5], $line.split(" or ")[-1])
        $validNums = @()
        foreach ($range in $validRanges) {
            [int]$start = $range.split("-")[0]
            [int]$end = $range.split("-")[-1]
            $validNums += $start..$end
            $allValidNums += $start..$end
        }
        $fields.Add($field, $validNums)
    }
    elseif ($blanks -eq 1) {
        if ($line[0] -match "\d") {
            $myTicket = $line.split(",")
        }
    }
    elseif ($blanks -eq 2) {
        if ($line[0] -match "\d") {
            $ticket = $line.split(",")
            $otherTickets.Add($inputData.indexOf($line), $ticket)
        }
    }
}

$invalidSum = 0
$ticketKeys = $otherTickets.Keys
foreach ($ticketKey in $ticketKeys) {
    $ticketNums = $otherTickets.$ticketKey
    foreach ($number in $ticketNums) {      
        if ($allValidNums -notcontains $number) {
            $invalidSum += [int]$number
        }    
    }
}

return $invalidSum
