# 速查卡 — 公众号 SOP Phase 0-8

> 完整说明见 [SOP.md](./SOP.md)。本文档用于操作时 10 秒定位当前步骤。

---

## 前置准备（首次执行，一次搞定）

```bash
# clone 执行层
git clone https://github.com/timeyour/wechat-auto-push-lib.git
cd wechat-auto-push-lib
pip install -r requirements.txt
cp .env.example .env          # 填入 WECHAT_APPID / WECHAT_APPSECRET
npm install -g @wenyan-md/cli    # 可选，排版用

# 安装 Skills（Get笔记等）
# https://clawhub.ai/iswalle/getnote
# https://www.biji.com/skill

# clone 方法层（当前仓库）
cd .. && git clone https://github.com/timeyour/wechat-ops-sop.git
```

> Obsidian / IMA / 乐享 属于可选知识沉淀层，不是首次执行前置条件。

---

## Phase 0 → 8 速查

| Phase | 名称 | 读 skill | 执行命令 | 产出 |
|:-----:|------|----------|----------|------|
| **0** | 选题 | `skills/topic-discovery/SKILL.md` | — | 标题 + 大纲 |
| **1** | 写稿 | `skills/content-writing/SKILL.md`<br>`skills/seo-geo/SKILL.md` | — | Markdown 草稿 |
| **2** | 优化 | 内容优化 skill | — | 定稿文章 |
| **3** | 配图 | `skills/image-generation/SKILL.md` | `cd ../wechat-auto-push-lib && python img_fallback.py cover "标题" --style tech` | 封面 + 内文图 |
| **4** | 合规 | `skills/compliance-check/SKILL.md` | `cd ../wechat-auto-push-lib && python compliance_check.py article.md [--strict]` | 通过 / 需修改 |
| **5** | 排版 | `skills/typesetting-publish/SKILL.md`<br>`skills/theme-gallery/SKILL.md` | WenYan + publisher.py（见下方详细命令） | HTML 草稿 |
| **6** | 飞书录入 | — | `cd ../wechat-auto-push-lib && python _feishu_add_record.py` | 记录已存 |
| **7** | 冷启动 | `skills/cold-start/SKILL.md` | 手动：转发群 + 小号互动 | 互动信号 |
| **8** | 24h复盘 | `skills/data-review/SKILL.md`<br>`skills/growth-review/SKILL.md` | — | 复盘报告 |

---

## 可选知识沉淀层

| 目标 | 适合什么场景 |
|------|--------------|
| **Obsidian** | 个人长期研究、专题积累 |
| **IMA** | 个人云端随时查 |
| **乐享** | 团队共享和协作 |

默认挂在信息采集之后。想先把文章跑通，可以先完全跳过。

---

## 三条铁律

| 规则 | 说明 |
|------|------|
| 🔴 BLOCKER 必须清零 | Phase 4 合规检查出现 BLOCKER，不进入 Phase 5 |
| 🕐 发布时间锁 20:00 | Phase 5 排版发布后，次日 20:00 发 |
| 📋 录飞书不能忘 | Phase 6 在发布当天执行，数据不丢失 |

---

## 环境变量（缺少则降级或跳过）

| 变量 | 用途 | 必需 |
|------|------|------|
| `WECHAT_APPID` / `WECHAT_APPSECRET` | 公众号发布 | 是 |
| `DASHSCOPE_API_KEY` | 豆包模型（写作/排版） | 推荐 |
| `GEMINI_API_KEY` | 图片生成（优先） | 可选 |
| `BRAVE_SEARCH_API_KEY` | 信息采集 | 可选 |
| `GITHUB_TOKEN` | 运营复盘 | 可选 |

---

## Phase 5 排版命令（完整步骤）

```bash
# 1. 选主题 → skills/theme-gallery/SKILL.md

# 2. WenYan 排版
cd ../wechat-auto-push-lib
node wenyan_render.mjs article.md out.html

# 3. 用户预览确认后

# 4. 推送草稿（WenYan路径）
cd ../wechat-auto-push-lib
python wechat_api/publisher.py --html out.html
```
