---
name: build-loop
description: Generator-evaluator implementation workflow for Codex. Use when the user asks for build-loop, sprint contract, generator/evaluator loop, independent review, PR-ready implementation, or a non-trivial code change that touches roughly 3 or more files, 30 or more lines, cross-module behavior, tests, release flow, or user-facing behavior.
---

# Build Loop

Use a generator-evaluator loop for non-trivial implementation work. The loop prevents vague scope, self-review bias, and context drift by requiring a testable contract before edits and a separate evaluation pass before completion.

## Operating Rules

- Respect repository instructions first: `AGENTS.md`, project docs, and existing patterns.
- Check `git status` before edits. Do not overwrite or revert user changes.
- Keep the scope inside the accepted sprint contract.
- If the task is a bug fix, gather evidence and list at least two hypotheses before proposing code changes.
- For changes over 10 lines, present the sprint contract and wait for user confirmation before editing.
- Do not create commits, push, open PRs, or merge unless the user requested those actions.

## Phase 1: Sprint Contract

Read enough code to make the contract concrete. Identify the project commands from package metadata, docs, or existing CI config.

Present this contract and wait for confirmation:

```markdown
### Sprint Contract: <task name>
**Goal**: <one sentence>
**Acceptance Criteria**:
- [ ] <specific, independently verifiable criterion>
- [ ] <specific, independently verifiable criterion>
**Files to Change**:
- <path>
**Files NOT to Change**:
- <path or scope boundary>
**Verification Commands**:
- <lint/typecheck/test/build commands>
**Risk Areas**:
- <known pitfall>
**Alternatives Considered**:
- <short option and trade-off>
```

Proceed only after the user confirms the contract or explicitly updates it.

## Phase 2: Implement

Execute one logical unit at a time.

1. Create or switch to a focused branch when the user requested Git/PR work.
2. Update a visible task plan for multi-step work.
3. Make the smallest coherent edit for the next acceptance criterion.
4. Run the narrowest relevant verification after each logical unit.
5. Fix failures before starting unrelated work.
6. Keep commits small and focused when commits are requested.
7. After all edits, verify every acceptance criterion.

Use structured APIs, parsers, or existing project helpers instead of ad hoc text manipulation when reasonable.

## Phase 3: Simplify

Run a mechanical simplification pass before final review:

- Remove duplication introduced by the change.
- Replace new custom logic with existing local helpers when they fit.
- Delete unused state, dead branches, and accidental abstractions.
- Check that names, file placement, and boundaries match the surrounding code.
- Re-run affected lint, typecheck, test, or build commands after simplification.

If subagents are available and the user has authorized parallel or delegated review, ask independent reviewers to inspect code reuse, code quality, and efficiency. Otherwise, perform the pass locally and disclose that the review was local.

## Phase 4: Independent Review

Evaluate the final diff against the accepted sprint contract.

When subagents are available and policy allows, use a reviewer with fresh context. Give it the contract, relevant instructions, and `git diff`. If not, do a separate local review pass from the diff and make the limitation clear.

Review output format:

```markdown
## Verdict: PASS | FAIL
## Sprint Contract Check
- [x] <criterion> - verified by <command or inspection>
- [ ] <criterion> - failed because <reason>
## Findings
- CRITICAL: <must fix before completion> @ <file:line>
- WARNING: <risk or follow-up> @ <file:line>
## Required Changes
- <critical fixes only>
```

On `PASS`, finish with changed files, verification results, and PR/merge status when applicable.

On `FAIL`, fix critical findings only, rerun simplification and review, and stop after two failed review loops with the remaining findings.

## PR And Merge

When the user requested PR creation or merge:

1. Ensure the working tree only stages intended files.
2. Run the agreed verification commands before pushing.
3. Push the branch.
4. Open a PR with the sprint contract and verification evidence.
5. Merge only after requested checks pass or the user explicitly accepts the remaining risk.
