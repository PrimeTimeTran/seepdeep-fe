Counter
List
Dict

### 217. Contains Duplicate

```python

```

### 242. Valid Anagram

```python
class Solution:
    def isAnagram(self, s: str, t: str) -> bool:
        if len(s) != len(t): return False
        sStore, tStore = {}, {}

        for i in range(len(s)):
            sChar = s[i]
            tChar = t[i]
            sStore[sChar] = sStore.get(sChar, 0) + 1
            tStore[tChar] = tStore.get(tChar, 0) + 1

        for i in range(len(s)):
            if sStore.get(s[i]) != tStore.get(s[i]):
                return False
        return True
```

```python
class Solution:
    def isAnagram(self, s: str, t: str) -> bool:
        if len(s) != len(t): return False
        sStore, tStore = {}, {}

        for i, c in enumerate(s):
            sStore[c] = sStore.get(c, 0) + 1
            tStore[t[i]] = tStore.get(t[i], 0) + 1

        for c in s:
            if sStore.get(c) != tStore.get(c):
                return False
        return True
```

### 1. Two Sum

```python

```

### 49. Group Anagrams

```python
class Solution:
  def groupAnagrams(self, strs: List[str]) -> List[List[str]]:
    res = defaultdict(list)
    for s in strs:
      count = [0] * 26
      for c in s:
        count[ord(c) - ord('a')] += 1

      res[tuple(count)].append(s)
    return res.values()
```

Better runtime

```python
class Solution:
    def groupAnagrams(self, strs):
        anagram_map = defaultdict(list)

        for word in strs:
            sorted_word = ''.join(sorted(word))
            anagram_map[sorted_word].append(word)

        return list(anagram_map.values())
```

### 347. Top K Frequent Elements

```python
class Solution:
    def topKFrequent(self, nums: List[int], k: int) -> List[int]:
        c = Counter(nums).most_common(k)
        return [k[0] for k in c]
```

### 238. Product of Array Except Self

```python

```

### 36. Valid Sudoku

```python
class Solution:
    def isValidSudoku(self, board: List[List[str]]) -> bool:
        m, n = 9,9
        rows, cols, blocks = defaultdict(set), defaultdict(set), defaultdict(set)

        for r in range(m):
            for c in range(n):
                num = board[r][c]
                if num == '.':
                    continue
                key = (r//3, c//3)
                seen = num in rows[r] or num in cols[c] or num in blocks[key]
                if seen: return False
                rows[r].add(num)
                cols[c].add(num)
                blocks[key].add(num)
        return True
```

### Encode and Decode Strings

```python

```

### 128. Longest Consecutive Sequence

```python
class Solution:
  def longestConsecutive(self, nums: List[int]) -> int:
    res = 0
    vals = set(nums)
    for n in nums:
        if n-1 not in vals:
            cur = 0
            while n+cur in vals:
                cur+=1
            res = max(cur, res)
    return res
```

### 53. Maximum Sub array

```python
class Solution:
    def maxSubArray(self, nums: List[int]) -> int:
        cur, res = 0, nums[0]
        for n in nums:
            if cur < 0:
                cur = 0
            cur += n
            res = max(res, cur)

        return res
```

###

```python

```
