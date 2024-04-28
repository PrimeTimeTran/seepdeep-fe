# Dynamic Programming

To prepare for dynamic programming(dp), it's essential to grasp some fundamental techniques:

- Recursion: DP often involves breaking down a problem into smaller sub-problems. Understanding recursion, how it works, and its implementation is crucial, as DP often builds upon recursive solutions.

- Identifying Overlapping Sub-Problems: DP relies on solving overlapping sub-problems. Identifying these sub-problems helps in applying DP techniques effectively.

- Memoization: This technique involves storing the results of expensive function calls and returning the cached result when the same inputs occur again. It's a top-down approach to DP and helps avoid redundant computations.

- Bottom-Up (tabulation) Approach: This involves solving the problem iteratively, starting from the smallest sub-problems and building up to larger ones. It typically requires using arrays or tables to store intermediate results.

- Understanding Optimal Substructure: DP problems exhibit optimal substructure, meaning the optimal solution to a problem can be constructed from the optimal solutions of its sub-problems. Recognizing and utilizing this property is essential.

- State Representation: Formulating the problem in terms of states and transitions is crucial for DP. Each state represents a specific configuration of the problem, and transitions denote how the states are connected.

- Choosing the Right Data Structure: Depending on the problem, choosing the appropriate data structure for storing intermediate results can significantly impact the efficiency of DP solutions. Common data structures include arrays, matrices, hash maps, and trees.

- Practice, Practice, Practice: DP can be challenging to grasp initially, but like any skill, practice is key. Solve a variety of DP problems to familiarize yourself with different patterns and techniques.

By mastering these fundamental techniques, you'll be well-prepared to tackle DP problems effectively. Start with simpler problems and gradually move on to more complex ones as you build your understanding and confidence.

## Solution categories

Carry
Memo
Tabulation
Both tabulation (bottom-up) and memoization (top-down) are techniques used in dynamic programming (DP) to solve problems by breaking them down into smaller subproblems. Each approach has its advantages and may be easier to implement depending on the problem and the programmer's preference.

Tabulation involves solving the problem by iteratively filling up a table, starting from the smallest subproblems and progressively solving larger subproblems until the final solution is reached. This approach is generally more straightforward and easier to understand for beginners because it follows a systematic approach. It often requires less mental overhead as it doesn't involve recursive calls.

Memoization, on the other hand, involves solving the problem recursively while storing the results of already solved subproblems in a data structure (usually a dictionary or an array) to avoid redundant computations. This approach is more intuitive for some people, especially those with a background in recursion, as it closely resembles the recursive formulation of the problem. However, it may require a deeper understanding of how recursion and memoization work, and it can be trickier to implement correctly, especially when dealing with multiple recursive calls.

In summary, neither tabulation nor memoization is universally easier than the other, as it often depends on the problem at hand and the individual programmer's familiarity and comfort with the techniques. Some problems may be more naturally suited to one approach over the other, and personal preference and experience also play a significant role in determining which technique feels easier to work with.

## Techniques

Top down & bottom up

### 70. Climbing Stairs

```python
# Bottom up
class Solution:
    def climbStairs(self, n: int) -> int:
        if n <= 2:
            return n
        one, two = 1, 2
        for _ in range(3,n+1):
            tmp = one + two
            one = two
            two = tmp
        return two

# Bottom up tab
class Solution:
    def climbStairs(self, n: int) -> int:
        ans = [0] * (n + 1)
        ans[0], ans[1] = 1, 1
        for i in range(2, n + 1):
            ans[i] = ans[i - 1] + ans[i - 2]
        return ans[-1]

# Top down memo with list
class Solution:
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

# Top down memo with dictionary
    def climbStairs(self, n, dic={1: 1, 2: 2}):
        if n not in dic:
            dic[n] = self.climbStairs(n - 1) + self.climbStairs(n - 2)
        return dic[n]
```

### 746. Min Cost Climbing Stairs

```python
# Bottom up tab
class Solution:
    def minCostClimbingStairs(self, cost: List[int]) -> int:
        ans = [0] * len(cost)
        ans[0], ans[1] = cost[0], cost[1]
        for i in range(2, len(cost)):
            ans[i] = cost[i] + min(ans[i - 1], ans[i - 2])
        return min(ans[-1], ans[-2])

# Top down memo
class Solution:
    def minCostClimbingStairs(self, cost: List[int]) -> int:
        store, n = {0: cost[0], 1: cost[1]}, len(cost)
        def helper(i):
            if i in store:
                return store[i]
            store[i] = cost[i] + min(helper(i - 1), helper(i - 2))
            return store[i]
        return min(helper(n - 1), helper(n - 2))
```

### 198. House Robber

