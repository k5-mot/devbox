---
applyTo: "frontend/src/**/*"
---

# Serendie アイコンシステム（Serendie Symbols）ガイドライン

## 概要

Serendie Symbols は、Serendie Design System に含まれる 300 種類以上のアイコンライブラリです。現在 Outlined（線）と Filled（塗り）の 2 パターンで提供されており、React 環境での使用に最適化されています。

## 設計原則

### 1. Arc を生かす

Serendie ブランドのシンボルである半円（Arc）を表現に活用し、ブランドアイデンティティを統一します。

### 2. 極端なシルエット

線と角のコントラストを意識したメリハリのある形状により、視認性と美しさを両立します。

### 3. ユーザーを驚かせない

個性よりも一般性を重視した分かりやすいアイコンデザインにより、直感的な理解を促します。

## 技術仕様

### デザイン仕様

- **線幅**: 1.2px
- **角丸半径**: 0.25px
- **グリッド**: 24dp × 24dp
- **ライブエリア**: 20dp × 20dp（パディング 2dp）
- **パスの間隔**: 1.6px

### バリエーション

- **Outlined**: 線のみのシンプルなアイコン（デフォルト）
- **Filled**: 塗りつぶしのある視認性重視のアイコン

## React 環境での使用方法

### 基本的な使用法

```tsx
import { IconName } from "@serendie/symbols";

function MyComponent() {
  return (
    <div>
      <IconName />
    </div>
  );
}
```

### よく使用されるアイコンの例

```tsx
import {
  // ナビゲーション
  HomeIcon,
  MenuIcon,
  ArrowBackIcon,
  ArrowForwardIcon,
  ChevronLeftIcon,
  ChevronRightIcon,
  ChevronUpIcon,
  ChevronDownIcon,

  // アクション
  AddIcon,
  EditIcon,
  DeleteIcon,
  SaveIcon,
  CancelIcon,
  CheckIcon,
  CloseIcon,
  SearchIcon,
  FilterIcon,
  SortIcon,

  // ユーザー・アカウント
  PersonIcon,
  AccountCircleIcon,
  GroupIcon,
  LoginIcon,
  LogoutIcon,

  // コミュニケーション
  EmailIcon,
  PhoneIcon,
  ChatIcon,
  NotificationsIcon,

  // ファイル・データ
  FileIcon,
  FolderIcon,
  UploadIcon,
  DownloadIcon,
  AttachmentIcon,
  ImageIcon,
  DocumentIcon,

  // 設定・ツール
  SettingsIcon,
  InfoIcon,
  HelpIcon,
  MoreVertIcon,
  MoreHorizIcon,

  // 状態表示
  VisibilityIcon,
  VisibilityOffIcon,
  FavoriteIcon,
  StarIcon,
  LockIcon,
  UnlockIcon,
  ErrorIcon,
  WarningIcon,
  SuccessIcon,
} from "@serendie/symbols";
```

### アイコンのサイズ設定

```tsx
import { SearchIcon } from "@serendie/symbols";
import { Box } from "../styled-system/jsx";

function IconSizeExample() {
  return (
    <Box>
      {/* デフォルトサイズ（24px） */}
      <SearchIcon />

      {/* サイズ指定（CSS in JSの場合） */}
      <Box fontSize="16px">
        <SearchIcon />
      </Box>

      {/* サイズ指定（インラインスタイルの場合） */}
      <SearchIcon style={{ width: "32px", height: "32px" }} />
    </Box>
  );
}
```

### アイコンの色設定

```tsx
import { HeartIcon } from "@serendie/symbols";
import { Box } from "../styled-system/jsx";

function IconColorExample() {
  return (
    <Box>
      {/* デザイントークンを使用した色指定 */}
      <Box color="var(--sd-system-color-impression-primary)">
        <HeartIcon />
      </Box>

      {/* PandaCSSの色指定 */}
      <Box color="red.500">
        <HeartIcon />
      </Box>
    </Box>
  );
}
```

## ボタンとの組み合わせ

### IconButton との使用

```tsx
import { DeleteIcon, EditIcon, MoreVertIcon } from "@serendie/symbols";
import { IconButton } from "@serendie/ui";
import { HStack } from "../styled-system/jsx";

function ActionButtons() {
  return (
    <HStack gap="2">
      <IconButton aria-label="編集" variant="outline">
        <EditIcon />
      </IconButton>

      <IconButton aria-label="削除" variant="outline" colorScheme="negative">
        <DeleteIcon />
      </IconButton>

      <IconButton aria-label="その他のオプション" variant="ghost">
        <MoreVertIcon />
      </IconButton>
    </HStack>
  );
}
```

### Button との組み合わせ

```tsx
import { AddIcon, SaveIcon, CancelIcon } from "@serendie/symbols";
import { Button } from "@serendie/ui";
import { HStack, Box } from "../styled-system/jsx";

function ButtonWithIcons() {
  return (
    <HStack gap="3">
      <Button variant="primary">
        <Box mr="2">
          <AddIcon />
        </Box>
        新規作成
      </Button>

      <Button variant="outline">
        <Box mr="2">
          <SaveIcon />
        </Box>
        保存
      </Button>

      <Button variant="ghost">
        <Box mr="2">
          <CancelIcon />
        </Box>
        キャンセル
      </Button>
    </HStack>
  );
}
```

## フォームでの使用

### 入力フィールドでの使用

