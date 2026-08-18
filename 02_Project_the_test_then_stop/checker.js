// Checker script - runs tests and exits 0 only if all pass
const { spawn } = require('child_process');
const path = require('path');

const testProcess = spawn('node', ['test-runner.js'], {
  cwd: __dirname,
  stdio: 'inherit'
});

testProcess.on('close', (code) => {
  if (code === 0) {
    console.log('\n✅ CHECKER PASSED: All tests green!');
    process.exit(0);
  } else {
    console.log('\n❌ CHECKER FAILED: Tests are failing');
    process.exit(1);
  }
});
