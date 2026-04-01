# 公众号运营 SOP + Skills 体系

> 从选题到复盘，AI Agent 驱动的半自动化公众号运营工具链。

**定位：AI 实用派** — 不追一手资讯，追第一手实操解读。

---

## 仓库结构

```
wechat-ops-sop/
├── SOP.md                        ← Phase 0-8 完整操作流程
├── README.md                     ← 本文件
├── .gitignore
└── skills/                       ← 13 个独立 Skill
    ├── README.md                 ← Skill 索引
    ├── topic-discovery/          ← 选题发现
    ├── corpus-playbook/          ← 语料学习 + 30话题画廊
    ├── info-gathering/            ← 全网信息采集
    ├── content-writing/           ← 洋葱结构写作
    ├── seo-geo/                  ← SEO + GEO 优化
    ├── image-generation/          ← 配图降级链
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

## 13 个 Skills

| Skill | 用途 |
|-------|------|
| **topic-discovery** | 信息差选题，评估框架，标题公式 |
| **corpus-playbook** | 30话题画廊，历史文章风格学习 |
| **info-gathering** | 全网素材收集，多源交叉验证 |
| **content-writing** | 洋葱结构，完读率优先 |
| **seo-geo** | 搜一搜优化 + AI搜索优化 |
| **image-generation** | 截图优先，豆包封面降级链 |
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
