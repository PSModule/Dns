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
                Name     = '127.0.0.1'
                Expected = $true
            },
            @{
                Name     = 'localhost'  
                Expected = $true
            },
            @{
                Name     = 'nonexistent.invalid.domain.test'
                Expected = $false
            }
        ) {
            $result = Resolve-DnsHost -Name $Name -ErrorAction SilentlyContinue
            Write-Host "Results: $($result | Format-Table -AutoSize | Out-String)"
            if ($Expected) {
                $result | Should -Not -BeNullOrEmpty
                $result | Should -BeOfType [DnsRecord]
                $result[0].Name | Should -Not -BeNullOrEmpty
                $result[0].IPAddress | Should -Not -BeNullOrEmpty
                $result[0].Type | Should -BeIn @('A', 'AAAA')
                $result[0].Section | Should -Be 'Answer'
                $result[0].CharacterSet | Should -Be 'Unicode'
                $result[0].TTL | Should -BeGreaterThan 0
                $result[0].DataLength | Should -BeIn @(4, 16)
            } else {
                $result | Should -BeNullOrEmpty
            }
        }
    }
}
