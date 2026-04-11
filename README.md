# wechat-ops-sop

> 公众号内容工厂的方法层：AI Agent 驱动的选题→写稿→配图→合规→发布→复盘 SOP。

> 执行层实现见 [wechat-auto-push-lib](https://github.com/timeyour/wechat-auto-push-lib)

---

## 3 分钟开始

```bash
git clone https://github.com/timeyour/wechat-ops-sop.git && cd wechat-ops-sop && .\install.ps1
```

---

## 一键安装（两种方式）

### 方式 A：GitHub 懒人包（无需账号，推荐）

```bash
git clone https://github.com/timeyour/wechat-ops-sop.git
cd wechat-ops-sop
# Windows:
.\install.ps1
# Mac/Linux:
chmod +x install.sh && ./install.sh
```

### 方式 B：Clawdhub 一键（小龙虾/OpenClaw 用户）

```bash
# 安装全部 14 个 skill
clawdhub install wechat-ops-sop

# 或单独安装某个 skill
clawdhub install wechat-image-gen
clawdhub install wechat-seo-geo
```

发布方式见 [PUBLISH.md](PUBLISH.md)。

---

## 环境变量（可选，首次使用配置）

| 变量 | 用途 | 必填 |
|------|------|------|
| `DASHSCOPE_API_KEY` | 豆包模型（内容写作、排版、语料等核心功能） | **推荐配置** |
| `GEMINI_API_KEY` | 图片生成（可选，有则优先） | 可选 |
| `WECHAT_APPID` / `WECHAT_SECRET` | 公众号发布 | 可选 |
| `TENCENT_MAP_KEY` | SEO + GEO 优化 | 可选 |
| `BRAVE_SEARCH_API_KEY` | 信息采集 | 可选 |
| `GITHUB_TOKEN` | 运营复盘 | 可选 |

---

## 仓库结构

```
wechat-ops-sop/
├── SOP.md                        ← Phase 0-8 完整操作流程
├── QUICKREF.md                   ← 速查卡（操作时 10 秒定位当前步骤）
├── README.md                     ← 本文件
├── install.ps1                   ← Windows 一键安装脚本
├── install.sh                     ← Mac/Linux 一键安装脚本
├── PUBLISH.md                    ← Clawdhub 发布指南
├── .gitignore
└── skills/                       ← 14 个独立 Skill（Clawdhub 标准格式）
    ├── topic-discovery/          ← 选题发现
    ├── corpus-playbook/          ← 语料学习 + 30话题画廊
    ├── info-gathering/            ← 全网信息采集
    ├── saymore-fetch/            ← Saymore 精选内容抓取
    ├── content-writing/           ← 洋葱结构写作
    ├── seo-geo/                  ← SEO + GEO 优化（ERE框架+v1.1）
    ├── image-generation/          ← 5级配图降级链（v1.1）
    ├── theme-gallery/             ← 8个排版主题
    ├── typesetting-publish/       ← 排版 → 发布全流程
    ├── compliance-check/           ← 16项合规审核
    ├── cold-start/                ← 冷启动策略
    ├── data-review/               ← 数据复盘
    ├── cross-platform/            ← 跨平台分发
    └── growth-review/             ← 全局增长复盘
```

---

## 快速开始

### 1. 克隆项目

```bash
git clone https://github.com/timeyour/wechat-ops-sop.git
cd wechat-ops-sop
```

### 2. 安装依赖（Python）

```bash
pip install feedparser beautifulsoup4 readability-lxml pillow requests
```

### 3. 配置文件

参考 [wechat-auto-push-lib](https://github.com/timeyour/wechat-auto-push-lib) 中的 `config.example.py` 配置微信 API 凭证。

### 4. 开始运营

按 `SOP.md` 中的 Phase 0-8 顺序执行。

---

## 核心工作流

```
选题 (Phase 0)
  └→ 语料学习 (corpus-playbook)
       └→ 信息采集 (info-gathering)
            └→ 写稿 (Phase 1) → 内容优化 (Phase 2)
                 └→ 配图 (Phase 3)
                      └→ 合规检查 (Phase 4)
                           └→ 排版发布 (Phase 5)
                                └→ 飞书录入 (Phase 6)
                                     └→ 冷启动 (Phase 7)
                                          └→ 数据复盘 (Phase 8)
                                               └→ 跨平台分发 (cross-platform, 可选)
```

详细 SOP → 参见 [SOP.md](SOP.md)

---

## 14 个 Skills

| Skill | 用途 |
|-------|------|
| **topic-discovery** | 信息差选题，评估框架，标题公式 |
| **corpus-playbook** | 30话题画廊，历史文章风格学习 |
| **info-gathering** | 全网素材收集 + 知识管线（raw→wiki→三路分发） |
| **saymore-fetch** | Saymore 精选内容（GitHub Repos / AI Builders / Polymarket） |
| **content-writing** | 洋葱结构，完读率优先 |
| **seo-geo** | 搜一搜优化 + AI搜索优化（ERE框架+v1.1） |
| **image-generation** | 5级降级链（截图→豆包4.0→豆包4.5→Unsplash→prompt+v1.1） |
| **theme-gallery** | 8主题画廊，点选切换 |
| **typesetting-publish** | WenYan排版→合规→推草稿→冷启动 |
| **compliance-check** | 16项检查（红线+必须+优化） |
| **cold-start** | 前2h生死期，流量池闯关 |
| **data-review** | 48h考核期分析，优化建议 |
| **cross-platform** | 公众号→知乎/小红书/视频号分发 |
| **growth-review** | 全局运营决策校验 |

详见 `skills/README.md`

---

## 配套工具库

完整技术实现（RSS抓取、微信API、wenyan排版、封面生成）见另一仓库：

**[wechat-auto-push-lib](https://github.com/timeyour/wechat-auto-push-lib)**

---

## 设计参考

- 设计范式：[slavingia/skills](https://github.com/slavingia/skills)
- 理论基础：《The Minimalist Entrepreneur》by Sahil Lavingia
- 运营知识：IMA知识库

---

## License

MIT
