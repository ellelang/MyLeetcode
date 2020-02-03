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

df = pd.DataFrame([['Tom',211,111],['Galie',209,211],[123,236,'Remo'],\
                   [124,236,'Carmen'],[234,345,'Alfred'],[236,346,'Marvela'],\
                   [124,236,'Armin'],[234,345,'Boris'],['Katya',109,323]], \
                  columns=['Parent','Child','Name'])

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