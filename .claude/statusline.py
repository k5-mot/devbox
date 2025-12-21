#!/usr/bin/env python3
import json
import sys
import os
from dataclasses import dataclass
from typing import Optional


@dataclass
class ModelInfo:
    """モデル情報のデータモデル"""

    display_name: str
    input_price_per_mtok: float = 0.0
    output_price_per_mtok: float = 0.0

    @classmethod
    def from_dict(cls, data: dict) -> "ModelInfo":
        return cls(
            display_name=data.get("display_name", "Unknown"),
            input_price_per_mtok=data.get("input_price_per_mtok", 0.0),
            output_price_per_mtok=data.get("output_price_per_mtok", 0.0),
        )


@dataclass
class TokenUsage:
    """トークン使用量のデータモデル"""

    input_tokens: int = 0
    output_tokens: int = 0
    cache_read_tokens: int = 0
    cache_creation_tokens: int = 0

    @classmethod
    def from_dict(cls, data: dict) -> "TokenUsage":
        return cls(
            input_tokens=data.get("input_tokens", 0),
            output_tokens=data.get("output_tokens", 0),
            cache_read_tokens=data.get("cache_read_tokens", 0),
            cache_creation_tokens=data.get("cache_creation_tokens", 0),
        )

    def total_tokens(self) -> int:
        """総トークン数を計算"""
        return (
            self.input_tokens
            + self.output_tokens
            + self.cache_read_tokens
            + self.cache_creation_tokens
        )

    def compact_rate(self) -> float:
        """コンパクト率を計算 (キャッシュの効率性)"""
        total_input = self.input_tokens + self.cache_creation_tokens
        if total_input == 0:
            return 0.0
        return (self.cache_read_tokens / (total_input + self.cache_read_tokens)) * 100


@dataclass
class WorkspaceInfo:
    """ワークスペース情報のデータモデル"""

    current_dir: str
    git_branch: Optional[str] = None

    @classmethod
    def from_dict(cls, data: dict) -> "WorkspaceInfo":
        current_dir = data.get("current_dir", os.getcwd())
        git_branch = cls._get_git_branch(current_dir)
        return cls(current_dir=current_dir, git_branch=git_branch)

    @staticmethod
    def _get_git_branch(workspace_path: str) -> Optional[str]:
        """Gitブランチ名を取得"""
        git_head_path = os.path.join(workspace_path, ".git", "HEAD")
        if os.path.exists(git_head_path):
            try:
                with open(git_head_path, "r") as f:
                    ref = f.read().strip()
                    if ref.startswith("ref: refs/heads/"):
                        return ref.replace("ref: refs/heads/", "")
            except Exception:
                pass
        return None

    def dir_name(self) -> str:
        """ディレクトリ名を取得"""
        return os.path.basename(self.current_dir)


@dataclass
class StatusLineData:
    """ステータスライン表示用のデータモデル"""

    model: ModelInfo
    workspace: WorkspaceInfo
    token_usage: TokenUsage

    @classmethod
    def from_stdin(cls) -> "StatusLineData":
        """標準入力からJSONを読み取ってデータモデルを構築"""
        data = json.load(sys.stdin)

        return cls(
            model=ModelInfo.from_dict(data.get("model", {})),
            workspace=WorkspaceInfo.from_dict(data.get("workspace", {})),
            token_usage=TokenUsage.from_dict(data.get("token_usage", {})),
        )

    def calculate_cost(self) -> float:
        """使用コストを計算(USD)"""
        input_cost = (
            self.token_usage.input_tokens / 1_000_000
        ) * self.model.input_price_per_mtok
        output_cost = (
            self.token_usage.output_tokens / 1_000_000
        ) * self.model.output_price_per_mtok
        cache_creation_cost = (
            self.token_usage.cache_creation_tokens / 1_000_000
        ) * self.model.input_price_per_mtok
        # キャッシュ読み取りは通常10%のコスト
        cache_read_cost = (
            (self.token_usage.cache_read_tokens / 1_000_000)
            * self.model.input_price_per_mtok
            * 0.1
        )

        return input_cost + output_cost + cache_creation_cost + cache_read_cost


class EmojiIcons:
    """Emojiアイコン定義"""

    MODEL = "🧿"
    FOLDER = "📁"
    GIT_BRANCH = "🌿"
    TOKENS = "🪙"
    COST = "💵"
    COMPACT = "♨️"


class AnsiColors:
    """ANSIエスケープシーケンスによる色定義"""

    RESET = "\033[0m"
    BOLD = "\033[1m"

    # 基本色
    RED = "\033[31;2m"
    GREEN = "\033[32;2m"
    YELLOW = "\033[33;2m"
    BLUE = "\033[34;2m"
    MAGENTA = "\033[35;2m"
    CYAN = "\033[36;2m"
    WHITE = "\033[37;2m"


def get_compact_rate_color(compact_rate: float) -> str:
    """コンパクト率に応じた警戒色を返す (緑→黄→赤)"""
    if compact_rate < 50.0:
        return AnsiColors.GREEN
    elif compact_rate < 80.0:
        return AnsiColors.YELLOW
    else:
        return AnsiColors.RED


def format_statusline(data: StatusLineData) -> str:
    """ステータスラインをフォーマット"""
    components = [
        f"{AnsiColors.MAGENTA}{EmojiIcons.MODEL} {data.model.display_name}{AnsiColors.RESET}",
        f"{AnsiColors.RED}{EmojiIcons.FOLDER} {data.workspace.dir_name()}{AnsiColors.RESET}",
    ]

    # Gitブランチがある場合は追加
    if data.workspace.git_branch:
        components.append(
            f"{AnsiColors.YELLOW}{EmojiIcons.GIT_BRANCH} {data.workspace.git_branch}{AnsiColors.RESET}"
        )

    # トークン数 (値がわからない場合は0を表示)
    total_tokens = data.token_usage.total_tokens()
    components.append(
        f"{AnsiColors.CYAN}{EmojiIcons.TOKENS} {total_tokens:,}tok{AnsiColors.RESET}"
    )

    # コスト (値がわからない場合は0を表示)
    cost = data.calculate_cost()
    components.append(
        f"{AnsiColors.BLUE}{EmojiIcons.COST} ${cost:.4f}{AnsiColors.RESET}"
    )

    # コンパクト率 (値がわからない場合は0を表示)
    compact_rate = data.token_usage.compact_rate()
    compact_color = get_compact_rate_color(compact_rate)
    components.append(
        f"{compact_color}{EmojiIcons.COMPACT} {compact_rate:.1f}%{AnsiColors.RESET}"
    )

    return " | ".join(components)


def main():
    """メイン処理"""
    try:
        statusline_data = StatusLineData.from_stdin()
        output = format_statusline(statusline_data)
        print(output)
    except Exception as e:
        # エラー時は最小限の情報を表示
        print(f"Error: {str(e)}")
        sys.exit(1)


if __name__ == "__main__":
    main()
