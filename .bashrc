preexec_invoke_exec() {
    # Avoid recursive calls from command completion
    [ -n "$COMP_LINE" ] && return

    # Extract the first word of the command (the actual command being run)
    local cmd=$(echo "$BASH_COMMAND" | awk '{print $1}')

    # Check if the command is a shell built-in or function
    if type "$cmd" &> /dev/null; then
        type_output=$(type -t "$cmd")
        if [[ "$type_output" == "builtin" || "$type_output" == "function" ]]; then
            return  # Skip prefixing this command
        fi
    fi

    # Check if the user is logged in to 1Password
    if ! op whoami > /dev/null 2>&1; then
        echo "You are not logged into 1Password. Please log in."
        eval $(op signin)
        if [ $? -ne 0 ]; then
            echo "Failed to sign in to 1Password. Aborting command."
            return 1
        fi
    fi

    # Prefix the command with `op run --`
    command_to_run="op run -- '$BASH_COMMAND'"
    eval "$command_to_run"
    return $?  # Return the status of the executed command
}

# Set a DEBUG trap to execute the function before every command
trap 'preexec_invoke_exec' DEBUG
