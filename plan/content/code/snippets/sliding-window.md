Kadanes Algorithm
```python
class Solution:
    def maxSubArray(self, nums: List[int]) -> int:
        res, cur = nums[0], 0
        for n in nums:
            if cur < 0:
                cur = 0
            cur += n
            res = max(res, cur)
        return res
```