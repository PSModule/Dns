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

    Describe 'Resolve-DnsHost' {
        Context 'Existing record' {
            It 'returns at least one record for example.com' {
                $result = $null
                { $script:result = Resolve-DnsHost -Name 'example.com' -ErrorAction Stop } | Should -Not -Throw
                $result | Should -Not -BeNullOrEmpty
                LogGroup 'Results' {
                    Write-Host "$($result | Format-Table -AutoSize | Out-String)"
                }
            }
        }

        Context 'Non-existing record' {
            It 'returns no records or throws for a non-existent host' {
                { Resolve-DnsHost -Name 'no-such-host.invalid' -ErrorAction Stop } | Should -Not -Throw
            }
        }
    }
}
