Q259011 - A Simple DCOM Client Server Test Application 


-------------------------------------------------------------------------------
The information in this article applies to:

 - Microsoft Windows NT Server version 4.0 
 - Microsoft Windows NT Workstation version 4.0 
 - Microsoft Windows 98 
 - Windows 95 with DCOM, version 1.0 
 - Microsoft Windows 2000 Professional 
 - Microsoft Windows 2000 Server 
-------------------------------------------------------------------------------

SUMMARY
=======

This article provides a simple client/server test application that enables you
to check if DCOM is working between two computers when security is turned off.

MORE INFORMATION
================

The following file is available for download from the Microsoft Download Center.
Click the file name below to download the file:

   DCOMTest.exe

For more information about how to download files from the Microsoft Download
Center, please visit the Download Center at the following Web address

   http://www.microsoft.com/downloads/search.asp

and then click "How to use the Microsoft Download Center".

Microsoft used the most current virus detection software available on the date of
posting to scan this file for viruses. Once posted, the file is housed on secure
servers that prevent any unauthorized changes to the file.

This self extracting file contains three files: TstSrvr.exe, Tstclnt.exe, and
Tstsrvr.reg.

Steps to Take on the Server Computer
------------------------------------

1. Click Start, click Run, and then type "cmd" (without the quotation marks)
   (for Windows NT) or "command" (without the quotation marks) (for Windows
   95/Windows 98).

   NOTE: This sample uses C drive, but you can use any local drive.

2. Type "MD C:\Test" (without the quotation marks) to create a folder.

3. Type "CD C:\Test" (without the quotation marks).

4. Copy following files into C:\Test:

   tstSrvr.exe
   tstclnt.exe
   tstsrvr.reg

5. At the command prompt, type "regedit tstsrv.reg" (without the quotation
   marks). This will cause Registry Editor (Regedit.exe) to run on Tstssv.reg.

6. Click Start, click Run, and type "C:\Test\TstSrvr.exe" (without the quotation
   marks).

When Regedit has finished running, the server command window will flash and
display output similar to the following:

C:\test>tstSrvr
Client: Creating Instance...0.0636 seconds
Client: Reading data...0.0010 seconds
Client: Writing data...0.0004 seconds
Client: Done

NOTE: Do not log off from the server.

Steps to Take on the Client Computer
------------------------------------

1. Click "Start" (without the quotation marks), click "Run" (without the
   quotation marks), and then type "cmd" (without the quotation marks) (for
   Windows NT) or "command" (without the quotation marks) (for Windows
   95/Windows 98).

2. Type "C:" (without the quotation marks). (This sample uses C drive, but you
   can use any local drive.)

3. Type "MD C:\Test" (without the quotation marks) to create a folder.

4. Type "CD C:\Test" (without the quotation marks).

5. Copy the following files into C:\Test:

   TstSrvr.exe
   Tstclnt.exe
   Tstsrvr.reg

6. At the command prompt, type "PING <server computer name>" (without the
   quotation marks) (replace <server computer name> with the actual
   computer name) to make sure that the server computer can be reached.

7. At the command prompt, type "Tstclient <server computer name>" (without
   the quotation marks).

A successful run will cause the display of output similar to this:

C:\test>tstclnt MyServerMachineName
Client: Creating Instance...0.1696 seconds
Client: Reading data...0.0011 seconds
Client: Writing data...0.0005 seconds
Client: Done

REFERENCES
==========

The Test sample is based on the simple DCOM sample that is included with the
platform SDK. Please refer to the Platform SDK simple sample for more details on
the code for this sample.

Additional query words:
