# Synopsis

This sample shows a DCOM server running inside of a windows container that supports Kerberos authentication (using gMSA). The sample requires a Windows domain and container host which is properly configured for gMSA authentication, as described in the [windows-containers-AD](https://github.com/plooploops/windows-containers-AD) repository.

An additional proof of concept example is included in the [DcomTestExe](./DcomTestExe) directory, which tests anonymous DCOM access between containers using the [DcomTest Sample](https://support.microsoft.com/en-us/help/259011/sample-a-simple-dcom-client-server-test-application) app from microsoft.


# Building containers

# Running containers

The test containers require some additional args for the `docker run` command:

# Building and running locally

For debugging purposes the client and server can both be run outside of docker using visual studio. Open [DcomContainerSample.sln](./DcomContainerSample.sln) as an administrator and set `DcomClientApp` as the startup project, and then build and debug. The default configuration will activate the COM server in the same process as the client, as opposed to configuring using the `DcomServerApp`.

# Misc

https://support.microsoft.com/en-us/help/259011/sample-a-simple-dcom-client-server-test-application