# ============================================================
# wechat-ops-sop 懒人安装脚本（Windows / PowerShell）
# 用法：在 PowerShell 中运行
#   .\install.ps1
# ============================================================

$ErrorActionPreference = "Stop"
$RepoRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$SkillDir = Join-Path $RepoRoot "skills"
$TargetDir = "$env:USERPROFILE\.workbuddy\skills"

Write-Host "============================================" -ForegroundColor Cyan
Write-Host " wechat-ops-sop 懒人安装脚本 (Windows)" -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan
Write-Host ""

# 1. 检测 .workbuddy/skills 目录
if (-not (Test-Path $TargetDir)) {
    Write-Host "[创建] ~\.workbuddy\skills\" -ForegroundColor Yellow
    New-Item -ItemType Directory -Path $TargetDir -Force | Out-Null
}

# 2. 收集所有 skill
$skills = Get-ChildItem -Path $SkillDir -Directory
if ($skills.Count -eq 0) {
    Write-Host "[错误] 未找到 skills 目录，请确认当前目录是 wechat-ops-sop 仓库根目录" -ForegroundColor Red
    exit 1
}

Write-Host "共 $($skills.Count) 个 skill 待安装：" -ForegroundColor Green
foreach ($skill in $skills) {
    $target = Join-Path $TargetDir $skill.Name
    if (Test-Path $target) {
        Write-Host "  [更新] $($skill.Name)" -ForegroundColor Yellow
        Remove-Item $target -Recurse -Force
    } else {
        Write-Host "  [安装] $($skill.Name)" -ForegroundColor Green
    }
    Copy-Item $skill.FullName -Destination $target -Recurse -Force
}

Write-Host ""
Write-Host "============================================" -ForegroundColor Cyan
Write-Host " 安装完成！重启 WorkBuddy/小龙虾生效" -ForegroundColor Green
Write-Host "============================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "已安装的 skills（~/.workbuddy/skills/）：" -ForegroundColor White
Get-ChildItem -Path $TargetDir -Directory | ForEach-Object {
    $emoji = ""
    $md = Join-Path $_.FullName "SKILL.md"
    if (Test-Path $md) {
        $content = Get-Content $md -Raw -ErrorAction SilentlyContinue
        if ($content -match 'emoji:\s*"?([^\s"\n]+)"?') { $emoji = $matches[1] }
    }
    Write-Host "  $emoji $($_.Name)"
}

Write-Host ""
Write-Host "提示：首次使用请设置以下环境变量（缺少则该 skill 降级或跳过）：" -ForegroundColor Yellow
Write-Host "  GEMINI_API_KEY      - 图片生成（可选，有则优先）" -ForegroundColor White
Write-Host "  DASHSCOPE_API_KEY   - 豆包模型（内容写作、排版等核心 skill）" -ForegroundColor White
Write-Host "  WECHAT_APPID        - 公众号 AppID（发布到公众号）" -ForegroundColor White
Write-Host "  WECHAT_SECRET       - 公众号 Secret（发布到公众号）" -ForegroundColor White
Write-Host "  TENCENT_MAP_KEY     - 腾讯地图 Key（SEO-GEO skill）" -ForegroundColor White
Write-Host "  BRAVE_SEARCH_API_KEY - Brave搜索（信息采集，可选）" -ForegroundColor White
Write-Host "  GITHUB_TOKEN        - GitHub Token（运营复盘，可选）" -ForegroundColor White
