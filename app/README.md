# ⚛️ Frontend Guide

このディレクトリはフロントエンド (Vite + React + TypeScript) のソースを格納しています。ここには開発・ビルド・lint に関する手順と主要ファイルの説明をまとめています。

## 🧩 Tech Stack

| Category | Technology | Description |
|---|---|---|
| Language | TypeScript | プログラミング言語 |
| Runtime | Node.js 22.16.0 | JavaScript ランタイム |
| Package | pnpm | パッケージマネージャ (推奨) |
| Package | npm | パッケージマネージャ (代替) |
| Package | yarn | パッケージマネージャ (代替) |
| Build | Vite | フロントエンドビルドツール |
| Framework | React | UI ライブラリ |
| Linter | Biome | コード整形・静的解析 |

## 📝 Notes

- パッケージマネージャは `pnpm` を想定していますが、`npm` や `yarn` でも動作します。
- Node.js のバージョンは 22.16.0 を使用しています。

## Install (依存関係インストール)

pnpm を使う場合:

```bash
cd app
pnpm install
```

npm を使う場合:

```bash
cd app
npm install
```

## Development (開発サーバ起動)

開発モードを起動すると Vite の HMR が使えます:

```bash
cd app
pnpm run dev
# or
npm run dev
```

これによりホストを公開しているため、コンテナ内からでもブラウザでアクセスできます。

## Build / Preview

```bash
cd app
pnpm run build
pnpm run preview
# or
npm run build
npm run preview
```

## Lint / Format / Check

このプロジェクトは `biome` を使って lint/format/check を行います。devtools が入っている場合:

```bash
pnpm run lint
pnpm run format
pnpm run check
# or with npm
npm run lint
npm run format
npm run check
```

## Files (主要ファイルの説明)

- `package.json` - スクリプトと依存関係 (dev: `vite --host`, build: `tsc -b && vite build` など)
- `pnpm-lock.yaml` - pnpm のロックファイル
- `tsconfig.app.json`, `tsconfig.node.json`, `tsconfig.json` - TypeScript 設定
- `vite.config.ts` - Vite 設定 (プラグイン等)
- `src/` - アプリケーションソース (React コンポーネント等)
- `public/` - 静的アセット

## テスト

このテンプレートではテストフレームワークは含まれていません。必要に応じて `vitest` や `jest` を導入してください。

---

問題があれば、実際に使いたいパッケージマネージャや開発用スクリプト名を教えてください。README を調整します。
