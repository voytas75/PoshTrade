<#
.SYNOPSIS
    Calculates the On-Balance Volume (OBV) for a given set of closing prices and corresponding volumes.
.DESCRIPTION
    This script defines a PowerShell function, Get-OBV, which calculates the OBV values based on the provided closing prices and volumes.
.PARAMETER Close
    An array of closing prices.
.PARAMETER Volume
    An array of corresponding volumes.
.EXAMPLE
    $closePrices = 1.1, 1.2, 1.3, 1.2, 1.1
    $volumes = 100, 200, 300, 200, 100
    Get-OBV -Close $closePrices -Volume $volumes
#>

function Get-OBV {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [double[]] $Close,
        [Parameter(Mandatory = $true)]
        [double[]] $Volume
    )

    # Create a list to store On-Balance Volume (OBV) values
    $obv = [System.Collections.Generic.List[Double]]::new()
    $obv.Add($Volume[0])  # Initialize with the first volume value

    # Calculate OBV values
    for ($i = 1; $i -lt $Close.Length; $i++) {
        $prevClose = $Close[$i - 1]
        $currentClose = $Close[$i]
        $currentVolume = $Volume[$i]

        # Determine whether to add, subtract, or maintain OBV value
        if ($currentClose -gt $prevClose) {
            $obv.Add($obv[$i - 1] + $currentVolume)  # Price increased
        }
        elseif ($currentClose -lt $prevClose) {
            $obv.Add($obv[$i - 1] - $currentVolume)  # Price decreased
        }
        else {
            $obv.Add($obv[$i - 1])  # Price unchanged
        }
    }

    return $obv
}