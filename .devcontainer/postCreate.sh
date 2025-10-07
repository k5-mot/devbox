#!/usr/bin/env bash

printf "\e[36mpostCreateCommand\e[0m\n"

function chown_dir() {
  local dir=$1
  if [ -d "$dir" ]; then
    sudo chown -R $(whoami):$(whoami) "$dir"
  fi
}

function setup_api() {
  printf "\e[34mSetup API environment...\e[0m\n"
  chown_dir api/.venv
  pushd api
  uv python install 3.12
  uv sync --dev
  popd
}

function setup_app() {
  printf "\e[34mSetup APP environment...\e[0m\n"
  chown_dir app/node_modules
  pushd app
  pnpm install
  popd
}

setup_api &
setup_app &
wait
printf "\e[32mSetup complete!\e[0m\n"
