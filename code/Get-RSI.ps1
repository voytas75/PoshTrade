function Get-RSI {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [double[]]$DataPoints,
        [Parameter(Mandatory = $true)]
        [int]$Period
    )

    $upValues = New-Object 'System.Collections.Generic.List[Double]'
    $downValues = New-Object 'System.Collections.Generic.List[Double]'
    $rsiValues = New-Object 'System.Collections.Generic.List[Double]'
    $averageGain = 0
    $averageLoss = 0
    $rs = 0
    $rsi = 0

    for ($i = 1; $i -le $DataPoints.Length; $i++) {
        $diff = $DataPoints[$i] - $DataPoints[$i-1]
        if ($diff -ge 0) {
            $upValues.Add($diff)
            $downValues.Add(0)
        }
        else {
            $upValues.Add(0)
            $downValues.Add([math]::Abs($diff))
        }
        if ($i -eq $Period) {
            if ($upValues.Count -ne 0) {
                $averageGain = [Math]::Round(($upValues | ForEach-Object {$_} | Measure-Object).Average, 2)
            }
            if ($downValues.Count -ne 0) {
                $averageLoss = [Math]::Round(($downValues | ForEach-Object {$_} | Measure-Object).Average, 2)
            }
            $rs = $averageGain / $averageLoss
            $rsi = 100 - (100 / (1 + $rs))
            $rsiValues.Add($rsi)
        }
        elseif ($i -gt $Period) {
            $prevAverageGain = $averageGain
            $prevAverageLoss = $averageLoss
            $averageGain = [Math]::Round(((($Period - 1) * $prevAverageGain) + $upValues[$i-1]) / $Period, 2)
            $averageLoss = [Math]::Round(((($Period - 1) * $prevAverageLoss) + $downValues[$i-1]) / $Period, 2)
            $rs = $averageGain / $averageLoss
            $rsi = 100 - (100 / (1 + $rs))
            $rsiValues.Add($rsi)
        }
        else {
            $rsiValues.Add(0)
        }
    }

    return $rsiValues
}

<# 
$data = @(34.39, 34.24, 33.68, 33.50, 33.75, 33.25, 32.20, 32.29, 32.31, 33.35, 34.39, 35.35, 35.15, 35.16, 35.23, 34.80, 35.12, 34.87, 34.80, 34.20, 34.34, 34.26, 34.17, 34.07, 33.40, 33.60, 33.26, 32.75, 32.60, 32.69)

# Call the Get-RSI function with a period of 14
$rsi = Get-RSI -DataPoints $data -Period 14

# Output the results
$rsi

#>
