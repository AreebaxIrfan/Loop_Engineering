"""Math utility functions."""


def divide(a, b):
    """Divide a by b and return the result."""
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
