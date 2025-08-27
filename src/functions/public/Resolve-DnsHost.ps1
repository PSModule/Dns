function Resolve-DnsHost {
    <#
        .SYNOPSIS
        Resolves a hostname to an IP address.

        .DESCRIPTION
        This function resolves a hostname to an IP address using the System.Net.Dns class.

        .EXAMPLE
        Resolve-DnsHost -HostName 'google.com'

        .OUTPUTS
        [System.Net.IPHostEntry](https://learn.microsoft.com/en-us/dotnet/api/system.net.iphostentry?view=net-8.0)
    #>
    [OutputType([System.Net.IPHostEntry])]
    [CmdletBinding()]
    param (
        # The name of the host to resolve
        [Parameter(Mandatory)]
        [string] $Name
    )

    try {
        [System.Net.Dns]::GetHostEntry($Name)
    } catch {
        Write-Debug "Failed to resolve DNS for [$Name]"
        Write-Debug $_
    }
}
