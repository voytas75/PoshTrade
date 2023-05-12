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
            $downValues.Add($diff -as [math]::Abs)
        }
        if ($i -eq $Period) {
            $averageGain = [Math]::Round(($upValues | Measure-Object -Property 'Average').Average, 2)
            $averageLoss = [Math]::Round(($downValues | Measure-Object -Property 'Average').Average, 2)
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
