# Advanced Python

## heapq

https://leetcode.com/problems/k-th-smallest-prime-fraction/?envType=daily-question&envId=2024-05-10

## deque

## bisect

https://leetcode.com/problems/k-th-smallest-prime-fraction/?envType=daily-question&envId=2024-05-10

## itertools

### combinations

```python
chars = ['a','b','c','d','e']
# Create combinations of n chars
n = 2
items = itertools.combinations(chars,n)
print(list(items))
```

### islice

### count

### cycle

### repeat

### accumulate

### batched

### chain

### groupby

## Counter

Benefits

- Doesn't error when searching for a key that doesn't exist.

```python
counter1 = Counter('abc')
print(counter1['z'])

counter2 = {}
print(counter2['z'])
```
