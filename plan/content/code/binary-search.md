

### 704. Binary Search
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

### 
```python
```
### 
```python
```
### 
```python
```
### 
```python
```
### 
```python
```
### 
```python
```
### 
```python
```
### 3116. Kth Smallest Amount With Single Denomination Combination 
```python
# https://leetcode.com/problems/kth-smallest-amount-with-single-denomination-combination/solutions/5019504/python3-math-inclusion-exclusion-principle-binary-search
class Solution:
    def findKthSmallest(self, coins: List[int], k: int) -> int:
        dic, n = defaultdict(list), len(coins)
        for i in range(1, n + 1):
            for comb in itertools.combinations(coins, i):
                dic[len(comb)].append(math.lcm(*comb))
        
        def count(dic, target):
            ans = 0
            for i in range(1, n + 1):
                for lcm in dic[i]:
                    ans += target // lcm * pow(-1, i + 1)
            return ans
        
        start, end = min(coins), min(coins) * k
        while start + 1 < end:
            print('start: ', start,' end: ',end)
            mid = (start + end) // 2
            if count(dic, mid) >= k:
                end = mid
            else:
                start = mid
        if count(dic, start) >= k:
            return start
        else:
            return end
```
