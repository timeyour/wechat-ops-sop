# corpus-playbook — 语料学习与写作手册 Skill

> 学 YouMind 的语料学习 + 改稿迭代功能，在 WorkBuddy 里原生实现。

## 核心功能

1. **30 话题画廊** — 浏览器点选，从 6 大类 30 个话题中选写作方向
2. **历史文章语料库** — 把写得最好的历史文章放入 corpus/，AI 分析你的写作风格
3. **Playbook 自动生成** — `build-playbook.py` 基于语料 + 话题，生成该话题的专属写作手册
4. **改稿反馈学习** — `learn-revision.py` 对比 AI 稿 vs 人工修改稿，提取风格差异点
5. **迭代机制** — 每积累 5 条改稿记录 → Playbook 自动更新，AI 写作越来越像你

---

## 目录结构

```
corpus-playbook/
├── corpus/           ← 历史文章（.md / .txt）
│   ├── Claude_Code_深度体验30天.md
│   └── …
├── lessons/          ← 改稿反馈记录（JSON）
│   ├── 20260401120000.json
│   └── …
├── playbooks/        ← 生成的写作手册（按话题ID命名）
│   ├── 01_AI工具实测.md
│   ├── 11_新手入门.md
│   └── …
├── config.json       ← 配置
├── build-playbook.py ← 生成写作手册
├── learn-revision.py ← 改稿学习
└── topic-gallery.html ← 30话题画廊（浏览器打开）
```

---

## 快速开始

### Step 1 — 放入历史文章

把写得最好的 10-30 篇公众号文章（Markdown 格式）放入：

```
./corpus-playbook/corpus/
```

> 若将本项目克隆到本地，路径为 `<项目根目录>/corpus-playbook/corpus/`

文件名格式建议：`话题_序号.md`（如 `AI工具实测_001.md`）

### Step 2 — 打开话题画廊

```
open corpus-playbook/topic-gallery.html
```

或告诉 AI：`打开话题画廊`，然后在浏览器中点选今天要写的话题。

### Step 3 — 生成写作手册

选好话题后，复制命令到终端运行：

```bash
# 例如选了「AI工具实测」（话题ID=1）
python corpus-playbook/build-playbook.py 1

# 查看所有已有手册
python corpus-playbook/build-playbook.py list

# 强制重新生成（覆盖已有手册）
python corpus-playbook/build-playbook.py 1 --force
```

### Step 4 — 用 Playbook 写稿

生成的 `playbooks/ID_话题名.md` 就是该话题的专属写作手册。告诉 AI：

> "请参考 `corpus-playbook/playbooks/01_AI工具实测.md` 写作手册，写一篇关于 XXX 的公众号文章。"

---

## 命令速查

| 操作 | 命令 |
|------|------|
| 生成写作手册 | `python build-playbook.py <话题ID>` |
| 列出已有手册 | `python build-playbook.py list` |
| 添加改稿记录 | `python learn-revision.py add <AI稿.md> <人工稿.md>` |
| 查看改稿记录 | `python learn-revision.py list` |
| 改稿统计 | `python learn-revision.py stats` |

---

## 30 个话题（话题ID速查）

