# Linked List

# 206. Reverse Linked List
```python
# Definition for singly-linked list.
# class ListNode:
#     def __init__(self, val=0, next=None):
#         self.val = val
#         self.next = next
class Solution:
    def reverseList(self, head: Optional[ListNode]) -> Optional[ListNode]:
        prev = None
        while head:
            nxt, head.next = head.next, prev
            prev, head = head, nxt
        return prev

```

# 21. Merge Two Sorted Lists

```python
# Definition for singly-linked list.
# class ListNode:
#     def __init__(self, val=0, next=None):
#         self.val = val
#         self.next = next
class Solution:
    def mergeTwoLists(self, l1: Optional[ListNode], l2: Optional[ListNode]) -> Optional[ListNode]:
        head = ListNode()
        tail = head
        while l1 and l2:
            if l1.val < l2.val:
                tail.next = l1
                l1 = l1.next
            else:
                tail.next = l2
                l2 = l2.next
            tail = tail.next
        tail.next = l1 or l2
        return head.next
```

# 143. Reorder List
```python
# Definition for singly-linked list.
# class ListNode:
#     def __init__(self, val=0, next=None):
#         self.val = val
#         self.next = next
class Solution:
    def reorderList(self, head: Optional[ListNode]) -> None:
        d = ListNode(0, head)
        s, f = d, d
        
        # Use slow & fast pointer to find list mid point
        while f and f.next:
            s = s.next
            f = f.next.next
        p, c = None, s

        # Reverse 2nd list
        while c:
            nxt = c.next
            c.next = p
            p = c
            c = nxt
        l1, l2 = head, p
        while l1 and l2:
            tmp1, tmp2 = l1.next, l2.next
            l1.next, l2.next = l2, tmp1
            l1, l2 = tmp1, tmp2

```

# 19. Remove Nth Node From End of List
```python
# Definition for singly-linked list.
# class ListNode:
#     def __init__(self, val=0, next=None):
#         self.val = val
#         self.next = next
class Solution:
    def removeNthFromEnd(self, head: Optional[ListNode], n: int) -> Optional[ListNode]:
        start = ListNode(0, head)
        s, f = start, start
        while n > 0:
            f = f.next
            n -= 1
        while f and f.next:
            s = s.next
            f = f.next
        s.next = s.next.next
        return start.next
```


# 138. Copy List with Random Pointer

```python
"""
# Definition for a Node.
class Node:
    def __init__(self, val, next, random):
        self.val = val
        self.next = next
        self.random = random
"""
class Solution:
    def copyRandomList(self, head: "Node") -> "Node":
        if head is None:
            return None
        store = {}
        cur = head
        while cur:
            store[cur] = Node(cur.val, None, None)
            cur = cur.next
        cur = head
        while cur:
            if cur.next:
                store[cur].next = store[cur.next]
            if cur.random:
                store[cur].random = store[cur.random]
            cur = cur.next
        return store[head]
```


# 2. Add Two Numbers
```python
class Solution:
    def addTwoNumbers(self, l1: Optional[ListNode], l2: Optional[ListNode]) -> Optional[ListNode]:
        def toint(n):
            return n.val + 10 * toint(n.next) if n else 0

        def tolist(n):
            node = ListNode(n % 10)
            if n > 9:
                node.next = tolist(n // 10)
            return node
        return tolist(toint(l1) + toint(l2))
```



# 287. Find the Duplicate Number
```python
# https://leetcode.com/problems/find-the-duplicate-number/solutions/5041189/video-floyd-s-tortoise-and-hare-algorithm-and-prove-it-with-simple-calculation/
class Solution:
    def findDuplicate(self, nums: List[int]) -> int:
        s, f = nums[0], nums[0]
        while True:
            s, f = nums[s], nums[nums[f]]
            if s == f:
                break
        f = nums[0]
        while s != f:
            s, f = nums[s], nums[f]
        return s

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