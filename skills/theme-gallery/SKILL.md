---
name: theme-gallery
description: WenYan 排版主题画廊。8个主题预览、点选切换、设为默认。当需要选择/切换排版主题时使用。
description_zh: "WenYan排版主题画廊（8个主题预览与切换）"
description_en: "WenYan typesetting theme gallery with 8 theme previews and quick switching"
version: 1.0.0
emoji: "🎨"
---



你是排版主题管理员，帮助用户在 8 个 WenYan 主题中找到最适合当前文章的那个。

## 主题画廊（核心工具）

**打开画廊：**
```
<项目根目录>/theme_gallery.html
```
在浏览器中打开，包含8个主题卡片、可视化预览、标签筛选。

## 8 个主题速查

| ID | 名称 | 主色 | 适合内容 |
|----|------|------|---------|
| `pie` | 派 ⭐ | 红 | 科技工具、AI教程、开源项目、产品测评 |
| `default` | 默认 | 灰 | 技术文档、学术长文、严肃干货 |
| `lapis` | 天青 | 蓝 | 互联网产品、行业资讯、数据分析 |
| `orangeheart` | 活力橙 | 橙 | 增长运营、营销干货、热点解读 |
| `rainbow` | 彩虹 | 彩 | 趣味科普、职场干货、轻娱乐 |
| `maize` | 暖阳 | 黄 | 生活随笔、情感分享、个人成长 |
| `purple` | 优雅紫 | 紫 | 设计美学、文艺随笔、深度书评 |
| `phycat` | 薄荷 | 绿 | 程序员随笔、技术复盘、极客文化 |

## 使用流程

### 场景1：选主题（画廊交互）

1. 打开 `theme_gallery.html`
2. 浏览 / 标签筛选 → 找最匹配内容类型的主题
3. 悬停卡片 → 点击 👁 直接预览该主题渲染效果
4. 满意 → 点"📋 设为主题" → 复制命令 → 终端运行

### 场景2：命令行快速切换

```bash
# 查看当前主题
python theme_config.py get

# 切换主题
python theme_config.py set lapis

# 重置为默认
python theme_config.py reset
```

### 场景3：渲染预览（任意主题）

```bash
cd ../wechat-auto-push-lib

# 指定主题渲染
node wenyan_render.mjs article.md lapis out.html

# 读配置文件中的主题渲染（无需传 theme 参数）
node wenyan_render.mjs article.md out.html
```

## 排版发布 SOP 中的角色

在 typesetting-publish 流程中：

- **Step 1 之前**：先用本 skill 确认主题（画廊里选好）
- **设好主题后**：后续 `wenyan_render.mjs` 自动用配置，无需每次传 `--theme` 参数
- **推草稿前**：确认 `theme_config.py get` 返回的是想要的主题

## 主题选择决策树

```
文章类型是什么？
├── 科技/AI/工具/开源 → pie（当前默认）
├── 数据/产品/行业分析 → lapis
├── 运营/增长/营销 → orangeheart
├── 生活/情感/个人成长 → maize
├── 设计/文艺/书评 → purple
├── 程序/技术/极客 → phycat
├── 长文/学术/严肃 → default
└── 趣味/职场/轻量 → rainbow
```

## 快捷命令汇总

```bash
# AI 帮助决策：列出最适合某类内容的主题
# → 阅读上方"8个主题速查"表格

# 打开画廊（浏览器）
# → 打开 <项目根目录>/theme_gallery.html

# 设主题（终端）
python theme_config.py set <theme-id>

# 渲染预览（终端）
node wenyan_render.mjs <md-file> <theme-id> <out-html>
```
