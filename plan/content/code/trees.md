# Trees

Trees are a special type of graph where there are nodes.
They consist of parent and child nodes.
The root of the tree is the most senior family member, the ancestor of all child nodes.
If a node has no children it's called a leaf node.

Tree DataStructures are used in many types of applications.
They're used to create more sophisticated data structures such as heaps for example.

Solving tree problems usually involve recursion.
When solving recursive problems we have to handle base case.

# 226. Invert Binary Tree

```python
class Solution:
    def invertTree(self, root: Optional[TreeNode]) -> Optional[TreeNode]:
        if not root:
            return None
        self.invertTree(root.left)
        self.invertTree(root.right)
        root.left, root.right = root.right, root.left
        return root
```

# 104. Maximum Depth of Binary Tree

```python
class Solution:
    def maxDepth(self, root: Optional[TreeNode]) -> int:
        if not root:
            return 0
        return 1 + max(self.maxDepth(root.left), self.maxDepth(root.right))
```

# 543. Diameter of Binary Tree

```python
class Solution:
    def diameterOfBinaryTree(self, root: Optional[TreeNode]) -> int:
        self.max = 0
        def dfs(n):
            if not n: return 0
            left, right = dfs(n.left), dfs(n.right)
            self.max = max(self.max, left+right)
            return 1 + max(left,right)
        dfs(root)
        return self.max
```

# 110. Balanced Binary Tree

```python
# https://leetcode.com/problems/balanced-binary-tree/solutions/35708/very-simple-python-solutions-iterative-and-recursive-both-beat-90

class Solution(object):
    def isBalanced(self, root):
        stack, node, last, depths = [], root, None, {}
        while stack or node:
            if node:
                stack.append(node)
                node = node.left
            else:
                node = stack[-1]
                if not node.right or last == node.right:
                    node = stack.pop()
                    left, right  = depths.get(node.left, 0), depths.get(node.right, 0)
                    if abs(left - right) > 1: return False
                    depths[node] = 1 + max(left, right)
                    last = node
                    node = None
                else:
                    node = node.right
        return True
```

# 100. Same Tree

```python
class Solution:
    def isSameTree(self, p: Optional[TreeNode], q: Optional[TreeNode]) -> bool:
        if not p and not q:
            return True
        if p and q and p.val == q.val:
            return self.isSameTree(p.left,q.left) and self.isSameTree(p.right,q.right)
        return False
```

# 572. Subtree of Another Tree
```python
class Solution:
    def isSubtree(self, root: Optional[TreeNode], subRoot: Optional[TreeNode]) -> bool:
        if not root:
            return False
        if self.isSameTree(root, subRoot): return True
        return self.isSubtree(root.left, subRoot) or self.isSubtree(root.right, subRoot)

    def isSameTree(self, p: Optional[TreeNode], q: Optional[TreeNode]) -> bool:
        if not p and not q:
            return True
        if p and q and p.val == q.val:
            return self.isSameTree(p.left,q.left) and self.isSameTree(p.right,q.right)
        return False
```

# 235. Lowest Common Ancestor of a Binary Search Tree

```python
class Solution:
    def lowestCommonAncestor(self, root: 'TreeNode', p: 'TreeNode', q: 'TreeNode') -> 'TreeNode':
        cur = root
        while True:
            if cur.val > p.val and cur.val > q.val:
                cur = cur.left
            elif cur.val < p.val and cur.val < q.val:
                cur = cur.right
            else:
                return cur
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


