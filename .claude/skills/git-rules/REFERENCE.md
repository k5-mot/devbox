# Git 運用リファレンス

このファイルはこのリポジトリで採用する Git / PR 運用ルールを明文化したものです。

---

## 1. 目的

- 目的: ブランチ運用、Issue/PR の流れ、コミット規約、リリース手順を統一し、品質と可観測性を高める。
- 適用範囲: このリポジトリ内のすべての開発作業（例外は PR にて合意）。

---

## 2. 開発フロー

以下は、日常的に実行する開発フローの通し手順です。各ステップに CLI コマンドの例を示します。

### 2-1. 【Planner】GitHub Issue の起票

```bash
gh issue create \
　　--title "Short title" \
　　--body "Describe the problem or feature" \
　　--label "type:feature"
```

### 2-2. 【Committer】最新の main ブランチを取得

```bash
git checkout main
git pull --rebase origin main
```

### 2-2. 【Committer】機能開発ブランチの作成

- ブランチ名は、後述のｑ[3. ブランチ戦略と命名](#3-ブランチ戦略と命名) に従うこと

```bash
# 【個人開発】Issue 番号 + 短い説明
git checkout -b feature/123-add-login

# 【組織開発】Sprint 番号 + Issue 番号 + 短い説明
git checkout -b feature/S5-123-add-login
```

### 2-3. 【Committer】実装とコミット

- コミットメッセージは、[Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/) に従うこと
- 詳細は、後述の [6. コミットメッセージ作成ルール](#6-コミットメッセージconventional-commits) を参照

```bash
# ステージング
git add <files>

# コミット例
git commit -m "feat(auth): add login endpoint"
```

### 2-4. 【Committer】最新の main ブランチを反映する

```bash
git pull --rebase origin main
```

### 2-4. 【Committer】リモートへプッシュ

```bash
git push -u origin feature/123-add-login
```

### 2-4. 【Committer】PR (Pull Request) の作成

- 詳細は、後述の [5. Pull Request (PR) ルール](#5-pull-request-pr-ルール) を参照

```bash
gh pr create \
  --title "feat: add login" \
  --body "What / Why / How to test / Closes #123" \
  --base main \
  --head feature/123-add-login
```

### 2-5. 【Reviewer】CI の確認とコードレビュー・承認

```bash
# CI の確認
gh pr checks <PR_NUMBER>

# コードレビューの承認
gh pr review <PR_NUMBER> --approve --body "LGTM"
```

### 2-6. 【Committer】マージ前の最終確認

- 最新の main ブランチを反映し、プッシュ

```bash
git checkout feature/123-add-login
git pull --rebase origin main
git push --force-with-lease --force-if-includes
```


- TODO: 以下は、Github Flavoed Makrdwonで書くこと
- (注意) 履歴書き換え時は `git push --force-with-lease` または `git push --force-if-includes` を使用してください（詳細は 7. 履歴書き換えと push の扱い を参照）

### 2-7. 【Committer】マージとブランチ削除

- REVIEW: SQuashは基本的に許容しないです。
- TODO: 「コミットをリベースしてマージする」で基本的にマージします

- 参考資料：[プルリクエストのマージについて - GitHub Docs](https://docs.github.com/ja/pull-requests/collaborating-with-pull-requests/incorporating-changes-from-a-pull-request/about-pull-request-merges#rebase-and-merge-your-commits)

```bash
gh pr merge <PR_NUMBER> --rebase --delete-branch
```

### 2-8. 【Product Owner】リリースとタグ付け

```bash
# 1. main を取得
git checkout main
git pull origin main

# 2. リリース用タグを作成
git tag -a v1.2.3 -m "release v1.2.3"

# 3. タグをリモートにプッシュ
git push origin v1.2.3
```

---

## 3. Issue 運用ルール

- Issue作成時、以下のルールを順守すること
  - label を必ず設定すること
    - `type:feature`: 新機能
    - `type:bug`: バグ
    - `type:improvement`: 改善提案
    - `type:docs`: ドキュメント
    - Issue を作成する条件: 新機能、バグ、改善提案、設計上の判断を要する事項。軽微な修正は PR で対応可能。
- テンプレートとラベル: `.github/ISSUE_TEMPLATE` とラベル（例: `type:bug`, `type:feature`, `priority:high`, `status:triage`, `sprint:<n>`）を活用する。
- ライフサイクル: `triage` → `assign` → `in progress` → `review` → `done`。
- PR との連携: PR に `Closes #<issue>` を含めると自動で Issue を閉じる。コミットや PR に Issue 番号を明示してください。

---

## 4. ブランチ命名ルール

> [!IMPORTANT]
> シンプルなGitHub Flowを採用することで、
> ブランチ管理が容易になり、開発速度が向上します。

```bash
# 【個人開発】Issue 番号 + 短い説明
git checkout -b feature/123-add-login

# 【組織開発】Sprint 番号 + Issue 番号 + 短い説明
git checkout -b feature/S5-123-add-login
```

> [!NOTE]
> - GitHub Flow
>   - [GitHub フロー | GitHub Docs](https://docs.github.com/ja/get-started/using-github/github-flow)
> Git flow
>   - [A successful Git branching model](https://nvie.com/posts/a-successful-git-branching-model/)
>   - [Gitflow ワークフロー | Atlassian Git Tutorial](https://www.atlassian.com/ja/git/tutorials/comparing-workflows/gitflow-workflow)
> GitLab Flow
>   - [GitLab Flowとは](https://about.gitlab.com/ja-jp/topics/version-control/what-is-gitlab-flow/)
> Trunk based development
>   - [DORA | Capabilities: Trunk-based development](https://dora.dev/capabilities/trunk-based-development/)
>   - [トランク ベース開発 | Atlassian Git Tutorial](https://www.atlassian.com/ja/continuous-delivery/continuous-integration/trunk-based-development)

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
