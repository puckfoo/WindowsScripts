Funciton ServerPairs {
    [CmdletBinding()]
    param(
        [string]$NearSide = $env:COMPUTERNAME       
    )
    
    $FarSide = switch ( $NearSide) {
        { $PSItem -eq 'chfile03' } {
            'ny4file04'
        }
        { $PSItem -eq 'chfile05' } {
            'ny4file05'
        }
        { $PSItem -eq 'chfile07'} {
            'ny4file07'
        }
        {$PSItem -eq 'ch2file08'} {
            'ny4file08'
        }
        { $PSItem -eq 'chfile10'} {
            'ny4file10'
        }
    }

    $results = [PSCustomObject]@{
        Primary = $NearSide
        Secondary = $FarSide
    }

    return $results
}






