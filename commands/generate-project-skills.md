Generate project-specific slash commands by combining global templates with project context.

## Prerequisites
- Project root must have a CLAUDE.md (run /generate-project-claude first if missing)
- Global templates are in ~/.claude/templates/

## Steps

### 1. Read Project Context
- Read the project's CLAUDE.md to extract: stack, commands, deploy platform, architecture, constraints
- If CLAUDE.md does not exist, stop and tell the user to run /generate-project-claude first

### 2. Read Global Templates
Read all .md files from ~/.claude/templates/. For each template, generate a project-customized version.

### 3. Generate Project Commands
Create .claude/commands/ directory in the project root (if not exists).

For each template, generate a customized command file that:
- Replaces generic instructions with project-specific commands (e.g., "flutter test" instead of "run tests")
- Embeds the project's tech stack so agents don't waste time detecting it
- Includes project-specific constraints from CLAUDE.md
- Keeps the same agent structure (roles, phases, output format)

#### qa-team.md → .claude/commands/qa-team.md
Customize:
- Tell agents the exact tech stack (no detection needed)
- Specify the project's test command and lint command
- Include project-specific constraints as review criteria
- Add project-specific security concerns if inferrable from stack

#### architecture-debate.md → .claude/commands/architecture-debate.md
Customize:
- Pre-fill the tech stack context so agents don't ask
- Include current architecture summary from CLAUDE.md
- Add project constraints as debate parameters

#### emergency-bugfix.md → .claude/commands/emergency-bugfix.md
Customize:
- Specify the exact test command for verification
- Specify the exact build command to confirm fix doesn't break build
- Include deploy platform for rollback instructions
- Add project-specific "things that commonly break" from Known Pitfalls (if any)

### 4. Output Format for Each Generated Command
Each command file must:
- Start with a one-line description of what it does
- Reference the project stack explicitly (e.g., "This is a Flutter/Dart project using Riverpod")
- Include concrete commands (not generic placeholders)
- Stay under 50 lines
- Be written entirely in English (optimal for LLM instruction-following)

### 5. Summary
After generating all commands, display:
- List of created files
- How to use each one (e.g., /qa-team, /architecture-debate, /emergency-bugfix)
- Reminder that project-level commands override global templates
- Reminder to add project-specific Known Pitfalls as they are discovered
