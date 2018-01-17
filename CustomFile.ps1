Configuration CustomFile 
{ 

    param
    (
       [string[]]$ComputerName="localhost" 
    ) 


    #Set-ExecutionPolicy Unrestricted
    Import-DscResource -ModuleName FileCHecker

    Node $ComputerName 
    {  

        FileChecker MyCheck
        {
            path = "c:\test\1.txt"
        }

    }
}
#CustomFile
#Start-DscConfiguration CustomFile -Force -Wait -Verbose
