# Dynamic Programming

To prepare for dynamic programming(dp), it's essential to grasp some fundamental techniques:

- Recursion: DP often involves breaking down a problem into smaller subproblems. Understanding recursion, how it works, and its implementation is crucial, as DP often builds upon recursive solutions.

- Identifying Overlapping Subproblems: DP relies on solving overlapping subproblems. Identifying these subproblems helps in applying DP techniques effectively.

- Memoization: This technique involves storing the results of expensive function calls and returning the cached result when the same inputs occur again. It's a top-down approach to DP and helps avoid redundant computations.

- Bottom-Up (Tabulation) Approach: This involves solving the problem iteratively, starting from the smallest subproblems and building up to larger ones. It typically requires using arrays or tables to store intermediate results.

- Understanding Optimal Substructure: DP problems exhibit optimal substructure, meaning the optimal solution to a problem can be constructed from the optimal solutions of its subproblems. Recognizing and utilizing this property is essential.

- State Representation: Formulating the problem in terms of states and transitions is crucial for DP. Each state represents a specific configuration of the problem, and transitions denote how the states are connected.

- Choosing the Right Data Structure: Depending on the problem, choosing the appropriate data structure for storing intermediate results can significantly impact the efficiency of DP solutions. Common data structures include arrays, matrices, hash maps, and trees.

- Practice, Practice, Practice: DP can be challenging to grasp initially, but like any skill, practice is key. Solve a variety of DP problems to familiarize yourself with different patterns and techniques.

By mastering these fundamental techniques, you'll be well-prepared to tackle DP problems effectively. Start with simpler problems and gradually move on to more complex ones as you build your understanding and confidence.

## Memoization

### Fibonacci

```python
# No memoization
def fib(n):
    if n <= 2: return 1
    return fib(n-1) + fib(n-2)

print(fib(1))
print(fib(2))
print(fib(6))
print(fib(7))
print(fib(8))
print(fib(50))
```

##### Time & Space Complexity

```python
def dib(n):
    if n <= 1: return
    return dib(n-1) + dib(n-1)

def fib(n):
    if n <= 1: return
    return fib(n-1) + fib(n-2)

def lib(n):
    if n <= 1: return
    return dib(n-2) + dib(n-2)
```

Time
O(dib) <= O(fib) <= O(lib)
O(2^n) <= O(2^n) <= O(2^n)

Space
O(dib) <= O(fib) <= O(lib)
O(N) <= O(N) <= O(N)

#### Memo

```python
def fib(n, store = {}):
    if n <= 2: return 1
    if store.get(n): return store[n]
    store[n] =  fib(n-1, store) + fib(n-2, store)
    return store[n]

print(fib(1))
print(fib(2))
print(fib(6))
print(fib(7))
print(fib(8))
print(fib(50))
```

##### Time & Space Complexity

Time
O(N)

Space
O(N)

### Grid Traveler

```python
def gridTraveler(m, n):
    if m == 1 and n == 1:
        return 1
    if m == 0 or n == 0:
        return 0
    return gridTraveler(m-1, n) + gridTraveler(m, n-1)

print(gridTraveler(1, 1)) # 1
print(gridTraveler(2, 3)) # 3
print(gridTraveler(3, 2)) # 3
print(gridTraveler(3, 3)) # 6
print(gridTraveler(18,18)) # Timeout... but 2333606220
```

##### Time & Space Complexity

Time
O(2^(n+m))

Space
O(N+M)

#### Memo

```python
def gridTraveler(m, n, store={}):
    if store.get((m,n)):
        return store[(m,n)]
    if m == 1 and n == 1:
        store[(m, n)] = 1
        return 1
    if m == 0 or n == 0:
        return 0
    store[(m, n)] = gridTraveler(m-1, n, store) + gridTraveler(m, n-1, store)
    return store[(m,n)]

print(gridTraveler(1, 1)) # 1
print(gridTraveler(2, 3)) # 3
print(gridTraveler(3, 2)) # 3
print(gridTraveler(3, 3)) # 6
print(gridTraveler(18,18)) # 2333606220
```

### Can Sum

```python

```

### How Sum

```python

```

### Best Sum

```python

```

### Can Construct

```python

```

### Count Construct

```python

```

### All Construct

```python

```

## Tabulation

### Fibonacci

```python

```

### Grid Traveler

```python

```

### Can Sum

```python

```

### How Sum

```python

```

### Best Sum

```python

```

### Can Construct

```python

```

### Count Construct

```python

```

### All Construct

```python

```
