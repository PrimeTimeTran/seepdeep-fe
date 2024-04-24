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


# 78. Subsets

```python
class Solution:
    def subsets(self, nums: List[int]) -> List[List[int]]:
        res = [[]]
        for n in nums:
            res += [subset+[n] for subset in res]
        return res
```
# 39. Combination Sum

```python
class Solution:
    def combinationSum(self, candidates: List[int], target: int) -> List[List[int]]:
        res = []
        def helper(i, cur, total):
            if total == target:
                res.append(cur.copy())
                return
            if i == len(candidates) or total > target:
                return 0
            cur.append(candidates[i])
            helper(i, cur, total+candidates[i])
            cur.pop()
            helper(i+1, cur, total)
        
        helper(0,[],0)
        return res
```
