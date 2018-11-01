$script:rand = New-Object Random
function Get-ServerContainerName {
    $num = $script:rand.Next( 11, 999 )
    return "dcomtest$num"
}

Describe 'DcomTestExe container' {
    $script:cleanup = @()

    BeforeAll {
        $images = docker images --format '{{.Repository}}'
        $image = $images | Where-Object { $_ -eq 'dcomtest-exe-server' }
        if( -not $image ) {
            & $PSScriptRoot/build.ps1 | Out-Host
        }
    }

    AfterAll {
        $script:cleanup | Foreach-Object { docker kill $_ }
    }

    Context 'No authentication' {
        It "Does not return access denied" {
            $server = Get-ServerContainerName
            Write-Host "`tStarting server container with name $server" -ForegroundColor Yellow
            $runOutput = docker run -d --rm --name $server "dcomtest-exe-server"
            "`t$runOutput" | Out-Host
            $script:cleanup += $server

            $serverIp = docker inspect $server -f "{{.NetworkSettings.Networks.nat.IPAddress}}"
            Write-Host "`tStarting client container to connect to $server on $serverIp" -ForegroundColor Yellow
            $dockerRunOutput = docker run --rm "dcomtest-exe-client" $serverIp
            $dockerRunOutput | % { "`t$_" | Out-Host }
            $dockerRunOutput | Should -Not -BeLike "*access is denied*"
        }
    }
}