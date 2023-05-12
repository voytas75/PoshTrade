function Get-OBV {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [double[]] $Close,
        [Parameter(Mandatory = $true)]
        [double[]] $Volume
    )

    $obv = [System.Collections.Generic.List[Double]]::new()
    $obv.Add($Volume[0])

    for ($i = 1; $i -lt $Close.Length; $i++) {
        $prevClose = $Close[$i - 1]
        $currentClose = $Close[$i]
        $currentVolume = $Volume[$i]

        if ($currentClose -gt $prevClose) {
            $obv.Add($obv[$i - 1] + $currentVolume)
        }
        elseif ($currentClose -lt $prevClose) {
            $obv.Add($obv[$i - 1] - $currentVolume)
        }
        else {
            $obv.Add($obv[$i - 1])
        }
    }

    return $obv
}

<# 
$closePrices = 1.1, 1.2, 1.3, 1.2, 1.1
$volumes = 100, 200, 300, 200, 100

Get-OBV -Close $closePrices -Volume $volumes

#>