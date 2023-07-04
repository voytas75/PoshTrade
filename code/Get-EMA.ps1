function Get-EMA {
    <#
    .SYNOPSIS
    Calculates the Exponential Moving Average (EMA) for a given set of data points.
    
    .DESCRIPTION
    This function calculates the Exponential Moving Average (EMA) for a given set of data points.
    The EMA is a commonly used technical indicator used in financial analysis.
    
    .PARAMETER DataPoints
    An array of doubles representing the data points for which the EMA needs to be calculated.
    
    .PARAMETER Period
    An integer representing the period or number of data points to consider in the EMA calculation.
    
    .EXAMPLE
    PS> $data = 1..10 | foreach { $_ + Get-Random -Minimum 1 -Maximum 10 }
    PS> $ema = Get-EMA -DataPoints $data -Period 5
    PS> $ema
    2.5
    3.25
    4.125
    5.0625
    6.03125
    6.515625
    6.7578125
    6.87890625
    6.939453125
    6.9697265625
    
    .NOTES
    Author: Wojciech Napierała
    Date: 04.07.2023
    Version: 1.1
    #>
    
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [double[]]$DataPoints,

        [Parameter(Mandatory = $true)]
        [ValidateRange(1, [int]::MaxValue)]
        [int]$Period
    )

    try {
        $multiplier = 2 / ($Period + 1)
        $emaValues = New-Object 'System.Collections.Generic.List[Double]'
        $emaValues.Add($DataPoints[0])
        for ($i = 1; $i -lt $DataPoints.Length; $i++) {
            $ema = ($DataPoints[$i] - $emaValues[$i - 1]) * $multiplier + $emaValues[$i - 1]
            $emaValues.Add($ema)
        }

        return $emaValues
    }
    catch {
        Write-Error "An error occurred while calculating the EMA. Details: $($_.Exception.Message)"
    }
}

<# 
$dataPoints = 3.5, 3.8, 3.6, 3.9, 3.7, 3.5, 3.3, 3.6, 3.8, 4.1, 4.2, 4.5, 4.2, 4.0, 4.1
$period = 10
Get-EMA -DataPoints $dataPoints -Period $period

#>
