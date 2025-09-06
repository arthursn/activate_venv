activate_venv() {
    dir="${1:-.}"
    script_candidates=("$dir/bin/activate" "$dir/.venv/bin/activate")

    # Add git repo root venv if in a git repo
    if git_repo="$(git rev-parse --show-toplevel 2>/dev/null)"; then
        script_candidates+=("$git_repo/.venv/bin/activate")
    fi

    # Try each candidate
    for script in "${script_candidates[@]}"; do
        if [ -f "$script" ]; then
            source "$script"
            return 0
        fi
    done

    echo "Could not find venv activation script"
    return 1
}

alias venv=activate_venv
