class DnsHost {
    [string]$Name
    [string]$Alias
    [string[]]$AddressList

    DnsHost() {}

    DnsHost([string]$Name, [string]$Alias, [string[]]$AddressList) {
        $this.Name = $Name
        $this.Alias = $Alias
        $this.AddressList = $AddressList
    }
}
