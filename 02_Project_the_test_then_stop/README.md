Difficulty: easy to medium · Uses: Concept 5 (conditional loop), Concept 11 (maker-checker).

Build. Put 2 or 3 small failing tests in your repo. Build a loop that keeps working until the tests pass, but let a command (the test runner), not the agent, decide when it is done. Cap it at, say, 6 tries.

Done when the loop stops because the tests actually passed, not because it hit the cap. If it keeps hitting the cap, your stop condition or your prompt needs work. That is the lesson.