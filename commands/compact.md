Strategic context compaction at a logical workflow boundary.

IMPORTANT: Only compact when explicitly invoked. Never auto-compact mid-task.

## When to Use
- After completing a research phase, before starting implementation
- After finishing a milestone or feature, before starting the next
- After a long debugging session, before moving to a different area
- When context feels bloated but you still have work ahead

## Steps

### 1. Identify Current State
Summarize in 3-5 lines:
- What was accomplished so far
- What is the current working state (files modified, tests passing/failing)
- What remains to be done

### 2. Persist Critical Context
Before compacting, write essential state to files so it survives compaction:
- If there is an active plan: ensure the plan file is up to date with current progress
- If there are uncommitted changes: run git diff and note the scope
- If there are discovered constraints or decisions: update the project CLAUDE.md Known Pitfalls section

### 3. Create Compaction Summary
Write a concise handoff note that your post-compaction self can use to resume:

```
## Session Continuity
- Goal: [what we're building/fixing]
- Done: [completed items]
- Current: [what's in progress right now]
- Next: [immediate next steps]
- Key decisions: [important choices made and why]
- Watch out: [gotchas discovered during this session]
```

### 4. Compact
Proceed with context compaction. The summary above ensures continuity.

### 5. After Compaction
- Re-read the session continuity note
- Re-read the project CLAUDE.md
- Confirm orientation before resuming work
