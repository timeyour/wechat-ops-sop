---
name: saymore-fetch
description: Saymore.app 精选内容抓取。快速获取 AI 行业情报（GitHub AI Repos、AI Builders、Polymarket 大户动态等），用于选题发现和素材采集。当需要采集 AI 行业一手信息时使用。
description_zh: "Saymore.app 精选内容抓取（GitHub AI Repos / AI Builders / Polymarket 动态）"
description_en: "Saymore.app curated content fetcher for AI industry intel (GitHub repos, AI Builders, Polymarket)"
version: 1.0.0
emoji: "📡"
metadata:
  openclaw:
    requires:
      bins:
        - python3
---

你是信息采集专家，负责从 Saymore.app 抓取精选内容订阅源。

## 功能概述

- 列出所有已订阅的 Collection
- 按 Collection ID 抓取最新条目（分页）
- 按 24h 活跃度排序抓取 Top Collection
- 预设快捷键：GitHub、AI Builders、Polymarket、Musk 等

## 安装

```bash
pip install requests
```

## 凭证配置

在脚本顶部设置 API Key：

```python
API_KEY = "smai_<YOUR_KEY>"   # 替换为你的 Saymore AI Key
```

> 获取方式：访问 https://saymore.app → 登录 → 设置 → API Key

## CLI 用法

```bash
# 列出所有订阅
python saymore_fetch.py list

# 抓取指定 Collection（替换 <ID> 为 Collection ID）
python saymore_fetch.py fetch <ID>

# 抓取 Top 3 最活跃 Collection
python saymore_fetch.py top

# 使用预设快捷键
python saymore_fetch.py github     # GitHub 1k+ AI Agent Repos
python saymore_fetch.py builders   # 张咋啦推荐的 AI Builders
python saymore_fetch.py us-ai     # 美国 AI 公司动态
python saymore_fetch.py polymarket# Polymarket 大户跟踪
python saymore_fetch.py musk      # 马斯克相关动态
```

## Python API

```python
import sys
sys.path.insert(0, "<脚本所在目录>")
from saymore_fetch import list_subscriptions, fetch_collection, fetch_top, PRESETS

# 列出所有订阅
list_subscriptions()

# 抓取指定 Collection
fetch_collection(cid=68, limit=10)

# 抓取 Top 3
fetch_top(limit=3)

# 使用预设
cid = PRESETS["github"]  # 68
fetch_collection(cid)
```

## 常用 Collection ID 参考

| 快捷键 | ID | 名称 |
|--------|-----|------|
| `github` | 68 | GitHub 1k+ AI Agent Repos |
| `builders` | 51 | 张咋啦 AI Builders |
| `us-ai` | 18 | 美国 AI 公司 |
| `polymarket` | 27 | Polymarket 大户跟踪 |
| `musk` | 22 | 马斯克相关动态 |
| — | — | 更多 ID 用 `list` 命令查看 |

## 与其他工具联动

### 联动 RSS Monitor（公众号内容监控）

```python
# 在 rss_monitor.py 的 scrape_url() 中加入 Saymore
import subprocess, sys
result = subprocess.run(
    [sys.executable, "saymore_fetch.py", "github"],
    capture_output=True, text=True
)
print(result.stdout)
```

### 联动微信公众号推送

在公众号推送流程中，Saymore 作为内容来源输入：

```
Saymore(github/builders) → AI 分析 → 文章生成 → 合规检查 → 封面生成 → 推草稿
```

### 联动 Polymarket Research

```python
# polymarket_research.py 中的 research_from_saymore() 可扩展为：
# 1. 从 Saymore polymarket collection 取热门市场 URL
# 2. 逐一调用 Gemini Deep Research
# 3. 保存研究报告到指定目录
```

## 使用场景

| 场景 | 推荐 Collection | 用途 |
|------|----------------|------|
| AI Agent 技术选型 | `github` | 发现新兴框架、工具趋势 |
| 创始人/产品动态 | `builders` | 竞品分析、行业洞察 |
| 预测市场情报 | `polymarket` | 热点事件、舆论风向 |
| 大佬观点追踪 | `musk` | 马斯克系动态 |
| 美国科技动态 | `us-ai` | 政策、行业趋势 |

## 输出

1. Collection 条目列表（标题 / URL / 摘要 / 热度）
2. 按 24h 活跃度排序的 Top Collection
3. 适合直接作为选题或素材输入到后续流程
