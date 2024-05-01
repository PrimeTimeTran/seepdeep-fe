# Advanced Python

## heapq

## deque

## bisect

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
