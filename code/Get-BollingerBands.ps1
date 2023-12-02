<#
.SYNOPSIS
    Calculates Bollinger Bands for a given symbol and closing prices.
.DESCRIPTION
    This script defines a PowerShell function, Get-BollingerBands, which calculates Bollinger Bands
    based on the provided symbol and closing prices within a specified period and number of standard deviations.
.PARAMETER symbol
    The symbol for which Bollinger Bands are calculated.
.PARAMETER prices
    An array of objects containing date and close price properties.
.PARAMETER period
    The period for calculating the moving average and standard deviation. Default is 20.
.PARAMETER num_std_devs
    The number of standard deviations for calculating upper and lower bands. Default is 2.
.EXAMPLE
    $symbol = "BTC/USD"
    $prices = @(
        [pscustomobject]@{ date = "2022-01-01"; close = 50000 },
        [pscustomobject]@{ date = "2022-01-02"; close = 55000 },
        ...
    )
    Get-BollingerBands -symbol $symbol -prices $prices -period 20 -num_std_devs 2
.NOTES
    Author: Wojciech Napierała
    Date: 04.07.2023
    Version: 1.1
#>

function Get-BollingerBands {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$symbol,

        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [array]$prices,

        [Parameter(Mandatory = $false)]
        [ValidateRange(1, [int]::MaxValue)]
        [int]$period = 20,

        [Parameter(Mandatory = $false)]
        [ValidateRange(0, [int]::MaxValue)]
        [int]$num_std_devs = 2
    )

    # Calculate moving average and standard deviation
    $ma_values = $prices[-$period..-1].close
    $ma_value = ($ma_values | Measure-Object -Average).Average
    $stdev = [Math]::Sqrt(($ma_values | ForEach-Object { [Math]::Pow($_ - $ma_value, 2) } | Measure-Object -Average).Average)

    # Calculate upper and lower bands
    $upper_band = $ma_value + ($num_std_devs * $stdev)
    $lower_band = $ma_value - ($num_std_devs * $stdev)

    # Output Bollinger Bands
    Write-Output "The Bollinger Bands for $symbol are: Upper Band = $upper_band, Lower Band = $lower_band."
}