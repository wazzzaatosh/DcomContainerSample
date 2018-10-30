using System;
using System.Collections.Generic;
using System.Runtime.InteropServices;

using Interfaces;

namespace DcomServerImpl
{
    [ProgId( "DcomContainerSample.DcomTestServer" )]
    [Guid( "C08D6390-DDE2-4283-A9CD-77510CC6F0E1" )]
    [ComVisible( true )]
    public class DcomTestServer : IDcomTest
    {
        public DcomTestServer()
        {
            m_callbacks = new List<IDcomTestCallback>();
        }

        public void RegisterCallback( IDcomTestCallback callback )
        {
            m_callbacks.Add( callback );
        }

        public string SayHello()
        {
            m_callbacks.ForEach( c => c.SayHelloCallback() );
            return string.Format( "Hello from {0}", Environment.MachineName );
        }

        private List<IDcomTestCallback> m_callbacks;
    }
}
