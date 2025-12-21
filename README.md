# 🚀 devbox

開発環境のテンプレートプロジェクト

## 📖 概要

`devbox`は、新規プロジェクトを作成する際に環境構築をスキップするためのテンプレートリポジトリです。
Windows + WSL + Docker + Dev Container環境を前提とした、すぐに使える開発環境を提供します。

## ✨ 特徴

- **🔧 統一された開発環境**: Dev Containerを使用し、チーム全体で同一の開発環境を実現
- **📦 豊富なプリインストールツール**: Node.js、Python、AWS CLI、Azure CLI、Terraformなど、
モダンな開発に必要なツールを標準搭載
- **🤖 AIコーディングエージェント対応**: Claude Code、Cline、Codex等のAIツールがプリインストール
- **⚡ 効率的なパッケージ管理**: ボリュームマウントによる依存関係のキャッシュで高速な再構築
- **🔄 複数プロジェクト間で認証情報を共有**: Claude Code/Codexの認証情報をbind mountで共有し、
複数のdevboxプロジェクトで使い回し可能

## 📋 前提条件

このテンプレートを使用するには、以下の環境が必要です：

- Windows 11（管理者権限が必要）
- インターネット接続

## 🛠️ セットアップ手順

詳細なセットアップ手順は [SETUP.md](SETUP.md) を参照してください。

### クイックスタート

1. **Windows環境の準備**: PowerShell 7+、VSCode、Git、WSL2をインストール
2. **WSL2のセットアップ**: Ubuntu、Docker をインストール
3. **テンプレートの使用**: このリポジトリをクローンして Dev Container で開く
4. **認証設定**: AWS CLI、Azure CLI、Claude Code、Codex の認証を実施

## 📦 インストール済みツール

### 💻 開発言語・ランタイム

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

#### 1.3 [OPTION] プロキシ設定（企業ネットワーク等で必要な場合）

プロキシ環境下でツールをインストール・使用する場合、最初にプロキシ設定を行います。

##### PowerShell 7+ のプロキシ設定

**手順1: PowerShellプロファイルの作成**

PowerShell 7+で以下を実行：

```powershell
# プロファイルファイルが存在しない場合は作成
if (!(Test-Path -Path $PROFILE)) {
    New-Item -ItemType File -Path $PROFILE -Force
}

# プロファイルをエディタで開く
notepad $PROFILE
```

**手順2: プロキシ設定を追加**

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

#### 1.4 フォント設定

プログラミングに最適化されたNerd Fontsをインストールします。

##### 1.4.1 Nerd Fontsのインストール

PowerShell 7+で以下を実行：

```powershell
# CascadiaCode Nerd Fontをインストール
oh-my-posh font install CascadiaCode

# Meslo Nerd Fontをインストール
oh-my-posh font install Meslo
```

##### 1.4.2 Windows Terminalでフォントを設定

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

##### 1.4.3 VSCodeでフォントを設定

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

#### 1.5 ターミナル環境のカスタマイズ（Oh My Posh）

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

#### 1.6 Gitの設定

PowerShell 7+またはBashで以下を実行：

```bash
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
git config --global core.editor "code --wait"
```

#### 1.7 VSCode拡張機能のインストール

VSCodeを開き、以下の拡張機能をインストールします：

- **Dev Containers** (`ms-vscode-remote.remote-containers`)

または、コマンドラインから：

```bash
code --install-extension ms-vscode-remote.remote-containers
```

### 2. WSL2のセットアップ

#### 2.1 WSL2のインストール

管理者権限のPowerShellで以下のコマンドを実行します：

```powershell
wsl --install
```

インストール後、システムを再起動します。

#### 2.2 Ubuntuの初期設定

WSLを起動し、ユーザー名とパスワードを設定します。

#### 2.3 パッケージの更新

```bash
sudo apt-get update
sudo apt-get upgrade -y
```

#### 2.4 Sudoのパスワード不要化

```bash
sudo visudo
```

以下の行を追加します：

```text
your_username ALL=(ALL) NOPASSWD:ALL
```

#### 2.5 Dockerのインストール

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

#### 2.6 Dockerの動作確認

```bash
docker --version
docker run hello-world
```

#### 2.7 [OPTION] WSLのプロキシ設定（企業ネットワーク等で必要な場合）

プロキシ環境下でWSLを使用する場合、`~/.bashrc` に以下を追加します：

**手順1: .bashrcを編集**

```bash
nano ~/.bashrc
```

**手順2: プロキシ設定を追加**

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

**手順3: 設定を反映**

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

#### 2.8 [OPTION] Dockerのプロキシ設定（企業ネットワーク等で必要な場合）

