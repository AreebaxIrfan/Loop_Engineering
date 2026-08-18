"""Math utility functions."""


def divide(a, b, default=None):
    """Divide a by b and return the result.

    Args:
        a: Numerator
        b: Denominator
        default: Value to return if b is zero (raises ZeroDivisionError if not provided)

    Returns:
        Result of a/b, or default if b is zero and default is provided

    Raises:
        ZeroDivisionError: If b is zero and no default is provided
    """
    if b == 0:
        if default is not None:
            return default
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
