function Resolve-DnsHost {
    <#
        .SYNOPSIS
        Resolves a hostname to an IP address.

        .DESCRIPTION
        This function resolves a hostname to an IP address using the System.Net.Dns class.

        .EXAMPLE
        Resolve-DnsHost -HostName 'google.com'

        .OUTPUTS
        [DnsHost]
    #>
    [OutputType([DnsHost])]
    [CmdletBinding()]
    param (
        # The name of the host to resolve
        [Parameter(Mandatory)]
        [string] $Name,

        # The address family to use for the DNS resolution
        [Parameter()]
        [System.Net.Sockets.AddressFamily] $AddressFamily = 'Unspecified'
    )

    try {
        $entry = [System.Net.Dns]::GetHostEntry($Name, $AddressFamily)
        return [DnsHost]::new($entry.HostName, $entry.Aliases, $entry.AddressList)
    } catch {
        Write-Debug "Failed to resolve DNS for [$Name]"
        Write-Debug $_
    }
}
