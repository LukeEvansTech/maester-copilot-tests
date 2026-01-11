# maester-copilot-tests

Custom [Maester](https://maester.dev) tests focused on Microsoft 365 Copilot security controls.

[Maester](https://github.com/maester365/maester) is a PowerShell-based test framework for Microsoft 365 security configuration. This repo extends it with tests specific to the controls that change Copilot's blast radius:

- Sensitivity labels deployed and applied.
- Restricted SharePoint search enabled.
- Microsoft Purview audit logging enabled and capturing `CopilotInteraction` events.
- Copilot opt-out/opt-in alignment with tenant policy.

## Status

Early — public seed of an ongoing project. Tests follow the Maester custom-test convention: each `Test-*.Tests.ps1` file is a Pester test that can be discovered and executed by `Invoke-Maester`.

## Install

```powershell
Install-Module Maester
git clone https://github.com/LukeEvansTech/maester-copilot-tests.git
cd maester-copilot-tests
```

## Run

```powershell
Connect-Maester
Invoke-Maester -Path ./tests
```

Or include this folder alongside your existing Maester custom-tests folder and run from there.

## Tests included

| Test file | Control checked |
| --------- | --------------- |
| `tests/Test-CopilotSensitivityLabels.Tests.ps1` | At least three sensitivity labels are configured and at least one is published. |
| `tests/Test-CopilotAuditLogging.Tests.ps1` | Unified audit log is enabled at the tenant level (precondition for Copilot interaction auditing). |
| `tests/Test-CopilotRestrictedSharePointSearch.Tests.ps1` | Restricted SharePoint Search configuration follows tenant policy. |

## Contributing

PRs welcome. New tests should:

- Live in `tests/` and follow the `Test-Copilot*.Tests.ps1` naming convention.
- Use `Connect-Maester` for graph access.
- Tag with `Tag` of `'Copilot'` plus the relevant Microsoft 365 area (`'Purview'`, `'SharePoint'`, `'Entra'`, etc.) so they can be selectively run.

See [CONTRIBUTING](.github/CONTRIBUTING.md).

## Licence

[MIT](LICENSE).
