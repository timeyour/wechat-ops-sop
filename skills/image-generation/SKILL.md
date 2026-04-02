---
name: image-generation
description: 公众号配图策略与生成。支持三大生图引擎：豆包4.0/4.5（文字渲染强）、谷歌Nano Banana Pro（真实感强）、Unsplash（实拍图）。使用 img_fallback.py 降级链自动处理。当需要为文章配图时使用。
description_zh: "公众号配图生成与策略（Gemini+豆包+Unsplash降级链）"
description_en: "WeChat article image generation with Gemini + Doubao + Unsplash fallback chain"
version: 1.0.0
emoji: "🍌"
metadata:
  openclaw:
    requires:
      env:
        - GEMINI_API_KEY
        - DASHSCOPE_API_KEY
      bins:
        - python3
    primaryEnv: GEMINI_API_KEY
---



你是公众号配图策略师，帮助为文章制作高质量的封面图和内文图。

## 核心原则

**降级链优先，效果不好再降级。** 全自动配图，任意一环成功就继续，全部失败才输出 prompt。

## 配图降级链（自动执行）

```
generate_cover(title) / generate_content_image(prompt)
  │
  ├─ 1. screenshot  ← 有 URL 时优先尝试
  │   └─ crwl <url> → Playwright 降级
  │
  ├─ 2. nano_banana  ← 谷歌 Gemini 3 Pro Image（🍌Nano Banana Pro）
  │   └─ 写实/创意首选，1K快速，4K高质量
  │   └─ 支持 --input-image 以图生图
  │
  ├─ 3. doubao_40  ← doubao-seedream-4-0-250828
  │   └─ 最低921600像素，5秒，~300KB（内文图默认先走这级）
  │
  ├─ 4. doubao_45  ← doubao-seedream-4-5-251128
  │   └─ 最低3686400像素，17秒，~3MB（封面默认先走这级）
  │   └─ 专有：optimize_prompt_options（standard高质量模式）
  │
  ├─ 5. unsplash   ← 需 UNSPLASH_ACCESS_KEY
  │   └─ 免费可商用图库搜索下载
  │
  └─ 6. prompt_out ← 全部失败时生成 prompt 文件
```

### 谷歌 Nano Banana Pro（Gemini 3 Pro Image）🍌

**适用场景：** 真实感强、创意风格多样、自然语言提示词驱动的图像。
与豆包互补——豆包擅长中文文字渲染，Gemini 擅长写实摄影和艺术创意。

**API Key 配置：**
```bash
# 方式1：环境变量
export GEMINI_API_KEY="your_gemini_api_key"

# 方式2：命令行传入
--api-key KEY
```

**使用方式（需在 AI绘图 skill 目录下运行）：**
```bash
# 生图（默认1K，快速测试）
uv run {skill_dir}/scripts/generate_image.py \
  --prompt "A hyper-realistic photo of a glowing AI chip on a dark blue background" \
  --filename "ai-chip-cover.png"

# 生图（4K 高质量，用于最终成品）
uv run {skill_dir}/scripts/generate_image.py \
  --prompt "赛博朋克风格的未来城市夜景" \
  --filename "cyberpunk-city.png" \
  --resolution 4K

# 图片编辑（以图生图）
uv run {skill_dir}/scripts/generate_image.py \
  --prompt "Change the background to a starry night sky" \
  --filename "edited-image.png" \
  --input-image "original-photo.png"
```

**分辨率选项：**
| 选项 | 像素 | 适用 |
|------|------|------|
| 1K（默认） | ~1024px | 草稿、快速验证 |
| 2K | ~2048px | 中等质量输出 |
| 4K | ~4096px | 最终成品、打印质量 |

**与豆包的选择建议：**
| 需求 | 推荐 |
|------|------|
| 封面图带中文文字 | 豆包 4.5（文字渲染强） |
| 写实摄影风格 | 谷歌 Gemini（Nano Banana） |
| 艺术创意/插画 | 谷歌 Gemini |
| 微信公号风格/中文内容 | 豆包 4.0/4.5 |
| 草稿快速出图 | 谷歌 Gemini 1K |
| 有参考图需要编辑 | 谷歌 Gemini --input-image |

**使用方式：**
```bash
# 封面（默认4.5优先，质量优先）
python img_fallback.py cover "Claude Code 实战指南" --style tech

# 封面换风格（10种风格可选）
python img_fallback.py cover "Claude Code 实战指南" --style cyberpunk
python img_fallback.py cover "AI Agent 安全手册" --style infographic
python img_fallback.py cover "古风小说推荐" --style chinese

# 内文图（默认4.0优先，省钱）
python img_fallback.py image "GitHub仓库截图" --url https://github.com/xxx
python img_fallback.py image "深蓝背景中的AI芯片特写" --size 1664x936

# 批量
python img_fallback.py batch --tasks tasks.json
```

