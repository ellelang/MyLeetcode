 #Definition for a binary tree node.
k={}
cpdomains = ["900 google.mail.com", "50 yahoo.com", "1 intel.mail.com", "5 wiki.org"]
for m in cpdomains:
    l=int(m.split(' ')[0])
    j=m.split(' ')[1].split('.')
    for i in range(len(j),0,-1):
            if ('.').join(j[i-1:]) in k:
                k[('.').join(j[i-1:])]+=l
            else:
                k[('.').join(j[i-1:])]=l

# H is the key of the dictionary
result =  [str(k[H])+" "+H for H in k]

from collections import Counter
myList = [1,1,2,3,4,5,3,2,3,4,2,1,2,3]
Counter(myList)


def subdomainVisits(cpdomains):
        ans = Counter()
        for domain in cpdomains:
            count, domain = domain.split()
            count = int(count)
            frags = domain.split('.')
            for i in range(len(frags)):
                ans[".".join(frags[i:])] += count

        return ["{} {}".format(ct, dom) for dom, ct in ans.items()]
    
subdomainVisits(cpdomains)
