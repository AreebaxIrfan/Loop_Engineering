// verify.mjs — verify the DRILL_SECRET is available from the correct source
// WITHOUT ever printing the raw secret value or committing it.
//
// Strategy: hash the secret (SHA-256) and compare against a committed
// EXPECTED_HASH. This proves the correct secret is present without exposing it.

import crypto from 'node:crypto';
import fs from 'node:fs';
import path from 'node:path';
import os from 'node:os';

// SHA-256 of the correct secret value. Committed safely (not a secret itself).
// To regenerate after changing the secret:
//   node -e "console.log(require('crypto').createHash('sha256').update('VALUE').digest('hex'))"
const EXPECTED_HASH =
  '8e2508b342340611e64dd94e67f0688d5d2e9baf05b29bbdfd3573ed766f793d';

// Load a local .env file (gitignored) if present.
// We do this manually to avoid a dependency and to track the source explicitly.
let loadedFromDotEnv = false;
const dotEnvPath = path.resolve(process.cwd(), '.env');
if (fs.existsSync(dotEnvPath)) {
  const raw = fs.readFileSync(dotEnvPath, 'utf8');
  for (const line of raw.split(/\r?\n/)) {
    const trimmed = line.trim();
    if (!trimmed || trimmed.startsWith('#')) continue;
    const eq = trimmed.indexOf('=');
    if (eq === -1) continue;
    const key = trimmed.slice(0, eq).trim();
    let val = trimmed.slice(eq + 1).trim();
    if (val.startsWith('"') && val.endsWith('"')) val = val.slice(1, -1);
    if (val.startsWith("'") && val.endsWith("'")) val = val.slice(1, -1);
    if (!(key in process.env)) process.env[key] = val;
    if (key === 'DRILL_SECRET') loadedFromDotEnv = true;
  }
}

function fail(msg) {
  console.error(`✗ ${msg}`);
  console.error(
    '\nHint: local runs need a gitignored .env with DRILL_SECRET=<value>.' +
      ' Cloud runs need the secret in the runner environment secret store.'
  );
  process.exit(1);
}

const secret = process.env.DRILL_SECRET;
if (!secret || secret.trim() === '') {
  fail('DRILL_SECRET is missing from the environment.');
}

const source = loadedFromDotEnv
  ? 'local gitignored .env file'
  : 'inherited environment (cloud-runner secret store)';

const actualHash = crypto.createHash('sha256').update(secret).digest('hex');

if (EXPECTED_HASH === '0'.repeat(64)) {
  fail(
    'EXPECTED_HASH is still the placeholder. Set it to the SHA-256 of the secret ' +
      'so verification can confirm the correct value without printing it.'
  );
}

if (actualHash !== EXPECTED_HASH) {
  fail(
    `DRILL_SECRET is present (source: ${source}) but its hash does NOT match EXPECTED_HASH.`
  );
}

// Confirm the value is non-empty and not accidentally echoed.
const masked = '•'.repeat(Math.min(8, secret.length));
console.log(
  `✓ DRILL_SECRET verified — correct value present via ${source}. ` +
    `(masked length ${secret.length}, preview "${masked}…")`
);
console.log('✓ Secret value was never printed in full.');
process.exit(0);
