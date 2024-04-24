# Dynamic Programming

To prepare for dynamic programming, it's essential to grasp some fundamental techniques:

- Understanding Recursion: Dynamic programming often involves breaking down a problem into smaller subproblems. Understanding recursion, how it works, and its implementation is crucial, as dynamic programming often builds upon recursive solutions.

- Identifying Overlapping Subproblems: Dynamic programming relies on solving overlapping subproblems. Identifying these subproblems helps in applying dynamic programming techniques effectively.

- Memoization: This technique involves storing the results of expensive function calls and returning the cached result when the same inputs occur again. It's a top-down approach to dynamic programming and helps avoid redundant computations.

- Bottom-Up (Tabulation) Approach: This involves solving the problem iteratively, starting from the smallest subproblems and building up to larger ones. It typically requires using arrays or tables to store intermediate results.

- Understanding Optimal Substructure: Dynamic programming problems exhibit optimal substructure, meaning the optimal solution to a problem can be constructed from the optimal solutions of its subproblems. Recognizing and utilizing this property is essential.

- State Representation: Formulating the problem in terms of states and transitions is crucial for dynamic programming. Each state represents a specific configuration of the problem, and transitions denote how the states are connected.

- Choosing the Right Data Structure: Depending on the problem, choosing the appropriate data structure for storing intermediate results can significantly impact the efficiency of dynamic programming solutions. Common data structures include arrays, matrices, hash maps, and trees.

- Practice, Practice, Practice: Dynamic programming can be challenging to grasp initially, but like any skill, practice is key. Solve a variety of dynamic programming problems to familiarize yourself with different patterns and techniques.


By mastering these fundamental techniques, you'll be well-prepared to tackle dynamic programming problems effectively. Start with simpler problems and gradually move on to more complex ones as you build your understanding and confidence.



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