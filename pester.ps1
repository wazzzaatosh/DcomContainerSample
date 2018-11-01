$script:rand = New-Object Random
function Get-ServerContainerName {
    $num = $script:rand.Next( 11, 999 )
    return "dcomtest$num"
}

$script:cleanup = @()
$script:network = $null
Describe 'Dcom container tests' {
    BeforeAll {
        # The images need to be built.
        $images = docker images --format '{{.Repository}}'
        $image = $images | Where-Object { $_ -eq 'dcomtest-exe-server' }
        if( -not $image ) {
            & $PSScriptRoot/build.ps1 | Out-Host
        }

        # We need a transparent network to use.
        $networks = docker network ls --format '{{.Name}}|{{.Driver}}'
        foreach( $info in $networks ) {
            $parts = $info.Split( '|' )
            if( $parts[1] -eq 'ics' ) {
                $script:network = $parts[0]
                Write-Host "`tUsing the docker internal network `"$($script:network)`"" -ForegroundColor Yellow
                break
            }
        }

        if( -not $script:network ) {
            throw "An internal network cannot be found, dcom container tests require an internal network to function. An internal network can be created with the following command: docker network create -d ics --subnet 10.0.0.0/24 --gateway 10.0.0.1 internal"
        }
    }

    AfterAll {
        $script:cleanup | Foreach-Object { docker kill $_ }
    }

    Context 'DcomTestExe application' {
        $server = Get-ServerContainerName
        Write-Host "`tStarting server container with name $server on network $script:network" -ForegroundColor Yellow
        $runOutput = docker run -d --network=$script:network --rm --name $server --hostname $server "dcomtest-exe-server"
        "`t$runOutput" | Out-Host
        $script:cleanup += $server

        Write-Host "`tStarting client container to connect to $server on network $script:network" -ForegroundColor Yellow
        $dockerRunOutput = docker run --network=$script:network --rm "dcomtest-exe-client" $server
        $dockerRunOutput | % { "`t$_" | Out-Host }

        It "Does not return access denied" {
            $dockerRunOutput | Should -Not -BeLike "*access is denied*"
        }

        It "Does not return RPC server unavailable" {
            $dockerRunOutput | Should -Not -BeLike "*RPC server is unavailable*"
        }
    }
}