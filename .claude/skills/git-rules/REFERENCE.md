# Git 運用リファレンス

このファイルはこのリポジトリで採用する Git / PR 運用ルールを明文化したものです。

---

## 1. 目的と適用範囲
- 目的: ブランチ運用、Issue/PR の流れ、コミット規約、リリース手順を統一し、品質と可観測性を高める。
- 適用範囲: このリポジトリ内のすべての開発作業（例外は PR にて合意）。

---

## 2. 開発フロー（全体の流れ）
以下は日常的に実行する「Issue→ブランチ→コミット→PR→レビュー→rebase→マージ→リリース」までの通し手順です。

1. Issue の起票（必要に応じて）
   - 新機能、バグ、改善提案、設計方針などは Issue を立てて議論します。小さな修正は PR で直接対応可能。
2. ブランチの作成
   - `main` を最新化してからトピックブランチを作成します（例: `git checkout main && git pull --rebase origin main && git checkout -b feature/123-add-login`）。Issue に紐づける場合は番号を含めることを推奨します。
3. 実装とコミット
   - 小さな単位でコミットし、コミットメッセージは Conventional Commits を適用します。
4. リモートへ push と PR の作成
   - 作業を push して PR を作成。PR 本文に `何を / なぜ / 影響範囲 / テスト手順 / 関連 Issue` を明記します。
5. レビューと CI
   - コミッター以外の承認者によるレビューを受け、必要な変更を行います。CI がある場合は全チェック通過を確認します。
6. マージ前の最終調整
   - マージ前に `git pull --rebase origin main` を行い、fast-forward が可能な状態にします（競合があれば解消し、動作確認）。
7. マージとブランチ削除
   - Fast-Forward（または Squash）でマージし、PR に `Closes #<issue>` を含めていれば Issue は自動で閉じられます。マージ後は作業ブランチを削除します。
8. リリースとタグ付け
   - 必要に応じて SemVer に従ってタグ付けし、リリースノートを作成します。

---

## 3. ブランチ戦略と命名
- 採用: GitHub Flow をベースに、**`main` と短いトピックブランチ名**（短く分かりやすい）を使用します。`develop` や `release` ブランチは使用しません。
- 命名例:
  - トピックブランチ: `increase-test-timeout`, `add-code-of-conduct`
  - Issue 紐付け: `feature/123-add-login`（Issue 番号を含めたい場合）
- チーム方針で `feature/` プレフィックスを必須にしても良いが、短く分かりやすい命名を優先してください。

---

## 4. Issue の運用
- Issue を作成する条件: 新機能、バグ、改善提案、設計上の判断を要する事項。軽微な修正は PR で対応可能。
- テンプレートとラベル: `.github/ISSUE_TEMPLATE` とラベル（例: `type:bug`, `type:feature`, `priority:high`, `status:triage`, `sprint:<n>`）を活用する。
- ライフサイクル: `triage` → `assign` → `in progress` → `review` → `done`。
- PR との連携: PR に `Closes #<issue>` を含めると自動で Issue を閉じる。コミットや PR に Issue 番号を明示してください。

---

## 5. Pull Request（PR）ルール
- 必須情報: 変更の要約 / 変更理由 / 影響範囲 / テスト手順 / 関連 Issue
- レビュー: コミッター以外の承認者が最低 1 名必要（プロジェクトで更に厳格化してよい）。
- CI: CI がある場合は必須チェック通過がマージ条件となります。

---

## 6. コミットメッセージ：Conventional Commits（詳細）
- 形式(必須):
  - `<type>(<scope>): <subject>`
- 拡張フォーマット（推奨）:
  - ```
    <type>(<scope>): <subject>

    <body>

    <footer>
    ```
- type の代表例: `feat`, `fix`, `chore`, `docs`, `style`, `refactor`, `perf`, `test`, `ci`, `build`
- subject のルール:
  - 命令形で一行に簡潔にまとめる（目安: 50 文字以内）
  - 先頭は小文字、末尾にピリオドを付けない
- body:
  - 詳細な説明、背景、影響範囲、回避策などを記述（必要時）
- footer:
  - 破壊的変更: `BREAKING CHANGE: <description>` を記載
  - Issue 参照: `Closes #123` / `Refs #123`
- 例:
  - `feat(auth): add JWT support`
  - `fix(api): handle null response in /user`
  - `docs: update CONTRIBUTING with branch rules`

---

## 7. 履歴書き換えと push の扱い（`--force-with-lease`）
- 原則: `git push --force` は禁止。個人ブランチで履歴整理（rebase/squash）する場合は `git push --force-with-lease` を使用し、**PR に注記してレビュー承認を得る**こと。
- 公開ブランチ上での force push は行わないこと。

---

## 8. 緊急対応（hotfix）の扱い（GitHub Flow と整合）
- 補足: GitHub Flow は hotfix を明文化していませんが、緊急修正が必要な場合は次の運用を推奨します。
  1. `hotfix/<short-desc>` のトピックブランチを作成する（必要なら Issue を作成）。
  2. 最小限の修正を行い、直ちに PR を作成してレビュー・CI を行う。
  3. 承認後 `main` にマージし、必要ならタグ付けしてリリースする。関連ブランチへ修正をバックポートすること。
- hotfix も通常の PR フロー（レビュー・CI）を基本にしつつ、迅速に対応すること。

---

## 9. タグ付け（リリース）と SemVer
- タグは SemVer に従う（例: `v1.2.3`）。
- プリリリースは `-rc.1` などを使用。
- タグは `main` に対して付与し、可能なら GPG 署名を推奨。

---

## 10. スクラムを踏まえた追加ルール
- スプリント内で完結する単位でブランチを管理し、原則スプリント終了までにマージまたはクローズする。
- ブランチ命名例（スクラム）: `feature/SPRINT<番号>-<ISSUE番号>-<短い説明>`（任意）。
- PR にスプリント番号やレビューチェックリストを含める。

---

## 11. エージェント（Copilot / Claude）向けの使い方
- エージェントは本ドキュメントに従い、助言とチェックリストを提示してください。自動でマージやブロックは行わないこと。

---

## 12. 更新手順
- ドキュメントを更新する場合は、PR に変更理由と影響範囲を明記してレビューを受けてください。

---

## 13. 参考資料
- GitHub Flow: https://docs.github.com/ja/get-started/using-github/github-flow
- Agent skills: https://docs.github.com/ja/copilot/concepts/agents/about-agent-skills
- Semantic Versioning: https://semver.org/
- Conventional Commits: https://www.conventionalcommits.org/

---