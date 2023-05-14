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
        Write-Error "Not enough data points"
        return
    }

    $rocValues = @()
    for ($i = $period; $i -lt $closePrices.Count; $i++) {
        $roc = ($closePrices[$i] - $closePrices[$i - $period]) / $closePrices[$i - $period] * 100
        $rocValues += [math]::Round($roc, 2)
    }

    return $rocValues
}

<# 
# Get historical price data from the API (for testing purposes only)
$apiResponse = Invoke-RestMethod -Uri 'https://api.coingecko.com/api/v3/coins/bitcoin/market_chart?vs_currency=usd&days=30'
$closePrices = $apiResponse.prices | foreach { $_[1] }

# Calculate the ROC for a period of 5 days
$rocValues = Get-ROC -closePrices $closePrices -period 5
Write-Output $rocValues

#>