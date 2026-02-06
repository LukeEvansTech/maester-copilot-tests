#Requires -Modules Pester, Maester

BeforeDiscovery {
    $script:tag = @('Copilot', 'Purview', 'SensitivityLabels')
}

Describe 'Microsoft 365 Copilot — sensitivity labels' -Tag $script:tag {

    Context 'Sensitivity-label catalogue' {
        It 'has at least three labels configured' {
            $labels = Invoke-MgGraphRequest -Method GET -Uri '/v1.0/informationProtection/policy/labels'
            ($labels.value | Measure-Object).Count | Should -BeGreaterOrEqual 3 -Because 'Copilot grounding requires meaningful classification — Public, Internal, Confidential at minimum.'
        }

        It 'has at least one label that is not Public' {
            $labels = Invoke-MgGraphRequest -Method GET -Uri '/v1.0/informationProtection/policy/labels'
            $nonPublic = $labels.value | Where-Object { $_.sensitivity -gt 0 }
            ($nonPublic | Measure-Object).Count | Should -BeGreaterOrEqual 1 -Because 'A single Public label provides no protection for Copilot grounding sources.'
        }
    }
}
