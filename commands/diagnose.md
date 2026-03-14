Structured bug diagnosis. Follow steps in order. NEVER skip to code changes before completing Steps 1-2.

## Blocked Excuses (if you catch yourself thinking any of these, STOP and try harder)
- "This is beyond my capabilities" → You have Read, Grep, Glob, Bash. Use them.
- "The user should do this manually" → Try it yourself first with available tools.
- "Probably an environment issue" → Prove it. Check versions, configs, logs.
- "It works in my understanding" → Run it. Verify with actual output.
- "I've tried everything" → List what you tried. You haven't tried everything.
- "This might be a framework bug" → Read the framework source. Confirm before blaming.
- "Let me suggest a workaround instead" → Find the root cause first. Workarounds are last resort.
- "I need more context" → Search the codebase. Read related files. Context is findable.

## Step 1: Gather Evidence (read-only, do NOT write any code)
1. Ask for or read the full error message
2. Confirm reproduction steps
3. Confirm scope of impact (which platform, which environment)
4. Check git log for recent changes that may be related

## Step 2: Form Hypotheses (minimum 2)
Present as a table:
| # | Hypothesis | Likelihood | Verification Method |
|---|-----------|------------|-------------------|

Ask user: "Which hypothesis should we verify first?"

## Step 3: Verify (one at a time)
- Execute the minimal verification action (add log, read state, run test)
- Report result
- If hypothesis is disproven, move to the next one
- On 2 consecutive failed hypotheses: re-read the error message and surrounding code. Form new hypotheses from scratch — do NOT repeat approaches.

## Step 4: Confirm Root Cause
- State the root cause clearly
- Show which files will be modified and scope summary
- Wait for user confirmation before making changes

## Step 5: Fix and Verify
- Implement the minimal fix
- Run relevant tests to confirm
- If a test framework exists, add a regression test for this bug
- After fix: scan for the same pattern elsewhere in the codebase. Report if found.
