

# 704. Binary Search
```python
class Solution:
    def search(self, nums: List[int], target: int) -> int:
        l, r, mid = 0, len(nums) - 1, len(nums) // 2

        while l <= r:
            mid = (l + r) // 2
            if nums[mid] == target:
                return mid
            if nums[mid] > target:
                r = mid - 1
            else:
                l = mid + 1
        return -1

```

# 
```python
```

# 
```python
```
# 
```python
```
# 
```python
```
# 
```python
```
# 
```python
```
# 
```python
```
# 
```python
```
# 
```python
```
