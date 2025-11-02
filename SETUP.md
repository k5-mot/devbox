# 🛠️ devbox セットアップガイド

このドキュメントでは、devboxテンプレートを使用するための環境セットアップ手順を説明します。

## 📑 目次

- [1. Windows環境の準備](#1-windows環境の準備)
  - [1.1. PowerShellについて](#11-powershellについて)
  - [1.2. 必要なツールのインストール](#12-必要なツールのインストール)
  - [1.3. [OPTION] プロキシ設定](#13-option-プロキシ設定企業ネットワーク等で必要な場合)
    - [1.3.1. PowerShellプロファイルの作成](#131-powershellプロファイルの作成)
    - [1.3.2. プロキシ設定を追加](#132-プロキシ設定を追加)
  - [1.4. フォント設定](#14-フォント設定)
    - [1.4.1. Nerd Fontsのインストール](#141-nerd-fontsのインストール)
    - [1.4.2. Windows Terminalでフォントを設定](#142-windows-terminalでフォントを設定)
    - [1.4.3. VSCodeでフォントを設定](#143-vscodeでフォントを設定)
  - [1.5. ターミナル環境のカスタマイズ（Oh My Posh）](#15-ターミナル環境のカスタマイズoh-my-posh)
  - [1.6. Gitの設定](#16-gitの設定)
  - [1.7. VSCode拡張機能のインストール](#17-vscode拡張機能のインストール)
- [2. WSL2のセットアップ](#2-wsl2のセットアップ)
  - [2.1. WSL2のインストール](#21-wsl2のインストール)
  - [2.2. Ubuntuの初期設定](#22-ubuntuの初期設定)
  - [2.3. パッケージの更新](#23-パッケージの更新)
  - [2.4. Sudoのパスワード不要化](#24-sudoのパスワード不要化)
  - [2.5. Dockerのインストール](#25-dockerのインストール)
  - [2.6. Dockerの動作確認](#26-dockerの動作確認)
  - [2.7. [OPTION] WSLのプロキシ設定](#27-option-wslのプロキシ設定企業ネットワーク等で必要な場合)
    - [2.7.1. .bashrcを編集](#271-bashrcを編集)
    - [2.7.2. プロキシ設定を追加](#272-プロキシ設定を追加)
    - [2.7.3. 設定を反映](#273-設定を反映)
  - [2.8. [OPTION] Dockerのプロキシ設定](#28-option-dockerのプロキシ設定企業ネットワーク等で必要な場合)
    - [2.8.1. Docker Daemonのプロキシ設定](#281-docker-daemonのプロキシ設定)
    - [2.8.2. Docker Clientのプロキシ設定](#282-docker-clientのプロキシ設定docker-buildコマンド用)
- [3. このテンプレートの使用](#3-このテンプレートの使用)
  - [3.1. リポジトリのクローン](#31-リポジトリのクローン)
  - [3.2. Dev Containerで開く](#32-dev-containerで開く)
  - [3.3. 環境変数の設定](#33-環境変数の設定必要に応じて)
- [4. 認証設定](#4-認証設定初回セットアップ時に実施)
  - [4.1. AWS CLIの認証](#41-aws-cliの認証)
    - [4.1.1. 認証ディレクトリの作成](#411-認証ディレクトリの作成)
    - [4.1.2. ホストで認証](#412-ホストwindowsまたはwslで認証)
    - [4.1.3. Dev Containerで認証情報を有効化](#413-dev-containerで認証情報を有効化)
    - [4.1.4. AWS Access Keyの取得方法](#414-aws-access-keyの取得方法)
  - [4.2. Azure CLIの認証](#42-azure-cliの認証)
    - [4.2.1. 認証ディレクトリの作成](#421-認証ディレクトリの作成)
    - [4.2.2. ホストで認証](#422-ホストwindowsまたはwslで認証)
    - [4.2.3. Dev Containerで認証情報を有効化](#423-dev-containerで認証情報を有効化)
  - [4.3. Claude Codeの認証](#43-claude-codeの認証)
    - [4.3.1. Windowsで Claude Codeをインストール](#431-windowsで-claude-codeをインストール)
    - [4.3.2. Windowsで認証](#432-windowsで認証)
    - [4.3.3. WSLへシンボリックリンクを作成](#433-wslへシンボリックリンクを作成)
    - [4.3.4. Dev Container内で認証を確認](#434-dev-container内で認証を確認)
  - [4.4. Codex CLIの認証](#44-codex-cliの認証)
    - [4.4.1. WSLで Codex CLIをインストール](#441-wslで-codex-cliをインストール)
    - [4.4.2. WSLで認証](#442-wslで認証)
    - [4.4.3. Windowsへシンボリックリンクを作成](#443-windowsへシンボリックリンクを作成)
    - [4.4.4. Dev Container内で認証を確認](#444-dev-container内で認証を確認)
  - [4.5. 認証情報の共有について](#45-認証情報の共有について)

---

## 1. Windows環境の準備

### 1.1. PowerShellについて

このドキュメントでは、**PowerShell 7+（最新版）** を使用します。

- **Windows PowerShell 5.1**: Windows 11にプリインストールされている古いバージョン
- **PowerShell 7+**: 最新のクロスプラットフォーム版（これをインストールします）

以降の手順では、特に断りのない限り **PowerShell 7+** を使用します。

### 1.2. 必要なツールのインストール

**Windows PowerShell 5.1（プリインストール版）** を管理者権限で開き、以下のコマンドでツールを一括インストールします：

```powershell
# Windows Terminal、PowerShell 7+、OhMyPosh、VSCode、Git、AWS CLI、Azure CLIをインストール
winget install Microsoft.WindowsTerminal
winget install Microsoft.PowerShell  # PowerShell 7+ (最新版)
winget install JanDeDobbeleer.OhMyPosh
winget install Microsoft.VisualStudioCode
winget install Git.Git
winget install Amazon.AWSCLI
winget install Microsoft.AzureCLI
```

インストール後、**PowerShell 7+** を起動します（Windows Terminalから「PowerShell」を選択）。

### 1.3. [OPTION] プロキシ設定（企業ネットワーク等で必要な場合）

プロキシ環境下でツールをインストール・使用する場合、最初にプロキシ設定を行います。

#### 1.3.1. PowerShellプロファイルの作成

PowerShell 7+で以下を実行：

```powershell
# プロファイルファイルが存在しない場合は作成
if (!(Test-Path -Path $PROFILE)) {
    New-Item -ItemType File -Path $PROFILE -Force
}

# プロファイルをエディタで開く
notepad $PROFILE
```

#### 1.3.2. プロキシ設定を追加

開いたファイル（通常は `$Env:USERPROFILE\Documents\PowerShell\Microsoft.PowerShell_profile.ps1`）に以下を追加：

```powershell
# プロキシ設定
$env:HTTP_PROXY = "http://proxy.example.com:8080"
$env:HTTPS_PROXY = "http://proxy.example.com:8080"
$env:NO_PROXY = "localhost,127.0.0.1,127.0.0.0/8,::1,10.0.0.0/8,172.16.0.0/12,192.168.0.0/16"
```

保存後、PowerShell 7+を再起動するか、以下で設定を反映：

```powershell
. $PROFILE
```

**NO_PROXYの設定値について：**

- `localhost`: ローカルホスト名
- `127.0.0.1`: IPv4ループバックアドレス（CIDR非対応ツール用）
- `127.0.0.0/8`: IPv4ループバック範囲全体（127.0.0.0〜127.255.255.255、CIDR対応ツール用）
- `::1`: IPv6ループバックアドレス
- `10.0.0.0/8`: プライベートネットワーク（クラスA）
- `172.16.0.0/12`: プライベートネットワーク（クラスB）
- `192.168.0.0/16`: プライベートネットワーク（クラスC）

これらの設定により、ローカルおよびプライベートネットワークへの接続はプロキシを経由しません。
`127.0.0.1`と`127.0.0.0/8`の両方を指定することで、CIDR表記に対応していないツール（wget等）と
対応しているツール（curl、Python、Go等）の両方で正しく動作します。

**注意**: `proxy.example.com:8080` は実際のプロキシサーバーとポートに置き換えてください。

### 1.4. フォント設定

プログラミングに最適化されたNerd Fontsをインストールします。

#### 1.4.1. Nerd Fontsのインストール

PowerShell 7+で以下を実行：

```powershell
# CascadiaCode Nerd Fontをインストール
oh-my-posh font install CascadiaCode

# Meslo Nerd Fontをインストール
oh-my-posh font install Meslo
```

#### 1.4.2. Windows Terminalでフォントを設定

1. Windows Terminalを開く
2. 設定（`Ctrl+,`）を開く
3. 左側メニューから「既定値」を選択
4. 「外観」セクションで「フォントフェイス」を `CaskaydiaCove Nerd Font` に変更
5. 保存

または、設定ファイル（`settings.json`）を直接編集：

```json
{
    "profiles": {
        "defaults": {
            "font": {
                "face": "CaskaydiaCove Nerd Font"
            }
        }
    }
}
```

#### 1.4.3. VSCodeでフォントを設定

1. VSCodeを開く
2. 設定（`Ctrl+,`）を開く
3. `Editor: Font Family` を検索
4. 以下を先頭に追加：

```text
'CaskaydiaCove Nerd Font', Consolas, 'Courier New', monospace
```

または、設定ファイル（`settings.json`）を直接編集：

```json
{
    "editor.fontFamily": "'CaskaydiaCove Nerd Font', Consolas, 'Courier New', monospace",
    "editor.fontLigatures": true,
    "dev.containers.executeInWSL": true
}
```

**注意**: `dev.containers.executeInWSL`を`true`に設定することで、Dev ContainersがWSL内で実行されます。
これにより、Windowsホストよりも高速な動作とLinux環境との互換性が向上します。

### 1.5. ターミナル環境のカスタマイズ（Oh My Posh）

**参考資料**: [Tutorial: Set up a custom prompt for PowerShell or WSL with Oh My Posh](https://learn.microsoft.com/ja-jp/windows/terminal/tutorials/custom-prompt-setup)

PowerShell 7+で以下を実行：

```powershell
# OhMyPoshテーマの適用
oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\spaceship.omp.json" | Invoke-Expression
```

プロファイルに永続化する場合：

```powershell
# プロファイルに追加
Add-Content $PROFILE "oh-my-posh init pwsh --config `"`$env:POSH_THEMES_PATH\spaceship.omp.json`" | Invoke-Expression"
```

### 1.6. Gitの設定

PowerShell 7+またはBashで以下を実行：

```bash
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
git config --global core.editor "code --wait"
```

### 1.7. VSCode拡張機能のインストール

VSCodeを開き、以下の拡張機能をインストールします：

- **Dev Containers** (`ms-vscode-remote.remote-containers`)

または、コマンドラインから：

```bash
code --install-extension ms-vscode-remote.remote-containers
```

## 2. WSL2のセットアップ

### 2.1. WSL2のインストール

管理者権限のPowerShellで以下のコマンドを実行します：

```powershell
wsl --install
```

インストール後、システムを再起動します。

### 2.2. Ubuntuの初期設定

WSLを起動し、ユーザー名とパスワードを設定します。

### 2.3. パッケージの更新

```bash
sudo apt-get update
sudo apt-get upgrade -y
```

### 2.4. Sudoのパスワード不要化

```bash
sudo visudo
```

以下の行を追加します：

```text
your_username ALL=(ALL) NOPASSWD:ALL
```

### 2.5. Dockerのインストール

**参考資料**: [Install Docker Engine on Ubuntu](https://docs.docker.com/engine/install/ubuntu/)

```bash
# 古いバージョンの削除
sudo apt-get remove docker docker-engine docker.io containerd runc

# 必要なパッケージのインストール
sudo apt-get update
sudo apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

# DockerのGPGキーを追加
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

# Dockerリポジトリの設定
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | \
sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Dockerのインストール
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Dockerサービスの起動
sudo service docker start

# ユーザーをdockerグループに追加
sudo usermod -aG docker $USER
```

設定を反映するため、WSLを再起動します：

```bash
exit
```

PowerShellで：

```powershell
wsl --shutdown
wsl
```

### 2.6. Dockerの動作確認

```bash
docker --version
docker run hello-world
```

### 2.7. [OPTION] WSLのプロキシ設定（企業ネットワーク等で必要な場合）

プロキシ環境下でWSLを使用する場合、`~/.bashrc` に以下を追加します：

#### 2.7.1. .bashrcを編集

```bash
nano ~/.bashrc
```

#### 2.7.2. プロキシ設定を追加

ファイルの最後に以下を追加：

```bash
# プロキシ設定
export HTTP_PROXY="http://proxy.example.com:8080"
export HTTPS_PROXY="http://proxy.example.com:8080"
export NO_PROXY="localhost,127.0.0.1,127.0.0.0/8,::1,10.0.0.0/8,172.16.0.0/12,192.168.0.0/16"
export http_proxy="$HTTP_PROXY"
export https_proxy="$HTTPS_PROXY"
export no_proxy="$NO_PROXY"
```

#### 2.7.3. 設定を反映

```bash
source ~/.bashrc
```

**NO_PROXYの設定値について：**

- `localhost`: ローカルホスト名
- `127.0.0.1`: IPv4ループバックアドレス（CIDR非対応ツール用）
- `127.0.0.0/8`: IPv4ループバック範囲全体（127.0.0.0〜127.255.255.255、CIDR対応ツール用）
- `::1`: IPv6ループバックアドレス
- `10.0.0.0/8`: プライベートネットワーク（クラスA）
- `172.16.0.0/12`: プライベートネットワーク（クラスB）
- `192.168.0.0/16`: プライベートネットワーク（クラスC）

これらの設定により、ローカルおよびプライベートネットワークへの接続はプロキシを経由しません。
`127.0.0.1`と`127.0.0.0/8`の両方を指定することで、CIDR表記に対応していないツール（wget等）と
対応しているツール（curl、Python、Go等）の両方で正しく動作します。

**注意**: `proxy.example.com:8080` は実際のプロキシサーバーとポートに置き換えてください。

### 2.8. [OPTION] Dockerのプロキシ設定（企業ネットワーク等で必要な場合）

#### 2.8.1. Docker Daemonのプロキシ設定

WSLで以下のディレクトリとファイルを作成：

```bash
sudo mkdir -p /etc/systemd/system/docker.service.d
sudo nano /etc/systemd/system/docker.service.d/http-proxy.conf
```

以下の内容を追加：

```ini
[Service]
Environment="HTTP_PROXY=http://proxy.example.com:8080"
Environment="HTTPS_PROXY=http://proxy.example.com:8080"
Environment="NO_PROXY=localhost,127.0.0.1,127.0.0.0/8,::1,10.0.0.0/8,172.16.0.0/12,192.168.0.0/16"
```

Dockerサービスを再起動：

```bash
sudo systemctl daemon-reload
sudo service docker restart
```

#### 2.8.2. Docker Clientのプロキシ設定（docker buildコマンド用）

`docker build`時にプロキシを使用する場合、`~/.docker/config.json`を設定します：

```bash
mkdir -p ~/.docker
nano ~/.docker/config.json
```

以下の内容を追加：

```json
{
  "proxies": {
    "default": {
      "httpProxy": "http://proxy.example.com:8080",
      "httpsProxy": "http://proxy.example.com:8080",
      "noProxy": "localhost,127.0.0.1,127.0.0.0/8,::1,10.0.0.0/8,172.16.0.0/12,192.168.0.0/16"
    }
  }
}
```

この設定により、`docker build`実行時に自動的にプロキシ設定がビルドコンテキストに渡され、
Dev Containerのビルド時にもプロキシが適用されます。

## 3. このテンプレートの使用

### 3.1. リポジトリのクローン

```bash
git clone https://github.com/your-username/devbox.git
cd devbox
```

または、GitHubでこのリポジトリを「Use this template」ボタンでテンプレートとして使用します。

### 3.2. Dev Containerで開く

1. VSCodeでクローンしたディレクトリを開く
2. コマンドパレット（`Ctrl+Shift+P`）を開く
3. `Dev Containers: Reopen in Container`を選択
4. コンテナのビルドと起動を待つ（初回は時間がかかります）

### 3.3. 環境変数の設定（必要に応じて）

`.devcontainer/devcontainer.env`ファイルを編集して、プロジェクト固有の環境変数を設定します。

## 4. 認証設定（初回セットアップ時に実施）

各種ツールの認証を行います。認証情報はホストと共有されるため、
一度設定すれば複数のdevboxプロジェクトで使い回せます。

**重要**: Claude CodeとCodex CLIは、Dev Containerを起動する**前に**ホストで認証することを推奨します。

### 4.1. AWS CLIの認証

AWS CLIを使用する場合は、以下の手順で認証します。

**重要**: bind mountが有効な場合、マウント元ディレクトリが存在しないとDev Containerの起動に失敗します。
認証前に必ずディレクトリを作成してください。

#### 4.1.1. 認証ディレクトリの作成

**Windowsの場合：**

```powershell
# .awsディレクトリを作成（存在しない場合）
if (!(Test-Path "$env:USERPROFILE\.aws")) {
    New-Item -ItemType Directory -Path "$env:USERPROFILE\.aws"
}
```

**WSLの場合：**

```bash
# .awsディレクトリを作成（存在しない場合）
mkdir -p ~/.aws
```

#### 4.1.2. ホスト（WindowsまたはWSL）で認証

**Windowsの場合：**

```powershell
aws configure
```

**WSLの場合：**

```bash
aws configure
```

以下の情報を入力します：

```text
AWS Access Key ID [None]: YOUR_ACCESS_KEY_ID
AWS Secret Access Key [None]: YOUR_SECRET_ACCESS_KEY
Default region name [None]: ap-northeast-1
Default output format [None]: json
```

認証情報は以下のディレクトリに保存されます：

- Windows: `%USERPROFILE%\.aws\`
- WSL: `~/.aws/`

#### 4.1.3. Dev Containerで認証情報を有効化

ホストの認証情報をDev Containerと共有したい場合、
[.devcontainer/devcontainer.json](.devcontainer/devcontainer.json)のコメントアウトされた行を有効化します：

```json
"mounts": [
    "source=${localEnv:HOME}${localEnv:USERPROFILE}/.aws,target=/home/vscode/.aws,type=bind,consistency=cached",
    ...
]
```

コンテナを再ビルド後、Dev Container内で以下のコマンドで確認：

```bash
aws sts get-caller-identity
```

#### 4.1.4. AWS Access Keyの取得方法

1. [AWS Management Console](https://console.aws.amazon.com/)にログイン
2. IAM → ユーザー → セキュリティ認証情報
3. アクセスキーを作成

### 4.2. Azure CLIの認証

Azure CLIを使用する場合は、以下の手順で認証します。

**重要**: bind mountが有効な場合、マウント元ディレクトリが存在しないとDev Containerの起動に失敗します。
認証前に必ずディレクトリを作成してください。

#### 4.2.1. 認証ディレクトリの作成

**Windowsの場合：**

```powershell
# .azureディレクトリを作成（存在しない場合）
if (!(Test-Path "$env:USERPROFILE\.azure")) {
    New-Item -ItemType Directory -Path "$env:USERPROFILE\.azure"
}
```

**WSLの場合：**

```bash
# .azureディレクトリを作成（存在しない場合）
mkdir -p ~/.azure
```

#### 4.2.2. ホスト（WindowsまたはWSL）で認証

**Windowsの場合：**

```powershell
az login
```

**WSLの場合：**

```bash
az login
```

ブラウザが開き、Microsoftアカウントでのログインが求められます。
認証情報は以下のディレクトリに保存されます：

- Windows: `%USERPROFILE%\.azure\`
- WSL: `~/.azure/`

認証完了後、以下のコマンドで確認：

```bash
az account show
```

#### 4.2.3. Dev Containerで認証情報を有効化

ホストの認証情報をDev Containerと共有したい場合、
[.devcontainer/devcontainer.json](.devcontainer/devcontainer.json)のコメントアウトされた行を有効化します：

```json
"mounts": [
    "source=${localEnv:HOME}${localEnv:USERPROFILE}/.azure,target=/home/vscode/.azure,type=bind,consistency=cached"
]
```

コンテナを再ビルド後、Dev Container内で以下のコマンドで確認：

```bash
az account show
```

### 4.3. Claude Codeの認証

Claude Codeは**Windowsでのインストールを推奨**します（2025年にネイティブ対応）。

#### 4.3.1. Windowsで Claude Codeをインストール

**PowerShell 7+** を管理者権限で開き、以下を実行：

```powershell
winget install Anthropic.ClaudeCode
```

インストール後、PowerShellまたはコマンドプロンプトで `claude-code` コマンドが使用可能になります。

#### 4.3.2. Windowsで認証

Claude Codeは2つの認証方法をサポートしています：

**方法A: Claude.ai サブスクリプション（推奨）**

Claude Pro、Max、Team、またはEnterpriseサブスクリプションをお持ちの場合：

```powershell
# Claude Codeを起動して認証
claude-code auth login
```

ブラウザが開き、Claude.aiへのOAuth認証が求められます。
認証後、設定が `%USERPROFILE%\.claude\` ディレクトリに保存されます。

認証の確認：

```powershell
claude-code auth status
```

**方法B: Anthropic API Key**

API Keyを使用する場合（API使用料金が発生）：

1. [Anthropic Console](https://console.anthropic.com/)でAPI Keyを取得
2. PowerShellプロファイル（`$PROFILE`）に環境変数を設定（セクション1.3参照）：

```powershell
$env:ANTHROPIC_API_KEY = "sk-ant-api03-..."
```

#### 4.3.3. WSLへシンボリックリンクを作成

WSLからもWindows の認証情報を使用したい場合、シンボリックリンクを作成します：

```bash
# WSL内で実行
# ユーザー名を実際のWindowsユーザー名に置き換える
ln -s /mnt/c/Users/YOUR_USERNAME/.claude ~/.claude
```

#### 4.3.4. Dev Container内で認証を確認

Dev Container起動後、ターミナルで以下を実行：

```bash
claude-code auth status
```

認証情報はbind mountで自動的に共有されます。

**注意事項：**

- 環境変数 `ANTHROPIC_API_KEY` が設定されている場合、サブスクリプションより優先されます
- API Key使用時はAPI使用料金が発生します

### 4.4. Codex CLIの認証

Codex CLIは**WSLでのインストールを推奨**します（Windows版は実験的）。

#### 4.4.1. WSLで Codex CLIをインストール

WSLで以下を実行：

```bash
npm install -g @openai/codex
```

インストール後、`codex` コマンドが使用可能になります。

#### 4.4.2. WSLで認証

Codex CLIは2つの認証方法をサポートしています：

**方法A: ChatGPT アカウント（推奨）**

ChatGPT Plus、Pro、Business、Edu、またはEnterpriseプランをお持ちの場合：

```bash
codex login
```

ブラウザが開き、ChatGPTアカウントでのOAuth認証が求められます。
認証情報は `~/.codex/` ディレクトリに保存されます。

認証の確認：

```bash
codex auth status
```

**方法B: OpenAI API Key**

API Keyを使用する場合：

**ステップ1: API Keyの取得**

[OpenAI Platform](https://platform.openai.com/)でAPI Keyを取得します。

**ステップ2: 環境変数の設定**

`~/.bashrc` に環境変数を設定（セクション2.7参照）：

```bash
export OPENAI_API_KEY="sk-proj-..."
```

**ステップ3: API Keyでログイン**

```bash
printenv OPENAI_API_KEY | codex login --with-api-key
```

#### 4.4.3. Windowsへシンボリックリンクを作成

WindowsからもWSLの認証情報を使用したい場合、シンボリックリンクを作成します：

**PowerShell 7+** を管理者権限で開き、以下を実行：

```powershell
# ユーザー名を実際のWSLユーザー名に置き換える
cmd /c mklink /D "$env:USERPROFILE\.codex" "\\wsl$\Ubuntu\home\YOUR_WSL_USERNAME\.codex"
```

**注意**: WSLディストリビューションが`Ubuntu`でない場合は、適切な名前に置き換えてください
（例: `\\wsl$\Ubuntu-22.04\...`）。

#### 4.4.4. Dev Container内で認証を確認

Dev Container起動後、ターミナルで以下を実行：

```bash
codex auth status
```

認証情報はbind mountで自動的に共有されます。

### 4.5. 認証情報の共有について

このdevboxテンプレートでは、各種ツールの認証情報をWindowsホスト（またはWSL）と
bind mountで共有しています。

**メリット：**

- 一度認証すれば、複数のdevboxプロジェクトで同じ認証情報を使い回せます
- プロジェクトを削除しても認証情報は保持されます
- 認証設定がホストに保存されるため、バックアップや移行が容易です

**認証情報の保存場所：**

| ツール | Windows | WSL |
|--------|---------|-----|
| AWS CLI | `%USERPROFILE%\.aws\` | `~/.aws/` |
| Azure CLI | `%USERPROFILE%\.azure\` | `~/.azure/` |
| Claude Code | `%USERPROFILE%\.claude\` | `~/.claude/` |
| Codex | `%USERPROFILE%\.codex\` | `~/.codex/` |

**bind mount設定：**

Claude CodeとCodexは標準でbind mountが有効になっています。
AWS CLIとAzure CLIは必要に応じて[.devcontainer/devcontainer.json](.devcontainer/devcontainer.json)で
有効化できます。
