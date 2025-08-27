function Resolve-DnsHost {
    <#
        .SYNOPSIS
        Resolves a hostname to an IP address.

        .DESCRIPTION
        This function resolves a hostname to an IP address using the System.Net.Dns class.

        .EXAMPLE
        Resolve-Host -HostName 'google.com'

        .OUTPUTS
        [System.Net.IPHostEntry](https://learn.microsoft.com/en-us/dotnet/api/system.net.iphostentry?view=net-8.0)
    #>
    [OutputType([System.Net.IPHostEntry])]
    [CmdletBinding()]
    param (
        # The hostname to resolve
        [Parameter(Mandatory)]
        [Alias('IP', 'Address', 'Host', 'IPAddress', 'Destination')]
        [string] $HostName
    )

    [System.Net.Dns]::Resolve($HostName)
}
