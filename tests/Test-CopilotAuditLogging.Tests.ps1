#Requires -Modules Pester, Maester

BeforeDiscovery {
    $script:tag = @('Copilot', 'Purview', 'AuditLogging')
}

Describe 'Microsoft 365 Copilot — Purview audit logging' -Tag $script:tag {

    Context 'Unified audit log' {
        It 'is enabled at the tenant level' {
            $config = Invoke-MgGraphRequest -Method GET -Uri '/v1.0/security/auditLog/queries?$top=1'
            { Invoke-MgGraphRequest -Method GET -Uri '/v1.0/security/auditLog/queries?$top=1' } | Should -Not -Throw -Because 'CopilotInteraction events are written to the unified audit log; if it is off, there is no Copilot audit trail.'
            $config | Should -Not -BeNullOrEmpty
        }
    }
}
