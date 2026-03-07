function ActivateVenv {
    param(
        [string]$Dir = "."
    )

    # Initialize root folders array
    $RootFolders = @("$Dir")

    # If .venv folder exists, prepend $Dir/.venv to root folder candidates
    if (Test-Path "$Dir/.venv") {
        $RootFolders = @("$Dir/.venv") + $RootFolders
    }

    # If in a git repo and .venv exists, prepend $GitRepo/.venv to root folder candidates
    try {
        $GitRepo = git rev-parse --show-toplevel 2>$null
        if ($?) {
            if (Test-Path "$GitRepo/.venv") {
                $RootFolders = @("$GitRepo/.venv") + $RootFolders
            }
        }
    }
    catch {
        # Ignore errors from git command
    }

    # Activation scripts relative paths
    $ScriptPaths = @(
        "Scripts/activate.ps1",  # Windows
        "bin/activate.ps1"       # Unix
    )

    # Generate script candidates
    $ScriptCandidates = @()
    foreach ($Root in $RootFolders) {
        foreach ($RelPath in $ScriptPaths) {
            $ScriptCandidates += "$Root/$RelPath"
        }
    }

    # Try each candidate
    foreach ($Script in $ScriptCandidates) {
        if (Test-Path $Script) {
            & $Script
            return
        }
    }

    Write-Host "Could not find venv activation script"
}

Set-Alias -Name Venv -Value ActivateVenv
