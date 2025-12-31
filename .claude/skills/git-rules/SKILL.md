---
name: git-rules
description: |
  このリポジトリの Git / PR 運用ルールを参照する汎用スキルです。
  - ルールの一次情報は `REFERENCE.md` にあります（`.claude/skills/git-rules/REFERENCE.md`）。
  - この SKILL は GitHub Copilot と Claude Code の両方から利用できます。
---

## いつ使うか
- このリポジトリでのブランチ戦略や PR ルールを確認したいとき。
- PR の作成やレビューを支援するチェックリストが欲しいとき。

## 使い方（人間 / エージェント向け）
1. まず `REFERENCE.md`（`/.claude/skills/git-rules/REFERENCE.md`）を参照してルールを把握する。
2. PR のチェックを依頼された場合は、`REFERENCE.md` を基準に以下を確認して下さい:
   - ブランチ名がルールに従っているか
   - PR タイトル・本文に必要情報が記載されているか（何を・なぜ・影響範囲・テスト手順）
   - 必要なレビュー承認があるか
   - CI（存在する場合）が成功しているか
3. 問題があれば、PR に対して具体的な修正案（例文）をコメントすること。

## 補足
- `REFERENCE.md` は「canonical（唯一の正しい仕様）」です。更新は PR を通して行ってください。
- この SKILL は助言を与えるためのもので、強制は Branch Protection など管理機能により行ってください。