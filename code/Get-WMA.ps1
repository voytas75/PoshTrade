<# 
.SYNOPSIS
Calculate the weighted moving average of a series of data points.

.DESCRIPTION
The Get-WeightedMovingAverage function calculates the weighted moving average for a given series of data points and a specified period. It returns a list of the weighted moving average values.

.PARAMETER DataPoints
The array of data points for which to calculate the weighted moving average.

.PARAMETER Period
The period over which to calculate the weighted moving average.

.EXAMPLE
$dataPoints = 1, 2, 3, 4, 5, 6, 7, 8, 9, 10
Get-WeightedMovingAverage -DataPoints $dataPoints -Period 3
# Returns: 2, 3, 4, 5, 6, 7, 8, 9

#>
function Get-WeightedMovingAverage {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [double[]]$DataPoints,
        [Parameter(Mandatory = $true)]
        [int]$Period
    )

    # Create a new list to store the weighted moving average values
    $wmaValues = New-Object 'System.Collections.Generic.List[Double]'
    
    # Calculate the weighted moving average for each data point
    for ($i = 0; $i -lt ($DataPoints.Length - $Period + 1); $i++) {
        $sum = 0.0
        $divisor = 0.0
        
        # Calculate the sum and divisor for the weighted average
        for ($j = $i; $j -lt ($i + $Period); $j++) {
            $sum += ($DataPoints[$j] * ($Period - ($j - $i)))
            $divisor += ($Period - ($j - $i))
        }
        
        # Add the weighted average value to the list
        $wmaValues.Add($sum / $divisor)
    }

    # Return the list of weighted moving average values
    return $wmaValues
}