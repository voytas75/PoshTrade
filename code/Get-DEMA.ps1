function Get-DEMA {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [double[]]$DataPoints,
        [Parameter(Mandatory = $true)]
        [int]$Period
    )

    $ema1 = Get-EMA -DataPoints $DataPoints -Period $Period
    $ema2 = Get-EMA -DataPoints $ema1 -Period $Period
    $demaValues = New-Object 'System.Collections.Generic.List[Double]'
    for ($i = 0; $i -lt $DataPoints.Length; $i++) {
        $dema = 2 * $ema1[$i] - $ema2[$i]
        $demaValues.Add($dema)
    }

    return $demaValues
}

<# 
$data = @(50.10, 51.20, 52.30, 53.40, 54.50, 55.60, 56.70, 57.80, 58.90, 60.00, 61.10, 62.20, 63.30, 64.40, 65.50)
Get-DEMA -DataPoints $data -Period 5
#>