using System;
using Interfaces;

namespace DcomClientApp
{
    public class Program
    {
        public static void Main( string[] args )
        {
            // Use the first argument as the computer name if given.
            Type iface = args.Length == 0
                ? Type.GetTypeFromProgID( ServerProgID )
                : Type.GetTypeFromProgID( ServerProgID, args[0].Trim() );

            var server = (IDcomTest)Activator.CreateInstance( iface );
            server.RegisterCallback( new Callback() );

            Console.WriteLine( "Execute IDcomTest.SayHello()" );
            string message = server.SayHello();
            Console.WriteLine( "IDcomTest.SayHello(): {0}", message );

#if DEBUG
            Console.ReadKey();
#endif
        }

        private class Callback : IDcomTestCallback
        {
            public void SayHelloCallback()
            {
                Console.WriteLine( "IDcomTestCallback.SayHelloCallback(): Hello from {0}", Environment.MachineName );
            }
        }

        internal const string ServerProgID = "DcomContainerSample.DcomTestServer";
    }
}
