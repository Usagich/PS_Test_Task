function Get-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable])]
    param
    (
        [parameter(Mandatory = $true)]
        [System.String]
        $path
    )

    return $path

}


function Set-TargetResource
{
    [CmdletBinding()]
    param
    (
        [parameter(Mandatory = $true)]
        [System.String]
        $path
    )

    if (Test-Path $path)
    {
        $file = Get-Content $path
        $containsWord = $file | %{$_ -match "hello"}
        if ($containsWord -contains $true) 
        {
            return $true
        } 
        else 
        {
            'hello' | Set-Content $path
        }
    }
    else
    {
        New-Item $path -type file -Force
        'hello' | Set-Content $path
    }
}


function Test-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Boolean])]
    param
    (
        [parameter(Mandatory = $true)]
        [System.String]
        $path
    )

    return $false
}


Export-ModuleMember -Function *-TargetResource

