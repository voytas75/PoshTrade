function Get-WeightedMovingAverage {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [double[]]$DataPoints,
        [Parameter(Mandatory = $true)]
        [int]$Period
    )

    $wmaValues = New-Object 'System.Collections.Generic.List[Double]'
    for ($i = 0; $i -lt ($DataPoints.Length - $Period + 1); $i++) {
        $sum = 0.0
        $divisor = 0.0
        for ($j = $i; $j -lt ($i + $Period); $j++) {
            $sum += ($DataPoints[$j] * ($Period - ($j - $i)))
            $divisor += ($Period - ($j - $i))
        }
        $wmaValues.Add($sum / $divisor)
    }

    return $wmaValues
}

<# 
$dataPoints = 1, 2, 3, 4, 5, 6, 7, 8, 9, 10
Get-WeightedMovingAverage -DataPoints $dataPoints -Period 3

#>