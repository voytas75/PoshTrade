function Get-FibonacciRetracement {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [double]$StartPrice,
        [Parameter(Mandatory = $true)]
        [double]$EndPrice
    )

    $retracementLevels = @()
    $retracementLevels += ($EndPrice - ($EndPrice - $StartPrice) * 0.236)
    $retracementLevels += ($EndPrice - ($EndPrice - $StartPrice) * 0.382)
    $retracementLevels += ($EndPrice - ($EndPrice - $StartPrice) * 0.5)
    $retracementLevels += ($EndPrice - ($EndPrice - $StartPrice) * 0.618)
    $retracementLevels += ($EndPrice - ($EndPrice - $StartPrice) * 0.786)

    return $retracementLevels
}


<# 
Get-FibonacciRetracement -StartPrice 100 -EndPrice 200
#>