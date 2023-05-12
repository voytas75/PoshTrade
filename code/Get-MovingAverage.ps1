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
