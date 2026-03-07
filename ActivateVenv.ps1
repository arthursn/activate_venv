function ActivateVenv {
    param(
        [string]$Dir = "."
    )

    $ScriptCandidates = @(
        "$Dir/Scripts/activate.ps1",
        "$Dir/.venv/Scripts/activate.ps1",
        "$Dir/bin/activate.ps1",
        "$Dir/.venv/bin/activate.ps1"
    )

    try {
        $GitRepo = git rev-parse --show-toplevel 2>$null
        if ($?) {
            $ScriptCandidates += "$GitRepo/.venv/Scripts/activate.ps1"
            $ScriptCandidates += "$GitRepo/.venv/bin/activate.ps1"
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