##### 2.8.1 Docker Daemonのプロキシ設定

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

##### 2.8.2 Docker Clientのプロキシ設定（docker buildコマンド用）

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

### 3. このテンプレートの使用

#### 3.1 リポジトリのクローン

```bash
git clone https://github.com/your-username/devbox.git
cd devbox
```

または、GitHubでこのリポジトリを「Use this template」ボタンでテンプレートとして使用します。

#### 3.2 Dev Containerで開く

1. VSCodeでクローンしたディレクトリを開く
2. コマンドパレット（`Ctrl+Shift+P`）を開く
3. `Dev Containers: Reopen in Container`を選択
4. コンテナのビルドと起動を待つ（初回は時間がかかります）

#### 3.3 環境変数の設定（必要に応じて）

`.devcontainer/devcontainer.env`ファイルを編集して、プロジェクト固有の環境変数を設定します。

### 4. 認証設定（初回セットアップ時に実施）

各種ツールの認証を行います。認証情報はホストと共有されるため、
一度設定すれば複数のdevboxプロジェクトで使い回せます。

**重要**: Claude CodeとCodex CLIは、Dev Containerを起動する**前に**ホストで認証することを推奨します。

#### 4.1 AWS CLIの認証

AWS CLIを使用する場合は、以下の手順で認証します。

**重要**: bind mountが有効な場合、マウント元ディレクトリが存在しないとDev Containerの起動に失敗します。
認証前に必ずディレクトリを作成してください。

##### 手順1: 認証ディレクトリの作成

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

##### 手順2: ホスト（WindowsまたはWSL）で認証

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

##### 手順3: Dev Containerで認証情報を有効化

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

##### AWS Access Keyの取得方法

