function Get-TEMA {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [double[]]$DataPoints,
        [Parameter(Mandatory = $true)]
        [int]$Period
    )

    $ema1 = Get-EMA -DataPoints $DataPoints -Period $Period
    $ema2 = Get-EMA -DataPoints $ema1 -Period $Period
    $ema3 = Get-EMA -DataPoints $ema2 -Period $Period
    $temaValues = New-Object 'System.Collections.Generic.List[Double]'
    for ($i = 0; $i -lt $DataPoints.Length; $i++) {
        $tema = 3 * $ema1[$i] - 3 * $ema2[$i] + $ema3[$i]
        $temaValues.Add($tema)
    }

    return $temaValues
}

<# 
$dataPoints = 1..20 | ForEach-Object {Get-Random -Minimum 1 -Maximum 100}
$period = 10
$temaValues = Get-TEMA -DataPoints $dataPoints -Period $period
Write-Output $temaValues

#>
