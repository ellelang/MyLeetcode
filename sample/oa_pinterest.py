import pandas as pd 

#No  Name    ID  Parent_Id
#1   Tom     211 111
#2   Galie   209 111
#3   Remo    200 101
#4   Carmen  212 121
#5   Alfred  111 191
#6   Marvela 101 111
#7   Armin   234 101
#8   Boris   454 109
#9   Katya   109 323

df = pd.DataFrame([['Tom',211,111],['Galie',209,111],['Remo',200,101],\
                   ['Carmen',212,121],['Alfred',111,191],['Marvela',101,111],\
                   ['Armin',234,101],['Boris',454,109],['Katya',109,323]], \
                  columns=['Name','ID','Parent_Id'])

relations = [[123,234],[234,345],[123,235],[123,236],[124,236],[236,346]]
children = {}

for p, c in relations:
    children.setdefault(p, []).append(c)
roots = set(children) - set(c for cc in children.values() for c in cc)

def all_children(p):
    if p not in children:
        return set()
    return set(children[p] + [b for a in children[p] for b in all_children(a)])

print({p: all_children(p) for p in roots})
# {123: {234, 235, 236, 345, 346}, 124: {346, 236}}


id_name_dict = dict(zip(df.ID, df.Name))
parent_dict = dict(zip(df.ID, df.Parent_Id))

def find_parent(x):
    value = parent_dict.get(x, None)
    if value is None:
        return ""
    else:
        # Incase there is a id without name.
        if id_name_dict.get(value, None) is None:
            return "" + find_parent(value)

        return str(id_name_dict.get(value)) +", "+ find_parent(value)

find_parent(209)

#####################
from collections import defaultdict   
#edges = [['1', '3'], ['2', '3'], ['3', '6'], ['5', '6'],['5','7']]
edges = [['1', '2'], ['2', '4'], ['1', '11'], ['4', '11']]
G = defaultdict(list)
for (s,t) in edges:
    G[s].append(t)
    G[t].append(s)

print (G.items())
#keys = [i for i in G if '6' in G[i]]

#G.values()
def in_values(s, d):
    """Does `s` appear in any of the values in `d`?"""
    for v in d.values():
        if s in v:
            return True
    return False


def DFS(G,v,seen=None,path=None):
    if seen is None: seen = []
    if path is None: path = [v]

    seen.append(v)

    paths = []
    for t in G[v]:
        if t not in seen:
            t_path = path + [t]
            paths.append(tuple(t_path))
            paths.extend(DFS(G, t, seen[:], t_path))
    if not paths:
        return '-1'
    else:
        return paths
        
G = defaultdict(list)
for (s,t) in edges:
    G[s].append(t)
    G[t].append(s)

DFS(G, '2')    


def DFS(G,v,seen=None,path=None):
    if seen is None: seen = []
    if path is None: path = [v]

    seen.append(v)

    paths = []
    for t in G[v]:
        if t not in seen:
            t_path = path + [t]
            paths.append(tuple(t_path))
            paths.extend(DFS(G, t, seen[:], t_path))
    return paths


# Define graph by edges
edges = [['1', '2'], ['2', '4'], ['1', '11'], ['4', '11']]
edges = [['1', '3'], ['2', '3'], ['3', '6'], ['5', '6'],['5','7']]
# Build graph dictionary
G = defaultdict(list)
for (s,t) in edges:
    G[s].append(t)
    G[t].append(s)

# Run DFS, compute metrics
all_paths = DFS(G, '2')
max_len   = max(len(p) for p in all_paths)
max_paths = [p for p in all_paths if len(p) == max_len]
min(min(max_paths))
len(all_paths)
res = [min(idx) for idx in zip(*max_paths)] 
# Output
print("All Paths:")
print(all_paths)
print("Longest Paths:")
for p in max_paths: print("  ", p)
print("Longest Path Length:")
print(max_len)
#############
edges = [[1,3],[2,3],[3,6],[5,6],[5,7]]



# Python3 implementation of the above approach 
v = [[] for i in range(100)] 
  
# An utility function to add an edge in an 
# undirected graph. 
def addEdge(x, y): 
    v[x].append(y) 
    v[y].append(x) 
  
# A function to print the path between 
# the given pair of nodes. 
def printPath(stack): 
    for i in range(len(stack) - 1): 
        print(stack[i], end = " -> ") 
    print(stack[-1]) 
  
# An utility function to do 
# DFS of graph recursively 
# from a given vertex x. 
def DFS(vis, x, y, stack): 
    stack.append(x) 
    if (x == y): 
  
        # print the path and return on 
        # reaching the destination node 
        printPath(stack) 
        return
    vis[x] = True
  
    # A flag variable to keep track 
    # if backtracking is taking place 
    flag = 0
    if (len(v[x]) > 0): 
        for j in v[x]: 
              
            # if the node is not visited 
            if (vis[j] == False): 
                DFS(vis, j, y, stack) 
                flag = 1
  
    if (flag == 0): 
  
        # If backtracking is taking 
        # place then pop 
        del stack[-1] 
  
# A utility function to initialise 
# visited for the node and call 
# DFS function for a given vertex x. 
def DFSCall(x, y, n, stack): 
      
    # visited array 
    vis = [0 for i in range(n + 1)] 
  
    #memset(vis, false, sizeof(vis)) 
  
    # DFS function call 
    DFS(vis, x, y, stack) 
  
# Driver Code 
n = 10
stack = [] 
  
# Vertex numbers should be from 1 to 9. 
addEdge(1, 2) 
addEdge(1, 3) 
addEdge(2, 4) 
addEdge(2, 5) 
addEdge(2, 6) 
addEdge(3, 7) 
addEdge(3, 8) 
addEdge(3, 9) 
  
# Function Call 
DFSCall(4, 8, n, stack) 

#############
graph = {'A': set(['B', 'C']),
         'B': set(['A', 'D', 'E']),
         'C': set(['A', 'F']),
         'D': set(['B']),
         'E': set(['B', 'F']),
         'F': set(['C', 'E'])}




def dfs_paths(graph, start, goal):
    stack = [(start, [start])]
    visited = set()
    while stack:
        (vertex, path) = stack.pop()
        if vertex not in visited:
            if vertex == goal:
                return path
            visited.add(vertex)
            for neighbor in graph[vertex]:
                stack.append((neighbor, path + [neighbor]))

print (dfs_paths(graph, 'A', 'F'))
