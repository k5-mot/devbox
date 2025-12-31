# Agent Skills（エージェントスキル）

このドキュメントは、リポジトリに追加する Agent Skills とその運用について整理したものです。

## 目的
- GitHub Copilot や Claude Code などのエージェントがリポジトリに関するルールを理解し、繰り返し可能な作業を自動化できるようにする。
- PR ポリシーやコミットメッセージ規約を自動検査するためのスキルを提供する。

## 配置場所
- Canonical（推奨）: `.claude/skills/<skill-name>/SKILL.md`（GitHub Copilot と Claude Code 両方から参照できます）
- 互換性のために `.github/skills/` に置くことも可能ですが、メンテナンス性向上のため **`.claude/skills` に一本化することを推奨** します。

現在このリポジトリに導入するスキル（最初のセット）:
- `pr-policy`: PR タイトル/本文/レビュー/CI を検査するスキル
- `commit-msg-lint`: PR 内のコミットメッセージが Conventional Commits に準拠しているかを検査
- `branch-cleanup`: マージ後のブランチ削除を補助

## 運用
- スキルはエージェント（GitHub Copilot / Claude Code 等）がコンテキストに読み込んで使用します。現時点では CI による自動検査は必須ではなく、エージェントの支援（助言・チェックリスト提示）を目的とします。
- スキル本文（`SKILL.md`）は人とエージェント双方の実行手順を明記する。
- `SKILL.md` の例は `.claude/skills/pr-policy/SKILL.md` を参照してください。

---

## 拡張案
- Danger / Probot を使ったより高度な自動化（例: 自動リマインダー、複雑な承認ルール）
- 管理者向けのブランチ保護自動化スクリプト（注意: 管理者権限が必要）

---

必要なら、これらのスキルセットをさらに増やして自動化を強化します。
