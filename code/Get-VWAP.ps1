function Get-VWAP {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [double[]]$PriceValues,
        [Parameter(Mandatory = $true)]
        [double[]]$VolumeValues
    )

    $sumPriceVolume = 0
    $sumVolume = 0

    for ($i = 0; $i -lt $PriceValues.Length; $i++) {
        $sumPriceVolume += $PriceValues[$i] * $VolumeValues[$i]
        $sumVolume += $VolumeValues[$i]
    }

    $vwap = $sumPriceVolume / $sumVolume

    return $vwap
}

<# 
$prices = 1.23, 1.24, 1.25, 1.26, 1.27
$volumes = 100, 200, 300, 400, 500

Get-VWAP -PriceValues $prices -VolumeValues $volumes

#>