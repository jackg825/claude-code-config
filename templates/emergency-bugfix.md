# Emergency Bug Fix

## Phase 1 (parallel, 2 agents)
1. **Reproducer** — minimal reproduction: read error → trace code path → confirm repro steps
2. **Root Cause Analyst** — root cause analysis: recent git log → correlation analysis → confidence rating

## Phase 2 (sequential, 1 agent, based on Phase 1 results)
3. **Fixer** — minimal fix:
   - Change only what is necessary. No refactoring.
   - Run relevant tests to confirm the fix
   - Add a regression test for this bug
   - Commit message must clearly describe root cause and fix

## Constraints
- Minimal change surface. Fix the bug, nothing else.
- No "while we're at it" cleanups.
- Speed > elegance. Cleanup is a separate task.

## Usage
Provide: error message, reproduction steps (if known), urgency level
