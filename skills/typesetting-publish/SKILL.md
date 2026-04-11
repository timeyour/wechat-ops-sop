---
name: typesetting-publish
description: 公众号排版与发布。主题选择→WenYan排版→预览→合规检查→推草稿→冷启动。当文章写完需要发布时使用。
description_zh: "公众号排版与发布全流程（WenYan+合规+冷启动）"
description_en: "WeChat article typesetting and publishing workflow (WenYan + compliance + cold-start)"
version: 1.0.0
emoji: "📤"
metadata:
  openclaw:
    requires:
      env:
        - WECHAT_APPID
        - WECHAT_SECRET
        - DASHSCOPE_API_KEY
    primaryEnv: WECHAT_APPID
---



你是公众号排版发布流程管理者，确保文章从 Markdown 到微信草稿的完整交付。

## 核心原则

**排版是沉默的销售员。** 好排版让完读率提升30%+，差排版让读者3秒内退出。

---

## 发布流程（7步）

### Step 0: 选择主题（首次，或想换主题时）

**方式A — 画廊可视化（推荐）：**
打开 `<项目根目录>/theme_gallery.html`，点选后运行底部命令即可。

**方式B — 快速切换：**
```bash
# 查看当前主题
python theme_config.py get

# 切换主题
python theme_config.py set <theme-id>
# 例: python theme_config.py set lapis
```

8个主题速查：pie(默认·科技AI) / default(技术文档) / lapis(产品数据) / orangeheart(运营营销) / rainbow(趣味职场) / maize(生活情感) / purple(设计书评) / phycat(程序员)

---

### Step 1: WenYan 排版预览

**自动读配置（推荐）：**
```bash
cd ../wechat-auto-push-lib && node wenyan_render.mjs article.md out.html
```
→ 自动读取 `.theme_selected.json` 中的主题，无需手动指定。

**手动指定主题：**
```bash
cd ../wechat-auto-push-lib && node wenyan_render.mjs article.md lapis out.html
```

渲染产物：
- `out.html` — 完整预览页
- `out_content.html` — 纯正文HTML（推草稿用）

---

### Step 2: 合规检查

```bash
python compliance_check.py article.md
```

检查项（16项）：
- 🔴 红线6条：政治敏感、虚假信息、个人信息、金融荐股、诱导分享、AI完全替代
- 🟡 必须5条：AI标注、数据来源、图片版权、敏感词、标题合规
- 🟢 优化5条：绝对化用语、标题长度、互动引导、SEO关键词、摘要

**命中红线 → 修改后重检，不推。**

---

### Step 3: AI 封面生成（可选）

```bash
python img_fallback.py cover "文章标题" --style tech
```
封面自动裁剪为 900×383，上传到 `generated-images/`。

---

### Step 4: 用户确认

- 预览 HTML 发给用户（`open_result_view`）
- 用户确认标题、内容、配图
- 修改直到满意

---

### Step 5: 推送草稿

```bash
cd ../wechat-auto-push-lib
python wechat_api/publisher.py --html out.html
```
自动完成：上传封面→上传内文图→替换URL→创建草稿。

---

### Step 6: 飞书追踪（自动）

```bash
cd ../wechat-auto-push-lib && python _feishu_add_record.py
```
写入多维表格：标题/日期/类型/字数/状态。

---

### Step 7: 冷启动（发布后2小时内，生死期）

1. 转发到3-5个高精准群，话术："求各位大佬看下最后一段逻辑对不对"
2. 5个朋友帮忙点开+留言
3. 自己小号在评论区提问引发互动
4. **绝不到死水群群发**（秒退=完读率暴跌=判死刑）

---

## 发布时间

**锁定 20:00（晚上8点）**，用户活跃高峰。
- 提前30分钟完成所有检查
- 发布前确认"允许被推荐"已勾选
- 禁止分组群发/私密发送

## 排版要点

- 正文用 WenYan 主题（`pie` 默认，AI/科技类优先）
- RSS 热榜类用暗色模板（手动排版）
- 每段≤3行
- 图片间隔3-4屏
- 首图高质量可提升点击率40%

## 反模式

- 正文含外链 → 限流
- 单日推送>2次 → 新号限流3天
- "关注领红包"诱导话术 → 限流
- 频繁改名称/简介 → 权重下降

## 输出

1. 预览 HTML 路径
2. 合规检查结果（通过/不通过+具体问题）
3. 草稿 media_id
4. 冷启动检查清单
