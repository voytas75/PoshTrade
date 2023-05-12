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
