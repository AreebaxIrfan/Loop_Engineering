#!/usr/bin/env python3
"""Checker script to validate fixes pass tests and handle edge cases."""
import sys
from math_utils import divide, calculate_average, safe_divide



def test_divide_by_zero():
    """Test that divide handles division by zero."""
    try:
        result = divide(10, 0)
        print(f"FAIL: divide(10, 0) should raise ZeroDivisionError, got {result}")
        return False
    except ZeroDivisionError:
        print("PASS: divide(10, 0) correctly raises ZeroDivisionError")
        return True


def test_calculate_average_empty_list():
    """Test that calculate_average handles empty list."""
    try:
        result = calculate_average([])
        print(f"FAIL: calculate_average([]) should raise ValueError or ZeroDivisionError, got {result}")
        return False
    except (ValueError, ZeroDivisionError):
        print("PASS: calculate_average([]) correctly raises exception")
        return True


def test_calculate_average_normal():
    """Test normal average calculation."""
    result = calculate_average([1, 2, 3, 4, 5])
    expected = 3.0
    if result == expected:
        print(f"PASS: calculate_average([1,2,3,4,5]) = {result}")
        return True
    else:
        print(f"FAIL: calculate_average([1,2,3,4,5]) expected {expected}, got {result}")
        return False


def test_safe_divide_zero():
    """Test safe_divide with zero divisor."""
    result = safe_divide(10, 0)
    if result == 0:
        print(f"PASS: safe_divide(10, 0) = {result} (default)")
        return True
    else:
        print(f"FAIL: safe_divide(10, 0) expected 0, got {result}")
        return False


def test_safe_divide_custom_default():
    """Test safe_divide with custom default."""
    result = safe_divide(10, 0, default=-1)
    if result == -1:
        print(f"PASS: safe_divide(10, 0, default=-1) = {result}")
        return True
    else:
        print(f"FAIL: safe_divide(10, 0, default=-1) expected -1, got {result}")
        return False


def test_safe_divide_normal():
    """Test safe_divide normal case."""
    result = safe_divide(10, 2)
    if result == 5.0:
        print(f"PASS: safe_divide(10, 2) = {result}")
        return True
    else:
        print(f"FAIL: safe_divide(10, 2) expected 5.0, got {result}")
        return False


def main():
    """Run all tests and return exit code."""
    print("=" * 50)
    print("Running Checker Tests")
    print("=" * 50)

    tests = [
        test_divide_by_zero,
        test_calculate_average_empty_list,
        test_calculate_average_normal,
        test_safe_divide_zero,
        test_safe_divide_custom_default,
        test_safe_divide_normal,
    ]

    results = []
    for test in tests:
        try:
            results.append(test())
        except Exception as e:
            print(f"ERROR in {test.__name__}: {e}")
            results.append(False)

    print("=" * 50)
    passed = sum(results)
    total = len(results)
    print(f"Results: {passed}/{total} tests passed")
    print("=" * 50)

    if passed == total:
        print("VERDICT: PASS")
        return 0
    else:
        print("VERDICT: FAIL")
        return 1


if __name__ == "__main__":
    sys.exit(main())
