import math

def binom(n, k):
    return math.factorial(n) / (math.factorial(n - k) * math.factorial(k))

def num_trees(n):
    """
    Returns the number of binary trees with n labelled items at the leafs.
    """
    assert n >= 0, n
    if n <= 2:
        return n
    return sum(binom(n, k) * num_trees(k) * num_trees(n - k) for k in range(1, n))

if __name__ == "__main__":
    for i in range(1, 11):
        print "{:>2}: {:>11} {:>7}".format(i, num_trees(i), math.factorial(i))
