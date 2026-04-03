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
# 安装全部 13 个 skill
clawdhub install wechat-ops-sop

# 或单独安装某个 skill
clawdhub install wechat-image-gen
clawdhub install wechat-seo-geo
```

发布方式见 [PUBLISH.md](PUBLISH.md)。

---


## 环境变量：零配置即可开始

**所有 Skill 都有降级链，不配置任何 Key 也能用。** 按需添加，Key 越多功能越强。

### 只配 1 个 Key（推荐起步）

```bash
export DASHSCOPE_API_KEY="your_key"   # 阿里云通义千问/通义万相
```

凭一个 DASHSCOPE Key 可用：内容写作、配图生成、排版、语料学习、SEO/GEO、信息采集（豆包模型）。

### 按需追加

| 变量 | 什么时候需要 | 用途 |
|------|------------|------|
| `GEMINI_API_KEY` | 想用 Gemini 生图 | 图片生成（优先级更高） |
| `WECHAT_APPID` / `WECHAT_SECRET` | 想自动推草稿箱 | 公众号发布 |
| `TENCENT_MAP_KEY` | 想用地理位置 SEO | SEO + GEO 优化 |
| `BRAVE_SEARCH_API_KEY` | 想用 Brave 搜索 | 信息采集（替代豆包搜索） |
| `GITHUB_TOKEN` | 想抓 GitHub 数据 | 运营复盘 |

### 无 Key 时的降级行为

| Skill | 无 Key 降级到 |
|-------|--------------|
| 配图生成 | Unsplash 免费图库 / 纯文字 prompt |
| 内容写作 | 本地推理（需本地模型） |
| 信息采集 | 豆包搜索（DASHSCOPE Key） |
| SEO/GEO | 手动查百度指数、腾讯位置服务 |
| 运营复盘 | 手动登录后台导出数据 |


---

## 仓库结构

```
wechat-ops-sop/
├── SOP.md                        ← Phase 0-8 完整操作流程
├── README.md                     ← 本文件
├── install.ps1                   ← Windows 一键安装脚本
├── install.sh                     ← Mac/Linux 一键安装脚本
├── PUBLISH.md                    ← Clawdhub 发布指南
├── .gitignore
├── references/                    ← 运营经验库（SEO指南+文章产出+Session日志）
│   ├── seo-geo/                  ← SEO + GEO 参考资料
│   ├── articles/                 ← 本次实际产出文章 + 合规报告
│   └── sessions/                 ← Session 操作日志
└── skills/                       ← 13 个独立 Skill（Clawdhub 标准格式）
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

### 2. 配置环境变量

复制 `.env.example`（从 [wechat-auto-push-lib](https://github.com/timeyour/wechat-auto-push-lib) 复制），填入需要的 API Key。

### 3. 开始运营

按 [SOP.md](SOP.md) 中的 Phase 0-8 顺序执行各 Skill。

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
| **image-generation** | 截图优先，Gemini+豆包双引擎降级链 |
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
