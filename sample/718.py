class Solution(object):
    def findLength(self, A, B):
        """
        :type A: List[int]
        :type B: List[int]
        :rtype: int
        """
        res = 0
        m,n = len(A),len(B)
        dp = [[0 for i in range(n+1)] for i in range(m+1)]
        
        for i in range(m+1):
            for j in range(n+1):
                if(i==0 or j==0):
                    dp[i][j]=0
                elif(A[i-1]==B[j-1]):
                    dp[i][j]=1+dp[i-1][j-1]
                    res = max(res,dp[i][j])
                else:
                    dp[i][j]=0        
        return res


a = Solution()
A= [1,2,3,2,1]
B= [3,2,1,4,7]
a.findLength(A,B)

dp = [[0 for i in range(6)] for i in range(6)]

import collections
Bstarts = collections.defaultdict(list)
for j, y in enumerate(B):
            Bstarts[y].append(j)


class Solution(object):
    def findLength(self, A, B):
        ans = 0
        Bstarts = collections.defaultdict(list)
        for j, y in enumerate(B):
            Bstarts[y].append(j)

        for i, x in enumerate(A):
            for j in Bstarts[x]:
                k = 0
                while i+k < len(A) and j+k < len(B) and A[i+k] == B[j+k]:
                    k += 1
                ans = max(ans, k)
        return ans