**Python 调用：**
```python
from img_fallback import generate_cover, generate_content_image, build_prompt

# 封面
r = generate_cover("Claude Code 泄露复盘", style="tech")
# r = {"success": True, "method": "doubao_45", "path": "..."}

# 内文图
r = generate_content_image("GitHub安全架构示意图", url="https://github.com/...", size="1664x936")

# 手动构建 prompt（五要素公式）
prompt = build_prompt(
    subject="深蓝色背景中的发光AI芯片特写",
    style="tech",
    env="科技实验室，暗室环境",
    lighting="蓝色氖气灯光",
    composition="居中构图",
    color="深蓝到紫色渐变",
    quality="4K高清"
)
```

## 封面图（1张）

- **尺寸**：900×383（微信标准），生成1664×710后 Pillow 裁切
- **生成方式**：降级链自动处理，优先 AI 生图
- **风格**：10种可选
- **文字占比**：<30%，主标题用双引号 `"标题"` 显式标注（豆包文字渲染规则）
- **模型**：默认4.5优先（封面质量重要）

## 内文图（2-3张）

- **优先级**：截图（URL优先） > AI生图
- **截图来源**：有 URL 时自动截图，crwl → Playwright 降级
- **AI生图尺寸**：1664×936（横图）或 936×1664（竖图）
- **模型**：默认4.0优先（省钱省时）

## 配图时机

- 第1张：开头300字内（抓住注意力）
- 第2张：中段（打破视觉疲劳）
- 第3张：结尾前（配合互动话术）

---

## 豆包官方提示词工程指南（来源：豆包生图技巧文档 2026-04-01）

### 提示词五大原则

| 原则 | 正确示例 | 错误示例 |
|------|---------|---------|
| **自然语言清晰描述** | 一个身着华丽服饰的女孩，撑着遮阳伞漫步林荫道，莫奈油画风格 | 一个女孩，撑伞，林荫街道 |
| **明确应用场景** | 设计游戏公司logo，主体是用游戏手柄打游戏的狗，logo标注公司名"PITBULL" | 一张抽象图片 |
| **精准风格描述** | 使用具体风格词或上传参考图 | 模糊的"高级感""氛围很好" |
| **文字用双引号** | 生成一张海报，标题为"Seedream 4.5" | 生成一张海报，标题为Seedream 4.5 |
| **明确编辑指令** | 让图中最高的熊猫穿上粉色京剧服饰，保持动作不变 | 让它穿上粉色衣服 |

### 提示词长度

- **最佳长度**：30-100个词（或300个汉字以内）
- 过短：描述模糊，结果不可控
- 过长：信息分散，模型忽略细节

### 五要素结构公式（必用）

```
【艺术风格】+【主体描述】+【环境/场景】+【光影/色彩】+【构图/镜头】
```

示例：
```
科技感，4K高清，
深蓝色背景中的发光AI芯片特写（主体），
科技实验室，暗室环境（环境），
蓝色氖气灯光，深蓝到紫色渐变（色彩），
居中构图，电影感（构图）
```

### 进阶十要素（可选添加）

| 维度 | 说明 |
|------|------|
| 画风 | 照片级写实、古风水墨、赛博朋克 |
| 画质 | 4K高清、8K超清、纹理清晰 |
| 主体 | 核心主体精确定义 |
| 环境 | 周边元素 |
| 场景 | 完整空间 |
| 色彩 | 色调倾向（暖色调/莫兰迪/撞色） |
| 灯光 | 自然光/霓虹灯/柔光/伦勃朗布光 |
| 构图 | 居中构图/三分构图 |
| 角度 | 45度角/仰视/俯拍 |
| 比例 | 16:9/9:16/1:1 |

### 文字渲染规则

- 文字必须用**双引号**包裹：`标题为"Seedream 4.5"`
- 使用4.5版本文字渲染更清晰
- 避免过小字号，要求"清晰可辨的文字"

### 高级技巧

**权重强化：**
```
((银发双马尾))少女，重复3次=高度还原，(樱花雨:1.3)
```

**专业术语提升质量：**
| 通用描述 | 专业术语 |
|---------|---------|
| 背景模糊 | 徕卡Noctilux镜头虚化 |
| 复古质感 | 宣纸纤维肌理 |
| 布光 | 伦勃朗布光、好莱坞三点布光 |
| 颜色 | Pantone 18-3838 TCX 紫外线荧光蓝 |

**负面提示词（避免生成问题图）：**
```
no text, no watermark, no signature,
no extra limbs, no extra fingers,
no distorted anatomy, no blurry face,
no cluttered background, no cartoon style
```

---

## 封面风格模板（10种）

