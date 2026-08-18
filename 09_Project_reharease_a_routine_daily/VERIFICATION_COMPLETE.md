# Project Complete: Green CI ≠ Correct Logic

## The A5 Lesson

**In one sentence:** Green means the session ended without an infrastructure error, nothing more.

## What We Demonstrated

### Run 1: Genuinely Correct (GREEN ✓)
```
=== Routine Check Started ===
Reading status.txt...
File contents:
Build Status: SUCCESS
Last updated: 2026-08-18

Check PASSED: Found SUCCESS marker
Exit code: 0
```
This run is green because:
- The file existed
- The logic executed correctly
- The SUCCESS marker was found

### Run 2: Logically Failed but Still GREEN (✗)
```
=== Routine Check Started ===
Reading nonexistent_file.txt...
WARNING: File not found: nonexistent_file.txt
Check could not be performed, but exiting with success (0)
Exit code: 0
```
This run is green because:
- The script caught the error
- It explicitly exited with code 0
- No infrastructure error occurred

**But it's WRONG:** The check never actually ran. The logic failed, but the CI shows green.

### Run 3: Fixed - Now Correctly Reports Failure (RED ✓)
```
=== Routine Check Started ===
Reading status.txt...
ERROR: File not found: status.txt
Check FAILED: Cannot verify status
Exit code: 1
```
This run is red because:
- The file was missing
- The script correctly returns exit code 1
- The status now matches the actual logic result

## Key Takeaway

Always read the full transcript, not just the status column. A green checkmark only tells you:
- The process didn't crash
- No unhandled exception occurred
- The exit code was 0

It does NOT tell you:
- Whether the logic executed correctly
- Whether assertions passed
- Whether the actual task succeeded

## Files in This Project

- `routine.ps1` - The routine script (now fixed)
- `status.txt` - The file being checked
- `verify_routine.ps1` - Verification test script
