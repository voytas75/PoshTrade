<#
.SYNOPSIS
Calculates the Triple Exponential Moving Average (TEMA) for a given set of data points.

.DESCRIPTION
The Get-TEMA function calculates the TEMA using the Exponential Moving Average (EMA) for a given set of data points.
It returns a list of TEMA values.

.PARAMETER DataPoints
The array of data points for which to calculate the TEMA.

.PARAMETER Period
The period or number of data points to consider for the TEMA calculation.

.EXAMPLE
$dataPoints = 1..20 | ForEach-Object {Get-Random -Minimum 1 -Maximum 100}
$period = 10
$temaValues = Get-TEMA -DataPoints $dataPoints -Period $period
Write-Output $temaValues
#>

function Get-TEMA {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [double[]]$DataPoints,
        [Parameter(Mandatory = $true)]
        [int]$Period
    )

    # Calculate the first EMA
    $ema1 = Get-EMA -DataPoints $DataPoints -Period $Period

    # Calculate the second EMA
    $ema2 = Get-EMA -DataPoints $ema1 -Period $Period

    # Calculate the third EMA
    $ema3 = Get-EMA -DataPoints $ema2 -Period $Period

    # Calculate the TEMA values
    $temaValues = New-Object 'System.Collections.Generic.List[Double]'
    for ($i = 0; $i -lt $DataPoints.Length; $i++) {
        $tema = 3 * $ema1[$i] - 3 * $ema2[$i] + $ema3[$i]
        $temaValues.Add($tema)
    }

    return $temaValues
}