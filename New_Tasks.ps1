Configuration New_Tasks
{

    param(
        [string[]]$computerName="localhost",
        [string]$path="D:\path",
        [string]$fileName="mine",
        [string]$fileContent="nevermind"
        #[string]$path=(Get-AutomationVariable -Name 'path'),
        #[string]$fileName=(Get-AutomationVariable -Name 'fileName'),
        #[string]$fileContent=(Get-AutomationVariable -Name 'fileContent')
    )
    
    Import-DscResource -ModuleName PsDesiredStateConfiguration
    Import-DscResource -ModuleName AdaptModule

    Node $ComputerName 
    {  
       # WindowsFeature NetFramework
       # {
       #     Ensure = "Present" 
       #     Name = "NET-Framework-45-Core"
       # }
  
        AdaptModule FileAbsent 
        {
            Ensure = "Absent"
            Path = $path 
            FileName = $fileName
            FileContent = $fileContent
        }
        AdaptModule FilePresent 
        {
            Ensure = "Present"
            Path = $path 
            FileName = $fileName
            FileContent = $fileContent
            DependsOn = "[AdaptModule]FileAbsent"
        }
        Log LoggingForCopy
        {
            Message = "Trying to put variables"
            DependsOn = "[AdaptModule]FilePresent"
        }

    }
}
New_Tasks


Enable-PSRemoting -force
Start-DscConfiguration New_Tasks -Wait -Verbose -Force