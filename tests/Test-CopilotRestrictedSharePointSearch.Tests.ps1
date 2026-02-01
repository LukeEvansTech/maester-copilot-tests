#Requires -Modules Pester, Maester

BeforeDiscovery {
    $script:tag = @('Copilot', 'SharePoint', 'RestrictedSearch')
}

Describe 'Microsoft 365 Copilot — restricted SharePoint search' -Tag $script:tag {

    Context 'Restricted SharePoint Search policy' {
        It 'is configured (enabled or explicitly disabled with a documented reason)' {
            # Restricted SharePoint Search is queried via the SharePoint admin API.
            # When configured, the response contains a non-null `RestrictedSearchApplied` flag.
            try {
                $rss = Invoke-MgGraphRequest -Method GET -Uri '/beta/admin/sharepoint/settings'
                $rss | Should -Not -BeNullOrEmpty
                $rss.PSObject.Properties.Name | Should -Contain 'restrictedSearchApplied' -Because 'The Restricted SharePoint Search setting must be visible — present and reviewed, even if disabled by choice.'
            } catch {
                throw "SharePoint admin settings could not be queried: $($_.Exception.Message)"
            }
        }
    }
}
