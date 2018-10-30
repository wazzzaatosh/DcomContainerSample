namespace Interfaces
{
    using System.Runtime.InteropServices;

    [Guid( "22A64A1D-2D51-43D2-A1E2-CA034B4F2F6E" )]
    public interface IDcomTest
    {
        /// <summary>
        /// Returns a message that says "Hello from ComputerName"
        /// </summary>
        string SayHello();

        /// <summary>
        /// Registers a test callback with the server.
        /// </summary>
        void RegisterCallback( IDcomTestCallback callback );
    }

    [Guid( "76186B8F-9AA9-4BDC-9A0D-7312A43FA386" )]
    public interface IDcomTestCallback
    {
        /// <summary>
        /// Called from the server when SayHello is executed by the client.
        /// </summary>
        void SayHelloCallback();
    }
}