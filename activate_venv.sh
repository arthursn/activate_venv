activate_venv() {
    local dir="${1:-.}"
    local git_repo
    local root_folders=("$dir")

    # If .venv folder exists, prepend $dir/.venv to root folder candidates
    if [ -d $dir/.venv ]; then
        root_folders=($dir/.venv ${git_repo[@]})
    fi

    # If in a git repo and .venv exists, prepend $git_repo/.venv to root folder candidates
    if git_repo="$(git rev-parse --show-toplevel 2>/dev/null)"; then
        if [ -d $git_repo/.venv ]; then
            root_folders=($git_repo/.venv ${git_repo[@]})
        fi
    fi

    # Activation scripts relative paths
    local script_paths=(
        "bin/activate"     # Unix
        "Scripts/activate" # Windows
    )

    local script_candidates=()
    local root
    local relpath
    for root in "${root_folders[@]}"; do
        for relpath in "${script_paths[@]}"; do
            script_candidates+=("$root/$relpath")
        done
    done

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
