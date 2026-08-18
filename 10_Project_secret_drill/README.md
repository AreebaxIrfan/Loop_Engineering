# Secret Drill

This project demonstrates and verifies two secret-delivery paths for the same logical secret:

1. **Local execution** — secret comes from a **gitignored `.env`** file at repo root
2. **Cloud-runner execution** — secret comes from the **runner's environment secret store** (e.g., GitHub Actions `secrets`, GitLab CI `variables`, Azure Pipelines `secret variables`)

The secret value itself is **never printed** and **never committed**. Both paths are verified programmatically.

## Secret contract

- Name: `DRILL_SECRET`
- Expected value (for verification only): a non-empty string known to the operator
- Verification: hash the value (SHA-256) and compare against a stored **expected hash** (committed); this proves the correct secret is present without exposing it.

## Files

- `.env` — **gitignored**. Create locally with `DRILL_SECRET=your_value_here`
- `.env.example` — committed template (no real value)
- `verify.mjs` — Node verification script. Reads `DRILL_SECRET` from `process.env`, hashes it, compares to `EXPECTED_HASH`
- `package.json` — `npm run verify` runs the check
- `.github/workflows/verify.yml` — CI workflow that runs the same check using the runner's secret store

## Local verification

```bash
# 1. Create .env from template
cp .env.example .env
# 2. Edit .env and set DRILL_SECRET=your_actual_secret
# 3. Run verification
npm run verify
```

## Cloud-runner verification

1. Add `DRILL_SECRET` to your runner's secret store (GitHub: Settings → Secrets → Actions; GitLab: Settings → CI/CD → Variables; etc.)
2. Push; the workflow runs automatically and verifies the secret is available in the runner environment.

## Expected hash

The committed `EXPECTED_HASH` in `verify.mjs` is the SHA-256 of the correct secret value. To set it:

```bash
# Generate the hash for your chosen secret
node -e "console.log(require('crypto').createHash('sha256').update('YOUR_SECRET_VALUE').digest('hex'))"
```

Paste the output into `verify.mjs` as `EXPECTED_HASH`.