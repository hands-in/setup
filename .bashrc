preexec_invoke_exec() {
    # Avoid recursive calls from command completion
    [ -n "$COMP_LINE" ] && return

    # Extract the first word of the command (the actual command being run)
    local cmd=$(echo "$BASH_COMMAND" | awk '{print $1}')

    # List of known external commands that trigger op run --
    local known_commands=("npm" "pnpm" "yarn" "npx" "bun" "make" "nx")

    # Check if the command matches any known external command
    for known_cmd in "${known_commands[@]}"; do
        if [[ "$cmd" == "$known_cmd" ]]; then
            # Check if the user is logged in to 1Password
            if ! op whoami > /dev/null 2>&1; then
                echo "You are not logged into 1Password. Please log in."
                eval $(op signin)
                if [ $? -ne 0 ]; then
                    echo "Failed to sign in to 1Password. Aborting command."
                    return 1
                fi
            fi

            # Prefix the command with op run --
            command_to_run="op run -- $BASH_COMMAND"
            eval "$command_to_run"
            return $?  # Return the status of the executed command
        fi
    done
}

# Set a DEBUG trap to execute the function before every command
trap 'preexec_invoke_exec' DEBUG
