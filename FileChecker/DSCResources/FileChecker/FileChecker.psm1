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
        if (Get-Content $path -like 'hello')
        {
            return true
        }
        else
        {
            'hello' | Set-Content $path
        }
    }
    else
    {
        New-Item $path -type file 
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

    $false
}


Export-ModuleMember -Function *-TargetResource

