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

    $shortEMAValues = New-Object 'System.Collections.Generic.List[Double]'
    $longEMAValues = New-Object 'System.Collections.Generic.List[Double]'
    $macdValues = New-Object 'System.Collections.Generic.List[Double]'
    $signalLineValues = New-Object 'System.Collections.Generic.List[Double]'

    $shortEMAAlpha = 2 / ($ShortEMA + 1)
    $longEMAAlpha = 2 / ($LongEMA + 1)
    $signalEMAAlpha = 2 / ($SignalEMA + 1)

    $shortEMA = $DataPoints[0]
    $longEMA = $DataPoints[0]

    for ($i = 0; $i -lt $DataPoints.Length; $i++) {
        $shortEMA = ($DataPoints[$i] - $shortEMA) * $shortEMAAlpha + $shortEMA
        $longEMA = ($DataPoints[$i] - $longEMA) * $longEMAAlpha + $longEMA
        $shortEMAValues.Add($shortEMA)
        $longEMAValues.Add($longEMA)
        $macd = $shortEMA - $longEMA
        $macdValues.Add($macd)

        if ($i -lt $SignalEMA) {
            $signalLine = $macdValues | Measure-Object -Property 'Average'
            $signalLineValues.Add($signalLine.Average)
        }
        else {
            $signalLine = ($macd - $macdValues[$i - $SignalEMA]) * $signalEMAAlpha + $signalLineValues[$i - $SignalEMA]
            $signalLineValues.Add($signalLine)
        }
    }

    $histogramValues = New-Object 'System.Collections.Generic.List[Double]'
    for ($i = 0; $i -lt $macdValues.Count; $i++) {
        $histogram = $macdValues[$i] - $signalLineValues[$i]
        $histogramValues.Add($histogram)
    }

    $result = @{
        ShortEMA = $shortEMAValues
        LongEMA = $longEMAValues
        MACD = $macdValues
        SignalLine = $signalLineValues
        Histogram = $histogramValues
    }

    return $result
}

<# 
# Sample historical data values
$dataPoints = @(50.39, 51.64, 52.92, 53.48, 53.20, 52.35, 53.02, 52.86, 53.66, 54.08, 54.98, 54.21, 53.74, 54.17, 54.47, 54.28, 53.94, 53.27, 53.22, 52.84, 53.05, 52.83, 52.54, 52.08, 52.77, 52.66, 53.15, 53.90, 54.22, 54.20, 54.51, 54.25, 53.60, 53.61, 53.32, 53.67, 53.95, 53.75, 53.99, 54.33, 53.75, 53.39, 53.12, 52.98, 53.02, 52.58, 52.16, 51.68, 52.22, 51.59, 52.19, 52.17, 51.91, 52.29, 52.54, 53.08, 52.49, 51.90, 52.45, 51.88, 52.27, 52.25, 52.30, 52.55, 52.84, 53.03, 52.76, 52.67, 53.21, 52.75, 53.10, 52.65, 53.14, 53.14, 52.56, 51.97, 51.92, 52.21, 51.50, 50.92, 51.51, 51.19, 51.65, 51.71, 52.13, 51.70, 51.59, 51.43, 51.68, 51.92)

# Call the Get-MACD function with the sample data
$macd = Get-MACD -DataPoints $dataPoints -ShortEMA 12 -LongEMA 26 -SignalEMA 9

# Display the MACD and signal line values
$macd.MACD
$macd.SignalLine

#>
