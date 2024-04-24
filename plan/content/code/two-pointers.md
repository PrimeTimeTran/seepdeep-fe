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

# 11. Container With Most Water

```python
class Solution:
    def maxArea(self, H: List[int]) -> int:
        res, l, r = 0, 0, len(H) - 1

        while l < r:
            x = r - l
            y = min(H[l], H[r])
            res = max(res, x * y)
            if H[l] < H[r]:
                l += 1
            else:
                r -= 1
        return res
```


# 42. Trapping Rain Water
```python
class Solution:
    def trap(self, height: List[int]) -> int:
        res, l, r = 0, 0, len(height) - 1
        lMax, rMax = height[l], height[r]

        while l < r:
            if height[l] < height[r]:
                l += 1
                lMax = max(lMax, height[l])
                res += lMax - height[l]
            else:
                r -= 1
                rMax = max(rMax, height[r])
                res += rMax - height[r]
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
