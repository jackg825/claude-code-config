# Expert Panel Debate — Skill Design Spec

## Overview

A general-purpose multi-role expert team deliberation skill. Uses Claude Code Agent Teams to assemble independent expert agents that debate through structured multi-round argumentation, converging on actionable proposals presented as a decision matrix.

## Core Design Decisions

| Decision | Choice | Rationale |
|----------|--------|-----------|
| Scope | General-purpose (tech, product, strategy) | User wants one framework adaptable to any domain |
| Role assembly | Hybrid: auto-recommend + user adjusts | Balances convenience with user control |
| Architecture | Agent Team (not subagent or single-agent) | SendMessage enables real cross-expert debate; independent contexts prevent opinion contamination |
| Round structure | Hybrid: structured first 2 rounds → focused free debate | Ensures all perspectives surface before convergence |
| Termination | Convergence-based (auto-detect) | Continues until new arguments no longer shift rankings |
| Output | Decision matrix with scores per dimension | Structured, comparable, user makes final call |
| Visibility | Summary per round | Key arguments and disagreements, not full transcripts |

## Workflow

### Phase 0: Topic Analysis & Role Recommendation

- Analyze the user's topic/question
- Auto-recommend 3-5 expert roles with: name, domain expertise, expected perspective bias
- User may add, remove, or modify roles before confirming
- Examples for tech architecture: Systems Architect, DevOps Engineer, Security Engineer, Product Manager, Cost Analyst

### Phase 1: Team Assembly

- `TeamCreate` to create the deliberation team
- Spawn each expert via `Agent` tool with `team_name` and `name`
- Each expert's prompt includes:
  - Role definition and expertise area
  - Topic and background context
  - Debate rules and expected output format
  - Instruction to maintain independent perspective

### Phase 2: Structured Position Statements (Round 1)

- Moderator sends topic to all experts
- Each expert independently produces:
  - Recommended approach/solution
  - Core rationale (evidence-based)
  - Anticipated risks and limitations
- Moderator collects, synthesizes summary for user
- Summary format: each expert's position + initial divergence map

### Phase 3: Structured Cross-Examination (Round 2)

- Moderator identifies key disagreement axes from Round 1
- Assigns cross-examination pairs (e.g., "Architect challenges DevOps on deployment complexity")
- Experts debate directly via `SendMessage`
- Moderator synthesizes: arguments, counterarguments, areas of emerging consensus
- Summary format: disagreement points + how positions shifted

### Phase 4: Focused Free Debate (Round 3+)

- Moderator distills 2-3 unresolved core disputes
- Experts debate freely around these specific points
- Moderator evaluates convergence after each round
- **Convergence criteria:**
  - No new arguments that change solution rankings
  - Remaining disagreements are weight/priority differences, not fundamental objections
  - OR maximum 5 rounds reached (safety cap)
- Summary format per round: remaining disputes + convergence assessment

### Phase 5: Decision Matrix Output

- Moderator synthesizes all rounds into:
  - Solution list (2-3 viable options)
  - Evaluation dimensions (extracted from debate)
  - Scores + rationale per solution per dimension
  - Key trade-off summary
  - Each expert's final stance
  - Overall recommendation
- Shutdown all expert agents via `SendMessage` shutdown_request

## Output Format

```markdown
## Decision Matrix: <Topic>

### Solutions Under Consideration
- **Solution A**: [brief description]
- **Solution B**: [brief description]
- **Solution C**: [brief description]

### Evaluation

| Dimension | Solution A | Solution B | Solution C |
|-----------|-----------|-----------|-----------|
| Dim 1     | score + rationale | ... | ... |
| Dim 2     | ... | ... | ... |
| ...       | ... | ... | ... |

### Key Trade-offs
- [trade-off 1]
- [trade-off 2]

### Expert Final Positions
- **Role A**: Favors Solution X because...
- **Role B**: Favors Solution Y because...

### Recommendation
Based on the above analysis, [synthesized recommendation with conditions]
```

## Expert Prompt Template

Each expert agent receives a prompt structured as:

```
You are [Role Name], an expert in [domain].

## Your Perspective
[Description of expertise and the lens through which you evaluate solutions]

## Topic
[The question/problem to analyze]

## Background
[Context provided by the user]

## Rules
- Maintain your professional perspective throughout the debate
- Support arguments with evidence, trade-offs, and concrete examples
- Challenge other experts' positions constructively with specific counterpoints
- Be willing to update your position when presented with compelling evidence
- Respond to cross-examination with substantive rebuttals, not concessions
- Use SendMessage to communicate with other experts and the moderator
```

## Convergence Detection Logic

The moderator evaluates after each free debate round:

1. **Position stability**: Did any expert change their recommended solution?
2. **Argument novelty**: Were new arguments introduced, or rehashes of prior points?
3. **Disagreement scope**: Are disputes narrowing (from fundamental approach to implementation details)?

If all three indicate stability → declare convergence and proceed to Phase 5.

## Constraints

- Minimum 2 rounds (position + cross-examination) before convergence possible
- Maximum 5 total rounds (safety cap to prevent infinite loops)
- Minimum 3 experts, maximum 6 experts
- Each expert should receive the same background context
- Moderator never takes a side during debate, only in final recommendation
