# Dns

Dns is a PowerShell module for resolving host names from PowerShell scripts and automation.

## Prerequisites

- PowerShell with `Microsoft.PowerShell.PSResourceGet` available for `Install-PSResource`.
- The [PSModule framework](https://github.com/PSModule) is used for building, testing, and publishing the module.

## Installation

Install the module from the PowerShell Gallery:

```powershell
Install-PSResource -Name Dns
Import-Module -Name Dns
```

## Commands

- `Resolve-DnsHost` resolves a host name with `[System.Net.Dns]` and returns a structured `DnsHost` object.

## Usage

Resolve a host name:

```powershell
Resolve-DnsHost -Name 'github.com'
```

Resolve a host name for a specific address family:

```powershell
Resolve-DnsHost -Name 'github.com' -AddressFamily InterNetwork
```

## Documentation

Command documentation is published at [psmodule.io/Dns](https://psmodule.io/Dns/).

## Contributing

Issues and pull requests are welcome. Please use the repository issue tracker to report bugs, request features, or discuss improvements.
