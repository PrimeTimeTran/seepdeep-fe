# Tree Traversals

Tree traversal algorithms are used to visit and process all nodes in a tree data structure. There are three main types of tree traversal algorithms: preorder, inorder, and postorder. Each algorithm processes the nodes of the tree in a different order, resulting in different sequences of node visits.

## Setup

- Setup of our tree

```python
class Node:
	def __init__(self, key):
		self.val = key
		self.left = None
		self.right = None
root = Node(1)
root.left = Node(2)
root.right = Node(3)
root.left.left = Node(4)
root.left.right = Node(5)
```

## Pre Order

- In preorder traversal, the root node is visited first, followed by recursively visiting the left subtree and then the right subtree.
- The order of operations is: visit the current node, traverse the left subtree, traverse the right subtree.
- Preorder traversal is useful for creating a copy of the tree, evaluating arithmetic expressions, and prefix notation in expression trees.

```python
def printPreorder(root):
    if root:
        print(root.val, end=" ")
        printPreorder(root.left)
        printPreorder(root.right)
```

## In Order

- In inorder traversal, nodes are visited in ascending order (for binary search trees) by recursively visiting the left subtree, visiting the current node, and then recursively visiting the right subtree.
- The order of operations is: traverse the left subtree, visit the current node, traverse the right subtree.
- Inorder traversal is useful for producing sorted lists from binary search trees, performing binary tree operations, and for expression trees where it outputs infix notation.

```python
def printInorder(root):
    if root:
        printInorder(root.left)
        print(root.val, end=" "),
        printInorder(root.right)
```

## Post Order

- In postorder traversal, nodes are visited recursively by first visiting the left subtree, then the right subtree, and finally the current node.
- The order of operations is: traverse the left subtree, traverse the right subtree, visit the current node.
- Postorder traversal is useful for deleting nodes in a tree, evaluating arithmetic expressions, and postfix notation in expression trees.

```python
def printPostorder(root):
    if root:
        printPostorder(root.left)
        printPostorder(root.right)
        print(root.val, end=" "),
```

## Closing

These traversal algorithms are fundamental in understanding and manipulating tree structures efficiently. The choice of traversal depends on the specific task at hand and the desired order of processing nodes.
