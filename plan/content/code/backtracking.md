# Backtracking

To effectively solve DSA (Data Structures and Algorithms) backtracking problems, you'll want to master several techniques and concepts:

1. Understanding Backtracking: Firstly, ensure you have a clear understanding of what backtracking is. It's a systematic way to search for solutions to a problem by trying different options and abandoning paths that lead to dead ends.
2. Recursion: Backtracking is often implemented using recursion. Make sure you are comfortable with recursive function calls and understand how they work.
3. Decision Tree Visualization: Visualize the problem as a decision tree. Each node represents a decision, and each branch represents a possible choice.
4. State Space Tree: Understand how to represent the problem space as a tree of states. Each node represents a possible state of the solution.
5. Identifying Base Cases: Determine the conditions that indicate when you have found a solution or when you need to backtrack. These conditions form the base cases of your recursive function.
6. Choosing Variables and Parameters: Identify the variables and parameters needed to represent the current state of the problem and the choices available at each step.
7. Choosing the Right Backtracking Strategy: There are different backtracking strategies like simple backtracking, optimized backtracking, and dynamic backtracking. Choose the appropriate strategy based on the problem requirements to optimize your solution.
8. Pruning the Search Space: Implement techniques to prune the search space and avoid exploring unnecessary paths. This could involve using constraints or heuristics to eliminate certain choices.
9. Maintaining State: Ensure you have mechanisms in place to maintain the state of the search as you backtrack. This might involve using data structures like arrays, sets, or maps to track the current state.
10. Testing and Debugging: Practice testing your backtracking algorithms with different inputs and edge cases. Debugging recursive functions can be challenging, so develop strategies for identifying and fixing errors.
11. Optimization: Look for opportunities to optimize your backtracking algorithm, such as memoization or dynamic programming, if applicable.
12. Practice, Practice, Practice: Backtracking problems can be complex, so the key to mastering them is practice. Solve a variety of backtracking problems from different sources to strengthen your skills.

By mastering these techniques and concepts, you'll be well-equipped to tackle a wide range of backtracking problems in DSA.


## Key Concepts
- Involve a decision tree. 
- Involve removing a focused item from the candidate pool and continuing.
- Involve building up a solution which adds to a total response.


### 46. Permutations

```python
class Solution:
    def permute(self, nums):
        res = []
        def dfs(cur, path):
            if not cur:
                res.append(path)
                return
            for i in range(len(cur)):
                dfs(cur[:i] + cur[i+1:], path+[cur[i]])
        dfs(nums,[])
        return res

# class Solution:
#     def permute(self, nums):
#         res = []
#         self.dfs(nums, [], res)
#         return res
        
#     def dfs(self, nums, path, res):
#         if not nums:
#             res.append(path)
#         for i in range(len(nums)):
#             self.dfs(nums[:i]+nums[i+1:], path+[nums[i]], res)
```

### 78. Subsets

```python
class Solution:
    def subsets(self, nums: List[int]) -> List[List[int]]:
        res = [[]]
        for n in nums:
            res += [subset+[n] for subset in res]
        return res
```
### 39. Combination Sum

```python
class Solution:
    def combinationSum(self, candidates: List[int], target: int) -> List[List[int]]:
        res = []
        def dfs(i, cur, total):
            if total == target:
                res.append(cur.copy())
                return
            if i == len(candidates) or total > target:
                return 0
            dfs(i + 1, cur, total)
            val = candidates[i]
            dfs(i, cur + [val], total + val)
        dfs(0, [], 0)
        return res
```

### 90. Subsets II

```python
class Solution:
    def subsetsWithDup(self, nums):
        res = []
        nums.sort()
        def dfs(nums, path):
            res.append(path)
            for i in range(len(nums)):
                if i > 0 and nums[i] == nums[i-1]:
                    continue
                dfs(nums[i+1:], path + [nums[i]])
        dfs(nums, [])
        return res
```

### 40. Combination Sum II

```python
# With idx tracking.
class Solution:
    def combinationSum2(self, C, target):
        res = []
        C.sort()

        def dfs(start, path, total):
            if total == target:
                res.append(path)
                return
            if total > target: return
            for i in range(start, len(C)):
                if i > start and C[i] == C[i - 1]:
                    continue
                dfs(i + 1, path + [C[i]], total + C[i])

        dfs(0, [], 0)
        return res

# Without tracking idx but slicing input options instead.
class Solution:
    def combinationSum2(self, C, target):
        res = []
        C.sort()

        def dfs(nums, path, total):
            if total > target:
                return
            if total == target:
                res.append(path)
                return
            for i in range(len(nums)):
                cur = nums[i]
                if i > 0 and cur == nums[i - 1]:
                    continue
                dfs(nums[i + 1 :], path + [cur], total + cur)

        dfs(C, [], 0)
        return res

```

### 79. Word Search

```python
class Solution:
    def exist(self, board: List[List[str]], word: str) -> bool:
        target = len(word)
        m, n = len(board), len(board[0])

        def dfs(r, c, i):
            if i == target:
                return True
            out = r == m or c == n or r < 0 or c < 0
            if out:
                return
            if board[r][c] != word[i]: return

            tmp = board[r][c]
            board[r][c] = "#"
            res = (
                dfs(r + 1, c, i+1)
                or dfs(r - 1, c, i+1)
                or dfs(r, c + 1, i+1)
                or dfs(r, c - 1, i+1)
            )
            board[r][c] = tmp
            return res

        for r in range(m):
            for c in range(n):
                if dfs(r, c, 0):
                    return True
        return False

# Much faster
class Solution:
    def exist(self, board: List[List[str]], word: str) -> bool:
        m, n = len(board), len(board[0])
        ct = defaultdict(int)
        for r in range(m):
            for c in range(n):
                char = board[r][c]
                ct[char] += 1
        for c in word:
            ct[c] -= 1
            if ct[c] < 0:
                return False

        def dfs(i, r, c):
            if len(word) == i:
                return True
            out = r < 0 or c < 0 or r == m or c == n
            if out:
                return
            if board[r][c] != word[i]:
                return
            tmp = board[r][c]
            board[r][c] = "#"

            res = (
                dfs(i + 1, r + 1, c)
                or dfs(i + 1, r - 1, c)
                or dfs(i + 1, r, c + 1)
                or dfs(i + 1, r, c - 1)
            )

            board[r][c] = tmp
            return res

        for r in range(m):
            for c in range(n):
                if dfs(0, r, c):
                    return True
        return False
```

### 131. Palindrome Partitioning

```python
class Solution:
    def partition(self, s: str) -> List[List[str]]:
        res = []

        def dfs(s, path):
            if not s:
                res.append(path)
                return
            for i in range(1, len(s) + 1):
                # Check if palindrome
                # s[i - 1 :: -1]
                # Reverse the string and take i - 1 elements starting from the last element and working toward the front.
                #  Last index is 0, second to last is 1, etc.
                if s[:i] == s[i - 1 :: -1]:
                    dfs(s[i:], path + [s[:i]])

        dfs(s, [])
        return res
```

### 17. Letter Combinations of a Phone Number

```python
class Solution:
    def letterCombinations(self, digits: str) -> List[str]:
        dict = {'2':"abc", '3':"def", '4':"ghi", '5':"jkl", '6':"mno", '7': "pqrs", 
            '8':"tuv", '9':"wxyz"}
        
        combs = [''] if digits else []
        for d in digits:
            combs = [p+char for p in combs for char in dict[d]]
        return combs
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

