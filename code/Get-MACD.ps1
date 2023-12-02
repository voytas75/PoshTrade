<#
.SYNOPSIS
    Calculates the Moving Average Convergence Divergence (MACD) for a given set of data points.
.DESCRIPTION
    This script defines a PowerShell function, Get-MACD, which calculates the MACD values based on the provided historical data.
.PARAMETER DataPoints
    An array of historical data points.
.PARAMETER ShortEMA
    The number of periods for the short Exponential Moving Average (EMA).
.PARAMETER LongEMA
    The number of periods for the long Exponential Moving Average (EMA).
.PARAMETER SignalEMA
    The number of periods for the Signal Line Exponential Moving Average (EMA).
.EXAMPLE
    $dataPoints = @(50.39, 51.64, ... )  # Sample historical data values
    $macd = Get-MACD -DataPoints $dataPoints -ShortEMA 12 -LongEMA 26 -SignalEMA 9
    $macd.MACD  # Display MACD values
    $macd.SignalLine  # Display Signal Line values
#>

function Get-MACD {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [double[]]$DataPoints,
        [Parameter(Mandatory = $true)]
        [int]$ShortEMA,
        [Parameter(Mandatory = $true)]
        [int]$LongEMA,
        [Parameter(Mandatory = $true)]
        [int]$SignalEMA
    )

    # Create lists to store intermediate values
    $shortEMAValues = New-Object 'System.Collections.Generic.List[Double]'
    $longEMAValues = New-Object 'System.Collections.Generic.List[Double]'
    $macdValues = New-Object 'System.Collections.Generic.List[Double]'
    $signalLineValues = New-Object 'System.Collections.Generic.List[Double]'

    # Calculate alpha values for EMA calculations
    $shortEMAAlpha = 2 / ($ShortEMA + 1)
    $longEMAAlpha = 2 / ($LongEMA + 1)
    $signalEMAAlpha = 2 / ($SignalEMA + 1)

    # Initialize EMA values
    $shortEMA = $DataPoints[0]
    $longEMA = $DataPoints[0]

    # Calculate MACD values
    for ($i = 0; $i -lt $DataPoints.Length; $i++) {
        # Update short and long EMAs
        $shortEMA = ($DataPoints[$i] - $shortEMA) * $shortEMAAlpha + $shortEMA
        $longEMA = ($DataPoints[$i] - $longEMA) * $longEMAAlpha + $longEMA

        # Calculate MACD and update lists
        $macd = $shortEMA - $longEMA
        $macdValues.Add($macd)

        # Calculate Signal Line values
        if ($i -lt $SignalEMA) {
            $signalLine = $macdValues | Measure-Object -Property 'Average'
            $signalLineValues.Add($signalLine.Average)
        }
        else {
            $signalLine = ($macd - $macdValues[$i - $SignalEMA]) * $signalEMAAlpha + $signalLineValues[$i - $SignalEMA]
            $signalLineValues.Add($signalLine)
        }
    }

    # Calculate Histogram values
    $histogramValues = $macdValues - $signalLineValues

    # Build and return result
    $result = @{
        ShortEMA = $shortEMAValues
        LongEMA = $longEMAValues
        MACD = $macdValues
        SignalLine = $signalLineValues
        Histogram = $histogramValues
    }

    return $result
}
