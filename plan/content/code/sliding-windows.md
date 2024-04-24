# Sliding Windows

These problems are encountered often with lists. We maintain a left and right pointer and update them according to the needs of the problem.

We'll often times need to get the size of the window and this can be done using `r - l + 1` formula.

# 121. Best Time to Buy and Sell Stock

```python
class Solution:
    def maxProfit(self, P: List[int]) -> int:
        res, buy = 0, 0
        for r, sell in enumerate(P):
            res = max(res, sell - P[buy])
            if sell < P[buy]: buy = r
        return res
```

# 3. Longest Substring Without Repeating Characters

```python
class Solution:
    def lengthOfLongestSubstring(self, s: str) -> int:
        ans, l, window = 0, 0, set()
        for r, c in enumerate(s):
            if c in window:
                while c in window:
                    window.remove(s[l])
                    l += 1
            window.add(c)
            ans = max(ans, r - l + 1)
        return ans
```

# 424. Longest Repeating Character Replacement

```python
class Solution:
    def characterReplacement(self, s: str, k: int) -> int:
        maxf, res, l, win = 0, 0, 0, {}
        for r, c in enumerate(s):
            win[c] = win.get(c, 0) + 1
            maxf = max(maxf, win[c])
            while (r - l + 1) - maxf > k:
                win[s[l]] -= 1
                l += 1
            res = max(res, r-l+1)
        return res
```

# 567. Permutation in String

```python
class Solution:
    def checkInclusion(self, p: str, s: str) -> bool:
        l, cnt = 0, Counter(p)
        
        for r, c in enumerate(s):
            cnt[c] -= 1
            while cnt[c] < 0:
                cnt[s[l]] += 1
                l += 1
            if r - l + 1 == len(p):
                return True
        return False

        # Another technique
        cntr, w = Counter(s1), len(s1)
        for i in range(len(s2)):
            if s2[i] in cntr:
                cntr[s2[i]] -= 1
            if i >= w and s2[i-w] in cntr:
                cntr[s2[i-w]] += 1
            if all([cntr[i] == 0 for i in cntr]):
                return True
        return False
```

- https://leetcode.com/problems/find-all-anagrams-in-a-string/description/

#

```python
```

#

```python
```

# 76. Minimum Window Substring

```python
class Solution:
    def minWindow(self, s: str, t: str) -> str:
        if len(t) == 0: return ""
        l, win, ct = 0, {}, {}
        for c in t:
            ct[c] = ct.get(c, 0) + 1
        have, need = 0, len(ct)
        res, reslen = [-1, -1], float("infinity")
        # Expand window
        for r, c in enumerate(s):
            # Track chars in window
            win[c] = win.get(c, 0) + 1
            # Check if char in list of required chars. 
            # Yes? Check if enough in bounds of window
            if c in ct and win[c] == ct[c]:
                # Update count of how many we have
                have += 1
                # While we can, shrink the window.
                while have == need:
                    # Update res vars
                    if (r - l + 1) < reslen:
                        res = [l, r]
                        reslen = r - l + 1
                    # Update count of window, removing farthest left char
                    win[s[l]] -= 1
                    # If left most window char in watch list & removing it means 
                    # we no longer have enough of that char decrement our have.
                    if s[l] in ct and win[s[l]] < ct[s[l]]:
                        have -= 1
                    # Shrink window
                    l += 1
        l, r = res
        return s[l:r+1] if reslen != float('infinity') else ""

```

# 239. Sliding Window Maximum

- Maintain a list of indexes
- Pop from the right if the current index's element is larger than the last(it'll be useless, it's not the maximum, get rid of it.)
- If we've reached out windows size, add to the response the current maximum(the farthest left element in our queue)

```python
class Solution:
    def maxSlidingWindow(self, nums: List[int], k: int) -> List[int]:
        res = []
        q = deque()
        for i, n in enumerate(nums):
            while q and nums[q[-1]] < n:
                q.pop()
            q += i,
            if q[0] == i - k:
                q.popleft()
            if i>= k -1:
                res += nums[q[0]],
        return res
```
