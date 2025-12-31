#!/usr/bin/env bash

export WIN_USERNAME="$(powershell.exe -Command 'echo $env:UserName' | tr -d '\r')"

function setup_awscli() {
    # AWS CLI セットアップ関数
    if [ ! -d "${HOME}/.aws" ]; then
        ln -sv "${WIN_USERNAME}/.aws" "${HOME}/.aws"
        printf "\e[36m- Completed to setup AWS CLI.\e[0m\n"
    else
        printf "\e[33m- Skipped to setup AWS CLI...\e[0m\n"
    fi
}

function setup_azurecli() {
    # Azure CLI セットアップ関数
    if [ ! -d "${HOME}/.azure" ]; then
        ln -sv "${WIN_USERNAME}/.azure" "${HOME}/.azure"
        printf "\e[36m- Completed to setup Azure CLI.\e[0m\n"
    else
        printf "\e[33m- Skipped to setup Azure CLI...\e[0m\n"
    fi
}

function setup_claude_code() {
    # Claude Code セットアップ関数
    if [ ! -d "${HOME}/.claude" ]; then
        ln -sv "${WIN_USERNAME}/.claude" "${HOME}/.claude"
        printf "\e[36m- Completed to setup Claude Code.\e[0m\n"
    else
        printf "\e[33m- Skipped to setup Claude Code...\e[0m\n"
    fi
}

function setup_codex_cli() {
    # Codex CLI セットアップ関数
    if [ ! -d "${HOME}/.codex" ]; then
        ln -sv "${WIN_USERNAME}/.codex" "${HOME}/.codex"
        printf "\e[36m- Completed to setup Codex CLI.\e[0m\n"
    else
        printf "\e[33m- Skipped to setup Codex CLI...\e[0m\n"
    fi
}

function main() {
    printf "\e[34minitializeCommand\e[0m\n"

    SCRIPT_START=$(date +%s%3N)

    setup_awscli
    setup_azurecli
    setup_claude_code
    setup_codex_cli

    SCRIPT_END=$(date +%s%3N)

    TOTAL_DURATION=$((SCRIPT_END - SCRIPT_START))
    SECONDS=$((TOTAL_DURATION / 1000))
    MILLISECONDS=$((TOTAL_DURATION % 1000))
    printf "\e[32mSetup complete! Total time: %d.%03d [s]\e[0m\n" $SECONDS $MILLISECONDS
}

main
