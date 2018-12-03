# Synopsis

This sample shows a DCOM server running inside of a windows container that supports Kerberos authentication (using gMSA). The sample requires a Windows domain and container host which is properly configured for gMSA authentication, as described in the [windows-containers-AD](https://github.com/plooploops/windows-containers-AD) repository.

An additional proof of concept example is included in the [DcomTestExe](./DcomTestExe) directory, which tests anonymous DCOM access between containers using the [DcomTest Sample](https://support.microsoft.com/en-us/help/259011/sample-a-simple-dcom-client-server-test-application) app from microsoft.

# Examples

All of the examples can be built and run using the [test.ps1](./test.ps1) script in the root of the repository. The docker images may be built separately using the [build.ps1](./build.ps1) script. The tests make use of [pester](./pester.ps1) to build and test the client/server containers against each other.

# Building and running locally

For debugging purposes the client and server can both be run outside of docker using visual studio. Open [DcomContainerSample.sln](./DcomContainerSample.sln) as an administrator and set `DcomClientApp` as the startup project, and then build and debug. The default configuration will activate the COM server in the same process as the client, as opposed to configuring and using the `DcomServerApp`.

# TODOs:

- Pester tests return `access denied` for the DcomTestExe test that it runs. Not sure if this is a networking problem, or an installation problem. Maybe the reg file is not setting up anonymous auth correctly? Or maybe internal networking uses NAT features which don't work right for DCOM. I tried transparent networking and it fails as well (but maybe with a different error?)

- Once DcomTestExe works anonymously, continue filling out `pester.ps1` to test anonymous access between `DcomClientApp` and `DcomServerImpl` in two separate containers.

- Once that works, write `DcomServerApp` and use that as the container entrypoint for `DcomServerImpl` instead (this is more equivalent to how our apps are intialized in production).

- Once that works, write another test that uses a gMSA for authentication between the two containers (this will require a test domain setup either locally or on azure).