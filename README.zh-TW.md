# Claude Code 入門配置

[English](README.md) | **繁體中文**

經過數月迭代，提煉出的精簡高效 Claude Code 配置。

## TL;DR

```bash
# 備份 → 複製 → 客製化，3 步完成
cp -r ~/.claude ~/.claude-backup-$(date +%Y%m%d)
cp CLAUDE.md ~/.claude/CLAUDE.md
cp -r commands/ ~/.claude/commands/
cp -r hooks/ ~/.claude/hooks/
cp -r skills/ ~/.claude/skills/
cp -r templates/ ~/.claude/templates/
chmod +x ~/.claude/hooks/notify-error.sh
# 手動合併 settings.json，修改 CLAUDE.md 中標記 CUSTOMIZE 的區塊
```

**你會得到**：5 個 slash commands + 1 個 Agent Team skill + 3 個 agent team 模板 + 錯誤通知 hook。

## 設計理念

1. **英文指令** — LLM 對英文 prompt 的遵循度最高。僅將母語設為輸出語言規則。
2. **全域 CLAUDE.md 控制在 ~40 行** — 每一行都在爭奪 context window 的注意力。
3. **Slash commands 優於自由格式** — 可重複的工作流勝過臨時指令。
4. **專案級覆寫** — 為每個專案生成 CLAUDE.md 和 skills，避免 Claude 重複學習約束。
5. **Agent team 模板** — 可重用的藍圖，而非一次性 prompt。

## 包含內容

```
shareable-config/
├── CLAUDE.md                          # 全域規則（~35 行，有標記可客製化區塊）
├── settings.json                      # 插件推薦 + hooks 設定
├── commands/
│   ├── generate-project-claude.md     # /generate-project-claude — 自動生成專案 CLAUDE.md
│   ├── generate-project-skills.md     # /generate-project-skills — 自動生成專案專屬 skills
│   ├── diagnose.md                    # /diagnose — 結構化 bug 診斷
│   ├── release.md                     # /release — 多框架發佈流程
│   └── compact.md                     # /compact — 策略性 context 壓縮
├── hooks/
│   └── notify-error.sh               # 錯誤通知（需客製化終端機 app）
├── skills/
│   └── expert-panel-debate/
│       └── SKILL.md                   # Agent Team 多專家論證思辨 skill
└── templates/
    ├── qa-team.md                     # 3-agent 並行 QA 審查
    ├── architecture-debate.md         # 4-agent 架構辯論面板（簡易版）
    └── emergency-bugfix.md            # 3-agent 緊急 bug 修復
```

## 安裝

```bash
# 1. 備份現有配置
cp -r ~/.claude ~/.claude-backup-$(date +%Y%m%d)

# 2. 複製檔案（不會覆寫 settings.json — 需手動合併）
cp CLAUDE.md ~/.claude/CLAUDE.md
cp -r commands/ ~/.claude/commands/
cp -r hooks/ ~/.claude/hooks/
cp -r skills/ ~/.claude/skills/
cp -r templates/ ~/.claude/templates/
chmod +x ~/.claude/hooks/notify-error.sh

# 3. 手動合併 settings.json（參考檔案內的註解）

# 4. 客製化 CLAUDE.md（找到 CUSTOMIZE 標記區塊）
```

## 客製化

### CLAUDE.md
找到 `## CUSTOMIZE` 區塊 — 在此加入你的框架專屬規則。

### Hooks
編輯 `notify-error.sh` 第 19 行，將 `com.mitchellh.ghostty` 改為你的終端機 bundle ID：
- iTerm2: `com.googlecode.iterm2`
- Warp: `dev.warp.Warp-Stable`
- Terminal.app: `com.apple.Terminal`
- Ghostty: `com.mitchellh.ghostty`

### Slash Commands
所有指令透過配置檔（pubspec.yaml、package.json 等）自動偵測專案類型，無需額外設定。

## 使用方式

```bash
# 在任何專案中 — 生成專案專屬配置
/generate-project-claude
/generate-project-skills

# 開發工作流
/diagnose          # 遇到 bug 時
/release           # 準備發佈時
/compact           # context 膨脹時

# Skills — 自動觸發或手動呼叫
"組建專家團隊辯論：monorepo vs polyrepo"
"用 expert-panel-debate 分析資料庫遷移策略"

# Templates — 在對話中引用
"用 qa-team 模板審查我的變更"
"用 architecture-debate 模板評估：monorepo vs polyrepo"
"用 emergency-bugfix 模板處理這個線上問題"
```

## 推薦插件

參考 `settings.json` 的經測試組合。核心原則：
- **一個方法論插件**（如 superpowers）負責開發工作流
- **一個 PR 審查插件**（如 code-review）負責 GitHub 整合
- **一個深度分析插件**（如 pr-review-toolkit）負責按需審查
- 避免多個插件的 code-reviewer agent 互相衝突
