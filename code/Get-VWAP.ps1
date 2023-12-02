<#
.SYNOPSIS
This script calculates the Volume Weighted Average Price (VWAP).

.DESCRIPTION
The script takes two mandatory parameters - PriceValues and VolumeValues, which are arrays of prices and volumes respectively. 
It calculates the VWAP by summing the product of each price and its corresponding volume, and then dividing by the total volume.

.NOTES
Your name
Date of creation/update

.EXAMPLE
$prices = 1.23, 1.24, 1.25, 1.26, 1.27
$volumes = 100, 200, 300, 400, 500
Get-VWAP -PriceValues $prices -VolumeValues $volumes
#>

function Get-VWAP {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [double[]]$PriceValues, # Array of prices

        [Parameter(Mandatory = $true)]
        [double[]]$VolumeValues # Array of volumes
    )

    # Initialize variables to store sum of price*volume and sum of volumes
    $sumPriceVolume = 0
    $sumVolume = 0

    # Iterate over the price and volume arrays
    for ($i = 0; $i -lt $PriceValues.Length; $i++) {
        # Multiply each price by its corresponding volume and add to sum
        $sumPriceVolume += $PriceValues[$i] * $VolumeValues[$i]
        # Add each volume to total volume
        $sumVolume += $VolumeValues[$i]
    }

    # Calculate VWAP by dividing sum of price*volume by total volume
    $vwap = $sumPriceVolume / $sumVolume

    return $vwap
}