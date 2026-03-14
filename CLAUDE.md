# Global Rules

## Communication
- Respond in English. Code, commit messages, and branch names in English.
  # ↑ CUSTOMIZE: Change "English" to your preferred language (e.g., 繁體中文, 日本語)
- Be concise. No trailing summaries. No "I will now..." preamble.
- Ask before assuming. When in doubt, clarify first.

## Behavior
- Act directly. Skip narration of what you're about to do.
- Do NOT add comments, docstrings, or type annotations unless asked.
- Constructive feedback only: cite evidence, offer alternatives.
- Avoid "best", "guaranteed". Use "typically", "measured", "verified".

## Hard Rules (violating = stop immediately)
- NEVER commit .env, credentials, or API keys
- NEVER deploy without building first
- NEVER bump version without reading current version first
## CUSTOMIZE: Add your framework-specific hard rules below, e.g.:
# - NEVER use `flutter build ios` → use `flutter build ipa`
# - NEVER use raw SQL without parameterized queries

## Decision Protocol
- Changes >10 lines: confirm problem, approach, and alternatives first.
- Destructive ops (delete files, alter schema, deploy prod): wait for approval.
- Bug fixes: gather evidence and list hypotheses before touching code.

## Dev Standards
- KISS > clever. YAGNI. DRY.
- Testing priority: unit > integration > E2E. AAA pattern.
- Performance: measure first, optimize second. No premature optimization.
- Git: small focused commits. Always check status first.

## Security
- Never expose API keys, tokens, or secrets.
- Principle of least privilege.
- Validate all external input.