```python
# Bottom up
class Solution:
    def rob(self, nums: List[int]) -> int:
        n = len(nums)
        if n == 1:
            return nums[0]

        dp = [0] * n
        dp[0] = nums[0]
        dp[1] = max(nums[0], nums[1])
        for i in range(2, n):
            dp[i] = max(dp[i - 1], nums[i] + dp[i - 2])

        return dp[-1]

# https://leetcode.com/problems/house-robber/solutions/4697858/top-down-dp-recursion-memo
# Top down memo
class Solution:
    def rob(self, nums: List[int]) -> int:
        n, store = len(nums), {}

        def dp(i):
            if i >= n:
                return 0
            if i in store:
                return store[i]
            rob = nums[i] + dp(i + 2)
            skip = dp(i + 1)
            store[i] = max(rob, skip)
            return store[i]
        return dp(0)
```

### 213. House Robber II

```python
# Top down memo
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
            res = helper(i, i, res)                             # Odd length palindrome
            res = helper(i, i + 1, res)                         # Even length
        return res


# Tab
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


# Bottom up DP 2D
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

### 647. Palindromic Substrings

```python
# Memo
class Solution:
    def countSubstrings(self, s: str) -> int:
        n, c, memo = len(s), 0, {}
        def check(l, r):
            if l > r:
                return True
            if (l, r) in memo:
                return memo[(l, r)]
            if s[l] == s[r]:
                memo[(l, r)] = check(l + 1, r - 1)
                return memo[(l, r)]
            return False
        for l in range(n):
            for r in range(l, n):
                if check(l, r):
                    c += 1
        return c
# Tab 2D DP
class Solution:
    def countSubstrings(self, s: str) -> int:
        n = len(s)
        ans, palindrome = 0, [[False] * n for _ in range(n)]

        for length in range(1, n + 1):
            for i in range(n - length + 1):
                if s[i] == s[i + length - 1] and (length <= 2 or palindrome[i + 1][i + length - 2]):
                    palindrome[i][i + length - 1] = True
                    ans += 1

        return ans
# Brute Force
# Runs fastest
class Solution:
    def countSubstrings(self, s: str) -> int:
        self.ans = 0                                                # So we can access inside the helper function

        def helper(l, r):
            while l >= 0 and r < len(s) and s[l] == s[r]:           # Inbounds & same_character
                self.ans += 1                                       # Increment as it's a palindrome
                l, r = l - 1, r + 1

        for i, _ in enumerate(s):
            helper(i, i)                                            # Odd # chars palindrome
            helper(i, i + 1)                                        # Even # chars palindrome
        return self.ans
```

### 1641. Count Sorted Vowel Strings

```python
# Bottom up 1D
# Time O(nk)
# Space O(k)
class Solution:
    def countVowelStrings(self, n: int) -> int:
        dp = [1] * 5
        for _ in range(n-1):
            dp = accumulate(dp)
        return sum(dp)

# Top down
# Time O(nk)
# Space O(nk)
class Solution:
    def countVowelStrings(self, n, seen={}):
        def dp(n, k):
            if k == 1 or n == 1:
                return k
            if (n, k) in seen:
                return seen[n, k]
            seen[n, k] = sum(dp(n - 1, k) for k in range(1, k + 1))
            return seen[n, k]
        return dp(n, 5)
```

### 91. Decode Ways

```python
# Bottom up memo
class Solution:
    def numDecodings(self, s: str) -> int:
        dp = {len(s): 1}

        def safe_double_digit(i):
            inbounds = i + 1 < len(s)
            return inbounds and (s[i] == "1" or (s[i] == "2" and s[i + 1] in "0123456"))                # Guard inbound then check if potential legitimate char

        def helper(i):
            if i in dp:
                return dp[i]
            if s[i] == "0":
                return 0

            res = helper(i + 1)

            if safe_double_digit(i):
                res += helper(i + 2)
            dp[i] = res
            return dp[i]

        return helper(0)
```

### 322. Coin Change

```python
# Bottom up tab
class Solution:
    def coinChange(self, coins: List[int], amount: int) -> int:
        limit = amount + 1
        dp, dp[0] = [limit] * (limit), 0

        for a in range(limit):
            for c in coins:
                if a - c >= 0:
                    dp[a] = min(dp[a], dp[a - c] + 1)
        return dp[amount] if dp[amount] != limit else -1

