function Resolve-DnsHost {
    <#
        .SYNOPSIS
        Resolves a hostname to an IP address.

        .DESCRIPTION
        This function resolves a hostname to an IP address using the System.Net.Dns class.
        Returns detailed DNS record information similar to Windows' Resolve-DnsName.

        .EXAMPLE
        Resolve-DnsHost -Name 'google.com'

        .OUTPUTS
        [DnsRecord[]]
    #>
    [OutputType([DnsRecord[]])]
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
        $results = @()
        
        foreach ($address in $entry.AddressList) {
            $recordType = if ($address.AddressFamily -eq 'InterNetwork') { 'A' } else { 'AAAA' }
            $dnsRecord = [DnsRecord]::new($entry.HostName, $recordType, $address.ToString())
            $results += $dnsRecord
        }
        
        return $results
    } catch {
        Write-Debug "Failed to resolve DNS for [$Name]"
        Write-Debug $_
        return @()
    }
}
