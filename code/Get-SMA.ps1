function Get-SMA {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [double[]]$DataPoints,
        [Parameter(Mandatory = $true)]
        [int]$Period
    )

    $smaValues = New-Object 'System.Collections.Generic.List[Double]'
    for ($i = 0; $i -lt ($DataPoints.Length - $Period + 1); $i++) {
        $sum = 0.0
        for ($j = $i; $j -lt ($i + $Period); $j++) {
            $sum += $DataPoints[$j]
        }
        $smaValues.Add($sum / $Period)
    }

    return $smaValues
}
