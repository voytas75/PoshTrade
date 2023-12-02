<# 
.SYNOPSIS
    This script calculates the Rate of Change (ROC) for a given set of closing prices over a specified period.

.DESCRIPTION
    The Get-ROC function takes an array of closing prices and a period as input, and it returns an array of ROC values.

.PARAMETER closePrices
    An array of closing prices.

.PARAMETER period
    The period for calculating the ROC.

.EXAMPLE
    $apiResponse = Invoke-RestMethod -Uri 'https://api.coingecko.com/api/v3/coins/bitcoin/market_chart?vs_currency=usd&days=30'
    $closePrices = $apiResponse.prices | foreach { $_[1] }

    # Calculate the ROC for a period of 5 days
    $rocValues = Get-ROC -closePrices $closePrices -period 5
    Write-Output $rocValues

.NOTES
    File Name      : Get-ROC.ps1
    Author         : ScriptSavvyNinja
    Prerequisite   : PowerShell V3
#>

function Get-ROC {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [double[]]$closePrices,
        [Parameter(Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [int]$period
    )

    if ($closePrices.Count -lt $period) {
        Write-Error "Not enough data points. Please provide sufficient data for calculation."
        return
    }

    $rocValues = @()
    for ($i = $period; $i -lt $closePrices.Count; $i++) {
        # Calculate the Rate of Change (ROC) using the formula: ((Closing Price - Previous Closing Price) / Previous Closing Price) * 100
        $roc = ($closePrices[$i] - $closePrices[$i - $period]) / $closePrices[$i - $period] * 100
        $rocValues += [math]::Round($roc, 2)
    }

    return $rocValues
}
