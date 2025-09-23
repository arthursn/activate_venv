function ActivateVenv {
    param(
        [string]$Dir = "."
    )

    $ScriptCandidates = @(
        "$Dir\Scripts\Activate.ps1",
        "$Dir\.venv\Scripts\Activate.ps1"
    )

    try {
        $GitRepo = git rev-parse --show-toplevel 2>$null
        if ($?) {
            $ScriptCandidates += "$GitRepo\.venv\Scripts\Activate.ps1"
        }
    }
    catch {
        # Ignore errors from git command
    }

    foreach ($Script in $ScriptCandidates) {
        if (Test-Path $Script) {
            & $Script
            return
        }
    }

    Write-Host "Could not find venv activation script"
}

Set-Alias -Name Venv -Value ActivateVenv
