###Day 3 Step 1###
$File = "D:\AdventofCode2021\day3input.txt"
$Content = Get-Content $File

$Position = 0
$Number = 0
$Ones = 0 
$Zeros = 0
$GammaArray = @(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
$EpsilonArray = @(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)

while (!($null -eq $Content[$Position][$Number])) {
    if ($Content[$Position][$Number] -eq "1") {
        $Ones++
    }
    else {
        $Zeros++
    }
    $Position++
    if ($Position -eq $Content.Count) {
        $Position = 0
        if ($Ones -gt $Zeros) {
            $GammaArray[$Number] = "1"
            $EpsilonArray[$Number] = "0"
        }
        else {
            $GammaArray[$Number] = "0"
            $EpsilonArray[$Number] = "1"
        }
        $Ones = 0
        $Zeros = 0
        $Number ++
    }
    if ($Number -eq 12) {
        break
    }
}

$GammaArray -join ''
$Gamma = [Convert]::ToInt32($GammaArray -join '', 2)
$Gamma
$EpsilonArray -join ''
$Epsilon = [Convert]::ToInt32($EpsilonArray -join '', 2)
$Epsilon
$Gamma * $Epsilon


###Day 3 Step 2###

$File = "D:\AdventOfCode2021\day3input.txt"
$Content = Get-Content $File 

$Position = 0
$Number = 0
$Ones = 0
$Zeros = 0
$Oxygen = @()
$CO2 = @()
while ($Number -lt 1) {
    if ($Content[$Position][$Number] -eq "1") {
        $Ones++
    }
    else {
        $Zeros++
    }
    $Position++
    if ($Position -eq $Content.Count) {
        $Position = 0
        if ($Ones -gt $Zeros) {
            $Oxygen = $Content | Where-Object { $_ -match "^1" } 
            $CO2 = $Content | Where-Object { $_ -match "^0" }
        }
        else {
            $Oxygen = $Content | Where-Object { $_ -match "^0" }
            $CO2 = $Content | Where-Object { $_ -match "^1" }
        }
        $Number++
    }
    if ($Number -eq 12) {
        break
    }
}

$Position = 0
$Number = 1
$Ones = 0
$Zeros = 0
while ($Oxygen.Count -ge 2) {
    if ($Oxygen[$Position][$Number] -eq "1") {
        $Ones++
    }
    else {
        $Zeros++
    }
    $Position++
    if ($Position -eq $Oxygen.Count) {
        $Position = 0
        if ($Ones -ge $Zeros) {
            $Oxygen = $Oxygen | Where-Object { $_.Substring($Number) -match "^1" }
            if ($Oxygen.Count -eq 2) {
                $Oxygen = $Oxygen | Where-Object { $_.Substring($Number) -match "^1" }
                break
            }
        }
        else {
            $Oxygen = $Oxygen | Where-Object { $_.Substring($Number) -match "^0" }
        }
        if ($Number -lt 12) {
            $Number++
            $Ones = 0
            $Zeros = 0
        }
    }
}

$Position = 0
$Number = 1
$Ones = 0
$Zeros = 0
while ($CO2.Count -ge 2) {
    if ($CO2[$Position][$Number] -eq "1") {
        $Ones++
    }
    else {
        $Zeros++
    }
    $Position++
    if ($Position -eq $CO2.Count) {
        $Position = 0
        if ($Ones -ge $Zeros) {
            $CO2 = $CO2 | Where-Object { $_.Substring($Number) -match "^0" }
            if ($CO2.Count -eq 2) {
                $CO2 = $CO2 | Where-Object { $_.Substring($Number) -match "^0" }
                break
            }
        }
        else {
            $CO2 = $CO2 | Where-Object { $_.Substring($Number) -match "^1" }
        }
        if ($Number -lt 12) {
            $Number++
            $Ones = 0
            $Zeros = 0
        }
    }
}

$OxygenRating = [Convert]::ToInt32($Oxygen -join '', 2) 
$OxygenRating
$CO2Rating = [Convert]::ToInt32($CO2 -join '', 2)
$CO2Rating
$OxygenRating * $CO2Rating
