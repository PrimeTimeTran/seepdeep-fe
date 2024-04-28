Greedy algorithms are characterized by making locally optimal choices at each step with the hope of finding a global optimum solution. Here are some distinctive features of greedy algorithms/problems:

1. **Greedy Choice Property**: A greedy algorithm makes a series of choices that are locally optimal at each step. It doesn't reconsider or undo earlier choices once they are made. Each decision is made without regard to the consequences of future decisions.

2. **Optimal Substructure**: The problem exhibits optimal substructure if an optimal solution to the problem can be constructed from optimal solutions to its subproblems. Greedy algorithms exploit this property by making a series of choices that lead to an overall optimal solution.

3. **No Backtracking**: Greedy algorithms make decisions that are never reconsidered. Once a decision is made, it's final and never undone, which means greedy algorithms don't backtrack or revise earlier choices.

4. **Doesn't Always Guarantee Global Optimality**: Despite being locally optimal at each step, a greedy algorithm doesn't always produce the globally optimal solution. However, in many cases, it does yield solutions that are close to optimal, especially in problems where the greedy choice property and optimal substructure hold.

5. **Efficiency**: Greedy algorithms are often efficient in terms of time complexity since they make only one pass through the input data, making decisions quickly without needing to explore all possible solutions.

6. **Example Problems**: Classic examples of problems solved using greedy algorithms include the coin change problem, Huffman coding, minimum spanning tree algorithms like Prim's and Kruskal's algorithms, and the activity selection problem.

Despite their simplicity and efficiency, greedy algorithms may not always provide the best solution for every problem. It's crucial to analyze the problem's characteristics to determine if a greedy approach is suitable and if it can guarantee the desired solution quality.

### 55. Jump Game

```python
# Greedy
class Solution:
    def canJump(self, nums: List[int]) -> bool:
        goal = len(nums) - 1
        for i in range(len(nums) - 1, -1, -1):
            if nums[i] + i >= goal:
                goal = i
        return goal == 0

# DP
class Solution:
    def canJump(self, nums: List[int]) -> bool:
        N = len(nums)
        @lru_cache(N)
        def dfs(i):
            if i == N - 1:
                return True
            if nums[i] == 0:
                return False
            jump_limit = min(i + nums[i], N - 1) + 1
            for j in range(i + 1, jump_limit):
                if dfs(j):
                    return True
            return False
        return dfs(0)
```
