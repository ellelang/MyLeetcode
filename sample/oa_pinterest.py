import pandas as pd 
from collections import defaultdict   
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
        return -1
    else:
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
all_paths = DFS(G, 8)
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
child = {}
for p,c in p_c:
        child.setdefault(p,[]).append(c)
child.get(3)
child[1]
def earlies_p(dataset):
    child = {}
    for p,c in dataset:
        child.setdefault(p,[]).append(c)
    roots = set(child) - set(c for cc in child.values() for c in cc)
    
    return roots
earlies_p(p_c)

dataset_pc = pd.DataFrame(p_c, columns=['Parent','Child'])
#parent_dict = dict(zip(dataset_pc.Child, dataset_pc.Parent))
dict_pc = dict(p_c)

cp_dict = dict(zip(dataset_pc.Child, dataset_pc.Parent))


def find_parent(x):
    ListOfAncestor = list ()
    ListOfChild =  list()
    #dict_pc = dict(data)
    for item in dict_pc.items():
        ListOfChild.append(item[1])
        if item[1] == x:
            ListOfAncestor.append(item[0])
    return ListOfAncestor


find_parent(6)
       
def earlies_p(dataset,x):
    child = {}
    dict_pc = dict(dataset)
    for p,c in dataset:
        child.setdefault(p,[]).append(c)
    roots = set(child) - set(c for cc in child.values() for c in cc)
    return roots
            
earlies_p(p_c,6)

def findp(x):
    for item in dict_pc.items():
        if item[1] == x and item[0] in roots:
            return item[0]
        else:
            x = item[0]
            return findp(x)
            
findp(6)    




dict_pc.items()
ListOfChild =  list()
for item in dict_pc.items():
    ListOfChild.append(item[1])


    

#########
def find_parent(data,x):
    dict_pc = dict(data)
    value = dict_pc.get(x, None)
    if value is None:
        return ""
    else:
        return find_parent(value)

find_parent(p_c,6)

def find_key(d, value):
    for k,v in d.items():
        if isinstance(v, dict):
            p = find_key(v, value)
            if p:
                return [k] + p
        elif v == value:
            return [k]

find_key(dict_pc, 5)
