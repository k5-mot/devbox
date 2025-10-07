---
applyTo: "frontend/src/styles/**/*"
---

# Serendie Design Token ガイドライン

## 概要

**Serendie Design System** のデザイントークンは、デザインシステムを構成する最小単位です。Key/Value（名前と値）のペアからなり、カラー、タイポグラフィ、寸法、階層などを定義し、デザインと開発の共通言語となります。

### デザイントークンの特徴

- **Single Source of Truth**: コードと Figma の間で共有
- **2 層構造**: リファレンストークンとシステムトークン
- **テーマ対応**: 5 つのカラーテーマをサポート
- **W3C 準拠**: Design Tokens Format Module 草案に基づく設計

## 2 層構造

### リファレンストークン

生の値を示す素朴な命名。直接使用は避け、システムトークン経由で参照。

```
color.scale.green.500 (カラースケール500番の緑色)
```

### システムトークン

UI における意味性の強い命名。実際の開発ではこちらを使用。

```
color.impression.positiveContainer (ポジティブな印象の背景色)
```

## カラーテーマ（5 種類）

### テーマ切り替え

```tsx
// HTMLのdata-panda-theme属性でテーマ切り替え
<html data-panda-theme="konjo" />     // 紺青（濃い青）
<html data-panda-theme="asagi" />     // 浅葱（薄い青緑）
<html data-panda-theme="sumire" />    // 菫（紫）
<html data-panda-theme="tsutsuji" />  // 躑躅（鮮やかな赤）
<html data-panda-theme="kurikawa" />  // 栗皮（茶色）
```

### カラーシステムトークン例

```css
/* 基本印象色 */
sd.system.color.impression.primary
sd.system.color.impression.primaryContainer
sd.system.color.impression.onPrimary
sd.system.color.impression.onPrimaryContainer

/* 状態表現色 */
sd.system.color.impression.positive         // 成功・正常状態
sd.system.color.impression.positiveContainer
sd.system.color.impression.onPositive
sd.system.color.impression.onPositiveContainer

sd.system.color.impression.negative         // エラー・警告状態
sd.system.color.impression.negativeContainer
sd.system.color.impression.onNegative
sd.system.color.impression.onNegativeContainer

sd.system.color.impression.caution          // 注意状態
sd.system.color.impression.cautionContainer
sd.system.color.impression.onCaution
sd.system.color.impression.onCautionContainer

/* サーフェス色 */
sd.system.color.surface.primary            // 基本背景
sd.system.color.surface.secondary          // セカンダリ背景
sd.system.color.surface.tertiary           // 第三背景
sd.system.color.surface.inverse            // 反転背景

/* アウトライン色 */
sd.system.color.outline.primary
sd.system.color.outline.secondary
sd.system.color.outline.variant
```

## タイポグラフィトークン

### レスポンシブ対応（Compact/Expanded）

- **Compact**: 小さな画面・コンパクトなレイアウト用
- **Expanded**: 大きな画面・ゆったりしたレイアウト用

### Display（大見出し）

最も大きく目立つテキスト。ヒーローセクションやランディングページのメインタイトル用。

```css
sd.system.typography.display.small_compact
sd.system.typography.display.medium_compact
sd.system.typography.display.small_expanded
sd.system.typography.display.medium_expanded
```

### Headline（見出し）

セクションやページの見出し。記事タイトルやカテゴリタイトル用。

```css
sd.system.typography.headline.small_compact
sd.system.typography.headline.medium_compact
sd.system.typography.headline.large_compact
sd.system.typography.headline.small_expanded
sd.system.typography.headline.medium_expanded
sd.system.typography.headline.large_expanded
```

### Title（タイトル）

コンポーネントやカードのタイトル。モーダルタイトルやウィジェットタイトル用。

```css
sd.system.typography.title.small_compact
sd.system.typography.title.medium_compact
sd.system.typography.title.large_compact
sd.system.typography.title.small_expanded
sd.system.typography.title.medium_expanded
sd.system.typography.title.large_expanded
```

### Body（本文）

一般的な本文テキスト。記事内容や説明文用。

```css
sd.system.typography.body.extraSmall_compact
sd.system.typography.body.small_compact
sd.system.typography.body.medium_compact
sd.system.typography.body.large_compact
sd.system.typography.body.extraSmall_expanded
sd.system.typography.body.small_expanded
sd.system.typography.body.medium_expanded
sd.system.typography.body.large_expanded
```

### Label（ラベル）

ボタンテキスト、フォームラベル、ナビゲーションテキスト用。

```css
sd.system.typography.label.small_compact
sd.system.typography.label.medium_compact
sd.system.typography.label.large_compact
sd.system.typography.label.extraLarge_compact
sd.system.typography.label.small_expanded
sd.system.typography.label.medium_expanded
sd.system.typography.label.large_expanded
sd.system.typography.label.extraLarge_expanded
```

