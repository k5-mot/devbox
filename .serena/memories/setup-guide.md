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

## 1. Windows環境のセットアップ

### 1.1. PowerShell 7+をwingetでインストールする

本ドキュメントでは **PowerShell 7+** を使用するため、最初にインストールします。

- **Windows PowerShell 5.1**: Windows 11にプリインストールされている古いバージョン
- **PowerShell 7+**: 本手順でインストールする最新版

```powershell
winget install Microsoft.PowerShell  # PowerShell 7+ (最新版)
```

### 1.2. 開発ツールをwingetでインストールする

**PowerShell 7+** を**管理者権限**で開き、以下のコマンドでツールを一括インストールします。

```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser -Force

winget install `
  Git.Git `
  TortoiseGit.TortoiseGit `
  Microsoft.VisualStudioCode `
  Microsoft.WindowsTerminal `
  Amazon.AWSCLI `
  Microsoft.AzureCLI `
  jqlang.jq `
  NickeManarin.ScreenToGif  `
  JanDeDobbeleer.OhMyPosh `
  JGraph.Draw
```

### 1.3 PowerShellプロファイルをカスタマイズする

#### 1.3.1. PowerShellプロファイルを開く

**PowerShell 7+** を**管理者権限**で開き、以下のコマンドを実行します。

```powershell
# プロファイルファイルが存在しない場合は作成
if (!(Test-Path -Path $PROFILE)) {
    New-Item -ItemType File -Path $PROFILE -Force
}

# プロファイルをエディタで開く
notepad $PROFILE
```

##### 1.3.2. PowerShellプロファイルに設定を追加する

以下の内容をプロファイルファイルに追加します。

```powershell
### [REQUIRED] Oh-My-Posh
if (Get-Command -Name "oh-my-posh" -ErrorAction SilentlyContinue) {
    oh-my-posh init pwsh --config "jandedobbeleer" | Invoke-Expression
}

### [OPTIONAL] Proxy
$env:PROXY_ADDRESS = "http://proxy.example.com:8080"
$env:HTTP_PROXY = $env:PROXY_ADDRESS
$env:HTTPS_PROXY = $env:PROXY_ADDRESS
$env:NO_PROXY = "localhost,127.0.0.1,127.0.0.0/8,::1"
$env:http_proxy = $env:HTTP_PROXY
$env:https_proxy = $env:HTTPS_PROXY
$env:no_proxy = $env:NO_PROXY
```

保存後、**PowerShell 7+**を再起動する。

> [!note]
> NO_PROXYの設定値は、CIDR表記に対応していないツール(wget,...)と対応しているツール(curl,Python,...)の両方で正しく動作するように以下のように設定します。
> - `localhost`: ローカルホスト名
> - `127.0.0.1`: IPv4ループバックアドレス (CIDR非対応ツール用)
> - `127.0.0.0/8`: IPv4ループバック範囲全体 (CIDR対応ツール用)
> - `::1`: IPv6ループバックアドレス
> - `10.0.0.0/8`: プライベートネットワーク (Class A)
> - `172.16.0.0/12`: プライベートネットワーク (Class B)
> - `192.168.0.0/16`: プライベートネットワーク (Class C)

