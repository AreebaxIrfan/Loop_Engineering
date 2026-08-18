#!/bin/bash
# run-candidates.sh - Parallel draft-and-review engine
# Spins up git worktree candidates, runs fixes in parallel, and reports verdicts

# Don't use set -e because we need to handle failed tests gracefully

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
CANDIDATES_DIR="$PROJECT_ROOT/.candidates"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Define candidate branches
CANDIDATES=("candidate-fix-divide" "candidate-fix-average" "candidate-fix-all")

echo "========================================"
echo "Parallel Draft-and-Review Engine"
echo "========================================"
echo "Timestamp: $TIMESTAMP"
echo "Project Root: $PROJECT_ROOT"
echo "Candidates: ${CANDIDATES[*]}"
echo ""

# Cleanup function
cleanup() {
    echo ""
    echo "Cleaning up worktrees and branches..."
    for candidate in "${CANDIDATES[@]}"; do
        if [ -d "$CANDIDATES_DIR/$candidate" ]; then
            git worktree remove --force "$CANDIDATES_DIR/$candidate" 2>/dev/null || true
        fi
        git branch -D "$candidate" 2>/dev/null || true
    done
    rm -rf "$CANDIDATES_DIR"
    echo "Cleanup complete."
}

# Register cleanup on exit
trap cleanup EXIT

# Ensure we're on main and have a clean state
cd "$PROJECT_ROOT"
git checkout main 2>/dev/null || git checkout -b main

# Create initial commit if needed
if ! git rev-parse HEAD >/dev/null 2>&1; then
    git add -A
    git commit -m "Initial commit with buggy math_utils.py"
fi

echo "Setting up candidate worktrees..."
echo ""

# Create candidate worktrees
for candidate in "${CANDIDATES[@]}"; do
    echo "Creating worktree for: $candidate"
    git branch "$candidate" 2>/dev/null || git checkout -b "$candidate"
    git worktree add "$CANDIDATES_DIR/$candidate" "$candidate" 2>/dev/null || true
    git checkout main
done

echo ""
echo "========================================"
echo "Running fixes in parallel..."
echo "========================================"
echo ""

# Array to store PIDs
declare -A PIDS

# Run each candidate fix in parallel
for candidate in "${CANDIDATES[@]}"; do
    (
        echo "[$candidate] Starting..."
        cd "$CANDIDATES_DIR/$candidate"

        # Each candidate gets a different fix approach
        case "$candidate" in
            "candidate-fix-divide")
                echo "[$candidate] Fixing divide() only..."
                cat > math_utils.py << 'EOF'
"""Math utility functions."""


def divide(a, b):
    """Divide a by b and return the result.

    Raises:
        ZeroDivisionError: If b is zero.
    """
    if b == 0:
        raise ZeroDivisionError("Cannot divide by zero")
    return a / b


def calculate_average(numbers):
    """Calculate the average of a list of numbers."""
    total = sum(numbers)
    return total / len(numbers)


def safe_divide(a, b, default=0):
    """Safely divide a by b, returning default if b is zero."""
    if b == 0:
        return default
    return a / b
EOF
                ;;
            "candidate-fix-average")
                echo "[$candidate] Fixing calculate_average() only..."
                cat > math_utils.py << 'EOF'
"""Math utility functions."""


def divide(a, b):
    """Divide a by b and return the result."""
    return a / b


def calculate_average(numbers):
    """Calculate the average of a list of numbers.

    Raises:
        ValueError: If numbers list is empty.
    """
    if not numbers:
        raise ValueError("Cannot calculate average of empty list")
    total = sum(numbers)
    return total / len(numbers)


def safe_divide(a, b, default=0):
    """Safely divide a by b, returning default if b is zero."""
    if b == 0:
        return default
    return a / b
EOF
                ;;
            "candidate-fix-all")
                echo "[$candidate] Fixing all functions..."
                cat > math_utils.py << 'EOF'
"""Math utility functions."""


def divide(a, b):
    """Divide a by b and return the result.

    Raises:
        ZeroDivisionError: If b is zero.
    """
    if b == 0:
        raise ZeroDivisionError("Cannot divide by zero")
    return a / b


def calculate_average(numbers):
    """Calculate the average of a list of numbers.

    Raises:
        ValueError: If numbers list is empty.
    """
    if not numbers:
        raise ValueError("Cannot calculate average of empty list")
    total = sum(numbers)
    return total / len(numbers)


def safe_divide(a, b, default=0):
    """Safely divide a by b, returning default if b is zero."""
    if b == 0:
        return default
    return a / b
EOF
                ;;
        esac

        # Run checker
        echo "[$candidate] Running checker..."
        py checker.py > "$CANDIDATES_DIR/${candidate}.log" 2>&1
        EXIT_CODE=$?

        echo "[$candidate] Exit code: $EXIT_CODE"
        exit $EXIT_CODE
    ) &
    PIDS[$candidate]=$!
done

# Wait for all candidates and collect results
echo "Waiting for candidates to complete..."
echo ""

declare -A RESULTS
for candidate in "${CANDIDATES[@]}"; do
    wait ${PIDS[$candidate]}
    EXIT_CODE=$?
    RESULTS[$candidate]=$EXIT_CODE
done

echo ""
echo "========================================"
echo "RESULTS SUMMARY"
echo "========================================"
echo ""

PASSED=()
FAILED=()

for candidate in "${CANDIDATES[@]}"; do
    if [ "${RESULTS[$candidate]}" -eq 0 ]; then
        echo -e "${GREEN}✓ PASS${NC}: $candidate (exit code: 0)"
        PASSED+=("$candidate")
    else
        echo -e "${RED}✗ FAIL${NC}: $candidate (exit code: ${RESULTS[$candidate]})"
        FAILED+=("$candidate")
    fi

    # Show log excerpt
    if [ -f "$CANDIDATES_DIR/${candidate}.log" ]; then
        echo "  Last 5 lines of output:"
        tail -5 "$CANDIDATES_DIR/${candidate}.log" | sed 's/^/  /'
    fi
    echo ""
done

echo "========================================"
echo "VERDICT"
echo "========================================"
echo "Passed: ${#PASSED[@]}/${#CANDIDATES[@]}"
echo "Failed: ${#FAILED[@]}/${#CANDIDATES[@]}"

if [ ${#PASSED[@]} -gt 0 ]; then
    echo ""
    echo -e "${GREEN}Successful candidates:${NC}"
    for candidate in "${PASSED[@]}"; do
        echo "  - $candidate"
    done
fi

if [ ${#FAILED[@]} -gt 0 ]; then
    echo ""
    echo -e "${RED}Failed candidates:${NC}"
    for candidate in "${FAILED[@]}"; do
        echo "  - $candidate"
    done
fi

echo ""
echo "========================================"
echo "Cleanup will happen on script exit..."
echo "========================================"

# Exit with 0 if any candidate passed, 1 if all failed
if [ ${#PASSED[@]} -gt 0 ]; then
    exit 0
else
    exit 1
fi
