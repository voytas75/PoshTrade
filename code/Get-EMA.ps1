function Get-EMA {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [double[]]$DataPoints,
        [Parameter(Mandatory = $true)]
        [int]$Period
    )

    $multiplier = 2 / ($Period + 1)
    $emaValues = New-Object 'System.Collections.Generic.List[Double]'
    $emaValues.Add($DataPoints[0])
    for ($i = 1; $i -lt $DataPoints.Length; $i++) {
        $ema = ($DataPoints[$i] - $emaValues[$i - 1]) * $multiplier + $emaValues[$i - 1]
        $emaValues.Add($ema)
    }

    return $emaValues
}

<# 
$dataPoints = 3.5, 3.8, 3.6, 3.9, 3.7, 3.5, 3.3, 3.6, 3.8, 4.1, 4.2, 4.5, 4.2, 4.0, 4.1
$period = 10
Get-EMA -DataPoints $dataPoints -Period $period

#>