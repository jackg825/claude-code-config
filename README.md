# Claude Code Starter Config

A minimal, effective Claude Code configuration distilled from months of iteration.

## Philosophy

1. **English instructions** — LLMs follow English prompts most reliably. Use your native language only as an output rule.
2. **~40 lines max** for global CLAUDE.md — every line competes for attention in the context window.
3. **Slash commands over free-form prompts** — repeatable workflows beat ad-hoc instructions.
4. **Project-level overrides** — generate per-project CLAUDE.md and skills so Claude never re-learns constraints.
5. **Templates for agent teams** — reusable blueprints, not one-off prompts.

## What's Included

```
shareable-config/
├── CLAUDE.md                          # Global rules (~35 lines, customize section marked)
├── settings.json                      # Plugin recommendations + hooks
├── commands/
│   ├── generate-project-claude.md     # /generate-project-claude — auto-generate project CLAUDE.md
│   ├── generate-project-skills.md     # /generate-project-skills — auto-generate project-specific skills
│   ├── diagnose.md                    # /diagnose — structured bug diagnosis with anti-excuse list
│   ├── release.md                     # /release — multi-framework release workflow
│   └── compact.md                     # /compact — strategic context compaction
├── hooks/
│   └── notify-error.sh               # Error notification (customize terminal app)
└── templates/
    ├── qa-team.md                     # 3-agent parallel QA review
    ├── architecture-debate.md         # 4-agent architecture debate panel
    └── emergency-bugfix.md            # 3-agent emergency bug fix
```

## Installation

```bash
# 1. Back up existing config
cp -r ~/.claude ~/.claude-backup-$(date +%Y%m%d)

# 2. Copy files (won't overwrite settings.json — merge manually)
cp CLAUDE.md ~/.claude/CLAUDE.md
cp -r commands/ ~/.claude/commands/
cp -r hooks/ ~/.claude/hooks/
cp -r templates/ ~/.claude/templates/
chmod +x ~/.claude/hooks/notify-error.sh

# 3. Merge settings.json manually (see comments in file)

# 4. Customize CLAUDE.md (see CUSTOMIZE section markers)
```

## Customization

### CLAUDE.md
Look for `## CUSTOMIZE` sections — add your framework-specific rules there.

### Hooks
Edit `notify-error.sh` line 19: change `com.mitchellh.ghostty` to your terminal's bundle ID:
- iTerm2: `com.googlecode.iterm2`
- Warp: `dev.warp.Warp-Stable`
- Terminal.app: `com.apple.Terminal`
- Ghostty: `com.mitchellh.ghostty`

### Slash Commands
All commands auto-detect project type via config files (pubspec.yaml, package.json, etc).
No framework-specific customization needed.

## Usage

```bash
# In any project — generate project-specific config
/generate-project-claude
/generate-project-skills

# Development workflow
/diagnose          # When hitting a bug
/release           # When ready to release
/compact           # When context feels bloated

# Templates — reference in conversation
"Use the qa-team template to review my changes"
"Use the architecture-debate template to evaluate: monorepo vs polyrepo"
"Use the emergency-bugfix template for this production issue"
```

## Recommended Plugins

See `settings.json` for the tested combination. Key principle:
- **One methodology plugin** (e.g., superpowers) for dev workflow
- **One PR review plugin** (e.g., code-review) for GitHub integration
- **One deep analysis plugin** (e.g., pr-review-toolkit) for on-demand review
- Avoid multiple plugins with overlapping code-reviewer agents
