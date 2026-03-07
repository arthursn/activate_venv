activate_venv() {
    local dir="${1:-.}"
    local script_candidates=(
        "$dir/bin/activate"
        "$dir/.venv/bin/activate"
        "$dir/Scripts/activate"
        "$dir/.venv/Scripts/activate"
    )

    # Add git repo root venv if in a git repo
    local git_repo
    if git_repo="$(git rev-parse --show-toplevel 2>/dev/null)"; then
        script_candidates+=(
            "$git_repo/.venv/bin/activate"
            "$git_repo/.venv/Scripts/activate"
        )
    fi

    # Try each candidate
    local script
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
