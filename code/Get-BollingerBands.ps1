function Get-BollingerBands {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [string]$symbol,
        [Parameter(Mandatory=$true)]
        [array]$prices,
        [Parameter(Mandatory=$false)]
        [int]$period = 20,
        [Parameter(Mandatory=$false)]
        [int]$num_std_devs = 2
    )

    # Calculate moving average and standard deviation
    $ma = $prices | Select-Object -Last $period | Measure-Object -Property close -Average
    $ma_value = $ma.Average
    $stdev = [Math]::Sqrt(($prices | Select-Object -Last $period | ForEach-Object { [Math]::Pow($_.close - $ma_value, 2) } | Measure-Object -Average).Average)

    # Calculate upper and lower bands
    $upper_band = $ma_value + ($num_std_devs * $stdev)
    $lower_band = $ma_value - ($num_std_devs * $stdev)

    # Output Bollinger Bands
    Write-Output "The Bollinger Bands for $symbol are: Upper Band = $upper_band, Lower Band = $lower_band."
}

<# 
# Example usage
$symbol = "BTC/USD"
$prices = @(
    [pscustomobject]@{ date = "2022-01-01"; close = 50000 },
    [pscustomobject]@{ date = "2022-01-02"; close = 55000 },
    [pscustomobject]@{ date = "2022-01-03"; close = 52000 },
    [pscustomobject]@{ date = "2022-01-04"; close = 48000 },
    [pscustomobject]@{ date = "2022-01-05"; close = 49000 },
    [pscustomobject]@{ date = "2022-01-06"; close = 51000 },
    [pscustomobject]@{ date = "2022-01-07"; close = 53000 },
    [pscustomobject]@{ date = "2022-01-08"; close = 56000 },
    [pscustomobject]@{ date = "2022-01-09"; close = 59000 },
    [pscustomobject]@{ date = "2022-01-10"; close = 61000 }
)

Get-BollingerBands -symbol $symbol -prices $prices -period 20 -num_std_devs 2

#>