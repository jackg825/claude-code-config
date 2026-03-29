Generator-Evaluator loop for non-trivial tasks. Enforces plan → implement → simplify → review cycle with independent evaluation.

Inspired by Anthropic's harness design for long-running apps: separating generation from evaluation to counter self-evaluation bias and context degradation.

## When to Use
Tasks that touch ≥ 3 files OR ≥ 30 lines of change. For smaller changes, just implement directly.

## Input
$ARGUMENTS — describe the task, bug, or feature to build.

---

## Phase 1: PLAN (Sprint Contract)

Define testable acceptance criteria BEFORE writing any code.

1. Analyze the task: read relevant files, understand current behavior
2. Produce a sprint contract:

```
### Sprint Contract: [task name]
**Goal**: [one sentence]
**Acceptance Criteria** (each must be independently verifiable):
  - [ ] [criterion 1 — specific, testable]
  - [ ] [criterion 2]
  - ...
**Files to Change**: [list]
**Files NOT to Change**: [explicitly scope out]
**Risk Areas**: [known pitfalls relevant to this change]
```

3. Present the sprint contract and WAIT for user confirmation before proceeding.

---

## Phase 2: IMPLEMENT

Execute the plan. Iterate with tests at each checkpoint.

1. Implement changes incrementally — one logical unit at a time
2. After each unit:
   - Run the project's lint command — must pass
   - Run the project's test command — all tests must pass
   - If tests fail, fix before moving on
3. Commit each logical unit separately with descriptive messages
4. After all units complete, verify each acceptance criterion from the sprint contract
5. Check project-specific constraints from CLAUDE.md (if present)

---

## Phase 3: SIMPLIFY (Mechanical Evaluator)

Run `/simplify` to launch 3 parallel review agents:
1. **Code Reuse** — find duplicates, suggest existing utilities
2. **Code Quality** — redundant state, copy-paste, leaky abstractions
3. **Efficiency** — unnecessary work, missed concurrency, memory leaks

These agents find AND fix issues automatically. After fixes, re-run lint and tests.

---

## Phase 4: REVIEW (Independent Evaluator)

Launch a code-reviewer subagent with fresh context. The reviewer:

1. Receives the full `git diff` of all changes
2. Evaluates against the sprint contract from Phase 1
3. Checks project-specific constraints from CLAUDE.md
4. Produces a verdict:

```
## Verdict: PASS | FAIL
## Sprint Contract Check
- [x] criterion 1 — verified by [how]
- [ ] criterion 2 — FAILED: [reason]
## Findings (by severity)
- CRITICAL: [description] @ [file:line]
- WARNING: [description] @ [file:line]
## Required Changes (CRITICAL only)
```

### On PASS → Done. Summarize what was built and how it meets the sprint contract.

### On FAIL → Iterate (max 2 loops)
1. Fix CRITICAL findings only
2. Re-run Phase 3 (simplify) and Phase 4 (review)
3. If second review still FAILs → stop, present findings to user for decision

---

## Constraints
- Max 2 review iterations. Escalate to user after that.
- Phase 4 reviewer MUST be a subagent (fresh context = no self-evaluation bias).
- Never skip Phase 1. The sprint contract is the most valuable part.
- Do not refactor or "improve" code outside the sprint contract scope.
