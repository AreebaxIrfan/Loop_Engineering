Difficulty: medium · Uses: Concept 6 (unattended schedule), Concept 12 (the spine).

Build. Make a scheduled loop that runs once, reads a progress.md, gathers something simple from the repo (open TODO comments, or the last day's commits), writes a short summary, and updates progress.md with what it found and the date.

Done when you run it twice and the second run clearly builds on the first, meaning it does not repeat what it already recorded. That proves your spine works. If the second run starts from nothing, your loop has no memory yet.