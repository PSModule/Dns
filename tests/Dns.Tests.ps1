#Requires -Modules @{ ModuleName = 'Pester'; RequiredVersion = '5.7.1' }

[Diagnostics.CodeAnalysis.SuppressMessageAttribute(
    'PSUseDeclaredVarsMoreThanAssignments', '',
    Justification = 'Pester grouping syntax: known issue.'
)]
[Diagnostics.CodeAnalysis.SuppressMessageAttribute(
    'PSAvoidUsingConvertToSecureStringWithPlainText', '',
    Justification = 'Used to create a secure string for testing.'
)]
[Diagnostics.CodeAnalysis.SuppressMessageAttribute(
    'PSAvoidUsingWriteHost', '',
    Justification = 'Log outputs to GitHub Actions logs.'
)]
[Diagnostics.CodeAnalysis.SuppressMessageAttribute(
    'PSAvoidLongLines', '',
    Justification = 'Long test descriptions and skip switches'
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
                Expected = $true
            },
            @{
                Name     = 'nonexistent.example'
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
