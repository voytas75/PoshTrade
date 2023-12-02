function Get-RSI {
    <#
    .SYNOPSIS
    Calculates the Relative Strength Index (RSI) based on given data points and period.
    
    .DESCRIPTION
    This function calculates RSI using the average gain and loss over a specified period.
    
    .PARAMETER DataPoints
    An array of data points for RSI calculation.
    
    .PARAMETER Period
    The period over which to calculate RSI.
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [double[]]$DataPoints,
        [Parameter(Mandatory = $true)]
        [int]$Period
    )

    $upValues = New-Object 'System.Collections.Generic.List[Double]' # List to store positive changes
    $downValues = New-Object 'System.Collections.Generic.List[Double]' # List to store negative changes
    $rsiValues = New-Object 'System.Collections.Generic.List[Double]' # List to store calculated RSI values
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
$data = @(34.39, 34.24, ... ) # Array of data points for RSI calculation

# Call the Get-RSI function with a period of 14
$rsi = Get-RSI -DataPoints $data -Period 14

# Output the results
$rsi
#>