| ID | 话题 | 分类 | 推荐格式 |
|----|------|------|---------|
| 1 | AI工具实测 | 🛠 工具 | 横评+截图+评分 |
| 2 | GitHub热榜解读 | 🛠 工具 | 项目+演示+场景 |
| 3 | 效率技巧 | 🛠 工具 | 清单+步骤+对比 |
| 4 | Prompt工程 | 🛠 工具 | 模板+原理+举例 |
| 5 | 开发者工具 | 🛠 工具 | 对比+安装+推荐 |
| 6 | AI行业观察 | 💡 洞察 | 数据+判断+观点 |
| 7 | 产品分析 | 💡 洞察 | 分析+场景+总结 |
| 8 | 技术原理 | 💡 洞察 | 类比+要点+案例 |
| 9 | 创业思考 | 💡 洞察 | 经历+数据+方法 |
| 10 | AI替代观察 | 💡 洞察 | 对比+数据+建议 |
| 11 | 新手入门 | 📖 教程 | 步骤+截图+FAQ |
| 12 | 工具对比 | 📖 教程 | 打分+推荐+表格 |
| 13 | 自动化流程 | 📖 教程 | 流程图+工具+代码 |
| 14 | 本地部署 | 📖 教程 | 环境+命令+效果 |
| 15 | API接入 | 📖 教程 | 代码+成本+踩坑 |
| 16 | 技术解读 | 📖 教程 | 概念+细节+场景 |
| 17 | 观点输出 | ✍️ 观点 | 观点+逻辑+反例 |
| 18 | 避坑指南 | ✍️ 观点 | 问题+原因+正确做法 |
| 19 | 行业预测 | ✍️ 观点 | 趋势+预测+节点 |
| 20 | 冷知识 | ✍️ 观点 | 清单+叙述+配图 |
| 21 | 个人故事 | 📖 故事 | 时间线+数字+总结 |
| 22 | 案例拆解 | 📖 故事 | 背景+做法+数据 |
| 23 | 幕后花絮 | 📖 故事 | 过程+数据+反思 |
| 24 | 失败复盘 | 📖 故事 | 背景+原因+教训 |
| 25 | 资源合集 | 📦 合集 | 列表+链接+说明 |
| 26 | Prompt合集 | 📦 合集 | Prompt+场景+效果 |
| 27 | 书单推荐 | 📦 合集 | 书籍+推荐+顺序 |
| 28 | 工具清单 | 📦 合集 | 工具+用途+获取 |
| 29 | 热点追踪 | 🔥 热点 | 事件+观点+判断 |
| 30 | 选题参考 | 🔥 热点 | 选题+角度+SEO |

---

## 改稿学习工作流

每次发文章后，如果手动改了 AI 生成的草稿：

```bash
# 对比 AI 生成的草稿 vs 你最终发布版本
python learn-revision.py add ai_draft.md final_published.md

# 查看改稿统计（了解自己最常改哪些方面）
python learn-revision.py stats
```

积累 **5 条**改稿记录后，重新生成 Playbook：

```bash
python build-playbook.py <话题ID> --force
```

AI 会基于改稿规律调整写作规范，越来越像你的风格。

---

## 与内容写作 Skill 的集成

**内容写作 Skill**（`content-writing`）写稿时，自动引用对应话题的 Playbook：

```
用户：写一篇 GitHub 热榜解读
         ↓
Skill：检测话题ID=2
         ↓
读取 corpus-playbook/playbooks/02_GitHub热榜解读.md
         ↓
按 Playbook 中的结构规范 + 语料风格写稿
         ↓
输出初稿
```

---

## 技术说明

- **Playbook 生成**：纯规则引擎，无需 AI API（风格检测基于段落长度、数字密度、问句频率等指标）
- **改稿学习**：基于文本差异分析，无需 AI（diff 提取使用正则规则）
- **话题画廊**：纯 HTML+JS，localStorage 持久化，无需后端
- **语料库管理器**：corpus-manager.html 支持粘贴/预览/导出（无文件系统写入依赖）

---

## 文件路径

- **基础路径**：`<项目根目录>/corpus-playbook/`
- **画廊**：`corpus-playbook/topic-gallery.html`
- **语料库管理**：`corpus-playbook/corpus-manager.html`
- **监控面板**：`corpus-playbook/monitor.html`
- **Build 脚本**：`corpus-playbook/build-playbook.py`
- **改稿脚本**：`corpus-playbook/learn-revision.py`

## 热点监控数据源（monitor.html）

| 工具 | 地址 | 用途 |
|------|------|------|
| WeWrite | github.com/oaker-io/wewrite | 全流程AI写作Skill（1.1k Stars，MIT协议） |
| 低粉爆文 | newrank.cn/hotInfo?platform=weixin | 小号爆文追踪，找信息差选题 |
| 今日热榜 | tophub.today | 100+平台实时热榜聚合（实时/日/周/月） |
| 推特起爆 | sopilot.net/zh/hot-tweets | 推特起爆帖监控，2h黄金窗口，RSS: sopilot.net/rss/hottweets |
| NewsNow | newsnow.busiyi.world | 开源新闻聚合，PWA支持离线阅读 |
| Agent-Reach | 内置 WorkBuddy | Reddit/RSS/GitHub/V2EX 多源信息采集 |
