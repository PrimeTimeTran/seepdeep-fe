8,468,210

n!/(n-r)!


32 Teams
8 Divisions
17 Regular Season Games

6: Six games against divisional opponents — two games per team, one at home and one on the road.
4: Four games against teams from a division within its conference — two games at home and two on the road.
4: Four games against teams from a division in the other conference— two games at home and two on the road.
2: Two games against teams from the two remaining divisions in its own conference — one game at home and one on the road. Matchups are based on division ranking from the previous season.
17th: The 17th game is an additional game against a non-conference opponent from a division that the team is not scheduled to play. Matchups are based on division ranking from the previous season.

### 787. Cheapest Flights Within K Stops

```python
class Solution:
    def findCheapestPrice(self, n: int, flights: List[List[int]], src: int, dst: int, k: int) -> int:
        g = defaultdict(list)
        for u,v,w in flights:
            g[u].append((v,w))
            
        pq = [[0, src, k+1]]
        seen = {}
        while pq:
            c, u, stops = heappop(pq)
            if u == dst: return c
            
            if u in seen and seen[u] >= stops: continue
            seen[u] = stops-1
            
            if stops:
                for v, w in g[u]:
                    heappush(pq, (c+w, v, stops-1))
        return -1
```

### 3112. Minimum Time to Visit Disappearing Nodes

```python
class Solution:
    def minimumTime(
        self, n: int, edges: List[List[int]], disappear: List[int]
    ) -> List[int]:
        graph = defaultdict(list)
        for u, v, w in edges:
            graph[u].append((v, w))
            graph[v].append((u, w))
        pq = [(0, 0)]
        ans = [inf] * n
        ans[0] = 0
        while pq:
            x, u = heappop(pq)
            if x == ans[u]:
                for v, w in graph[u]:
                    if x + w < disappear[v] and x + w < ans[v]:
                        ans[v] = x + w
                        heappush(pq, (x + w, v))
        return [x if x < inf else -1 for x in ans]
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

