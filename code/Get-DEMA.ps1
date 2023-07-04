function Get-DEMA {
    <#
.SYNOPSIS
    Calculates the Double Exponential Moving Average (DEMA) for a given array of data points.

.DESCRIPTION
    The Get-DEMA function calculates the Double Exponential Moving Average (DEMA) for a given array of data points.
    It uses the Get-EMA function to calculate the exponential moving averages and then applies the DEMA formula to obtain the DEMA values.

.PARAMETER DataPoints
    The array of data points for which the DEMA needs to be calculated.
    The data points should be provided as an array of doubles.

.PARAMETER Period
    The period or number of data points to consider for the calculation of DEMA.
    It should be a positive integer value.

.EXAMPLE
    Get-DEMA -DataPoints 1, 2, 3, 4, 5 -Period 3
    Calculates the DEMA for the data points [1, 2, 3, 4, 5] using a period of 3.

.NOTES
    Author: Wojciech Napierała
    Date: 04.07.2023
#>

    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [double[]]$DataPoints,

        [Parameter(Mandatory = $true)]
        [ValidateRange(1, [int]::MaxValue)]
        [int]$Period
    )

    try {
        $ema1 = Get-EMA -DataPoints $DataPoints -Period $Period
        $ema2 = Get-EMA -DataPoints $ema1 -Period $Period

        $demaValues = @()

        for ($i = 0; $i -lt $DataPoints.Length; $i++) {
            $dema = 2 * $ema1[$i] - $ema2[$i]
            $demaValues += $dema
        }

        return $demaValues
    }
    catch {
        Write-Error "An error occurred while calculating DEMA: $_"
    }
}

<# 
$data = @(50.10, 51.20, 52.30, 53.40, 54.50, 55.60, 56.70, 57.80, 58.90, 60.00, 61.10, 62.20, 63.30, 64.40, 65.50)
Get-DEMA -DataPoints $data -Period 5
#>