# 1 [0, 1, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12]
# 2 [0, 1, 2, 12, 12, 12, 12, 12, 12, 12, 12, 12]
# 2 [0, 1, 1, 12, 12, 12, 12, 12, 12, 12, 12, 12]
# 3 [0, 1, 1, 2, 12, 12, 12, 12, 12, 12, 12, 12]
# 3 [0, 1, 1, 2, 12, 12, 12, 12, 12, 12, 12, 12]
# 4 [0, 1, 1, 2, 3, 12, 12, 12, 12, 12, 12, 12]
# 4 [0, 1, 1, 2, 2, 12, 12, 12, 12, 12, 12, 12]
# 5 [0, 1, 1, 2, 2, 3, 12, 12, 12, 12, 12, 12]
# 5 [0, 1, 1, 2, 2, 3, 12, 12, 12, 12, 12, 12]
# 5 [0, 1, 1, 2, 2, 1, 12, 12, 12, 12, 12, 12]
# 6 [0, 1, 1, 2, 2, 1, 2, 12, 12, 12, 12, 12]
# 6 [0, 1, 1, 2, 2, 1, 2, 12, 12, 12, 12, 12]
# 6 [0, 1, 1, 2, 2, 1, 2, 12, 12, 12, 12, 12]
# 7 [0, 1, 1, 2, 2, 1, 2, 3, 12, 12, 12, 12]
# 7 [0, 1, 1, 2, 2, 1, 2, 2, 12, 12, 12, 12]
# 7 [0, 1, 1, 2, 2, 1, 2, 2, 12, 12, 12, 12]
# 8 [0, 1, 1, 2, 2, 1, 2, 2, 3, 12, 12, 12]
# 8 [0, 1, 1, 2, 2, 1, 2, 2, 3, 12, 12, 12]
# 8 [0, 1, 1, 2, 2, 1, 2, 2, 3, 12, 12, 12]
# 9 [0, 1, 1, 2, 2, 1, 2, 2, 3, 4, 12, 12]
# 9 [0, 1, 1, 2, 2, 1, 2, 2, 3, 3, 12, 12]
# 9 [0, 1, 1, 2, 2, 1, 2, 2, 3, 3, 12, 12]
# 10 [0, 1, 1, 2, 2, 1, 2, 2, 3, 3, 4, 12]
# 10 [0, 1, 1, 2, 2, 1, 2, 2, 3, 3, 4, 12]
# 10 [0, 1, 1, 2, 2, 1, 2, 2, 3, 3, 2, 12]
# 11 [0, 1, 1, 2, 2, 1, 2, 2, 3, 3, 2, 3]
# 11 [0, 1, 1, 2, 2, 1, 2, 2, 3, 3, 2, 3]
# 11 [0, 1, 1, 2, 2, 1, 2, 2, 3, 3, 2, 3]
# Top down memo
class Solution:
    def coinChange(self, coins: List[int], amount: int) -> int:
        @lru_cache(None)
        def dfs(rem):
            if rem < 0:
                return -1
            if rem == 0:
                return 0
            min_cost = float('inf')
            for coin in coins:
                res = dfs(rem - coin)
                if res != -1:
                    min_cost = min(min_cost, res + 1)
            return min_cost if min_cost != float('inf') else -1

        return dfs(amount)
# Top down memo
class Solution:
    def coinChange(self, coins: List[int], amount: int) -> int:
        return self.recursiveHelper(coins,amount)

    def recursiveHelper(self, coins, remain):
        if remain < 0: return -1
        if remain == 0: return 0
        mincount = float('infinity')
        for c in coins:
            count = self.recursiveHelper(coins, remain - c)
            if count == -1: continue
            mincount = min(mincount, count+1)

        return -1 if mincount == float('infinity') else mincount
```

### 518. Coin Change II

```python
class Solution:
    def change(self, amount: int, coins: List[int]) -> int:
        dp, dp[0] = [0] * (amount + 1), 1
        for coin in coins:
            for j in range(coin, amount + 1):
                dp[j] += dp[j - coin]
        return dp[amount]
```

### 152. Maximum Product Subarray

```python
# Bottom up carry
class Solution:
    def maxProduct(self, nums: List[int]) -> int:
        res, curMax, curMin = nums[0], 1, 1
        for n in nums:
            vals = (n, n * curMax, n * curMin)
            curMax, curMin = max(vals), min(vals)
            res = max(res, curMax)
        return res

```

### 300. Longest Increasing Subsequence

```python
# Bottom up tab
class Solution:
    def lengthOfLIS(self, nums: List[int]) -> int:
        n, ans = len(nums), [1] * (len(nums) + 1)
        for i in range(n - 1, -1, -1):
            for j in range(i + 1, n):
                if nums[i] < nums[j]:
                    ans[i] = max(ans[i], ans[j] + 1)
        return max(ans)
```

### Fibonacci

```python
class Solution:
    def fib(self, n: int, memo={0: 0, 1: 1}) -> int:
        if n in memo:
            return memo[n]
        memo[n] = self.fib(n - 2) + self.fib(n - 1)
        return memo[n]
```

This algorithm is a Python implementation of the Fibonacci sequence using memo to improve its efficiency. Here's a breakdown of how it works:

1. The base case is checked first, the value of `n` already being inside of the dict `memo` results in the value of that key being returned.
2. If n is not in the memo dictionary (i.e., the Fibonacci number has not been calculated before), the function calculates it recursively by calling itself for the (n-2)th and (n-1)th Fibonacci numbers. It then adds these two Fibonacci numbers together and stores the result in the memo dictionary for future reference.
3. If n is already in the memo dictionary, meaning its Fibonacci number has been calculated before, the function simply returns the value stored in the memo dictionary for n.
4. Finally, the function returns the Fibonacci number corresponding to the input n.

This approach effectively reduces redundant calculations by storing previously calculated Fibonacci numbers in the memo dictionary, thus improving the overall efficiency of the Fibonacci sequence calculation, especially for larger values of n.

### 2370. Longest Ideal Subsequence

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

###

```python

```

###

```python

```
