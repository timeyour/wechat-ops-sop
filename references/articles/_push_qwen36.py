"""推送通义3.6实测文章草稿"""
import sys
import re
from pathlib import Path

sys.path.insert(0, r"c:\Users\lixin\WorkBuddy\20260325103711\wechat-auto-push")
from dotenv import load_dotenv
load_dotenv(Path(r"c:\Users\lixin\WorkBuddy\20260325103711\wechat-auto-push\.env"))
from wechat_api.publisher import WeChatPublisher

html_file = Path(r"c:\Users\lixin\WorkBuddy\Claw\wenyan_qwen36_content_content.html")
md_dir = Path(r"c:\Users\lixin\WorkBuddy\Claw")
title = "你的代码报错，AI自己修好了：通义3.6让我看到程序员未来3年的样子"
cover_path = Path(r"c:\Users\lixin\WorkBuddy\Claw\article_cover.png")

html_content = html_file.read_text("utf-8")
print(f"HTML loaded: {len(html_content)/1024:.1f}KB")

publisher = WeChatPublisher()

# 上传封面
print("\n[1] uploading cover...")
thumb_media_id = publisher.upload_thumb_image(cover_path)
print(f"  cover media_id: {thumb_media_id}")

# 扫描本地图片
local_imgs = re.findall(r'<img[^>]+src="([^"]+)"', html_content)
local_imgs = [p for p in local_imgs if not p.startswith("http")]
print(f"\n  Found {len(local_imgs)} local images:")
for p in local_imgs:
    print(f"    {p}")

# 上传内文图
wechat_urls = {}
if local_imgs:
    print(f"\n[2] uploading {len(local_imgs)} images...")
    for img_path in local_imgs:
        abs_path = (md_dir / img_path).resolve()
        if not abs_path.exists():
            print(f"  [WARN] not found: {abs_path}")
            continue
        print(f"  uploading: {abs_path.name} ({abs_path.stat().st_size//1024}KB)...")
        try:
            with open(abs_path, "rb") as f:
                data = publisher._request(
                    "/cgi-bin/media/uploadimg",
                    files={"media": (abs_path.name, f, "image/png")},
                )
            if "url" in data:
                wechat_urls[img_path] = data["url"]
                print(f"  [OK] -> {data['url']}")
            else:
                print(f"  [FAIL]: {data}")
        except Exception as e:
            print(f"  [ERROR]: {e}")

    # 替换URL
    print("\n[3] replacing image URLs...")
    for local_path, wechat_url in wechat_urls.items():
        html_content = html_content.replace(local_path, wechat_url)
    remaining = re.findall(r'<img[^>]+src="([^"]+)"', html_content)
    remaining_local = [r for r in remaining if not r.startswith("http")]
    if remaining_local:
        print(f"  [WARN] still local: {remaining_local}")
    else:
        print(f"  [OK] all images converted")

# 创建草稿
print("\n[4] creating draft...")
media_id = publisher.create_draft(
    title=title,
    content=html_content,
    thumb_media_id=thumb_media_id,
)
print(f"\nDONE! media_id: {media_id}")
