# The Doorbell Loop - Event-Driven PR Review

This project implements an event-driven loop that automatically reviews pull requests when they are opened or synchronized.

## Overview

This is a learning project demonstrating Concept 7 (event-driven loops) from Loop Engineering. The goal is to have Claude automatically review PRs when:
- A PR is opened (`pull_request.opened`)
- New commits are pushed to an existing PR (`pull_request.synchronize`)

## PR Review Rules

When reviewing PRs, Claude should check for:

### Correctness
- Logic errors and off-by-one mistakes
- Null/undefined checks that may be missing
- Edge cases that aren't handled

### Security
- Input validation
- Authentication/authorization issues
- Sensitive data exposure

### Code Quality
- Clear and maintainable code
- Appropriate error handling
- Consistent naming conventions

## Setup

1. Install the Claude GitHub App on this repository from https://github.com/apps/claude
2. Create a Routine at https://claude.ai/code/routines with:
   - **Trigger**: GitHub event - `pull_request.opened` and `pull_request.synchronize`
   - **Repository**: This repository
   - **Prompt**: See the Routine Prompt section below

## Routine Prompt

```
Review the pull request that triggered this routine.

1. Fetch the PR details and diff using `gh` CLI
2. Analyze the changes for:
   - Correctness bugs (logic errors, off-by-one, missing null checks)
   - Security issues (input validation, auth, data exposure)
   - Code quality (clarity, error handling, naming)
3. Post a summary review comment on the PR
4. If you find issues, leave inline comments on specific lines
5. If the PR looks good, approve it with a positive review

Use the review checklist in CLAUDE.md as your guide.
```

## Testing

1. Create a test PR with a planted bug (e.g., an off-by-one error or missing null check)
2. Verify the routine fires and reviews the PR
3. Push a new commit to trigger the synchronize event
4. Verify the routine fires again on the new commit

## Done When

- A PR receives an automated review without manual triggering
- The review flags planted bugs
- Pushing new commits triggers a re-review via synchronize event
