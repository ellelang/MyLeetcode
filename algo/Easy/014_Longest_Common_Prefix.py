_author_ = 'elle'
_project_ = 'leetcode'

# https://leetcode.com/problems/longest-common-prefix/
# Write a function to find the longest common prefix string amongst an array of strings.

# Sort strings and find longest prefix of first and last, which are the most different.
# Alternatively all strings could be inserted into a trie and we find the first node
# with more than one child.
# Time - O(k*n logn) where k is the length of the longest string and n is number of strings.
# Space - O(1)

strs = ['flower', 'flow', 'flight']

strs[1][:3]

def longestCommonPrefix(strs):
        """
        :type strs: List[str]
        :rtype: str
        """
        if not strs:
            return ''
        
        for i in range(len(strs[0])):
            '''
            i, compare strs[0][i] ?= strs[1][i]
            '''
            for string in strs[1:]:
                if i >= len(string) or string [i] != strs[0][i]:
                    return strs[0][:i] # return all letters before index i
        
        return strs[0]
    
longestCommonPrefix(strs)
    
def longestCommonPrefix2(strs):
    result = ""
    i = 0
    
    while True:
        try:
            sets = set(string[i] for string in strs)
            print ('set', sets)
            if len(sets) == 1:
                result += sets.pop()
                i += 1
            else: break
        except Exception:
            break
    
    return result

longestCommonPrefix2(strs)
