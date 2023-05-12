function Get-MovingAverage {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [string]$symbol,
        [Parameter(Mandatory=$true)]
        [array]$prices,
        [Parameter(Mandatory=$false)]
        [int]$period = 20
    )

    # Calculate moving average
    $ma = $prices | Select-Object -Last $period | Measure-Object -Property close -Average
    $ma_value = $ma.Average

    # Output moving average
    Write-Output "The $period-period moving average for $symbol is $ma_value."
}

<# 
# Define historical price data
$prices = @(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)

# Call function to calculate 5-period moving average
Get-MovingAverage -symbol "TEST" -prices $prices -period 5

#>