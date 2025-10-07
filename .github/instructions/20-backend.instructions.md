---
applyTo: "backend/**/*"
---

# バックエンド開発ガイドライン

## 技術スタック

- **Python 3.12+**: メインプログラミング言語
- **uv**: 高速な Python パッケージマネージャー
- **FastAPI v0.115.12**: 高性能な Web フレームワーク
- **Uvicorn v0.34.2**: ASGI サーバー
- **Pydantic v2.11.4**: データ検証とシリアライゼーション
- **Pydantic Settings v2.9.1**: 設定管理
- **LangChain v0.3.25**: LLM アプリケーション開発フレームワーク
  - **LangChain Core v0.3.65**: コア機能
  - **LangChain Community v0.3.25**: コミュニティ拡張
  - **LangChain AWS v0.2.25**: AWS 統合
  - **LangChain OpenAI v0.3.23**: OpenAI 統合
  - **LangChain Google GenAI v2.0.10**: Google AI 統合
- **Miro REST API v2.2.4**: Miro サービスとの連携用 Python クライアント
- **AI/LLM プロバイダー**:
  - **AWS Boto3 v1.38.36**: AWS Bedrock 連携
  - **Google Generative AI v0.8.5**: Google AI 連携
- **ユーティリティ**:
  - **HTTPX v0.28.1**: 非同期 HTTP クライアント
  - **Requests v2.32.3**: HTTP ライブラリ
- **開発ツール**:
  - **Ruff v0.11.10**: 高速な Python リンター・フォーマッター
  - **Pyright v1.1.400**: 型チェッカー
  - **pytest v8.3.5**: テストフレームワーク

## バックエンド構造

```
backend/
├── main.py                     # FastAPIのエントリーポイント、ルーティング
├── pyproject.toml              # Pythonプロジェクト設定とパッケージ依存関係
├── requirements.txt            # pip用依存関係リスト
├── uv.lock                     # uvパッケージマネージャーのロックファイル
├── db/                         # データベースファイル
│   ├── session.json            # セッション管理用JSON
│   └── user_sessions.sqlite3   # ユーザーセッション管理用SQLite DB
├── log/                        # ログファイル
│   └── app.log                 # アプリケーションログ
└── package/                    # メインパッケージ
    ├── api/                    # APIエンドポイント
    │   ├── oauth.py            # OAuth認証処理
    │   ├── users.py            # ユーザー管理API
    │   ├── group.py            # グループ機能API
    │   ├── task.py             # タスク機能API
    │   └── sticky_note.py      # 付箋機能API
    ├── chain/                  # LangChainのLLMチェイン
    │   ├── base.py             # 基底チェインクラス
    │   ├── extract_tasks.py    # タスク抽出チェイン
    │   ├── group_sticky_notes.py # 付箋グルーピングチェイン
    │   └── random_sticky_notes.py # ランダム付箋生成チェイン
    ├── common/                 # 共通ユーティリティ
    │   ├── logger.py           # ログ設定
    │   └── settings.py         # アプリケーション設定
    ├── db/                     # データベース関連
    │   ├── session.py          # セッション管理
    │   └── sqlite_storage.py   # SQLiteストレージ操作
    └── util/                   # その他ユーティリティ
        └── miro/               # Miro API関連ユーティリティ
```

## 開発ガイドライン

### FastAPI

- RESTful な API 設計を心がける
- 適切な HTTP ステータスコードを使用
- Pydantic モデルを使用したデータ検証
- OpenAPI 仕様書の自動生成を活用
- 非同期処理（async/await）を適切に使用

### LangChain

- チェインの設計は目的ごとに分離
- プロンプトテンプレートの管理を適切に行う
- LLM の応答に対する適切なエラーハンドリング
- メモリ使用量を考慮した実装

### データベース

- SQLite を使用したローカルストレージ
- 適切なデータモデリング
- セッション管理の実装
- データの整合性を保つ

### Miro REST API

- 適切な認証フローの実装
- レート制限を考慮した API 呼び出し
- エラーレスポンスの適切な処理
- OAuth2 フローの実装

### セキュリティ

- 環境変数を使用した設定管理
- API キーやトークンの安全な管理
- 入力値検証の徹底
- 適切な CORS 設定

### ログ管理

- 構造化ログの使用
- 適切なログレベルの設定
- エラー追跡のための詳細ログ
- 機密情報のログ出力を避ける
