#!/usr/bin/env bash
IFS="," read -r -a DEFAULT_UTILS <<< "${TOOLSTOINSTALL:-zelli,exa,bat,fd-find,ripgrep}"
set -e

for tool in "${DEFAULT_UTILS[@]}"; do
  echo "Installing $tool..."
  cargo install "$tool"
done

set +e
echo "Done!"
