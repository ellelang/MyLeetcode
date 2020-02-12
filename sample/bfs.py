from collections import deque

graph = {}
graph["you"] = ["alice", "bob", "claire"]
graph["bob"] = ["anuj", "peggy"]
graph["alice"] = ["peggy"]
graph["claire"] = ["thom", "jonny"]
graph["anuj"] = []
graph["peggy"] = []
graph["thom"] = []
graph["jonny"] = ["bob"]

# 节点对象，用来标识各个节点之间的父子关系
# name:字符串类型，代表节点名称
# parent:Node类型
class Node:
    def __init__(self, name, parent):
        self.name = name
        self.parent = parent

    def __str__(self):
        return self.name


def is_seller(friend):
    return friend.name[-1] == 'm'

# 通过bfs找到最近的节点
def bfs_search():
    search_queue = deque()
    # 初始化任务队列
    search_queue += [Node(name=friend, parent=Node(name='you', parent=None)) for friend in graph['you']]
    searchrd = []
    while search_queue:
        # 每次都弹出队列最左面的元素，且是关系最亲密的。
        friend = search_queue.popleft()
        # 防止重复搜索
        if friend not in searchrd:
            if is_seller(friend):
                print ("has seller,%s is seller" % (friend))
                return friend

            else:
                # 将当前friend的所有friend添加到队列的最右面
                search_queue += [Node(name=f, parent=friend) for f in graph[friend.name]]
    return None

# 根据超找到的对象，打印路径
def print_path(node):
    node_name_stack = []
    node_name_stack.append(node.name)
    parent_node = node.parent
    # 生成节点名称列表
    while parent_node:
        node_name_stack.append(parent_node.name)
        parent_node = parent_node.parent
    # 反转列表
    node_name_stack.reverse()
    # 打印路径
    print ("friends path:","--->".join(node_name_stack))


if __name__ == '__main__':
    target = bfs_search()
    print_path(target)
    

####################DES
from collections import defaultdict 
class Graph: 
  
    # Constructor 
    def __init__(self): 
  
        # default dictionary to store graph 
        self.graph = defaultdict(list) 
  
    # function to add an edge to graph 
    def addEdge(self, u, v): 
        self.graph[u].append(v) 
  
    # A function used by DFS 
    def DFSUtil(self, v, visited): 
  
        # Mark the current node as visited  
        # and print it 
        visited[v] = True
        print(v, end = ' ') 
  
        # Recur for all the vertices  
        # adjacent to this vertex 
        for i in self.graph[v]: 
            if visited[i] == False: 
                self.DFSUtil(i, visited) 
  
    # The function to do DFS traversal. It uses 
    # recursive DFSUtil() 
    def DFS(self, v): 
  
        # Mark all the vertices as not visited 
        visited = [False] * (len(self.graph)) 
  
        # Call the recursive helper function  
        # to print DFS traversal 
        self.DFSUtil(v, visited) 

g = Graph() 
#[[1,3],[2,3],[3,6],[5,6],[5,7]]
 
g.addEdge(0, 1) 
g.addEdge(0, 2) 
g.addEdge(1, 2) 
g.addEdge(2, 0) 
g.addEdge(2, 3) 
g.addEdge(3, 3) 
g.DFS(1) 


graph = {'A': set(['B', 'C']),
         'B': set(['A', 'D', 'E']),
         'C': set(['A', 'F']),
         'D': set(['B']),
         'E': set(['B', 'F']),
         'F': set(['C', 'E'])}

def dfs(graph, start):
    visited, stack = set(), [start]
    while stack:
        vertex = stack.pop()
        if vertex not in visited:
            visited.add(vertex)
            stack.extend(graph[vertex] - visited)
    return visited

dfs(graph, 'A') # {'E', 'D', 'F', 'A', 'C', 'B'}

def dfs(graph, start, visited=None):
    if visited is None:
        visited = set()
    visited.add(start)
    for next in graph[start] - visited:
        dfs(graph, next, visited)
    return visited

dfs(graph, 'C') # {'E', 'D', 'F', 'A', 'C', 'B'}

def dfs_paths(graph, start, goal, path=None):
    if path is None:
        path = [start]
    if start == goal:
        yield path
    for next in graph[start] - set(path):
        yield from dfs_paths(graph, next, goal, path + [next])

list(dfs_paths(graph, 'C', 'F'))


# Define graph by edges
#edges = [['1', '2'], ['2', '4'], ['1', '11'], ['4', '11']]
edges = [['1', '3'], ['2', '3'], ['3', '6'], ['5', '6'],['5','7'],['7','11']]
# Build graph dictionary
G = defaultdict(set)
for (s,t) in edges:
    G[s].add(t)
    G[t].add(s)
G
list(dfs_paths(G, '1', '2'))
dfs(G, '6') # {'E', 'D', 'F', 'A', 'C', 'B'}
list(dfs_paths(G, '2', '6'))