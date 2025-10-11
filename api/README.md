# 🐍 Backend Guide

このディレクトリは Python ベースのバックエンド API を格納しています。
ここでは環境構築、依存関係のインストール、開発サーバの起動方法を説明します。

## 🧩 Tech Stack

| Category | Technology | Description |
|---|---|---|
| Language | Python 3.12 | プログラミング言語 |
| Package | uv | パッケージマネージャ (推奨) |
| Package | pip | パッケージマネージャ (代替) |
| Framework | FastAPI | Web API フレームワーク |
| Server | uvicorn | ASGI サーバ |
| Validation | Pydantic | データバリデーション |
| Linter | Ruff | コード整形・静的解析 |
| Quality | pre-commit | Git フック管理 |

## 📝 Requirements

- Python 3.12 以上を推奨 (pyproject.toml の `requires-python` に準拠)
- 仮想環境の利用を推奨します

## Setup (初期セットアップ)

1. 仮想環境を作成して有効化します:

```bash
cd api
python -m venv .venv
source .venv/bin/activate
```

2. 依存関係をインストールします（pyproject.toml を使用）:

```bash
pip install -e .
# または開発依存を含める場合
pip install -e .[dev]
```

`pyproject.toml` に主要な依存が定義されています（例: FastAPI, uvicorn, pydantic, langchain など）。

## Development (開発サーバ起動)

一般的には `uvicorn` を使ってアプリを起動します。エントリポイントはプロジェクトによって異なるため、ここでは一般的な例を示します。実際のアプリケーションのエントリポイントが `main:app` の場合:

```bash
uvicorn main:app --reload --port 8000
```

もしエントリポイントが別の名前やモジュールにある場合はそれに合わせてください。

または簡易実行スクリプトがある場合はそれを利用してください。ルートの `main.py` は開発用の簡易ランナーが含まれている可能性があります。

## Lint / Type Check / Test

開発依存グループに `pyright`, `ruff`, `pytest` などが設定されています。導入後は次のように利用できます:

```bash
# ruff を使った lint
ruff check .

# pyright による型チェック
pyright

# pytest によるテスト実行
pytest
```

## Files (主要ファイルの説明)

- `pyproject.toml` - プロジェクト設定と依存関係
- `main.py` - 簡易ランナーやテスト用のエントリ (現在はサンプルの print 関数が含まれている)
- `README.md` - このファイル

## Notes

- 本 README の起動コマンドは一般的な例です。実際のエントリポイントや起動オプションはソースを参照して合わせてください。
- 環境変数やシークレットは `.env` 等で管理し、リポジトリにハードコードしないでください。

---

不明点や、実際のアプリケーションのエントリポイント（例: `app.main:app` など）が分かれば、それに合わせて起動例を修正して README を更新します。
