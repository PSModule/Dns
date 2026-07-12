# Dns

Dns is a PowerShell module for managing DNS tasks.

## Installation

Install the module from the PowerShell Gallery:

```powershell
Install-PSResource -Name Dns
Import-Module -Name Dns
```

## Usage

### Example: Resolve a hostname to its IP addresses

```powershell
Resolve-DnsHost -Name 'example.com'
```

On a successful lookup, returns a `DnsHost` object with the resolved host name, an alias (if any), and the list of IP addresses. If the host cannot be resolved, nothing is returned.

### Example: Resolve only IPv4 addresses

Use `-AddressFamily` to limit the resolution to a specific address family:

```powershell
Resolve-DnsHost -Name 'example.com' -AddressFamily InterNetwork
```

## Documentation

Documentation is published at [psmodule.io/Dns](https://psmodule.io/Dns/).

Use PowerShell help and command discovery for module details:

```powershell
Get-Command -Module Dns
Get-Help -Name Resolve-DnsHost -Examples
```
