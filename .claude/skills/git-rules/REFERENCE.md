# Git 運用リファレンス

このファイルはこのリポジトリで採用する Git / PR 運用ルールを明文化したものです。

---

## 1. 目的
- 目的: ブランチ運用、Issue/PR の流れ、コミット規約、リリース手順を統一し、品質と可観測性を高める。
- 適用範囲: このリポジトリ内のすべての開発作業（例外は PR にて合意）。

---

## 2. 開発フロー

以下は、日常的に実行する開発フローの通し手順です。各ステップに CLI コマンドの例を示します。

### 2-1. GitHub Issue の起票
- GitHub CLI:

```bash
gh issue create \
--title "Short title" \
--body "Describe the problem or feature" \
--label "type:feature"
```

### 2-2. ブランチの作成

- 最新の main を取得:

```bash
git checkout main
git pull --rebase origin main
```

- ブランチ作成 (Issue と紐付ける場合):

```bash
git checkout -b feature/123-add-login
```

### 2-3. 実装とコミット
- ステージング:

```bash
git add <files>
```

- コミット:

```bash
git commit -m "feat(auth): add login endpoint"
```

- 履歴整理 (任意):

```bash
git rebase -i HEAD~<n>
```

### 2-4. リモートへ push と PR の作成
- push:

```bash
git push -u origin feature/123-add-login
```

- PR 作成 (CLI):

```bash
gh pr create \
--title "feat: add login" \
--body "What / Why / How to test / Closes #123" \
--base main \
--head feature/123-add-login
```

### 2-5. レビューと CI の確認
- レビュー承認 (レビュワー側):

```bash
gh pr review <PR_NUMBER> --approve --body "LGTM"
```

- CI 結果確認:

```bash
gh pr checks <PR_NUMBER>
```

または GitHub UI の Checks タブを参照

### 2-6. マージ前の最終調整
- rebase して main と同期:

```bash
git checkout feature/123-add-login
git pull --rebase origin main
```

- 競合を解消し、動作確認を行う
- rebase 後にリモートに反映する場合 (必要時):

```bash
git push --force-with-lease
```

- (注意) 履歴書き換え時は `git push --force-with-lease` または `git push --force-if-includes` を使用してください（詳細は 7. 履歴書き換えと push の扱い を参照）

### 2-7. マージとブランチ削除
- マージ (CLI 例):

```bash
gh pr merge <PR_NUMBER> --squash
# または
gh pr merge <PR_NUMBER> --merge
```

- ブランチ削除:

```bash
git push origin --delete feature/123-add-login
```

### 2-8. リリースとタグ付け
- main を取得:

```bash
git checkout main
git pull origin main
```

- タグ付け:

```bash
git tag -a v1.2.3 -m "release v1.2.3"
git push origin v1.2.3
```

---

## 3. ブランチ戦略と命名
- 採用: GitHub Flow をベースに、**`main` と短いトピックブランチ名** (短く分かりやすい) を使用します。`develop` や `release` ブランチは使用しません。
- 命名例:
  - トピックブランチ: `increase-test-timeout`, `add-code-of-conduct`
  - Issue 紐付け: `feature/123-add-login` (Issue 番号を含めたい場合)
- チーム方針で `feature/` プレフィックスを必須にしても良いが、短く分かりやすい命名を優先してください。

---

## 4. Issue の運用
- Issue を作成する条件: 新機能、バグ、改善提案、設計上の判断を要する事項。軽微な修正は PR で対応可能。
- テンプレートとラベル: `.github/ISSUE_TEMPLATE` とラベル（例: `type:bug`, `type:feature`, `priority:high`, `status:triage`, `sprint:<n>`）を活用する。
- ライフサイクル: `triage` → `assign` → `in progress` → `review` → `done`。
- PR との連携: PR に `Closes #<issue>` を含めると自動で Issue を閉じる。コミットや PR に Issue 番号を明示してください。

---

## 5. Pull Request (PR) ルール
- 必須情報: 変更の要約 / 変更理由 / 影響範囲 / テスト手順 / 関連 Issue
- レビュー: コミッター以外の承認者が最低 1 名必要 (プロジェクトで更に厳格化してよい)。
- CI: CI がある場合は必須チェック通過がマージ条件となります。

(参照) 詳しい CLI の流れは 2. 開発フロー にあるコマンド例を参照してください。

---

## 6. コミットメッセージ：Conventional Commits
- 形式(必須):
  - `<type>(<scope>): <subject>`
- 拡張フォーマット（推奨）:
  - ```
    <type>(<scope>): <subject>

    <body>

    <footer>
    ```
