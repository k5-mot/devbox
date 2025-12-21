#!/usr/bin/env bash
HELIX_VERSION=${VERSION:-"latest"}
set -e

echo "Starting Helix installation (version: $HELIX_VERSION)..."

# パッケージマネージャーの判別とインストール
if command -v apt-get &> /dev/null; then
    echo "Installing Helix via apt..."

    # PPAの追加
    apt-get update
    apt-get install -y software-properties-common
    add-apt-repository -y ppa:maveonair/helix-editor
    apt-get update

    # Helixのインストール
    if [ "$HELIX_VERSION" = "latest" ]; then
        apt-get install -y helix
    else
        echo "Warning: Specific version installation not supported via PPA. Installing latest version."
        apt-get install -y helix
    fi

elif command -v dnf &> /dev/null; then
    echo "Installing Helix via dnf..."

    # Helixのインストール
    if [ "$HELIX_VERSION" = "latest" ]; then
        dnf install -y helix
    else
        dnf install -y "helix-${HELIX_VERSION}"
    fi

else
    echo "Neither apt nor dnf found. Attempting manual installation from GitHub releases..."

    # アーキテクチャとOSの検出
    ARCH=$(uname -m)
    OS=$(uname -s | tr '[:upper:]' '[:lower:]')

    # アーキテクチャのマッピング
    case "$ARCH" in
        x86_64)
            HELIX_ARCH="x86_64"
            ;;
        aarch64|arm64)
            HELIX_ARCH="aarch64"
            ;;
        *)
            echo "Unsupported architecture: $ARCH"
            exit 1
            ;;
    esac

    # OSのマッピング
    case "$OS" in
        linux)
            HELIX_OS="linux"
            ;;
        *)
            echo "Unsupported OS: $OS"
            exit 1
            ;;
    esac

    # バージョンの取得
    if [ "$HELIX_VERSION" = "latest" ]; then
        echo "Fetching latest version..."
        LATEST_VERSION=$(curl -s https://api.github.com/repos/helix-editor/helix/releases/latest | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')

        if [ -z "$LATEST_VERSION" ]; then
            echo "Failed to fetch the latest version"
            exit 1
        fi
        HELIX_VERSION="$LATEST_VERSION"
    fi

    echo "Installing Helix version: $HELIX_VERSION"

    # ダウンロードURL構築
    DOWNLOAD_URL="https://github.com/helix-editor/helix/releases/download/${HELIX_VERSION}/helix-${HELIX_VERSION}-${HELIX_ARCH}-${HELIX_OS}.tar.xz"
    echo "Downloading from: $DOWNLOAD_URL"

    # 一時ディレクトリの作成
    TMP_DIR=$(mktemp -d)
    cd "$TMP_DIR"

    # Helixのダウンロードと検証
    if ! curl -L -f -o helix.tar.xz "$DOWNLOAD_URL"; then
        echo "Failed to download Helix from $DOWNLOAD_URL"
        rm -rf "$TMP_DIR"
        exit 1
    fi

    # ファイルサイズの検証
    FILE_SIZE=$(stat -f%z helix.tar.xz 2>/dev/null || stat -c%s helix.tar.xz 2>/dev/null)
    if [ "$FILE_SIZE" -lt 1000 ]; then
        echo "Downloaded file is too small (${FILE_SIZE} bytes). Download may have failed."
        rm -rf "$TMP_DIR"
        exit 1
    fi

    echo "Download completed. File size: ${FILE_SIZE} bytes"

    # 解凍
    echo "Extracting archive..."
    tar -xf helix.tar.xz

    # インストールディレクトリの準備
    INSTALL_DIR="/usr/local"
    HELIX_DIR="helix-${HELIX_VERSION}-${HELIX_ARCH}-${HELIX_OS}"

    # バイナリのインストール
    if [ -f "$HELIX_DIR/hx" ]; then
        cp "$HELIX_DIR/hx" "$INSTALL_DIR/bin/hx"
        chmod +x "$INSTALL_DIR/bin/hx"
        echo "Installed hx binary to $INSTALL_DIR/bin/hx"
    else
        echo "hx binary not found in extracted archive"
        ls -la "$HELIX_DIR"
        rm -rf "$TMP_DIR"
        exit 1
    fi

    # ランタイムファイルのインストール
    if [ -d "$HELIX_DIR/runtime" ]; then
        mkdir -p "$INSTALL_DIR/lib/helix"
        cp -r "$HELIX_DIR/runtime" "$INSTALL_DIR/lib/helix/"
        echo "Installed runtime files to $INSTALL_DIR/lib/helix/runtime"
    else
        echo "Warning: runtime directory not found"
    fi

    # 環境変数の設定
    cat > /etc/profile.d/helix.sh << 'EOF'
export HELIX_RUNTIME=/usr/local/lib/helix/runtime
EOF
    chmod +x /etc/profile.d/helix.sh

    echo "Environment variable HELIX_RUNTIME set to /usr/local/lib/helix/runtime"

    # クリーンアップ
    cd /
    rm -rf "$TMP_DIR"
fi

# インストール確認
if command -v hx &> /dev/null; then
    echo "Helix installation completed successfully!"
    hx --version
else
    echo "Helix installation failed: hx command not found"
    exit 1
fi

set +e
echo "Done!"
