#!/usr/bin/env python3
"""
Morning Brief Generator
Reads progress.md to skip already-reported items, generates today's brief,
and appends new items to progress.md
"""
import subprocess
import re
from datetime import datetime
from pathlib import Path

REPO_ROOT = Path(__file__).parent
PROGRESS_FILE = REPO_ROOT / "progress.md"
BRIEF_FILE = REPO_ROOT / "brief.md"

def read_progress():
    """Read the progress file and return set of already-reported items"""
    if not PROGRESS_FILE.exists():
        return set()
    content = PROGRESS_FILE.read_text(encoding="utf-8")
    # Extract items after "## Reported Items"
    if "## Reported Items" in content:
        items_section = content.split("## Reported Items")[1]
        # Each line starting with "- " is a reported item
        items = re.findall(r"^- (.+)$", items_section, re.MULTILINE)
        return set(items)
    return set()

def get_todos():
    """Find TODO/FIXME comments in the repo"""
    todos = []
    for file in REPO_ROOT.rglob("*.md"):
        if file.name in ("progress.md", "brief.md"):
            continue
        content = file.read_text(encoding="utf-8")
        for i, line in enumerate(content.splitlines(), 1):
            if re.search(r"(TODO|FIXME|HACK|BUG)", line, re.IGNORECASE):
                todos.append(f"{file.name}:{i}: {line.strip()}")
    return todos

def get_recent_commits():
    """Get commits from the last day"""
    try:
        since = (datetime.now() - timedelta(days=1)).strftime("%Y-%m-%d")
        result = subprocess.run(
            ["git", "log", f"--since={since}", "--pretty=format:%h %s", "--no-merges"],
            capture_output=True, text=True, cwd=REPO_ROOT
        )
        if result.returncode == 0 and result.stdout.strip():
            return result.stdout.strip().splitlines()
    except Exception:
        pass
    return []

def get_git_status():
    """Get current git status summary"""
    try:
        result = subprocess.run(
            ["git", "status", "--short"],
            capture_output=True, text=True, cwd=REPO_ROOT
        )
        if result.returncode == 0 and result.stdout.strip():
            return result.stdout.strip().splitlines()
    except Exception:
        pass
    return []

def main():
    today = datetime.now().strftime("%Y-%m-%d")
    reported = read_progress()

    # Gather new items
    all_items = []

    # Check TODOs
    todos = get_todos()
    for todo in todos:
        if todo not in reported:
            all_items.append(("TODO", todo))

    # Check recent commits
    commits = get_recent_commits()
    for commit in commits:
        item = f"Commit: {commit}"
        if item not in reported:
            all_items.append(("COMMIT", item))

    # Check git status (uncommitted changes)
    status = get_git_status()
    for s in status:
        item = f"Uncommitted: {s}"
        if item not in reported:
            all_items.append(("STATUS", item))

    # Generate brief
    brief_lines = [
        f"# Morning Brief - {today}",
        "",
        f"Generated: {datetime.now().strftime('%H:%M')}",
        "",
    ]

    if all_items:
        brief_lines.append("## New Items Found")
        brief_lines.append("")
        for type_, item in all_items:
            brief_lines.append(f"- **[{type_}]** {item}")
    else:
        brief_lines.append("## No New Items")
        brief_lines.append("")
        brief_lines.append("Nothing new to report since last run.")

    brief_content = "\n".join(brief_lines)
    BRIEF_FILE.write_text(brief_content, encoding="utf-8")
    print(brief_content)

    # Append new items to progress.md
    if all_items:
        with PROGRESS_FILE.open("a", encoding="utf-8") as f:
            for _, item in all_items:
                f.write(f"- {item}\n")
        print(f"\n[OK] Appended {len(all_items)} new items to progress.md")
    else:
        print("\n[OK] No new items to append")

if __name__ == "__main__":
    from datetime import timedelta
    main()