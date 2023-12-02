<#
.SYNOPSIS
Calculates the Stochastic Oscillator values for a given set of high, low, and close values.

.DESCRIPTION
The Get-StochasticOscillator function calculates the Stochastic Oscillator values (K and D) based on the provided high, low, and close values.
The Stochastic Oscillator is a momentum indicator that compares a security's closing price to its price range over a specific period.

.PARAMETER HighValues
An array of double values representing the high values for each period.

.PARAMETER LowValues
An array of double values representing the low values for each period.

.PARAMETER CloseValues
An array of double values representing the close values for each period.

.PARAMETER Period
An integer representing the period for calculating the Stochastic Oscillator.

.EXAMPLE
$highValues = 1, 2, 3, 4, 5
$lowValues = 0.5, 1.5, 2.5, 3.5, 4.5
$closeValues = 1.5, 2.5, 3.5, 4.5, 5.5
$period = 3

Get-StochasticOscillator -HighValues $highValues -LowValues $lowValues -CloseValues $closeValues -Period $period
#>

function Get-StochasticOscillator {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [double[]]$HighValues,

        [Parameter(Mandatory = $true)]
        [double[]]$LowValues,

        [Parameter(Mandatory = $true)]
        [double[]]$CloseValues,

        [Parameter(Mandatory = $true)]
        [int]$Period
    )

    $kValues = New-Object 'System.Collections.Generic.List[Double]'
    $dValues = New-Object 'System.Collections.Generic.List[Double]'

    for ($i = $Period - 1; $i -lt $CloseValues.Length; $i++) {
        # Calculate the maximum high value over the specified period
        $maxHigh = ($HighValues[($i - ($Period - 1))..$i] | Measure-Object -Maximum).Maximum

        # Calculate the minimum low value over the specified period
        $minLow = ($LowValues[($i - ($Period - 1))..$i] | Measure-Object -Minimum).Minimum

        # Calculate the current close value
        $currentClose = $CloseValues[$i]

        # Calculate the K value using the Stochastic Oscillator formula
        $k = ($currentClose - $minLow) / ($maxHigh - $minLow) * 100
        $kValues.Add($k)

        if ($i -ge ($Period * 2 - 2)) {
            # Calculate the D value using the average of the K values over the specified period
            $dValue = ($kValues[($i - ($Period - 1))..$i] | Measure-Object -Average).Average
            $dValues.Add($dValue)
        }
        else {
            $dValues.Add(0)
        }
    }

    $result = @{
        K = $kValues
        D = $dValues
    }

    return $result
}