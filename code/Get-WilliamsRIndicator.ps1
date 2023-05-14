function Get-WilliamsRIndicator {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [double[]]$High,

        [Parameter(Mandatory = $true)]
        [double[]]$Low,

        [Parameter(Mandatory = $true)]
        [double[]]$Close,

        [Parameter(Mandatory = $true)]
        [int]$Period
    )

    $results = @()

    # Check if the arrays have any null values
    $Low = $Low | Where-Object { $_ -ne $null }
    $Close = $Close | Where-Object { $_ -ne $null }

    # Verify that the arrays have the same number of elements as the $High array
    if ($Low.Count -ne $High.Count) {
        throw "The number of elements in the Low and High arrays do not match."
    }

    if ($Close.Count -ne $High.Count) {
        throw "The number of elements in the Close and High arrays do not match."
    }

    # Initialize arrays if not already done
    if ($Low.Count -eq 0) {
        $Low = @()
        for ($i=0; $i -lt $High.Count; $i++) {
            $Low += $High[$i]
        }
    }

    if ($Close.Count -eq 0) {
        $Close = @()
        for ($i=0; $i -lt $High.Count; $i++) {
            $Close += $High[$i]
        }
    }

    # Populate results array with Williams %R values
    for ($i=$Period-1; $i -lt $High.Count; $i++) {
        $highestHigh = ($High[($i-$Period+1)..$i] | Measure-Object -Maximum).Maximum
        $lowestLow = ($Low[($i-$Period+1)..$i] | Measure-Object -Minimum).Minimum
        $williamsR = (($highestHigh - $Close[$i]) / ($highestHigh - $lowestLow)) * -100
        $results += $williamsR
    }

    return $results
}

<# 
$url = "https://api.coingecko.com/api/v3/coins/bitcoin/market_chart?vs_currency=usd&days=30"
$response = Invoke-RestMethod $url

$high = $response.prices | ForEach-Object { $_[1] }
$low = $response.prices | ForEach-Object { $_[1] }
$close = $response.prices | ForEach-Object { $_[1] }
$period = 14

$williamsR = Get-WilliamsRIndicator -High $high -Low $low -Close $close -Period $period

$williamsR

#>