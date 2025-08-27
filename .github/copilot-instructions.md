# PSModule/Dns PowerShell Module

The Dns module provides PowerShell functions for DNS resolution operations using the System.Net.Dns class.

**ALWAYS reference these instructions first and fallback to search or bash commands only when you encounter unexpected information that does not match the info here.**

## Working Effectively

### Prerequisites
- PowerShell 7.4.11+ is pre-installed
- Pester 5.7.1 is pre-installed for testing
- PSScriptAnalyzer 1.24.0 is pre-installed for linting

### Development Workflow
**CRITICAL**: This is a pure PowerShell module with NO build compilation required.

1. **Load the module for testing** (takes <1 second):
   ```powershell
   cd /home/runner/work/Dns/Dns
   . ./src/classes/public/DnsHost.ps1
   . ./src/functions/public/Resolve-DnsHost.ps1
   ```

2. **Run tests** (takes ~2 seconds):
   ```powershell
   # Define LogGroup function required by tests
   function LogGroup {
       param([string]$Title, [scriptblock]$ScriptBlock)
       Write-Host "::group::$Title"
       try { & $ScriptBlock } finally { Write-Host '::endgroup::' }
   }
   
   # Load module first
   . ./src/classes/public/DnsHost.ps1
   . ./src/functions/public/Resolve-DnsHost.ps1
   
   # Run Pester tests
   Invoke-Pester ./tests/Dns.Tests.ps1 -Passthru
   ```

3. **Run linting** (takes ~1.3 seconds):
   ```powershell
   # Lint source code
   Invoke-ScriptAnalyzer -Path ./src -Recurse -Settings ./.github/linters/.powershell-psscriptanalyzer.psd1
   
   # Lint tests
   Invoke-ScriptAnalyzer -Path ./tests -Recurse -Settings ./.github/linters/.powershell-psscriptanalyzer.psd1
   ```

### Manual Validation Scenarios
**ALWAYS run these validation steps after making any changes to ensure functionality works correctly:**

```powershell
# Load the module
. ./src/classes/public/DnsHost.ps1
. ./src/functions/public/Resolve-DnsHost.ps1

# Test 1: DnsHost class construction
$dnsHost = [DnsHost]::new('test.example.com', 'test', @('192.168.1.1', '192.168.1.2'))
$dnsHost | Format-List  # Should show Name, Alias, AddressList properties

# Test 2: DNS resolution with localhost (WORKS in sandbox)
$result = Resolve-DnsHost -Name '127.0.0.1'
if ($result) {
    Write-Host 'SUCCESS: DNS resolution works!'
    $result | Format-List  # Should show localhost with 127.0.0.1
} else {
    Write-Host 'FAILED: DNS resolution returned null'
}

# Test 3: Invalid domain handling
$result = Resolve-DnsHost -Name 'nonexistent.invalid.domain.test'
if ($result) {
    Write-Host 'UNEXPECTED: Should have returned null'
} else {
    Write-Host 'SUCCESS: Invalid domain correctly returned null'
}
```

## Important Limitations and Workarounds

### Network Restrictions
- **CRITICAL**: External DNS resolution (google.com, example.com) FAILS in sandbox environment
- **WORKAROUND**: Use localhost/127.0.0.1 for testing DNS functionality
- **CI BEHAVIOR**: The PSModule framework CI runs in environments with full network access
- Tests that require external DNS will fail locally but pass in CI

### PSModule Framework
- This module uses the [PSModule framework](https://github.com/PSModule/Process-PSModule) for CI/CD
- The framework handles module building, testing, and publishing automatically
- **NO local build steps required** - the module is pure PowerShell scripts
- CI workflows are in `.github/workflows/Process-PSModule.yml` using PSModule/Process-PSModule@v4

## Repository Structure

### Source Code
```
src/
├── classes/public/DnsHost.ps1      # DnsHost class definition
└── functions/public/Resolve-DnsHost.ps1  # Main DNS resolution function
```

### Tests
```
tests/Dns.Tests.ps1                 # Pester tests (requires Pester 5.7.1)
```

### Configuration
```
.github/linters/.powershell-psscriptanalyzer.psd1  # PSScriptAnalyzer rules
.github/PSModule.yml                 # PSModule framework configuration
.github/workflows/Process-PSModule.yml  # Main CI/CD workflow
.github/workflows/Linter.yml         # Super-linter workflow
```

## Common Tasks

### Adding New Functions
1. Create new function file in `src/functions/public/`
2. Follow existing pattern with proper comment-based help
3. Add corresponding tests in `tests/Dns.Tests.ps1`
4. Run validation steps to ensure functionality works

### Modifying Existing Code
1. **ALWAYS load and test manually first** using the validation scenarios above
2. Run linting: `Invoke-ScriptAnalyzer -Path ./src -Recurse -Settings ./.github/linters/.powershell-psscriptanalyzer.psd1`
3. Run tests: Load module then `Invoke-Pester ./tests/Dns.Tests.ps1 -Passthru`
4. **CRITICAL**: External DNS tests will fail locally but pass in CI

### Understanding Test Failures
- Tests expecting external DNS resolution will fail in sandbox environment
- Example: Tests for 'google.com' and 'example.com' fail locally
- Tests for 'nonexistent.example' pass (expects null result)
- **This is expected behavior** - the CI environment has full network access

## Key Module Components

### DnsHost Class
- Properties: `Name` (string), `Alias` (string), `AddressList` (string[])
- Constructor: `[DnsHost]::new($name, $alias, $addressList)`
- Used to return structured DNS resolution results

### Resolve-DnsHost Function
- **Purpose**: Resolves hostnames to IP addresses using System.Net.Dns
- **Parameters**: 
  - `Name` (mandatory) - hostname to resolve
  - `AddressFamily` (optional) - defaults to 'Unspecified'
- **Returns**: `[DnsHost]` object or `$null` if resolution fails
- **Error Handling**: Catches exceptions and writes debug output

### Validation Checklist
When making changes, ALWAYS verify:
- [ ] PSScriptAnalyzer passes with zero issues
- [ ] Module loads without errors
- [ ] DnsHost class constructs correctly
- [ ] Resolve-DnsHost works with localhost (127.0.0.1)
- [ ] Invalid domain names return null appropriately
- [ ] Pester tests run (external DNS failures expected locally)

## Time Expectations
- Module loading: <1 second
- PSScriptAnalyzer linting: ~1.3 seconds
- Pester test execution: ~2 seconds (including expected failures)
- Manual validation scenarios: <5 seconds total

**NEVER set timeouts less than 30 seconds for any PowerShell operations to account for potential module initialization overhead.**