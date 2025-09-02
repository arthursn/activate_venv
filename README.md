# Virtual Environment Activator

A simple shell utility to automatically find and activate Python virtual environments in your projects.

## Overview

This utility provides a convenient way to activate Python virtual environments without having to remember their exact location. It searches for activation scripts in common locations and provides a smart fallback to find the git repository root.

## Features

- Activates virtual environments with a simple command
- Searches in common locations (`./bin/activate` and `./.venv/bin/activate`)
- Automatically finds the git repository root when no path is specified
- Provides a convenient shell alias `venv`

## Installation

Add the following to your `.bashrc` or `.zshrc`:

```bash
source /path/to/activate_venv.sh
```

## Usage

### Activate a virtual environment in a specific directory

```bash
venv /path/to/project
```

### Activate a virtual environment in the current git repository

```bash
venv
```

## How It Works

The script searches for activation scripts in the following order:
1. `<specified_path>/bin/activate`
2. `<specified_path>/.venv/bin/activate`

If no path is specified, it uses `git rev-parse --show-toplevel` to find the root of the current git repository and searches there.

## License

[MIT](LICENSE)
