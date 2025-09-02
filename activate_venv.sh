activate_venv() {
    if [ $# -gt 0 ]; then
        script_candidates=("$1/bin/activate" "$1/.venv/bin/activate")
        for script in "${script_candidates[@]}"; do
            if [ -f "$script" ]; then
                source "$script"
                return 0
            fi
        done
    else
        git_repo="$(git rev-parse --show-toplevel 2>/dev/null)"
        if [ $? -eq 0 ]; then
            activate_venv $git_repo
            return 0
        fi
    fi
    echo "Could not find venv activation script"
    return 1
}

alias venv=activate_venv
