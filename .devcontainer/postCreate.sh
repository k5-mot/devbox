#!/usr/bin/env bash

printf "\e[34mpostCreateCommand\e[0m\n"

function chown_dir() {
  local dir=$1
  if [ -d "$dir" ]; then
    printf "\e[36m- Change the owner of \"%s\" to %s.\e[0m\n" "$dir" "$(whoami)"
    sudo chown -R $(whoami):$(whoami) "$dir"
  fi
}

function setup_api() {
  printf "\e[36mSetup API environment...\e[0m\n"
  chown_dir api/.venv
  pushd api
  uv python install 3.12
  uv sync --dev
  popd
}

function setup_app() {
  printf "\e[36mSetup APP environment...\e[0m\n"
  chown_dir app/node_modules
  pushd app
  pnpm install
  popd
}

function setup_serena() {
  printf "\e[36mSetup Serena MCP server...\e[0m\n"
  chown_dir .serena
  uvx --no-env-file --from git+https://github.com/oraios/serena serena project index
}

function setup_precommit() {
  printf "\e[36mSetup pre-commit...\e[0m\n"
  pre-commit install
}

SCRIPT_START=$(date +%s%3N)

setup_api &
setup_app &
setup_serena &
setup_precommit &
wait

SCRIPT_END=$(date +%s%3N)

TOTAL_DURATION=$((SCRIPT_END - SCRIPT_START))
SECONDS=$((TOTAL_DURATION / 1000))
MILLISECONDS=$((TOTAL_DURATION % 1000))
printf "\e[32mSetup complete! Total time: %d.%03d [s]\e[0m\n" $SECONDS $MILLISECONDS
