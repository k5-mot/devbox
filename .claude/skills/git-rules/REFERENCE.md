# Git 運用リファレンス

このファイルはリポジトリにおける Git / PR の運用規則を整理したものです。

---

## 1. 目的と適用範囲
- 目的: ブランチ運用・PR 手順・コミット規約などを統一し、レビューとマージの品質を担保する。 
- 適用範囲: このリポジトリ内のすべての開発作業（個別例外は PR に明記して議論する）。

---

## 2. 基本方針
- ブランチ戦略: GitHub Flow を採用。`main` は常にデプロイ可能な状態に保つ。
- ブランチ命名規則: `feature/<短い説明>`, `fix/<短い説明>`, `chore/<短い説明>`, `hotfix/<短い説明>`。
- コミット規約: **Conventional Commits** を推奨（例: `feat(auth): add login`）。

---

## 3. 開発フロー（推奨手順）
1. `main` を最新にする:
   - `git checkout main` して `git pull --rebase origin main` を実行。
2. 新しいブランチを作成:
   - `git checkout -b feature/<短い説明>`
3. 実装は小さなコミットで行い、ローカルで適宜 `git rebase -i` や整理を行う。
4. 作業中に `main` の更新があれば、ローカルブランチで `git pull --rebase origin main` して競合を解消する（merge より rebase を推奨）。
5. PR を作成し、レビューと CI 結果（存在する場合）を待つ。
6. マージの前に必ず最新の `main` に対して rebase を行い、**fast-forward が可能な状態**にすること（`git pull --rebase origin main`、競合解消、動作確認）。
7. マージは基本的に Fast-Forward（または Squash）を推奨。履歴の整合性が必要な場合にのみ Merge commit を用いる。

> 注意: `git pull --rebase` と fast-forward を徹底することで、不要なマージコミットや複雑な履歴を避けられます。

---

## 4. Pull Request（PR）ルール
- PR を作成する際の必須情報:
  - 変更の要約（何をしたか）
  - 変更理由（なぜ必要か）
  - 影響範囲（どこに影響するか）
  - テスト手順／確認方法
  - 関連 Issue やチケット番号
- レビュー要件: コミッター本人以外の承認者が最低1名必要（プロジェクトルールで更に厳格化することがあれば PR に明記）。
- CI が存在する場合は、必要なチェックが全て成功したことを確認すること（失敗している場合は修正を求める）。

---

## 5. コミットメッセージのガイドライン
- 形式: `type(scope?): subject`（Conventional Commits）
- 例: `feat(api): add health check endpoint`
- 小さな WIP コミットは許容するが、PR 作成前に整理（squash/rebase）すること。

---

## 6. 履歴書き換えと force push の扱い
- 原則: 履歴の書き換え（`git push --force` など）は**禁止**。どうしても必要な場合は PR として事前に合意を取り、影響範囲を明確にすること。
- 個人ブランチ内での rebase/squash は許容される（ローカルで履歴を整理し、最終的に fast-forward マージすること）。

---

## 7. 緊急対応（hotfix）
- 緊急修正は `hotfix/<短い説明>` ブランチで行い、迅速にレビュー・テストして main に取り込む。
- 取り込んだら、必要に応じてリリースノートや CHANGELOG を更新する。

---

## 8. エージェント（Copilot / Claude）向けの使い方
- エージェントがルールに基づくチェックを行う際は、このファイルの該当節を参照して、助言とチェックリストを提示してください。
- エージェントは自動的に PR を block したり merge を実行しないでください（あくまで助言が原則）。

---

## 9. 更新手順
- このドキュメントを更新するときは、変更理由と影響範囲を PR に明記してレビューを受けてください。

---

更新: このファイルを更新するときは、変更理由と影響範囲を PR に明記してレビューを受けてください。

---

## 10. 採用理由
- **Rebase / Fast-Forward を推奨する理由**: 履歴が直線的になり、不要なマージコミットが減るため、履歴の可読性とバグの追跡が容易になります。スクラムの短いリリースサイクルにも適しています。 
- **SemVer（タグ）を採用する理由**: バージョニングの互換性を明確にし、リリースや依存管理を一貫して行えるためです。

## 11. タグ付け（リリース）ルール
- タグは **SemVer** に従う（例: `v1.2.3`）。
- プリリリースは `-rc.1` や `-beta.1` の形式を付与する。
- タグ付けは `main` に対して行い、可能であれば GPG 署名を行うことを推奨します。

## 12. スクラム向け追加ルール
- ブランチはスプリント内で完結することを目標とし、原則スプリント終了までにマージまたはクローズすること。長期化が見込まれる場合はスコープを分割するか、事前にスクラムマスターと相談すること。
- ブランチ命名例: `feature/SPRINT<番号>-<ISSUE番号>-<短い説明>` または `feature/<ISSUE番号>-<短説明>` を推奨。
- PR 本文にスプリント番号や関連タスクを明記し、スプリントレビューでのチェックリスト（QA、ドキュメント更新等）を用意すること。

## 13. GitHub Flow の限定運用
- 本プロジェクトは GitHub Flow を採用し、運用ブランチは **`main` と `feature/*` のみ**を使用します（`develop` や `release` は使いません）。
- 参考: https://docs.github.com/ja/get-started/using-github/github-flow

## 14. Force push の扱い（`--force-with-lease`）
- `git push --force-with-lease` の使用は原則禁止です。例外的に個人ブランチ内で履歴を整理（rebase/squash）する場合のみ許可されますが、その際は**事前に PR に注記**し、レビューで承認を得ることを必須とします。
- 絶対に `git push --force` を使わず、`--force-with-lease` を使用してください（衝突の安全性を高めるため）。

## 15. 参考資料
- GitHub Flow: https://docs.github.com/ja/get-started/using-github/github-flow
- Agent skills: https://docs.github.com/ja/copilot/concepts/agents/about-agent-skills
- Semantic Versioning: https://semver.org/
- Conventional Commits: https://www.conventionalcommits.org/

---