- type の代表例と意味:
  - `feat`: 新機能の追加
  - `fix`: バグ修正
  - `docs`: ドキュメントのみの変更
  - `style`: フォーマット等の構文的変更（機能に影響しない）
  - `refactor`: バグ修正でも機能追加でもないリファクタリング
  - `perf`: パフォーマンス改善
  - `test`: テストの追加・修正
  - `ci`: CI 設定やワークフローの変更
  - `build`: ビルドシステムや依存に関する変更
  - `chore`: その他の雑務的変更（例: 依存更新、スクリプト）
- scope の選択肢と意味 (例):
  - `auth`: 認証関連の変更
  - `api`: API レイヤーの変更
  - `ui`: UI/フロントエンドの変更
  - `docs`: ドキュメント関連
  - `deps`: 依存関係の変更
  - `ci`: CI/パイプライン関連
  - `build`: ビルド関連
  - `tests`: テストに関する変更
  - scope は任意だが、小さく具体的な値を選ぶこと (例: `auth`, `payments`, `checkout`)
- subject のルール:
  - 命令形で一行に簡潔にまとめる（目安: 50 文字以内）
  - 先頭は小文字、末尾にピリオドを付けない
- body:
  - 詳細な説明、背景、影響範囲、回避策などを記述 (必要時)
- footer:
  - 破壊的変更: `BREAKING CHANGE: <description>` を記載
  - Issue 参照: `Closes #123` / `Refs #123`
- 例:
  - `feat(auth): add JWT support`
  - `fix(api): handle null response in /user`
  - `docs: update CONTRIBUTING with branch rules`

---

## 7. 履歴書き換えと push の扱い

> **⚠️ 注意:** 本リポジトリでは履歴書き換えを行う場合、下記のいずれかのオプションを必ず使用することを必須とします。
>
> - `git push --force-with-lease`
> - `git push --force-if-includes`
>
> **理由:**
>
> - `--force-with-lease` は、リモートが自分の期待と違う（他の変更が既にプッシュされている）場合に push を拒否して、他者の作業を誤って上書きする事故を防ぎます。
> - `--force-if-includes` は、push しようとしているコミットがすでにリモートに含まれているかを確認し、不必要な上書きを防ぐ補助的な安全弁となります。
>
> いずれの場合も、履歴書き換えは PR 上で注記し、必ずレビュー承認を得てから反映してください。

- 原則: `git push --force` は禁止。個人ブランチで履歴整理（rebase/squash）する場合は上記のオプションのいずれかを使用し、PR に注記してレビュー承認を得てください。
- 公開ブランチ上での force push は行わないこと。

---



---

## 8. タグ付け (リリース) と SemVer
- タグは SemVer に従う (例: `v1.2.3`).
- プリリリースは `-rc.1` などを使用します.
- タグは `main` に対して付与し、可能なら GPG 署名を推奨します.

---

## 9. スクラムを踏まえた追加ルール
- スプリント内で完結する単位でブランチを管理し、原則スプリント終了までにマージまたはクローズします.
- ブランチ命名例 (スクラム): `feature/SPRINT<番号>-<ISSUE番号>-<短い説明>` (任意).
- PR にスプリント番号やレビューチェックリストを含めてください.

---

## 10. エージェント (Copilot / Claude) 向けの使い方
- エージェントは本ドキュメントに従い、助言とチェックリストを提示してください。自動でマージやブロックは行わないこと.

---

## 11. 更新手順
- ドキュメントを更新する場合は、PR に変更理由と影響範囲を明記してレビューを受けてください.

---

> **決定記録 (Decision Records)**
>
> - **採用: GitHub Flow を採用** — 理由: ミニマルでアジリティを保ち、PR ベースのレビューが運用上簡潔になるため。
>
> - **採用: rebase / fast-forward を推奨** — 理由: 履歴の可読性が向上し、問題追跡が容易になるため。
>
> - **採用: Conventional Commits を採用** — 理由: 変更の自動分類やリリース自動化が容易になり、CI/自動化ツールとの親和性が高まるため。
>
> - **採用: SemVer を採用** — 理由: 互換性の期待を明確にし、リリース管理を体系化するため。

---

## 12. 参考資料
- GitHub Flow: https://docs.github.com/ja/get-started/using-github/github-flow
- Agent skills: https://docs.github.com/ja/copilot/concepts/agents/about-agent-skills
- Semantic Versioning: https://semver.org/
- Conventional Commits: https://www.conventionalcommits.org/

---
