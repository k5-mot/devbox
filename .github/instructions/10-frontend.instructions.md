---
applyTo: "frontend/**/*"
---

# フロントエンド開発ガイドライン

## 技術スタック

- **Vite v6.3.5**: 高速なビルドツール
- **React v19.1.0**: ユーザーインターフェースライブラリ
- **React DOM v19.1.0**: React DOM レンダリング
- **React Router DOM v7.6.2**: クライアントサイドルーティング
- **TypeScript v5.8.3**: 型安全性を提供する JavaScript のスーパーセット
- **Prettier v3.5.3**: コードフォーマッター
- **ESLint v9.29.0**: コード品質チェックツール
- **Panda CSS v0.54.0**: ゼロランタイム CSS-in-JS ライブラリ
- **Serendie Design System**: UI コンポーネントライブラリ
  - **@serendie/design-token v1.1.1**: デザイントークン
  - **@serendie/symbols v1.0.1**: アイコンライブラリ
  - **@serendie/ui v1.0.1**: UI コンポーネント
- **Mirotone v5**: Miro 公式デザインシステム
- **Miro WEB SDK**: Miro アプリケーション開発用 SDK (@mirohq/websdk-types)

## TypeScript 関連のベストプラクティス

### 関数型アプローチ (FP)

- 純粋関数を優先
- 不変データ構造を使用
- 副作用を分離
- 型安全性を確保

### プラクティス

- 小さく始めて段階的に拡張
- 過度な抽象化を避ける
- コードよりも型を重視

## フロントエンド構造

```
frontend/
└── src/
    ├── assets/      # 画像ファイルなどのリソース
    ├── components/  # 各ページで使用する大きめのUI要素
    ├── styles/      # Material UIのUI要素のカスタム要素
    ├── pages/       # ページコンポーネント
    ├── api/         # API関連のユーティリティ
    ├── util/        # 汎用ユーティリティ
    ├── App.tsx      # メインアプリケーションコンポーネント
    └── main.tsx     # エントリーポイント、ルーティング定義
```

## 開発ガイドライン

### コンポーネント設計

- 単一責任の原則に従う
- プロパティの型定義を明確にする
- 再利用可能なコンポーネントを作成する

### 状態管理

- ローカル状態は useState を使用
- 複雑な状態管理が必要な場合は useReducer を検討
- グローバル状態が必要な場合は適切なライブラリを選択

### スタイリング

- **Panda CSS**: ゼロランタイム CSS-in-JS ライブラリを使用
- **Serendie Design System**: UI コンポーネントライブラリを活用
- **Mirotone**: Miro 公式デザインシステムを使用
- コンポーネント固有のスタイルは適切に分離
- レスポンシブデザインを考慮

### Miro WEB SDK

- Miro API との連携は SDK を通じて行う
- 適切なエラーハンドリングを実装
- SDK のベストプラクティスに従う