1. [AWS Management Console](https://console.aws.amazon.com/)にログイン
2. IAM → ユーザー → セキュリティ認証情報
3. アクセスキーを作成

#### 4.2 Azure CLIの認証

Azure CLIを使用する場合は、以下の手順で認証します。

**重要**: bind mountが有効な場合、マウント元ディレクトリが存在しないとDev Containerの起動に失敗します。
認証前に必ずディレクトリを作成してください。

##### 手順1: 認証ディレクトリの作成

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

##### 手順2: ホスト（WindowsまたはWSL）で認証

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

##### 手順3: Dev Containerで認証情報を有効化

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

#### 4.3 Claude Codeの認証

Claude Codeは**Windowsでのインストールを推奨**します（2025年にネイティブ対応）。

##### 手順1: Windowsで Claude Codeをインストール

**PowerShell 7+** を管理者権限で開き、以下を実行：

```powershell
winget install Anthropic.ClaudeCode
```

インストール後、PowerShellまたはコマンドプロンプトで `claude-code` コマンドが使用可能になります。

##### 手順2: Windowsで認証

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

##### 手順3: WSLへシンボリックリンクを作成

WSLからもWindows の認証情報を使用したい場合、シンボリックリンクを作成します：

```bash
# WSL内で実行
# ユーザー名を実際のWindowsユーザー名に置き換える
ln -s /mnt/c/Users/YOUR_USERNAME/.claude ~/.claude
```

##### 手順4: Dev Container内で認証を確認

Dev Container起動後、ターミナルで以下を実行：

```bash
claude-code auth status
```

認証情報はbind mountで自動的に共有されます。

**注意事項：**

- 環境変数 `ANTHROPIC_API_KEY` が設定されている場合、サブスクリプションより優先されます
- API Key使用時はAPI使用料金が発生します

#### 4.4 Codex CLIの認証

Codex CLIは**WSLでのインストールを推奨**します（Windows版は実験的）。

##### 手順1: WSLで Codex CLIをインストール

WSLで以下を実行：

```bash
npm install -g @openai/codex
```

インストール後、`codex` コマンドが使用可能になります。

##### 手順2: WSLで認証

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

##### 手順3: Windowsへシンボリックリンクを作成

WindowsからもWSLの認証情報を使用したい場合、シンボリックリンクを作成します：

**PowerShell 7+** を管理者権限で開き、以下を実行：

```powershell
# ユーザー名を実際のWSLユーザー名に置き換える
cmd /c mklink /D "$env:USERPROFILE\.codex" "\\wsl$\Ubuntu\home\YOUR_WSL_USERNAME\.codex"
```

**注意**: WSLディストリビューションが`Ubuntu`でない場合は、適切な名前に置き換えてください
（例: `\\wsl$\Ubuntu-22.04\...`）。

##### 手順4: Dev Container内で認証を確認

Dev Container起動後、ターミナルで以下を実行：

```bash
codex auth status
```

認証情報はbind mountで自動的に共有されます。

#### 4.5 認証情報の共有について

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

## 📦 インストール済みツール

### 💻 開発言語・ランタイム

- **Node.js** 22.16.0
- **Python** 3.12
- **Zsh** (Oh My Zshとプラグイン付き)

### 📥 パッケージマネージャー

- **npm** (latest)
- **yarn** (latest)
- **pnpm** (latest)
- **uv** (Python)

### ☁️ クラウド・インフラツール

- **AWS CLI**
- **Azure CLI**
- **Terraform** (latest)
- **Docker** (Docker-in-Docker)

### 🔍 コード品質・開発ツール

- **Biome** 2.2.5 (Linter/Formatter)
- **git-cz** (Conventional Commits)
- **npm-check-updates** (依存関係の更新)
- **pre-commit** (Pythonコードフック)

### 🤖 AIコーディングエージェント

- **Claude Code** (`@anthropic-ai/claude-code`)
- **Codex** (`@openai/codex`)
- **Cline** (VSCode拡張)

### 🛠️ その他ユーティリティ

- **curl**
- **ca-certificates**
- **gnupg2**
- **vim**
- **jq**
- **Git**

## 📂 プロジェクト構成

```text
devbox/
├── .devcontainer/
│   ├── devcontainer.json          # Dev Container設定
│   ├── devcontainer.env           # 環境変数
│   ├── postCreate.sh              # コンテナ作成後スクリプト
│   ├── postStart.sh               # コンテナ起動後スクリプト
│   └── features/
│       └── npm/                   # カスタムnpm feature
├── .vscode/
│   └── settings.json              # VSCode設定
├── .markdownlint.json             # Markdownlint設定
├── README.md                      # このファイル
├── CLAUDE.md                      # AI駆動開発ガイドライン
├── LICENSE                        # ライセンス
├── biome.jsonc                    # Biome設定
└── changelog.config.js            # Changelogの設定
```

## ⚙️ カスタマイズ

### Dev Containerの設定変更

`.devcontainer/devcontainer.json`を編集して、必要なツールや拡張機能を追加できます。

### VSCode拡張機能の追加

`.devcontainer/devcontainer.json`の`customizations.vscode.extensions`配列に拡張機能IDを追加します。

### パッケージのキャッシュ

以下のディレクトリはDocker volumeとしてキャッシュされ、コンテナの再構築時に保持されます：

- `app/node_modules`
- `api/.venv`
- Serena MCPサーバのインデックス

以下のディレクトリはbind mountでホストと共有され、複数のdevboxプロジェクトで使い回せます：

- `~/.claude/` (Claude Code認証情報)
- `~/.codex/` (Codex認証情報)
- `~/.aws/` (AWS CLI認証情報、有効化が必要)
- `~/.azure/` (Azure CLI認証情報、有効化が必要)

## 🐛 トラブルシューティング

### WSLでDockerが起動しない

```bash
sudo service docker start
```

### Dev Containerのビルドが失敗する

1. Dockerが正しく動作しているか確認
2. `.devcontainer/devcontainer.json`の設定を確認
3. キャッシュをクリアして再ビルド：`Dev Containers: Rebuild Container`

### パッケージのインストールが遅い

初回ビルド時は時間がかかります。2回目以降はボリュームキャッシュにより高速化されます。

### プロキシ環境でインストールが失敗する

1. Windows、WSL、Dockerのすべてでプロキシ設定が正しく行われているか確認
2. `.devcontainer/devcontainer.env`にプロキシ設定が追加されているか確認
3. `NO_PROXY`設定に必要なドメインが含まれているか確認

### Claude Code/Codexの認証が失敗する

1. `/status`コマンドで現在の認証状態を確認
2. 環境変数 `ANTHROPIC_API_KEY` または `OPENAI_API_KEY` が意図せず設定されていないか確認
3. `~/.claude/` または `~/.codex/` ディレクトリの権限を確認
4. 再度 `codex login` または Claude Codeの認証を実行

## 📄 ライセンス

このプロジェクトのライセンスについては[LICENSE](LICENSE)ファイルを参照してください。

## 🔗 参考リンク

- [Dev Containers公式ドキュメント](https://code.visualstudio.com/docs/devcontainers/containers)
- [WSL公式ドキュメント](https://learn.microsoft.com/ja-jp/windows/wsl/)
- [Docker公式ドキュメント](https://docs.docker.com/)
- [Claude Code公式ドキュメント](https://docs.claude.com/en/docs/claude-code)
- [OpenAI Codex公式ドキュメント](https://developers.openai.com/codex)
