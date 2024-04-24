# Two Pointers

# 167. Two Sum II - Input Array Is Sorted
```python
class Solution:
    def twoSum(self, nums: List[int], target: int) -> List[int]:
        l,r = 0, len(nums)-1
        
        while l<=r:
            n = nums[l] + nums[r]
            if n == target:
                return [l+1,r+1]
            elif n > target:
                r -= 1
            else:
                l += 1
```
# 15. 3Sum

```python
class Solution:
    def threeSum(self, nums: List[int]) -> List[List[int]]:
      res = []
      nums.sort()
      for i, a in enumerate(nums):
        if i > 0 and a == nums[i - 1]:
          continue
        l, r = i + 1, len(nums) - 1
        while l < r:
          threeSum = a + nums[l] + nums[r]
          if threeSum > 0:
            r -= 1
          elif threeSum < 0:
            l += 1
          else:
            res.append([a, nums[l], nums[r]])
            l += 1
            while nums[l] == nums[l - 1] and l < r:
              l += 1
      return res
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
