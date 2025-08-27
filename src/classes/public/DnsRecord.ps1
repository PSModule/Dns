class DnsRecord {
    [string]$Name
    [string]$Type
    [int]$TTL
    [string]$Section
    [string]$IPAddress
    [string]$Address
    [string]$QueryType
    [string]$IP4Address
    [string]$IP6Address
    [string]$CharacterSet
    [int]$DataLength

    DnsRecord() {}

    DnsRecord([string]$Name, [string]$Type, [string]$IPAddress) {
        $this.Name = $Name
        $this.Type = $Type
        $this.QueryType = $Type
        $this.IPAddress = $IPAddress
        $this.Address = $IPAddress
        $this.Section = 'Answer'
        $this.CharacterSet = 'Unicode'
        $this.TTL = 60  # Default TTL since we can't get actual TTL from System.Net.Dns
        
        # Set IP4Address or IP6Address based on the IP type
        if ($IPAddress -match ':') {
            # IPv6
            $this.IP6Address = $IPAddress
            $this.DataLength = 16
        } else {
            # IPv4
            $this.IP4Address = $IPAddress
            $this.DataLength = 4
        }
    }
}