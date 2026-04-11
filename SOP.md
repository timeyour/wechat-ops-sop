# 公众号运营 SOP — Phase 0-8 全流程

> 从选题到复盘，完整发布链路。AI Agent 驱动，半自动化执行。

---

## ⚠️ 前置依赖

本 SOP 依赖两个安装项：

### 1. 执行层 — 公众号脚本库

Phase 3-6 调用的脚本由 [wechat-auto-push-lib](https://github.com/timeyour/wechat-auto-push-lib) 提供：

```bash
git clone https://github.com/timeyour/wechat-auto-push-lib.git
cd wechat-auto-push-lib
pip install -r requirements.txt
cp .env.example .env            # 编辑填入 AppID / AppSecret

# 可选：安装 wenyan-cli 排版引擎
npm install -g @wenyan-md/cli
```

> 所需脚本：`img_fallback.py`、`compliance_check.py`、`wechat_api/publisher.py`、`_feishu_add_record.py` 均在 `wechat-auto-push-lib/` 目录下。
> 使用 SOP 前确保执行层仓库已就位。

### 2. Skills — AI Agent 技能包

14 个运营 Skills（见 `skills/README.md`），以及 Get笔记 Skill（精选内容采集）：

| Skill | 安装地址 |
|-------|----------|
| **Get笔记**（精选内容采集）| https://clawhub.ai/iswalle/getnote |

> 快速安装：https://www.biji.com/skill

### 3. 素材预处理（可选入口）

如果文章素材已有（会议录音、文档、视频等），先经过预处理再进入 Phase 1：

| 素材类型 | 处理方式 | 输出 |
|----------|----------|------|
| 会议笔记 / 文档 | LLM 整理结构化要点 | Markdown 大纲 |
| 视频 / 录音 | Whisper/API 转录 → LLM 摘要 | Markdown 要点 |
| 已有草稿 / 半成品 | LLM 润色 + 结构调整 | 可投稿文章 |

> 输出：Markdown 要点/大纲 → **直接进入 Phase 1 写稿**
> 三种入口（选题写稿 / 素材转公众号 / 自选题）最终都汇入 Phase 1，共用执行层脚本。

### 4. 知识沉淀层（可选，不阻塞首次上手）

> 用途：把采集过的素材、专题总结、复盘结果沉淀到知识库，方便后续复用。

| 目标 | 用途 | 是否首次必需 |
|------|------|--------------|
| **Obsidian** | 个人研究、长线专题、第二大脑 | 否 |
| **IMA** | 个人云端笔记，跨设备查阅 | 否 |
| **乐享** | 团队共享、协作沉淀 | 否 |

**建议：**
- 第一次跑 SOP：先跳过这层
- 已开始稳定产出：再把高价值专题同步进去
- 有团队协作需求：再加乐享

> 这层默认挂在 `info-gathering` 之后，本质是“沉淀经验”，不是“阻塞发布”。

---

## Phase 0 — 选题

**执行前读：** `skills/topic-discovery/SKILL.md`

**操作步骤：**

1. 用信息差思维搜索候选选题（百度/GitHub/Reddit/HN/X/微博/知乎）
2. 按评估框架打分（总分≥20分才写）
3. 生成 5 个候选标题（格式：高频搜索词 + 数字 + 信息差，≤30字）
4. 用户敲定标题
5. 用户提供文章结构和大纲

**输出：** 敲定的标题 + 文章大纲

---

## Phase 1 — 写稿

**执行前读：**
- `skills/content-writing/SKILL.md`
- `skills/seo-geo/SKILL.md`（ERE框架+v1.1）

**要求：**

- 2000-3500字
- 内置合规：AI标注 + 图片来源 + 标题≤30字 + 文末在看引导
- 内置SEO：前300字自然植入关键词、文末3-5个话题标签
- 内置GEO：总分总 + 模块化 + Q&A + 数据佐证

**文章结构：**

- **开头黄金300字**：痛点共鸣 + 内容预告，直接给结论
- **正文**：洋葱结构，每段≤3行，每300字穿插图片或互动话术
- **结尾**：3句总结 + 互动提问 + 在看引导

**输出：** Markdown 格式文章初稿

---

## Phase 2 — 内容优化（非技术文适用）

> 技术干货文跳过此步，避免改歪。

**操作：** 多代理辩论 + 盲测投票，重点优化：
- 标题
- 开头钩子
- 金句
- 总结段

**输出：** 定稿文章

---

## Phase 3 — 配图

**执行前读：** `skills/image-generation/SKILL.md`（5级降级链 v1.1）

**操作：**

```bash
# img_fallback.py 来自 wechat-auto-push-lib/
cd ../wechat-auto-push-lib && python img_fallback.py cover "文章标题" --style tech
```

自动走 5 级降级链：截图(Crawl4ai) → 豆包4.0 → 豆包4.5 → Unsplash图库 → 输出prompt

**产出：**

| 类型 | 尺寸 | 数量 |
|------|------|------|
| 封面 | 900×383 | 1张 |
| 内文配图 | 1664×936 | 2-3张 |

**配图时机：**
- 第1张：开头300字内
- 第2张：中段
- 第3张：结尾前

---

## Phase 4 — 合规检查

**执行前读：** `skills/compliance-check/SKILL.md`

**操作：**

```bash
# compliance_check.py 来自 wechat-auto-push-lib/
cd ../wechat-auto-push-lib && python compliance_check.py article.md [--strict]
```

**三档结果：**

| 级别 | 含义 | 处理 |
|------|------|------|
| 🔴 BLOCKER | 不修改不能推 | 必须修改后才能进入下一步 |
| 🟡 REQUIRED | 提醒补内容 | 建议修改 |
| 🟢 SUGGEST | 建议优化 | 可选 |

> 只有全部 BLOCKER 清零才能推草稿。

---

## Phase 5 — 排版发布

**执行前读：** `skills/typesetting-publish/SKILL.md`

**操作步骤：**

1. **选主题**：`skills/theme-gallery/SKILL.md`（8个主题可选，`pie` 为科技/AI 默认）
2. **WenYan 排版**：`cd ../wechat-auto-push-lib && node wenyan_render.mjs article.md out.html`
3. **用户预览确认**：修改直到满意
4. **推送草稿**：
   - WenYan 路径（原创/手动编辑文章）：`cd ../wechat-auto-push-lib && python wechat_api/publisher.py --html out.html`
   - RSS 路径（转载/翻译文章）：`cd ../wechat-auto-push-lib && python main.py`
   - 两者最终都进入 mp.weixin.qq.com 草稿箱，需手动点「群发」

**发布时间：** 锁定 20:00（晚上8点）

---

## Phase 6 — 录飞书

```bash
# _feishu_add_record.py 来自 wechat-auto-push-lib/
cd ../wechat-auto-push-lib && python _feishu_add_record.py
```

记录：标题 / 发布日期 / 选题类型 / 预估字数 / 封面类型 / 关键词 / 状态

---

## Phase 7 — 冷启动（发布后前2小时）

> 这是黄金窗口，决定文章能否进入推荐流量池。

**操作：**

1. 转发到 3-5 个精准群
   - 话术："求各位大佬看下最后一段逻辑对不对"（不是求关注，是求反馈）
2. 5个朋友帮忙点开 + 留言（停留>30秒提升完读率）
3. 自己小号在评论区提问引发讨论
4. 回复前 10 条留言

**绝对禁止：**
- ❌ 死水群群发（秒退 = 完读率暴跌）
- ❌ 互关互阅群（低质量互动被识别）
- ❌ 朋友圈刷屏（降低信任度）

---

## Phase 8 — 24h 复盘

**执行前读：**
- `skills/data-review/SKILL.md`
- `skills/growth-review/SKILL.md`
- `skills/cold-start/SKILL.md`

**核心指标：**

| 指标 | 优秀 | 合格 | 差 |
|------|------|------|-----|
| 完读率 | >65% | >50% | <40% |
| 推荐率 | >85% | >50% | — |
| 分享率 | >15% | >5% | <2% |

**复盘问题：**

1. 哪个环节卡了/返工了？
2. SOP 缺了还是没按 SOP 执行？
3. 需要更新 skill 吗？

---

## Skill 索引

| Phase | Skill | 文件 |
|-------|-------|------|
| 0 选题 | topic-discovery | `skills/topic-discovery/SKILL.md` |
| 0 语料 | corpus-playbook | `skills/corpus-playbook/SKILL.md` |
| 信息采集 | info-gathering | `skills/info-gathering/SKILL.md`（含知识管线 + Obsidian / IMA / 乐享 三路分发） |
| 信息采集（精选） | saymore-fetch | `skills/saymore-fetch/SKILL.md` |
| 1 写稿 | content-writing | `skills/content-writing/SKILL.md` |
| 内容优化 | 内容优化 skill | （多代理辩论工作流） |
| 3 配图 | image-generation | `skills/image-generation/SKILL.md` |
| 4 合规 | compliance-check | `skills/compliance-check/SKILL.md` |
| 5 排版 | typesetting-publish | `skills/typesetting-publish/SKILL.md` |
| 5 主题 | theme-gallery | `skills/theme-gallery/SKILL.md` |
| 7 冷启动 | cold-start | `skills/cold-start/SKILL.md` |
| 8 复盘 | data-review | `skills/data-review/SKILL.md` |
| 全局复盘 | growth-review | `skills/growth-review/SKILL.md` |
| 分发 | cross-platform | `skills/cross-platform/SKILL.md` |
| SEO/GEO | seo-geo | `skills/seo-geo/SKILL.md`（ERE框架+v1.1） |
