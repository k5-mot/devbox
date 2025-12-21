#!/usr/bin/env bash

printf "\e[34mpostCreateCommand\e[0m\n"

function chown_dir() {
  # ディレクトリの所有者を変更する関数
  local dir=$1
  if [ -d "$dir" ]; then
    printf "\e[36m- Change the owner of \"%s\" to %s.\e[0m\n" "$dir" "$(whoami)"
    sudo chown -R $(whoami):$(whoami) "$dir"
  fi
}

function setup_python_project() {
  # Pythonプロジェクトインストール関数
  # Args:
  #   $1: プロジェクトディレクトリのパス
  local project_dir=$1

  printf "\e[36m- Setting up Python project in %s\e[0m\n" "$project_dir"
  chown_dir "$project_dir/.venv"
  pushd "$project_dir" > /dev/null
  uv python install 3.12
  uv sync --dev
  popd > /dev/null
  printf "\e[32m- Python dependencies installed in %s\e[0m\n" "$project_dir"
}

function setup_nodejs_project() {
  # Node.jsプロジェクトインストール関数
  # Args:
  #   $1: プロジェクトディレクトリのパス
  local project_dir=$1

  printf "\e[36m- Setting up Node.js project in %s\e[0m\n" "$project_dir"
  chown_dir "$project_dir/node_modules"
  chown_dir "$project_dir/node_modules/.pnpm"
  pushd "$project_dir" > /dev/null

  # パッケージマネージャーを検出
  if [ -f "pnpm-lock.yaml" ]; then
    printf "\e[36m- Using pnpm\e[0m\n"
    pnpm install
  elif [ -f "yarn.lock" ]; then
    printf "\e[36m- Using yarn\e[0m\n"
    yarn install
  elif [ -f "package-lock.json" ]; then
    printf "\e[36m- Using npm\e[0m\n"
    npm install
  else
    # デフォルトはnpmを使用
    printf "\e[36m- Using npm (default)\e[0m\n"
    npm install
  fi

  popd > /dev/null
  printf "\e[32m- Node.js dependencies installed in %s\e[0m\n" "$project_dir"
}

function setup_serena() {
  # Serenaセットアップ関数
  printf "\e[36mSetup Serena MCP server...\e[0m\n"
  chown_dir .serena
  uvx --no-env-file --from git+https://github.com/oraios/serena serena project index
  printf "\e[32m- Serena setup complete\e[0m\n"
}

function setup_precommit() {
  # pre-commitセットアップ関数
  printf "\e[36mSetup pre-commit...\e[0m\n"
  pre-commit install
  printf "\e[32m- pre-commit setup complete\e[0m\n"
}

function main() {
  # メイン関数
  local script_start=$(date +%s%3N)

  printf "\e[36mScanning workspace for projects...\e[0m\n"

  # 隠しディレクトリ以外のディレクトリを探索
  for dir in */; do
    # 末尾のスラッシュを削除
    dir="${dir%/}"

    # 隠しディレクトリをスキップ
    if [[ "$dir" == .* ]]; then
      continue
    fi

    # package.jsonが存在する場合、Node.jsプロジェクトとしてセットアップ
    if [ -f "$dir/package.json" ]; then
      printf "\e[36mFound Node.js project: %s\e[0m\n" "$dir"
      setup_nodejs_project "$dir" &
    fi

    # pyproject.tomlが存在する場合、Pythonプロジェクトとしてセットアップ
    if [ -f "$dir/pyproject.toml" ]; then
      printf "\e[36mFound Python project: %s\e[0m\n" "$dir"
      setup_python_project "$dir" &
    fi
  done

  # プロジェクトのセットアップとSerenaとpre-commitのセットアップを並列実行
  setup_serena &
  setup_precommit &

  # すべてのセットアップが完了するまで待機
  wait

  local script_end=$(date +%s%3N)
  local total_duration=$((script_end - script_start))
  local seconds=$((total_duration / 1000))
  local milliseconds=$((total_duration % 1000))
  printf "\e[32mSetup complete! Total time: %d.%03d [s]\e[0m\n" $seconds $milliseconds
}

# メイン関数を実行
main
