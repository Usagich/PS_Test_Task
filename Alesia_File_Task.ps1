Configuration Alesia_File_Task
{

# будешь создавать текстовый файл, имя и содержимое которого 
# > должно передаваться через переменные в Automation Account
# > 1 параметр путь
# > 1 параметр имя
# > 1 мараметр содержимое
# > всё строковые переменные

# напишешь конфигурацию, которую сложишь в свой тфс
# > в ней опишешь установку дотнета 4.5 как windows feature


    param(
        [string[]]$computerName="localhost",
        [string[]]$path=(Get-AutomationVariable -Name "path").Value,
        [string[]]$fileName=(Get-AutomationVariable -Name "fileName").Value,
        [string[]]$fileContent=(Get-AutomationVariable -Name "fileContent").Value
    )

    Import-DscResource -ModuleName PsDesiredStateConfiguration

    Node $ComputerName 
    {  
        WindowsFeature NetFramework
        {
            Ensure = "Present" 
            Name = "AS-NET-Framework"
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

