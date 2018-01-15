Configuration Alesia_File_Task
{

    param(
        [string[]]$computerName="localhost",
        [string]$path=(Get-AutomationVariable -Name 'path'),
        [string]$fileName=(Get-AutomationVariable -Name 'fileName'),
        [string]$fileContent=(Get-AutomationVariable -Name 'fileContent')
    )
    
    Import-DscResource -ModuleName PsDesiredStateConfiguration

    Node $ComputerName 
    {  
        WindowsFeature NetFramework
        {
            Ensure = "Present" 
            Name = "NET-Framework-45-Core"
        }
        File FileContent 
        {
            Ensure = "Present"
            DestinationPath = $path + $fileName
            Contents = $fileContent
        }
        Log LoggingForCopy
        {
            Message = "Trying to put variables"
            DependsOn = "[File]FileContent"
        }

    }
}
