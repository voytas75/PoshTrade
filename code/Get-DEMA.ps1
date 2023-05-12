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
