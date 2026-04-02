#!/usr/bin/env bash
# ============================================================
# wechat-ops-sop 懒人安装脚本（Mac / Linux / WSL）
# 用法：在终端中运行
#   chmod +x install.sh && ./install.sh
# ============================================================

set -e

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILL_DIR="$REPO_ROOT/skills"
TARGET_DIR="$HOME/.workbuddy/skills"

echo "============================================"
echo " wechat-ops-sop 懒人安装脚本 (Mac/Linux)"
echo "============================================"
echo ""

# 1. 检测 .workbuddy/skills 目录
if [ ! -d "$TARGET_DIR" ]; then
    echo "[创建] ~/.workbuddy/skills/"
    mkdir -p "$TARGET_DIR"
fi

# 2. 收集所有 skill
shopt -s nullglob
skills=( "$SKILL_DIR"/*/ )
shopt -u nullglob

if [ ${#skills[@]} -eq 0 ]; then
    echo "[错误] 未找到 skills 目录，请确认当前目录是 wechat-ops-sop 仓库根目录"
    exit 1
fi

echo "共 ${#skills[@]} 个 skill 待安装："

for skill_path in "${skills[@]}"; do
    skill_name=$(basename "$skill_path")
    target="$TARGET_DIR/$skill_name"

    if [ -d "$target" ]; then
        echo "  [更新] $skill_name"
        rm -rf "$target"
    else
        echo "  [安装] $skill_name"
    fi

    cp -r "$skill_path" "$target"
done

echo ""
echo "============================================"
echo " 安装完成！重启 WorkBuddy/小龙虾生效"
echo "============================================"
echo ""
echo "已安装的 skills（~/.workbuddy/skills/）："
ls -1 "$TARGET_DIR" | while read dir; do
    emoji=$(grep -m1 '^emoji:' "$TARGET_DIR/$dir/SKILL.md" 2>/dev/null | sed 's/emoji: *"?//;s/"$//' || echo "")
    echo "  $emoji $dir"
done

echo ""
echo "提示：首次使用请设置以下环境变量（缺少则该 skill 降级或跳过）："
echo "  GEMINI_API_KEY       - 图片生成（可选，有则优先）"
echo "  DASHSCOPE_API_KEY    - 豆包模型（内容写作、排版等核心 skill）"
echo "  WECHAT_APPID         - 公众号 AppID（发布到公众号）"
echo "  WECHAT_SECRET        - 公众号 Secret（发布到公众号）"
echo "  TENCENT_MAP_KEY      - 腾讯地图 Key（SEO-GEO skill）"
echo "  BRAVE_SEARCH_API_KEY - Brave搜索（信息采集，可选）"
echo "  GITHUB_TOKEN         - GitHub Token（运营复盘，可选）"