## CSS Variables 使用例

### 基本的な使用方法

```css
@import "@serendie/design-token/tokens.css";

/* 見出しのスタイリング */
h1 {
  font-size: var(--sd-system-typography-headline-large-expanded);
  color: var(--sd-system-color-impression-primary);
  line-height: var(--sd-system-typography-headline-large-expanded-lineHeight);
  font-weight: var(--sd-system-typography-headline-large-expanded-fontWeight);
}

/* ボタンのスタイリング */
.button-primary {
  background-color: var(--sd-system-color-impression-primaryContainer);
  color: var(--sd-system-color-impression-onPrimaryContainer);
  font-size: var(--sd-system-typography-label-medium-compact);
  font-weight: var(--sd-system-typography-label-medium-compact-fontWeight);
}

/* エラー状態のスタイリング */
.error-message {
  color: var(--sd-system-color-impression-negative);
  background-color: var(--sd-system-color-impression-negativeContainer);
  font-size: var(--sd-system-typography-body-small-compact);
}

/* サーフェス背景 */
.card {
  background-color: var(--sd-system-color-surface-secondary);
  border: 1px solid var(--sd-system-color-outline-variant);
}
```

### レスポンシブデザインでの使用

```css
/* モバイルファーストでcompactを使用 */
.responsive-text {
  font-size: var(--sd-system-typography-body-medium-compact);
}

/* より大きな画面でexpandedに切り替え */
@media (min-width: 768px) {
  .responsive-text {
    font-size: var(--sd-system-typography-body-medium-expanded);
  }
}
```

### テーマ対応のスタイリング

```css
/* 全テーマで動作するスタイル */
.theme-aware-button {
  background-color: var(--sd-system-color-impression-primaryContainer);
  color: var(--sd-system-color-impression-onPrimaryContainer);
  border: 2px solid var(--sd-system-color-impression-primary);
}

/* テーマが変更されても適切な色が自動適用される */
[data-panda-theme="asagi"] .theme-aware-button,
[data-panda-theme="konjo"] .theme-aware-button,
[data-panda-theme="sumire"] .theme-aware-button {
  /* 自動的にテーマ対応色が適用される */
}
```

## 命名規則

### デザイントークンの命名規則

1. **先頭小文字のキャメルケース（camelCase）**
2. **頭文字にアラビア数字を避ける**（`2extraSmall` → `twoExtraSmall`）
3. **省略記法を避ける**（`xs` → `extraSmall`）
4. **デバイス種別より画面幅に着目**（`mobile` → `compact`）
5. **プラットフォーム非依存の用語選択**

### 構造化命名

```
[ドメイン].[カテゴリ].[タイプ].[意味].[バリエーション]

例：
sd.system.color.impression.primary
sd.system.typography.headline.large_expanded
```

## 開発ガイドライン

### デザイントークン使用時の原則

1. **システムトークン優先**: リファレンストークンの直接使用を避ける
2. **意味のある命名**: 見た目ではなく役割に基づいたトークン選択
3. **テーマ対応**: 複数のカラーテーマに対応した設計
4. **レスポンシブ考慮**: Compact/Expanded の適切な使い分け
5. **アクセシビリティ**: コントラスト比が確保されたトークンの活用

### スタイルファイルでの実装例

```tsx
// frontend/styles/Button.tsx の例
import { css } from "@styled-system/css";

export const buttonStyles = css({
  // システムトークンを使用
  backgroundColor: "var(--sd-system-color-impression-primaryContainer)",
  color: "var(--sd-system-color-impression-onPrimaryContainer)",
  fontSize: "var(--sd-system-typography-label-medium-compact)",
  fontWeight: "var(--sd-system-typography-label-medium-compact-fontWeight)",

  // レスポンシブでのexpanded対応
  "@media (min-width: 768px)": {
    fontSize: "var(--sd-system-typography-label-medium-expanded)",
    fontWeight: "var(--sd-system-typography-label-medium-expanded-fontWeight)",
  },

  // ホバー状態での色変更
  "&:hover": {
    backgroundColor: "var(--sd-system-color-impression-primary)",
    color: "var(--sd-system-color-impression-onPrimary)",
  },
});
```

### 避けるべきパターン

```css
/* ❌ 避けるべき：直接値の指定 */
.bad-button {
  color: #0a69cf;
  font-size: 16px;
}

/* ❌ 避けるべき：リファレンストークンの直接使用 */
.bad-text {
  color: var(--sd-reference-color-scale-blue-500);
}

/* ✅ 推奨：システムトークンの使用 */
.good-button {
  color: var(--sd-system-color-impression-primary);
  font-size: var(--sd-system-typography-label-medium-compact);
}
```
