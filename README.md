# Virtual Environment Activator

A simple utility to automatically find and activate Python virtual environments in your projects, available for both Bash/Zsh and PowerShell.

## Overview

This utility provides a convenient way to activate Python virtual environments without having to remember their exact location. It searches for activation scripts in common locations and provides a smart fallback to find the git repository root.

## Features

- Activates virtual environments with a simple command
- Searches in common locations for activation scripts
- Automatically finds the git repository root when no path is specified
- Provides a convenient alias `venv` in both shell environments

## Installation

### Bash/Zsh

Add the following to your `.bashrc` or `.zshrc`:

```bash
source /path/to/activate_venv.sh
```

### PowerShell

Add the following to your PowerShell profile:

```powershell
. /path/to/ActivateVenv.ps1
```

To find your profile location, run `$PROFILE` in PowerShell. You may need to create the profile file if it doesn't exist.

## Usage

### Bash/Zsh

#### Activate a virtual environment in a specific directory

```bash
venv /path/to/project
```

#### Activate a virtual environment in the current git repository

```bash
venv
```

### PowerShell

#### Activate a virtual environment in a specific directory

```powershell
Venv -Dir "/path/to/project"
```

#### Activate a virtual environment in the current git repository

```powershell
Venv
```

## How It Works

### Bash/Zsh
The script searches for activation scripts in the following order:
1. `<specified_path>/bin/activate`
2. `<specified_path>/.venv/bin/activate`

### PowerShell
The script searches for activation scripts in the following order:
1. `<specified_path>\Scripts\Activate.ps1`
2. `<specified_path>\.venv\Scripts\Activate.ps1`

If no path is specified, both versions use `git rev-parse --show-toplevel` to find the root of the current git repository and search there.

