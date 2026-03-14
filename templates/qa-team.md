# QA Verification Team

## Roles (run in parallel)
1. **Code Reviewer** — correctness, design patterns, maintainability
2. **Security Reviewer** — OWASP, injection, permissions, data leaks
3. **Test Coverage Analyzer** — coverage, edge cases, regression risk

## Output Format per Agent (strict)
## Verdict: PASS | FAIL
## Findings (sorted by severity)
- CRITICAL: [description] @ [file:line]
- WARNING: [description] @ [file:line]
- INFO: [description]
## Suggested Fixes (CRITICAL and WARNING only)

## Constraints
- Each agent analyzes at most 20 files
- Output limit: 200 lines per agent
- If multiple agents report the same issue (same file:line), keep only the most detailed one when consolidating

## Usage
Provide: list of changed files or git diff
