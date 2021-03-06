function Get-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable])]
    param
    (
        [parameter(Mandatory = $true)]
        [System.String]$Path,
        [System.String]$FileName = "adapt-file.txt",
        [System.String]$FileContent = "default content",
        [parameter(Mandatory = $true)]
        [ValidateSet("Absent", "Present")]$Ensure
    )

    $infoLine = "file name is " + $FileName + " and it stores in " + $Path + " with content " + $FileContent 
    $infoLine > c:\adapt-module-log.txt

    $res = @{
                Path = $Path
                FileName = $FileName
                FileContent = $FileContent
                Ensure = if (Test-Path $Path$FileName) {"Present"} else {"Absent"}
    }

    return $res

}


function Set-TargetResource
{
    [CmdletBinding()]
    param
    (
        [parameter(Mandatory = $true)]
        [System.String]$Path,
        [System.String]$FileName = "adapt-file.txt",
        [System.String]$FileContent = "default content",
        [parameter(Mandatory = $true)]
        [ValidateSet("Absent", "Present")]$Ensure
    )

    if ($Path[-1] -ne '\')
    {
        $Path += '\'
    }

    if ((Test-Path $Path$FileName) -and ($Ensure -eq "Present"))
    {
        $file = Get-Content $Path$FileName
        $containsWord = $file | %{$_ -match $FileContent}
        if ($containsWord -contains $true) 
        {
            return $true
        } 
        else 
        {
            $FileContent | Set-Content $Path$FileName
        }
    }
    else
    {
        if($Ensure -eq "Absent")
        {
            Remove-Item $Path$FileName -Force
        }
        else
        {        
            New-Item $Path$FileName -type file -Force
            $FileContent | Set-Content $Path$FileName
        }
    }
}


function Test-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Boolean])]
    param
    (
        [parameter(Mandatory = $true)]
        [System.String]$Path,
        [System.String]$FileName = "adapt-file.txt",
        [System.String]$FileContent = "default content",
        [parameter(Mandatory = $true)]
        [ValidateSet("Absent", "Present")]$Ensure
    )


    if ((Test-Path $Path$FileName) -and ($Ensure -eq "Present"))
    {
        $file = Get-Content $Path$FileName
        $containsWord = $file | %{$_ -match $FileContent}
        if ($containsWord -contains $true) 
        {
            return $true
        } 
        else
        {
            return $false
        }
    }
    else
    {
        if($Ensure -eq "Absent")
        {
            return $true
        }
        else
        {
            return $false
        }
    }
}


Export-ModuleMember -Function *-TargetResource

