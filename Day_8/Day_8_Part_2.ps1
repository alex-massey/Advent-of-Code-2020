##
## https://adventofcode.com/2020/day/8
##


$inputData = Get-Content $PSScriptRoot\input.txt

function Test-Program {
    [CmdletBinding()]
    param (
        [Parameter()]
        [int]
        $nopIndexToChange,
        [int]
        $jmpIndexToChange
    )

    $testInput = $inputData.Clone()
    $accumulator = 0
    $i = 0

    if ($nopIndexToChange){
        $testInput[$nopIndexToChange] = "jmp "+ $testInput[$nopIndexToChange].split()[1]
    }
    if ($jmpIndexToChange){
        $testInput[$jmpIndexToChange] = "nop "+ $testInput[$jmpIndexToChange].split()[1]
    }

    while ($i -le ($testInput.Length)) {
        if ($i -eq $testInput.Length) {
            return $true,$accumulator
        }
        $line = $testInput[$i]
        if ($line -eq "exec") {
            break
        }
        $testInput[$i] = "exec"
        $words = $line.split()
        $cmd = $words[0]
        $value = [int]$words[1]
        if ($cmd -eq "acc") {
            $accumulator += $value
        }
        elseif ($cmd -eq "jmp") {
            $i += $value
            continue
        }
        $i++
    }
}

$nopIndicies = @()
$jmpIndicies = @()

for ($i=0; $i -lt $inputData.Length;$i++) {
    if ($inputData[$i].split()[0] -eq "nop") {
        $nopIndicies += [int]$i
    }
    elseif ($inputData[$i].split()[0] -eq "jmp") {
        $jmpIndicies += [int]$i
    }
}

foreach ($index in $jmpIndicies){
    if ($success){
        break
    }
    Write-Verbose "Changing jmp to nop at index $index"
    $success,$accumulator = Test-Program -jmpIndexToChange $index
}
foreach ($index in $nopIndicies){
    if ($success){
        break
    }
    Write-Verbose "Changing jmp to nop at index $index"
    $success,$accumulator = Test-Program -nopIndexToChange $index
}

if ($success){
    Write-Output "Program completed successfully!"
    Write-Output "Accumulator total: $accumulator"
} else {
    Write-Output "Program still looping. Check for errors."
}