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
            $result = Resolve-DnsHost -Name $Name -ErrorAction Stop
            LogGroup 'Results' {
                Write-Host "$($result | Format-Table -AutoSize | Out-String)"
            }
            if ($Expected) {
                $result | Should -Not -BeNullOrEmpty
                $result | Should -BeOfType [DnsHost]
                $result.Name | Should -Be $Name
                $result.AddressList.Count | Should -BeGreaterThan 0
            } else {
                $result | Should -BeNullOrEmpty
            }
        }
    }
}
