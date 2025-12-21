#!/usr/bin/env bash
# AWS SAM CLI のインストールスクリプト
# 公式ドキュメント: https://docs.aws.amazon.com/ja_jp/serverless-application-model/latest/developerguide/install-sam-cli.html

SAM_VERSION=${VERSION:-"latest"}
set -e

# アーキテクチャの検出
ARCHITECTURE=$(uname -m)
case $ARCHITECTURE in
    x86_64)
        DOWNLOAD_URL="https://github.com/aws/aws-sam-cli/releases/latest/download/aws-sam-cli-linux-x86_64.zip"
        ;;
    aarch64|arm64)
        DOWNLOAD_URL="https://github.com/aws/aws-sam-cli/releases/latest/download/aws-sam-cli-linux-arm64.zip"
        ;;
    *)
        echo "Error: Unsupported architecture: $ARCHITECTURE"
        echo "AWS SAM CLI supports only x86_64 and arm64/aarch64"
        exit 1
        ;;
esac

echo "Detected architecture: $ARCHITECTURE"
echo "Installing AWS SAM CLI..."

# 一時ディレクトリの作成
TMP_DIR=$(mktemp -d)
cd "$TMP_DIR"

# AWS SAM CLI のダウンロード
echo "Downloading AWS SAM CLI from $DOWNLOAD_URL..."
wget -q "$DOWNLOAD_URL" -O aws-sam-cli.zip

# 解凍
echo "Extracting AWS SAM CLI..."
unzip -q aws-sam-cli.zip -d sam-installation

# インストール
echo "Installing AWS SAM CLI..."
./sam-installation/install

# クリーンアップ
cd -
rm -rf "$TMP_DIR"

# インストール確認
if command -v sam &> /dev/null; then
    SAM_INSTALLED_VERSION=$(sam --version | awk '{print $4}')
    echo "AWS SAM CLI successfully installed: $SAM_INSTALLED_VERSION"
else
    echo "Error: AWS SAM CLI installation failed"
    exit 1
fi

set +e
echo "Done!"
