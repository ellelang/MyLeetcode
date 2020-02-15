import itertools
mystrs = ['RIGAMAROLE',
'CONSTRUCTIVE',
'ASSIDUOUSLY']

def findLongestRepeatedLetters(lines):
    countletter = []
    countlength = []
    
    for i in range(len(lines)):
        mystr = lines[i]
        idx = 0
        maxidx, maxlen = 0, 1
        for _, group in itertools.groupby(mystr):
            grouplen = sum(1 for _ in group)
            if grouplen >= maxlen:
                maxidx, maxlen = idx, grouplen
            idx += grouplen
        if maxlen == 1:
          countletter.append(min(mystr))
          countlength.append(1)
        else:
            
          countletter.append(mystr[maxidx])
          countlength.append(maxlen)
    merged_list = list(zip(countletter, countlength))  
    return merged_list

aaa = findLongestRepeatedLetters(mystrs) 
for a, b in aaa:  # <-- this unpacks the tuple like a, b = (0, 1)
    print(a, b)

len(mystrs)      

mystr = 'BBBA'
idx = 0
maxidx, maxlen = 0, 0
for _, group in itertools.groupby(mystr):
    grouplen = sum(1 for _ in group)
    if grouplen > maxlen:
        maxidx, maxlen = idx, grouplen
    idx += grouplen
    
print(maxidx, maxlen)





mystr[maxidx]
s = "aaassdddffccsdddfgssfrsfspppppppppppddsfs"

groups = itertools.groupby(s)
result = [(label, sum(1 for _ in group)) for label, group in groups]
for _, group in itertools.groupby(s):
   grouplen = sum(1 for _ in group)
   
def Convert(tup, di): 
    di = dict(tup) 
    return di 
dictionary = {} 
print (Convert(result, dictionary))      
