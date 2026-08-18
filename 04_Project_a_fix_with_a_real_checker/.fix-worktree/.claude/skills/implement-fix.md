# Implement Fix Skill

## Purpose
This skill guides an implementer agent to fix bugs in code following best practices.

## Steps

1. **Identify the bug**: Read the code and understand what's wrong
2. **Plan the fix**: Determine the minimal change needed to fix the issue
3. **Implement the fix**: Make the change with clear, readable code
4. **Verify the fix**: Ensure the fix works and doesn't break other functionality
5. **Document the change**: Add comments if needed to explain the fix

## Guidelines
- Make minimal, focused changes
- Preserve existing code style and conventions
- Add tests if the fix warrants it
- Don't add unnecessary abstractions or features

## Output Format
After implementing, provide:
1. A summary of what was fixed
2. The diff showing the changes
3. Any edge cases considered
