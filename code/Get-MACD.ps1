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
