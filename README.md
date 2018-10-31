# Synopsis

This sample shows a DCOM server running inside of a windows container that supports Kerberos authentication (using gMSA). The sample requires a Windows domain and container host which is properly configured for gMSA authentication, as described in the [windows-containers-AD](https://github.com/plooploops/windows-containers-AD) repository.

An additional proof of concept example is included in the [DcomTestExe](./DcomTestExe) directory, which tests anonymous DCOM access between containers using the [DcomTest Sample](https://support.microsoft.com/en-us/help/259011/sample-a-simple-dcom-client-server-test-application) app from microsoft.

# Examples

All of the examples require manual docker steps right now, until a build script is provided.

## No authentication using DcomTest

This test uses the DcomTest executables from microsoft (referenced [here](https://support.microsoft.com/en-us/help/259011/sample-a-simple-dcom-client-server-test-application)). The following commands will build and run the example:

```sh
docker build ./DcomTestExe -f Dockerfile.server -t cowens/dcomtest-exe-server
docker build ./DcomTestExe -f Dockerfile.client -t cowens/dcomtest-exe-client
docker run -d --name server cowens/dcomtest-exe-server

# Inspect the server and use the ip address to run the client.
docker inspect server
docker run -d --rm cowens/dcomtest-exe-client x.x.x.x
```

## No authentication using sample app

This test uses the sample applications in this repository with anonymous authentication.

```sh
docker build . -f Dockerfile.server -t cowens/dcom-sample-server
docker build . -f Dockerfile.client -t cowens/dcom-sample-client
docker run -d --name server cowens/dcom-sample-server

# Inspect the server and use the ip address to run the client.
docker inspect server
docker run --rm cowens/dcom-sample-client x.x.x.x
```

# Building and running locally

For debugging purposes the client and server can both be run outside of docker using visual studio. Open [DcomContainerSample.sln](./DcomContainerSample.sln) as an administrator and set `DcomClientApp` as the startup project, and then build and debug. The default configuration will activate the COM server in the same process as the client, as opposed to configuring and using the `DcomServerApp`.