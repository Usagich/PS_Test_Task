Configuration CallingxTask
{

    param(
        [string]$azureVarPath=(Get-AutomationVariable -Name 'Xpath'),
        [string]$azureVarFileName=(Get-AutomationVariable -Name 'XfileName'),
        [string]$azureVarFileContent=(Get-AutomationVariable -Name 'XfileContent')
    )
    
    Import-DscResource -ModuleName 'xTask'
        

    xTaskCompo ImportantTask
	{        
	    Path = $azureVarPath
	    FileName = $azureVarFileName
	    FileContent = $azureVarFileContent
	}

}
