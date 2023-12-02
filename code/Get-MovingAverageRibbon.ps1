<#
.SYNOPSIS
Calculates the moving averages for a given symbol and number of days.

.DESCRIPTION
The Get-MovingAverageRibbon function retrieves price data for a specified cryptocurrency symbol from the Coingecko API. It then calculates the moving averages using the Get-MovingAverage function. The moving averages are returned as a custom object.

.PARAMETER symbol
The symbol of the cryptocurrency for which the moving averages are calculated.

.PARAMETER days
The number of days of price data to consider for the moving averages.

.EXAMPLE
Get-MovingAverageRibbon -symbol "bitcoin" -days 90
Returns the moving averages for the Bitcoin cryptocurrency over the last 90 days.

#>
function Get-MovingAverageRibbon {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [string]$symbol,
        [Parameter(Mandatory=$true)]
        [ValidateRange(1,1000)]
        [int]$days
    )

    # Define the URL for the Coingecko API
    $url = "https://api.coingecko.com/api/v3/coins/$symbol/market_chart?vs_currency=usd&days=$days"
    
    try {
        # Invoke the API and get the response
        $response = Invoke-RestMethod -Uri $url

        # Extract the price data from the response
        $prices = $response.prices
        
        # Calculate the moving averages
        $ma10 = Get-MovingAverage -Data $prices -Window 10
        $ma20 = Get-MovingAverage -Data $prices -Window 20
        $ma30 = Get-MovingAverage -Data $prices -Window 30
        $ma40 = Get-MovingAverage -Data $prices -Window 40
        $ma50 = Get-MovingAverage -Data $prices -Window 50
        
        # Output the moving averages
        [pscustomobject]@{
            Symbol = $symbol
            MA10 = $ma10
            MA20 = $ma20
            MA30 = $ma30
            MA40 = $ma40
            MA50 = $ma50
        }
    }
    catch {
        # Handle any errors and output the exception message
        Write-Error $_.Exception.Message
    }
}

# Function: Get-MovingAverage
# Calculates the moving average of a given data array using a sliding window.
# Parameters:
#   -Data: The array of data for which the moving average is calculated.
#   -Window: The size of the sliding window used for the moving average calculation.
# Returns: The array of moving averages.
function Get-MovingAverage {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [array]$Data,
        [Parameter(Mandatory=$true)]
        [ValidateRange(1,1000)]
        [int]$Window
    )

    # Calculate the moving average using a sliding window
    $sum = 0
    $movingAverage = for ($i = 0; $i -lt $Data.Length; $i++) {
        $sum += $Data[$i][1]
        if ($i -ge $Window) {
            $sum -= $Data[$i-$Window][1]
            $average = $sum / $Window
        }
        else {
            $average = $sum / ($i + 1)
        }
        $average
    }

    # Round the moving average to 2 decimal places
    $movingAverage = $movingAverage | ForEach-Object { [Math]::Round($_, 2) }

    return $movingAverage
}