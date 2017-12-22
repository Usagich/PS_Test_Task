param
(
    [string[]]$ComputerName="localhost"
)

Configuration CustomFile 
{ 

    Set-ExecutionPolicy Unrestricted
    Import-DscResource -ModuleName FileCHecker

    Node $ComputerName 
    {  

        FileChecker MyCheck
        {
            path = "C:\test\1.txt"
        }

    }
}
CustomFile
Start-DscConfiguration CustomFile -Force
