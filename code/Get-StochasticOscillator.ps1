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
        $maxHigh = ($HighValues[($i - ($Period - 1))..$i] | Measure-Object -Maximum).Maximum
        $minLow = ($LowValues[($i - ($Period - 1))..$i] | Measure-Object -Minimum).Minimum
        $currentClose = $CloseValues[$i]
        $k = ($currentClose - $minLow) / ($maxHigh - $minLow) * 100
        $kValues.Add($k)

        if ($i -ge ($Period * 2 - 2)) {
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

<#
$highValues = 1, 2, 3, 4, 5
$lowValues = 0.5, 1.5, 2.5, 3.5, 4.5
$closeValues = 1.5, 2.5, 3.5, 4.5, 5.5
$period = 3

Get-StochasticOscillator -HighValues $highValues -LowValues $lowValues -CloseValues $closeValues -Period $period
#>