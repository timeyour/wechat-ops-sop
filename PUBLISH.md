# Clawdhub 一键发布指南

## 准备工作

### 1. 安装 clawdhub CLI

```bash
# Mac/Linux
curl -fsSL https://get.openclaw.ai/install.sh | bash

# 或 npm 全局安装
npm install -g clawdhub

# Windows (PowerShell)
iwr https://get.openclaw.ai/install.ps1 -UseBasicParsing | iex
```

### 2. 登录账号

```bash
clawdhub login
# 按提示输入 GitHub 账号授权
```

### 3. 检查环境

```bash
clawdhub --version
# 确认 >= 0.8.0
```

---

## 一键发布所有 13 个 Skill

在仓库根目录运行以下命令：

```bash
# ============================================================
# 一键发布全部 13 个 skill 到 Clawdhub
# ============================================================

SKILLS=(
  "image-generation:wechat-image-gen:公众号配图生成"
  "content-writing:wechat-content-writing:公众号内容写作"
  "typesetting-publish:wechat-typesetting:公众号排版发布"
  "compliance-check:wechat-compliance:公众号合规审核"
  "cold-start:wechat-cold-start:公众号冷启动"
  "growth-review:wechat-growth-review:公众号运营复盘"
  "corpus-playbook:wechat-corpus:语料学习写作手册"
  "seo-geo:wechat-seo-geo:搜一搜SEO优化"
  "info-gathering:wechat-info-gathering:全网信息采集"
  "data-review:wechat-data-review:文章数据复盘"
  "topic-discovery:wechat-topic-discovery:选题发现"
  "theme-gallery:wechat-theme-gallery:WenYan主题画廊"
  "cross-platform:wechat-cross-platform:跨平台分发"
)

for entry in "${SKILLS[@]}"; do
  IFS=':' read -r slug dir desc <<< "$entry"
  echo ""
  echo "============================================"
  echo " 发布: $slug"
  echo "============================================"
  clawdhub publish "./skills/$dir" \
    --slug "$slug" \
    --name "$desc" \
    --version 1.0.0 \
    --changelog "初始版本，完整功能"
  echo "[完成] $slug"
done

echo ""
echo "============================================"
echo " 全部 13 个 skill 发布完成！"
echo "============================================"
```

> **Windows 用户**：将上述脚本保存为 `publish-all.ps1`，在 PowerShell 中运行。
> **懒人方式**：用 `clawdhub publish ./skills/image-generation --slug wechat-image-gen` 逐个执行，参数格式一致。

---

## 发布后，其他人如何一键安装

```bash
# 安装全部（懒人包，一次装完）
clawdhub install timeyour/wechat-ops-sop

# 或单独安装某个 skill
clawdhub install wechat-image-gen
clawdhub install wechat-content-writing
clawdhub install wechat-seo-geo
# ...以此类推
```

---

## Skill 依赖清单（发布时自动校验）

| Skill Slug | 环境变量 | CLI 工具 |
|-----------|---------|---------|
| wechat-image-gen | `GEMINI_API_KEY`, `DASHSCOPE_API_KEY` | python3 |
| wechat-content-writing | `DASHSCOPE_API_KEY` | — |
| wechat-typesetting | `WECHAT_APPID`, `WECHAT_SECRET`, `DASHSCOPE_API_KEY` | — |
| wechat-compliance | — | — |
| wechat-cold-start | — | — |
| wechat-growth-review | `GITHUB_TOKEN`（可选） | — |
| wechat-corpus | `DASHSCOPE_API_KEY` | — |
| wechat-seo-geo | `TENCENT_MAP_KEY` | — |
| wechat-info-gathering | `BRAVE_SEARCH_API_KEY`（可选） | — |
| wechat-data-review | — | python3 |
| wechat-topic-discovery | `DASHSCOPE_API_KEY`（可选） | — |
| wechat-theme-gallery | — | — |
| wechat-cross-platform | `DASHSCOPE_API_KEY` | — |

---

## 版本升级

```bash
# 修改 SKILL.md 中的 version 后，重新发布
clawdhub update <slug> --version 1.1.0 --changelog "新增XXX功能"

# 或全部 skill 批量升版本
for entry in "${SKILLS[@]}"; do
  IFS=':' read -r slug dir desc <<< "$entry"
  clawdhub update "$slug" --version 1.1.0 --changelog "优化+BUG修复"
done
```

---

## 常见问题

**Q: `clawdhub login` 失败？**
```bash
# 清理旧 token 重试
clawdhub logout && clawdhub login
```

**Q: slug 已被占用？**
slug 是全局唯一标识，换一个即可，例如加前缀：`timeyour-wechat-image-gen`

**Q: 发布时提示缺少环境变量？**
正常。小龙虾会提示用户"缺少以下凭证，是否继续"，用户确认后 skill 仍可加载，只是部分功能降级。
