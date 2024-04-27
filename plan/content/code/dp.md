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

# 70. Climbing Stairs

```python
class Solution:
    # Bottom up, memoization
    def climbStairs(self, n: int) -> int:
        if n <= 2:
            return n
        one, two = 1, 2
        for _ in range(3,n+1):
            tmp = one + two
            one = two
            two = tmp
        return two

    # Top down + memorization (list)
    def climbStairs(self, n):
        if n == 1:
            return 1
        dic = [-1 for i in range(n)]
        dic[0], dic[1] = 1, 2
        return self.helper(n-1, dic)

    def helper(self, n, dic):
        if dic[n] < 0:
            dic[n] = self.helper(n-1, dic)+self.helper(n-2, dic)
        return dic[n]

    # Top down + memorization (dictionary)
    def climbStairs(self, n, dic={1: 1, 2: 2}):
        if n not in dic:
            dic[n] = self.climbStairs(n - 1) + self.climbStairs(n - 2)
        return dic[n]
```

# 746. Min Cost Climbing Stairs

```python
# Tabulation solution
class Solution:
    def minCostClimbingStairs(self, cost: List[int]) -> int:
        dp = [0] * len(cost)
        dp[0] = cost[0]
        dp[1] = cost[1]

        for i in range(2, len(cost)):
            dp[i] = cost[i] + min(dp[i-1], dp[i-2])

        return min(dp[-1], dp[-2])

# Memoization solution
class Solution:
    def minCostClimbingStairs(self, cost: List[int]) -> int:
        n, dic = len(cost), {0: cost[0], 1: cost[1]}

        def helper(n):
            if n in dic:
                return dic[n]
            dic[n] = cost[n] + min(helper(n - 1), helper(n - 2))
            return dic[n]


        return min(helper(n - 1), helper(n - 2))
```

# 198. House Robber

```python
# https://leetcode.com/problems/house-robber/solutions/4697858/top-down-dp-recursion-memoization
# Top-Down Memo
class Solution:
    def rob(self, nums: List[int]) -> int:
        memo, n = {}, len(nums)
        def dfs(i):
            if i >= n:
                return 0
            if i in memo:
                return memo[i]
            rob = nums[i] + dfs(i + 2)
            skip = dfs(i + 1)
            memo[i] = max(rob, skip)
            return memo[i]
        return dfs(0)
```

### 213. House Robber II

```python
# Top-Down Memo
class Solution:
    def rob(self, nums: List[int]) -> int:
        if len(nums) == 1:
            return nums[0]
        return max(self.helper(nums[1:]), self.helper(nums[:-1]))

    def helper(self, nums):
        n, store = len(nums), {}
        def dfs(i):
            if i >= n:
                return 0
            if i in store:
                return store[i]
            rob = nums[i] + dfs(i + 2)
            next_house = dfs(i + 1)
            store[i] = max(rob, next_house)
            return store[i]
        return dfs(0)
```

### 5. Longest Palindromic Substring

```python
# Brute Force
class Solution:
    def longestPalindrome(self, s: str) -> str:
        def helper(l, r, res):
            while l >= 0 and r < len(s) and s[l] == s[r]:       # If inbounds & same_character
                if (r - l + 1) > len(res):                      # If longer than previous longest
                    res = s[l : r + 1]                          # Set new longest palindromic substring
                l, r = l - 1, r + 1
            return res

        res = ""
        for i in range(len(s)):
            l, r = i, i
            res = helper(l, r, res)
            l, r = i, i + 1
            res = helper(l, r, res)
        return res


# Tabulation
class Solution:
    def longestPalindrome(self, s):
        def expand(l, r):
            while l >= 0 and r < len(s) and s[l] == s[r]:
                l -= 1
                r += 1
            return s[l+1:r]
        result = ""
        for i in range(len(s)):
            sub1 = expand(i, i)
            if len(sub1) > len(result):
                result = sub1
            sub2 = expand(i, i+1)
            if len(sub2) > len(result):
                result = sub2
        return result


# Bottom-Up DP 2D
class Solution:
    def longestPalindrome(self, s: str) -> str:
        n = len(s)
        ans, dp = "", [[False] * n for _ in range(n)]
        for i in range(n):
            ans, dp[i][i] = s[i], True
        maxLen = 1
        for start in range(n - 1, -1, -1):
            for end in range(start + 1, n):
                if s[start] == s[end]:
                    if end - start == 1 or dp[start + 1][end - 1]:
                        dp[start][end] = True
                        if maxLen < end - start + 1:
                            maxLen = end - start + 1
                            ans = s[start : end + 1]
        return ans
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

###

```python

```

###

```python

```

# Fibonacci

```python
class Solution:
    def fib(self, n: int, memo={0: 0, 1: 1}) -> int:
        if n in memo:
            return memo[n]
        memo[n] = self.fib(n - 2) + self.fib(n - 1)
        return memo[n]
```

This algorithm is a Python implementation of the Fibonacci sequence using memoization to improve its efficiency. Here's a breakdown of how it works:

1. The base case is checked first, the value of `n` already being inside of the dict `memo` results in the value of that key being returned.
2. If n is not in the memo dictionary (i.e., the Fibonacci number has not been calculated before), the function calculates it recursively by calling itself for the (n-2)th and (n-1)th Fibonacci numbers. It then adds these two Fibonacci numbers together and stores the result in the memo dictionary for future reference.
3. If n is already in the memo dictionary, meaning its Fibonacci number has been calculated before, the function simply returns the value stored in the memo dictionary for n.
4. Finally, the function returns the Fibonacci number corresponding to the input n.

This approach effectively reduces redundant calculations by storing previously calculated Fibonacci numbers in the memo dictionary, thus improving the overall efficiency of the Fibonacci sequence calculation, especially for larger values of n.

# 2370. Longest Ideal Subsequence

```python
# Fastest
class Solution:
    def longestIdealString(self, s: str, k: int) -> int:
        l = [0] * 128
        for c in s:
            i = ord(c)
            l[i] = max(l[i - k : i + k + 1]) + 1
        return max(l)

class Solution:
    def longestIdealString(self, s: str, k: int) -> int:
        bottom, dp = ord("a"), [0] * 26
        for ch in s:
            i = ord(ch) - bottom
            dp[i] = 1 + max(dp[max(0, i - k) : min(26, i + k + 1)])
        return max(dp)
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

#

```python

```

#

```python

```

#

```python

```
