# filepath: c:\Repos\GitHub\PSModule\Module\Dns\tests\Dns.Tests.ps1
[Diagnostics.CodeAnalysis.SuppressMessageAttribute(
    'PSReviewUnusedParameter', '',
    Justification = 'Required for Pester tests'
)]
[Diagnostics.CodeAnalysis.SuppressMessageAttribute(
    'PSUseDeclaredVarsMoreThanAssignments', '',
    Justification = 'Required for Pester tests'
)]
[CmdletBinding()]
param()

Describe 'Dns' {

    Context 'Resolve-DnsHost' {
        It 'Test record <Name> - should exist <expected>' -ForEach @(
            @{
                Name     = 'google.com'
                Expected = $true
            },
            @{
                Name     = 'example.com'
                Expected = $false
            }
        ) {
            { $script:result = Resolve-DnsHost -Name $Name -ErrorAction Stop } | Should -Not -Throw
            if ($Expected) {
                $result | Should -Not -BeNullOrEmpty
                LogGroup 'Results' {
                    Write-Host "$($result | Format-Table -AutoSize | Out-String)"
                }
            } else {
                $result | Should -BeNullOrEmpty
            }
        }
    }
}
