Configuration File_Task
{

    param(
        [string[]]$ComputerName="localhost"
    )

    Import-DscResource -ModuleName PsDesiredStateConfiguration

    Node $ComputerName 
    {  

        File FileContent 
        {
            Ensure = "Present"
            DestinationPath = "D:\test\1.txt"
            Contents = "hello"
        }
        Log LoggingForCopy
        {
            Message = "Trying to put hello"
            DependsOn = "[File]FileContent"
        }

    }
}
   
#set-item wsman:localhost\client\trustedhosts -value *   
#Run the function to compile the configuration
File_Task
#Pass the configuration to the nodes we defined and configure them
Start-DscConfiguration File_Task -Wait -Verbose
#Start-DscConfiguration File_Task