```tsx
import {
  SearchIcon,
  VisibilityIcon,
  VisibilityOffIcon,
} from "@serendie/symbols";
import { TextField, PasswordField, IconButton } from "@serendie/ui";
import { Box, VStack } from "../styled-system/jsx";

function FormWithIcons() {
  const [showPassword, setShowPassword] = useState(false);

  return (
    <VStack gap="4">
      <TextField
        label="検索"
        placeholder="キーワードを入力"
        startAdornment={
          <Box color="gray.500">
            <SearchIcon />
          </Box>
        }
      />

      <PasswordField
        label="パスワード"
        type={showPassword ? "text" : "password"}
        endAdornment={
          <IconButton
            aria-label={
              showPassword ? "パスワードを非表示" : "パスワードを表示"
            }
            variant="ghost"
            size="sm"
            onClick={() => setShowPassword(!showPassword)}
          >
            {showPassword ? <VisibilityOffIcon /> : <VisibilityIcon />}
          </IconButton>
        }
      />
    </VStack>
  );
}
```

## ナビゲーションでの使用

### BottomNavigation での使用

```tsx
import {
  HomeIcon,
  SearchIcon,
  NotificationsIcon,
  PersonIcon,
  SettingsIcon,
} from "@serendie/symbols";
import { BottomNavigation, BottomNavigationItem } from "@serendie/ui";

function AppBottomNavigation() {
  const [activeTab, setActiveTab] = useState("home");

  return (
    <BottomNavigation value={activeTab} onChange={setActiveTab}>
      <BottomNavigationItem value="home" label="ホーム" icon={<HomeIcon />} />
      <BottomNavigationItem value="search" label="検索" icon={<SearchIcon />} />
      <BottomNavigationItem
        value="notifications"
        label="通知"
        icon={<NotificationsIcon />}
      />
      <BottomNavigationItem
        value="profile"
        label="プロフィール"
        icon={<PersonIcon />}
      />
      <BottomNavigationItem
        value="settings"
        label="設定"
        icon={<SettingsIcon />}
      />
    </BottomNavigation>
  );
}
```

### TopAppBar での使用

```tsx
import { MenuIcon, SearchIcon, MoreVertIcon } from "@serendie/symbols";
import { TopAppBar, IconButton } from "@serendie/ui";
import { HStack } from "../styled-system/jsx";

function AppTopBar() {
  return (
    <TopAppBar>
      <HStack justify="space-between" align="center" w="full">
        <IconButton aria-label="メニューを開く" variant="ghost">
          <MenuIcon />
        </IconButton>

        <h1>アプリケーション名</h1>

        <HStack gap="1">
          <IconButton aria-label="検索" variant="ghost">
            <SearchIcon />
          </IconButton>
          <IconButton aria-label="その他のオプション" variant="ghost">
            <MoreVertIcon />
          </IconButton>
        </HStack>
      </HStack>
    </TopAppBar>
  );
}
```

## 状態表示での使用

### ステータスアイコン

```tsx
import {
  CheckCircleIcon,
  ErrorIcon,
  WarningIcon,
  InfoIcon,
  LoadingIcon,
} from "@serendie/symbols";
import { Box, HStack } from "../styled-system/jsx";

function StatusDisplay({ status, message }) {
  const getStatusIcon = () => {
    switch (status) {
      case "success":
        return <CheckCircleIcon />;
      case "error":
        return <ErrorIcon />;
      case "warning":
        return <WarningIcon />;
      case "info":
        return <InfoIcon />;
      case "loading":
        return <LoadingIcon />;
      default:
        return null;
    }
  };

  const getStatusColor = () => {
    switch (status) {
      case "success":
        return "var(--sd-system-color-impression-positive)";
      case "error":
        return "var(--sd-system-color-impression-negative)";
      case "warning":
        return "var(--sd-system-color-impression-warning)";
      case "info":
        return "var(--sd-system-color-impression-primary)";
      default:
        return "gray.500";
    }
  };

  return (
    <HStack gap="2" align="center">
      <Box color={getStatusColor()}>{getStatusIcon()}</Box>
      <span>{message}</span>
    </HStack>
  );
}
```

## アクセシビリティ配慮

### aria-label の使用

```tsx
import { DeleteIcon } from "@serendie/symbols";
import { IconButton } from "@serendie/ui";

function AccessibleIconButton() {
  return (
    <IconButton
      aria-label="項目を削除" // 必須：アイコンの意味を説明
      variant="outline"
      colorScheme="negative"
    >
      <DeleteIcon />
    </IconButton>
  );
}
```

### 装飾的アイコンの場合

```tsx
import { StarIcon } from "@serendie/symbols";
import { Box } from "../styled-system/jsx";

function DecorativeIcon() {
  return (
    <Box>
      <Box aria-hidden="true" display="inline">
        {" "}
        {/* 装飾目的の場合 */}
        <StarIcon />
      </Box>
      <span>おすすめ商品</span>
    </Box>
  );
}
```

## 命名規則とベストプラクティス

### アイコン名の規則

- 機能や概念を表す英語名 + `Icon`サフィックス
- PascalCase 形式（例: `HomeIcon`, `SearchIcon`, `ArrowForwardIcon`）

### 使用時のガイドライン

1. **一貫性**: 同じ機能には同じアイコンを使用
2. **文脈**: アイコンが表す機能が文脈から明確か確認
3. **サイズ**: 用途に応じて適切なサイズを選択（16px〜48px 推奨）
4. **色**: デザイントークンを活用した統一感のある色使用
5. **アクセシビリティ**: 必要に応じて aria-label や alt 属性を設定

### パフォーマンス最適化

```tsx
// 必要なアイコンのみをインポート（Tree Shaking対応）
import { HomeIcon, SearchIcon } from "@serendie/symbols";

// ✗ 避ける：全体インポート
// import * as Icons from '@serendie/symbols'
```
