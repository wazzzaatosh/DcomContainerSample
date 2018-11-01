param(
    [Parameter()]
    [ValidateSet( 'All', 'DcomTestExeServer', 'DcomTestExeClient', 'ServerContainer', 'ClientContainer' )]
    [string] $Stage = 'All'
)

try{
    Push-Location $PSScriptRoot
    if( $stage -eq 'All' -or $stage -eq 'DcomTestExeServer' ) {
        docker build ./DcomTestExe -f ./DcomTestExe/Dockerfile.server -t "dcomtest-exe-server"
    }
    if( $stage -eq 'All' -or $stage -eq 'DcomTestExeClient' ) {
        docker build ./DcomTestExe -f ./DcomTestExe/Dockerfile.client -t "dcomtest-exe-client"
    }
    if( $stage -eq 'All' -or $stage -eq 'ServerContainer' ) {
        docker build . -f Dockerfile.server -t "dcom-sample-server"
    }
    if( $stage -eq 'All' -or $stage -eq 'ClientContainer' ) {
        docker build . -f Dockerfile.client -t "dcom-sample-client"
    }
}
finally {
    Pop-Location
}