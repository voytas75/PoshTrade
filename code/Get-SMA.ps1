function Get-SMA {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [double[]]$DataPoints,
        [Parameter(Mandatory = $true)]
        [int]$Period
    )

    $smaValues = New-Object 'System.Collections.Generic.List[Double]'
    for ($i = 0; $i -lt ($DataPoints.Length - $Period + 1); $i++) {
        $sum = 0.0
        for ($j = $i; $j -lt ($i + $Period); $j++) {
            $sum += $DataPoints[$j]
        }
        $smaValues.Add($sum / $Period)
    }

    return $smaValues
}

<# 
$dataPoints = @(105.68, 107.79, 110.96, 112.18, 109.85, 111.03, 110.06, 111.89, 109.08, 109.75, 111.31, 111.02, 112.26, 112.63, 112.1, 113.05, 112.52, 110.92, 109.08, 109.72, 108.36, 109.65, 109.7, 108.87, 108.99, 108.03, 108.83, 109.45, 109.38, 110.38, 111.3, 111.12, 109.85, 109.87, 110.44, 110.52, 111.46, 110.96, 112.36, 112.21, 112.52, 111.2, 110.92, 110.06, 109.08, 110.16, 109.57, 109.51, 110.96, 111.39, 110.08)
$period = 10
Get-SMA -DataPoints $dataPoints -Period $period

#>
