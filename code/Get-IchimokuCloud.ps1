function Get-IchimokuCloud {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [double[]]$HighValues,
        [Parameter(Mandatory = $true)]
        [double[]]$LowValues,
        [Parameter(Mandatory = $true)]
        [int]$ConversionPeriod = 9,
        [Parameter(Mandatory = $true)]
        [int]$BasePeriod = 26,
        [Parameter(Mandatory = $true)]
        [int]$LaggingPeriod = 52,
        [Parameter(Mandatory = $false)]
        [int]$Displacement = 0
    )

    $conversionLine = [System.Collections.Generic.List[Double]]::new()
    $baseLine = [System.Collections.Generic.List[Double]]::new()
    $leadLineA = [System.Collections.Generic.List[Double]]::new()
    $leadLineB = [System.Collections.Generic.List[Double]]::new()

    $maxIndex = $HighValues.Length - 1
    for ($i = 0; $i -le $maxIndex; $i++) {
        $high = $HighValues[$i]
        $low = $LowValues[$i]

        # Calculate Conversion Line
        $conversionHigh = ($HighValues[($i-$ConversionPeriod+1)..$i] | Measure-Object -Maximum).Maximum
        $conversionLow = ($LowValues[($i-$ConversionPeriod+1)..$i] | Measure-Object -Minimum).Minimum
        $conversionLine.Add(($conversionHigh + $conversionLow) / 2)

        # Calculate Base Line
        $baseHigh = ($HighValues[($i-$BasePeriod+1)..$i] | Measure-Object -Maximum).Maximum
        $baseLow = ($LowValues[($i-$BasePeriod+1)..$i] | Measure-Object -Minimum).Minimum
        $baseLine.Add(($baseHigh + $baseLow) / 2)

        # Calculate Lead Line A
        if ($i + $LaggingPeriod + $Displacement -lt $maxIndex) {
            $leadLineAHigh = ($HighValues[($i-$ConversionPeriod+$LaggingPeriod+$Displacement+1)..($i+$LaggingPeriod+$Displacement)] | Measure-Object -Maximum).Maximum
            $leadLineALow = ($LowValues[($i-$ConversionPeriod+$LaggingPeriod+$Displacement+1)..($i+$LaggingPeriod+$Displacement)] | Measure-Object -Minimum).Minimum
            $leadLineA.Add(($leadLineAHigh + $leadLineALow) / 2)
        }

        # Calculate Lead Line B
        if ($i + $Displacement -lt $maxIndex) {
            $leadLineBHigh = ($HighValues[($i-$BasePeriod+$Displacement+1)..($i+$Displacement)] | Measure-Object -Maximum).Maximum
            $leadLineBLow = ($LowValues[($i-$BasePeriod+$Displacement+1)..($i+$Displacement)] | Measure-Object -Minimum).Minimum
            $leadLineB.Add(($leadLineBHigh + $leadLineBLow) / 2)
        }
    }

    $result = @{
        ConversionLine = $conversionLine
        BaseLine = $baseLine
        LeadLineA = $leadLineA
        LeadLineB = $leadLineB
    }

    $result
}

