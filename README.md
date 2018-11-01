# Synopsis

This sample shows a DCOM server running inside of a windows container that supports Kerberos authentication (using gMSA). The sample requires a Windows domain and container host which is properly configured for gMSA authentication, as described in the [windows-containers-AD](https://github.com/plooploops/windows-containers-AD) repository.

An additional proof of concept example is included in the [DcomTestExe](./DcomTestExe) directory, which tests anonymous DCOM access between containers using the [DcomTest Sample](https://support.microsoft.com/en-us/help/259011/sample-a-simple-dcom-client-server-test-application) app from microsoft.

# Examples

All of the examples can be built and run using the [test.ps1](./test.ps1) script in the root of the repository. The docker images may be built separately using the [build.ps1](./build.ps1) script. The tests make use of [pester](./pester.ps1) to build and test the client/server containers against each other.

# Building and running locally

For debugging purposes the client and server can both be run outside of docker using visual studio. Open [DcomContainerSample.sln](./DcomContainerSample.sln) as an administrator and set `DcomClientApp` as the startup project, and then build and debug. The default configuration will activate the COM server in the same process as the client, as opposed to configuring and using the `DcomServerApp`.