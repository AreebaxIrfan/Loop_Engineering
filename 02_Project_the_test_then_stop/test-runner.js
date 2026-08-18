const { add, multiply, subtract } = require('./math.js');

let passed = 0;
let failed = 0;

function test(description, fn) {
  try {
    fn();
    console.log(`✓ ${description}`);
    passed++;
  } catch (error) {
    console.log(`✗ ${description}`);
    console.log(`  Error: ${error.message}`);
    failed++;
  }
}

function assertEqual(actual, expected, message) {
  if (actual !== expected) {
    throw new Error(`${message}: expected ${expected}, got ${actual}`);
  }
}

// Test 1
test('add(2, 3) should return 5', () => {
  assertEqual(add(2, 3), 5, 'add(2, 3)');
});

// Test 2
test('multiply(3, 4) should return 12', () => {
  assertEqual(multiply(3, 4), 12, 'multiply(3, 4)');
});

// Test 3
test('subtract(10, 3) should return 7', () => {
  assertEqual(subtract(10, 3), 7, 'subtract(10, 3)');
});

console.log(`\nResults: ${passed} passed, ${failed} failed`);

// Exit with code based on test results
process.exit(failed > 0 ? 1 : 0);
