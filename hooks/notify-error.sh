#!/bin/bash

# Error notification hook for PostToolUse (Bash commands)
# Requires: brew install terminal-notifier
# CUSTOMIZE: Change -activate bundle ID to your terminal app (line 19)
#   iTerm2:       com.googlecode.iterm2
#   Warp:         dev.warp.Warp-Stable
#   Terminal.app: com.apple.Terminal
#   Ghostty:      com.mitchellh.ghostty

json=$(cat)

tool_name=$(echo "$json" | jq -r '.tool_name // ""')
exit_code=$(echo "$json" | jq -r '.tool_response.exit_code // 0')

if [[ "$tool_name" == "Bash" && "$exit_code" != "0" ]]; then
    command=$(echo "$json" | jq -r '.tool_input.command // ""' | head -c 60)

    # Skip test/lint/typecheck expected failures
    if ! echo "$command" | grep -qE "(test|spec|lint|eslint|prettier|jest|mocha|pytest|type-check|typecheck|analyze)"; then
        terminal-notifier \
            -title "Claude" \
            -subtitle "Command Failed" \
            -message "${command}... (exit: $exit_code)" \
            -sound Basso \
            -activate com.mitchellh.ghostty \
            -ignoreDnD \
            -group "claude-error"
    fi
fi

echo '{"continue": true}'