> [!tip]
> `oh-my-posh init pwsh --config "<color-theme>" | Invoke-Expression`
> oh-my-poshのカラーテーマは変更可能です。
> [Themes | Oh My Posh](https://ohmyposh.dev/docs/themes)

### 1.4. Nerd Fontsをインストールする

**PowerShell 7+** を開き、以下のコマンドを実行します。

```powershell
# Meslo Nerd Fontをインストール
oh-my-posh font install meslo

# CascadiaCode Nerd Fontをインストール
oh-my-posh font install CascadiaCode
```

#### 1.5. Windows Terminalでフォントを設定

1. Windows Terminalを開く
2. 設定(`Ctrl+,`)を開く
3. 左側メニューから「既定値」を選択する
4. 「外観」セクションで「フォントフェイス」を `CaskaydiaCove Nerd Font` に変更する
5. 「保存」する

または、設定ファイル(`settings.json`)を直接編集：

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

### 1.5. Gitの設定

**PowerShell 7+** を開き、以下のコマンドを実行します。

```bash
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
```

### 1.6 AWS CLIとAzure CLIの設定

#### 1.6.1. ディレクトリのセットアップ

```powershell
New-Item "$env:USERPROFILE\.aws"    -ItemType Directory -ErrorAction SilentlyContinue
New-Item "$env:USERPROFILE\.azure"  -ItemType Directory -ErrorAction SilentlyContinue
New-Item "$env:USERPROFILE\.claude" -ItemType Directory -ErrorAction SilentlyContinue
New-Item "$env:USERPROFILE\.codex"  -ItemType Directory -ErrorAction SilentlyContinue
```

#### 1.6.2. AWS CLIの設定

```powershell
aws configure
```

```powershell
AWS Access Key ID [None]: YOUR_ACCESS_KEY_ID
AWS Secret Access Key [None]: YOUR_SECRET_ACCESS_KEY
Default region name [None]: ap-northeast-1
Default output format [None]: json
```

#### 1.6.3. Azure CLIの設定

```powershell
az login
```

### 1.6.4. Anthropic Claude Codeの設定

```bash
claude
```

または、設定ファイル(`$env:USERPROFILE/.claude/settings.json`)を直接編集する。

```json
# TBM
```

### 1.6.5. OpenAI Codex CLIの設定

```bash
codex
```

または、設定ファイル(`$env:USERPROFILE/.codex/config.toml`)を直接編集する。

```toml
# TBM
```

### 1.7. VSCodeをセットアップ

#### 1.7.1. 拡張機能のインストール

VSCodeを開き、以下の拡張機能をインストールします：

- **Dev Containers** (`ms-vscode-remote.remote-containers`)

または、コマンドラインから：

```powershell
code --install-extension ms-vscode-remote.remote-containers
```

#### 1.7.2. VSCodeを設定

1. VSCodeを開く
2. 設定 (`Ctrl+,`)を開く
3. `Editor: Font Family` を検索
4. 以下を先頭に追加：

```text
'CaskaydiaCove Nerd Font', 'MesloLGM Nerd Font', Consolas, 'Courier New', monospace
```

または、設定ファイル (`settings.json`)を直接編集：

```json
{
    "editor.fontFamily": "'CaskaydiaCove Nerd Font', 'MesloLGM Nerd Font', Consolas, 'Courier New', monospace",
    "editor.fontLigatures": true,
    "dev.containers.executeInWSL": true,
    "chatgpt.preferWsl": true
}
```

> [!note]
> "dev.containers.executeInWSL": true
> 上記設定をすることで、Dev ContainersがWSL内で実行されます。
> 上記設定をしないと、Docker Desktopで実行されます。

> [!note]
> "chatgpt.preferWsl": true
> 上記設定をすることで、ChatGPTがWSL内で実行されます。
> - [Running Codex on Windows](https://developers.openai.com/codex/windows/)


## 2. WSL2のセットアップ

### 2.1. WSL2のインストール

**PowerShell 7+** を**管理者権限**で開き、以下のコマンドを実行します。

```powershell
wsl --install
ダウンロードしています: Ubuntu
インストールしています: Ubuntu
ディストリビューションが正常にインストールされました。'wsl.exe -d Ubuntu' を使用して起動できます
```

インストール後、システムを再起動します。

### 2.2. Ubuntuの初期設定

WSLを起動し、ユーザー名とパスワードを設定します。

```bash
Ubuntu を起動しています...
Provisioning the new WSL instance Ubuntu
This might take a while...
Create a default Unix user account: username
New password:
Retype new password:
passwd: password updated successfully
To run a command as administrator (user "root"), use "sudo <command>".
See "man sudo_root" for details.

username@hostname:/mnt/c/Users/username$
```

### 2.3. [OPTION] WSLのプロキシ設定（企業ネットワーク等で必要な場合）

プロキシ環境下でWSLを使用する場合、`~/.bashrc` に以下を追加します。

> [!note]
> 設定内容自体は、[1.3. [OPTION] プロキシ設定](#13-option-プロキシ設定企業ネットワーク等で必要な場合)と同様です。

#### 2.3.1. `~/.bashrc`にプロキシ設定を追加

**WSL** を開き、以下のコマンドを実行します。

```bash
nano ~/.bashrc
```

ファイルの最後に以下を追加する。

```bash
# プロキシ設定
export HTTP_PROXY="http://proxy.example.com:8080"
export HTTPS_PROXY="http://proxy.example.com:8080"
export NO_PROXY="localhost,127.0.0.1,127.0.0.0/8,::1,10.0.0.0/8,172.16.0.0/12,192.168.0.0/16"
export http_proxy="$HTTP_PROXY"
export https_proxy="$HTTPS_PROXY"
export no_proxy="$NO_PROXY"
```

プロキシ設定を反映するため、以下のコマンドを実行します。

```bash
source ~/.bashrc
```

#### 2.3.2. aptのプロキシ設定

**WSL** を開き、以下のコマンドを実行する。

```bash
sudo nano /etc/apt/apt.conf
```

以下の内容を末尾に追加する。

```text
Acquire::http::Proxy "http://proxy.example.com:8080";
Acquire::https::Proxy "http://proxy.example.com:8080";
```


### 2.4. Sudoのパスワード不要化

**WSL** を開き、以下のコマンドを実行します。

```bash
sudo visudo
```

以下の行を追加します。
- `<your_username>` はWSLのユーザー名に置き換えてください。

```text
<your_username> ALL=(ALL:ALL) NOPASSWD:ALL
```

### 2.5. パッケージの更新と必要なパッケージのインストール

**WSL** を開き、以下のコマンドを実行します。

```bash
sudo apt-get update
sudo apt-get install -y ca-certificates curl gnupg
sudo apt-get install -y --no-install-recommends unzip git wget python3-venv
sudo apt-get upgrade -y
sudo apt-get autoremove -y
sudo apt-get clean
```

## 2.6. miseとAWS CLIとAzure CLIのセットアップ

### 2.6.1. miseと各種ツールのインストール

**WSL** を開き、以下のコマンドを実行します。

```bash
curl https://mise.run/bash | sh
echo "eval \"\$(/home/merry/.local/bin/mise activate bash)\"" >> ~/.bashrc
source ~/.bashrc
mise use --global node@24 python@3.14 aws-cli@latest azure@latest
npm install -g npm @anthropic-ai/claude-code @openai/codex
```

### 2.6.2. AWS CLIの設定

**WSL** を開き、以下のコマンドを実行し、Windows側の認証情報をシンボリックリンクで共有する。
- `<username>` はWindowsのユーザー名に置き換えてください。

```bash
export WIN_USERNAME="$(powershell.exe -Command 'echo $env:UserName' | tr -d '\r')"
[ -L "$HOME/.aws" ] && rm -rfv "$HOME/.aws"
ln -sv "/mnt/c/Users/$WIN_USERNAME/.aws" "$HOME/.aws"
```

### 2.6.3. Azure CLIの設定

```bash
[ -L "$HOME/.azure" ] && rm -rfv "$HOME/.azure"
ln -sv "/mnt/c/Users/$WIN_USERNAME/.azure" "$HOME/.azure"
```

### 2.6.4. Anthropic Claude Codeの設定

```bash
npm install -g @anthropic-ai/claude-code
[ -L "$HOME/.claude" ] && rm -rfv "$HOME/.claude"
ln -sv "/mnt/c/Users/$WIN_USERNAME/.claude" "$HOME/.claude"

```

### 2.6.5. OpenAI Codex CLIの設定

```bash
npm install -g @openai/codex
[ -L "$HOME/.codex" ] && rm -rfv "$HOME/.codex"
ln -sv "/mnt/c/Users/$WIN_USERNAME/.codex" "$HOME/.codex"
```

## 3. Dockerのセットアップ

### 3.1. Dockerのインストール

> [!NOTE]
> 詳細な手順は、[Install Docker Engine on Ubuntu](https://docs.docker.com/engine/install/ubuntu/)を参照。

**WSL** を開き、以下のコマンドを実行し、Dockerをaptソースに追加する。

```bash
# 競合するすべてのパッケージをアンインストールする
for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do sudo apt-get remove $pkg; done

# 必要なパッケージをインストールする
sudo apt-get update
sudo apt-get install -y ca-certificates curl

# Dockerの公式GPGキーを追加する
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Dockerリポジトリをaptソースに追加する
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
```

Dockerをインストールする。

```bash
# Dockerパッケージをインストールする
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo usermod -aG docker $USER

```

Dockerを動作確認する。

```bash
# Dockerサービスを起動し、ステータスを確認する
sudo systemctl start docker
sudo systemctl status docker

# Dockerの動作確認
docker --version
sudo docker run hello-world

# ユーザーをdockerグループに追加
sudo usermod -aG docker $USER
```

### 3.2. [OPTION] Dockerのプロキシ設定（企業ネットワーク等で必要な場合）

#### 3.2.1. Docker Daemonのプロキシ設定

**WSL** を開き、以下のコマンドを実行し、以下のディレクトリとファイルを作成する。

```bash
sudo mkdir -p /etc/systemd/system/docker.service.d
sudo nano /etc/systemd/system/docker.service.d/http-proxy.conf
```

以下の内容を追加する。

> [!note]
> 設定内容自体は、[1.3. [OPTION] プロキシ設定](#13-option-プロキシ設定企業ネットワーク等で必要な場合)と同様です。

```ini
[Service]
Environment="HTTP_PROXY=http://proxy.example.com:8080"
Environment="HTTPS_PROXY=http://proxy.example.com:8080"
Environment="NO_PROXY=localhost,127.0.0.1,127.0.0.0/8,::1,10.0.0.0/8,172.16.0.0/12,192.168.0.0/16"
```

Dockerサービスを再起動する。

```bash
sudo systemctl daemon-reload
sudo service docker restart
```

> [!tip]
> Docker Daemonのプロキシ設定は、主に`docker pull`や`docker run`コマンドなどで使用される。
> - [Daemon proxy configuration](https://docs.docker.com/engine/daemon/proxy/)

#### 3.2.2. Docker Clientのプロキシ設定

**WSL** を開き、以下のコマンドを実行し、以下のディレクトリとファイルを作成する。

```bash
mkdir -p ~/.docker
nano ~/.docker/config.json
```

以下の内容を追加する。

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

> [!tip]
> Docker Clientのプロキシ設定は、主に`docker build`コマンドなどで使用される。
> - [Use a proxy server with the Docker CLI](https://docs.docker.com/engine/cli/proxy/)

## 4. devcontainersのセットアップ

### 4.1. リポジトリのクローン

**PowerShell 7+** を開き、以下のコマンドを実行します。

```powershell
New-Item "$env:USERPROFILE\repos" -ItemType Directory -ErrorAction SilentlyContinue
cd "$env:USERPROFILE\repos"
git clone https://github.com/k5-mot/devbox.git
cd devbox
```

### 4.2. Dev Containerで開く

1. VSCodeでクローンしたディレクトリを開く
2. コマンドパレット(`Ctrl+Shift+P`)を開く
3. `Dev Containers: Reopen in Container`を選択
4. コンテナのビルドと起動を待つ(初回は時間がかかります)

```bash
aws sts get-caller-identity
```