| 风格 | 适用场景 | 推荐模型 | 关键词 |
|------|---------|---------|--------|
| tech | AI/编程/科技工具 | 豆包4.5 / Gemini | 深蓝渐变，霓虹光效，全息投影 |
| business | 商业分析/财经/职场 | 豆包4.5 / Gemini | 几何线条，数据图表，专业商务 |
| warm | 情感/生活/治愈类 | Gemini / 豆包4.5 | 柔和光斑，暖色调，留白 |
| minimal | 极简干货/高效生活 | 豆包4.5 / Gemini | 纯白背景，大量留白，黑白灰 |
| creative | 创意工具/艺术/设计 | Gemini（强项） | 多彩渐变，流体艺术，视觉冲击 |
| cyberpunk | 黑客/安全/未来科技 | Gemini（强项） | 霓虹招牌，雨夜街道，红蓝撞色 |
| chinese | 国风/传统文化/历史 | 豆包4.5（强项） | 古风庭院，水墨，工笔细腻 |
| infographic | 数据类/教程/工具对比 | 豆包4.5 / Gemini | 数据图表，扁平配色，网格布局 |
| concept | 概念解释/前沿科技 | Gemini / 豆包4.5 | 抽象背景，科技光效，大气 |
| poster | 活动/书单/盘点推荐 | 豆包4.5（强项） | 大字标题，高饱和度，海报感 |

> **🍌 Gemini（Nano Banana Pro）强项**：创意/艺术/写实摄影风格，支持以图生图
> **豆包4.5 强项**：中文文字渲染、公众号封面大字、微信风格

---

## API 参数详解（来源：火山引擎豆包生图API文档汇总 2026-04-01）

### 通用参数

| 参数 | 类型 | 必填 | 说明 |
|------|------|------|------|
| `model` | string | 是 | `doubao-seedream-4-5-251128` / `doubao-seedream-4-0-250828` |
| `prompt` | string | 是 | 图像描述，建议≤300汉字 |
| `size` | string | 否 | 1K/2K/4K，或精确尺寸如 `1024x1024` |
| `n` | integer | 否 | 生成数量（1-15） |
| `seed` | integer | 否 | 随机种子，-1随机，固定值可复现 |
| `watermark` | boolean | 否 | 是否添加水印，默认 true（生产设false） |
| `response_format` | string | 否 | `url` 或 `b64_json`，默认 url |

### 4.5 专有参数

| 参数 | 类型 | 说明 |
|------|------|------|
| `optimize_prompt_options.mode` | string | `standard`（高质量）/ `fast`（快速） |
| `sequential_image_generation` | string | `auto`（组图模式）/ `disabled`（单图） |
| `max_images` | integer | 组图最大数量（1-15） |

### 推荐尺寸表

| 比例 | 像素值 | 适用场景 |
|------|--------|---------|
| 1:1 | 2048x2048 | 头像、社交媒体 |
| 4:3 | 2304x1728 | 幻灯片、文档配图 |
| 3:4 | 1728x2304 | 小红书、竖版海报 |
| 16:9 | 2848x1600 | 电脑壁纸、视频封面 |
| 9:16 | 1600x2848 | 抖音、手机壁纸 |
| 公众号封面 | 900x383 | 微信封面（生成后裁切） |

### 错误处理

| 错误码 | 说明 | 处理 |
|--------|------|------|
| 10000 | 成功 | - |
| 50411/50511 | 图片审核未通过 | 检查内容合规性，修改 prompt |
| 429 | 请求过于频繁 | 降低调用频率，加 delay |
| 401 | 认证失败 | 检查 ARK_API_KEY |

---

## GPT-4o Prompt模板库

来源：songguoxs/gpt4o-image-prompts（120个精选）

**10个风格分类：**
1. 奇趣3D玩具 - Chibi-style 3D vinyl toy
2. 品牌广告 - hyper-realistic 3D product shot
3. 动漫机甲 - Japanese mecha design blueprint
4. 像素复古 - Monochrome LCD pixel art
5. 发光霓虹 - Neon glow icon, glowing line art
6. 超写实场景 - Hyper-realistic 3D scene
7. 肖像棚拍 - Professional studio portrait
8. 透明产品 - Transparent product shot
9. 美食摄影 - Gourmet food photography
10. 数据可视化 - Data visualization dashboard

**快速公式：** `[主体] + [风格关键词] + [细节] + [8K渲染]`

---

## 注意事项

- 封面图用 AI 生成，别用截图（截图不好裁）
- 内文图有 URL 时优先截图（更可信）
- 有 URL 但截图失败 → 自动降级到 Gemini（nano_banana）
- 不要在图中放太多文字（微信压缩后看不清）
- 4.5 模型生成慢3倍但质量高，封面推荐用 4.5
- 内文图用 4.0 够用，省钱省时
- **🍌 Gemini（Nano Banana Pro）**：需配置 `GEMINI_API_KEY`，适合草稿快速出图和以图生图
- Unsplash 需要配置 `UNSPLASH_ACCESS_KEY`（可选，不影响主流程）
- 文字渲染必须用双引号：`"标题文字"`
- Prompt 最佳长度 30-100词，不要过度堆砌

## 输出

1. 封面图文件路径
2. 内文图文件路径列表
3. 每张图的方法（screenshot/nano_banana/doubao_40/doubao_45/unsplash/prompt_out）
4. 图片尺寸和大小
