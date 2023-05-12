function Get-EMA {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [double[]]$DataPoints,
        [Parameter(Mandatory = $true)]
        [int]$Period
    )

    $multiplier = 2 / ($Period + 1)
    $emaValues = New-Object 'System.Collections.Generic.List[Double]'
    $emaValues.Add($DataPoints[0])
    for ($i = 1; $i -lt $DataPoints.Length; $i++) {
        $ema = ($DataPoints[$i] - $emaValues[$i - 1]) * $multiplier + $emaValues[$i - 1]
        $emaValues.Add($ema)
    }

    return $emaValues
}
