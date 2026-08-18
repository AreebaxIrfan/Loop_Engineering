# Fix and Review Workflow

## Purpose
Orchestrates the implementer/reviewer split: implementer fixes bugs in a worktree, reviewer grades the diff, PR only opens on PASS.

## Workflow

### Phase 1: Implement (in worktree)
1. Create a worktree for isolated changes
2. Agent implements the fix following `/implement-fix` skill
3. Commit the changes

### Phase 2: Review
1. Get the diff from the worktree
2. Send diff to reviewer agent
3. Reviewer responds with PASS or FAIL

### Phase 3: Act on Review
- **PASS**: Open a PR with the fix
- **FAIL**: Revise the fix and resubmit for review

## Usage
This skill is invoked when you need to fix a bug with the maker-checker pattern.
