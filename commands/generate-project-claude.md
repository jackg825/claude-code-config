Analyze the current project and generate a CLAUDE.md at the project root.

## Steps

### 1. Detect Project Type
Check for these files to determine the tech stack:
- pubspec.yaml → Flutter/Dart
- package.json + next.config.* → Next.js
- package.json + wrangler.toml → Cloudflare Workers
- package.json (other) → Node.js/TypeScript
- Cargo.toml → Rust
- go.mod → Go
- pyproject.toml / requirements.txt → Python

### 2. Read Configuration
- Read main config files to extract: project name, dependencies, version
- Check CI/CD configs (.github/workflows/, Dockerfile, vercel.json, firebase.json)
- Check test framework and lint configuration

### 3. Analyze Project Structure
- List major directories and their purposes (src/, lib/, app/, pages/, etc.)
- Identify state management solution (if any)
- Identify routing solution (if any)

### 4. Generate CLAUDE.md
Create CLAUDE.md at the project root with this format:

```
# [Project Name] — [one-line description]
- Stack: [detected stack]
- This is NOT [other framework]. It does NOT have [other framework's tools].
(list 2-3 negative constraints based on detection)

## Commands
- Dev: [detected dev command]
- Build: [detected build command]
- Test: [detected test command]
- Lint: [detected lint command]

## Deploy
- Platform: [detected deploy platform]
- Command: [deploy command]
- Verify: [health check command, if inferrable]

## Architecture
[3-5 lines describing major directory structure and purposes]

## Project Constraints
[3-5 important constraints based on analysis]

## Known Pitfalls
(leave empty — user fills this when corrected)
```

### 5. Output
- Display the generated CLAUDE.md content
- Remind user to review and add project-specific constraints
