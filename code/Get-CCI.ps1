function Get-CCI {
    <#
    .EXAMPLE
    Example usage with historical data from Coingecko API

    $baseUrl = "https://api.coingecko.com/api/v3"
    $coinId = "bitcoin"
    $days = 30
    $url = "$baseUrl/coins/$coinId/market_chart?vs_currency=usd&days=$days"
    $response = Invoke-RestMethod -Uri $url
    $prices = $response.prices
    $highPrices = $prices | ForEach-Object { $_[1] }
    $lowPrices = $prices | ForEach-Object { $_[2] }
    $closePrices = $prices | ForEach-Object { $_[1] }
    $period = 20
    $cci = Get-CCI -HighPrices $highPrices -LowPrices $lowPrices -ClosePrices $closePrices -Period $period
    Write-Output $cci

    .NOTES
    Author: Wojciech Napierała
    Date: 04.07.2023
    Version: 1.1
    #>

    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [double[]]$HighPrices,

        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [double[]]$LowPrices,

        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [double[]]$ClosePrices,

        [Parameter(Mandatory = $true)]
        [ValidateRange(1, [int]::MaxValue)]
        [int]$Period
    )

    # Input validation
    if ($HighPrices.Length -ne $LowPrices.Length -or $LowPrices.Length -ne $ClosePrices.Length) {
        throw "Input arrays must have the same length."
    }

    $typicalPrices = for ($i = 0; $i -lt $ClosePrices.Length; $i++) {
        ($HighPrices[$i] + $LowPrices[$i] + $ClosePrices[$i]) / 3
    }

    $sma = Get-SMA -DataPoints $typicalPrices -Period $Period

    $meanDeviation = New-Object 'System.Collections.Generic.List[Double]'
    for ($i = $Period - 1; $i -lt $typicalPrices.Length; $i++) {
        $sum = 0.0
        for ($j = $i - $Period + 1; $j -le $i; $j++) {
            $sum += [Math]::Abs($typicalPrices[$j] - $sma[$i - $Period + 1])
        }
        $meanDeviation.Add($sum / $Period)
    }

    $cci = New-Object 'System.Collections.Generic.List[Double]'
    for ($i = $Period - 1; $i -lt $typicalPrices.Length; $i++) {
        $cci.Add(($typicalPrices[$i] - $sma[$i - $Period + 1]) / (0.015 * [Math]::Abs($meanDeviation[$i - $Period + 1])))
    }

    return $cci
}

<#
# Example usage with historical data from Coingecko API

$baseUrl = "https://api.coingecko.com/api/v3"
$coinId = "bitcoin"
$days = 30

$url = "$baseUrl/coins/$coinId/market_chart?vs_currency=usd&days=$days"
$response = Invoke-RestMethod -Uri $url
$prices = $response.prices
$highPrices = $prices | ForEach-Object { $_[1] }
$lowPrices = $prices | ForEach-Object { $_[2] }
$closePrices = $prices | ForEach-Object { $_[1] }

$period = 20
$cci = Get-CCI -HighPrices $highPrices -LowPrices $lowPrices -ClosePrices $closePrices -Period $period
Write-Output $cci

#>
