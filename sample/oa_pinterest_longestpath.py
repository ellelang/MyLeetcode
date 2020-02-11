  
n = 3 # i row
m = 3 # j, column
# Returns length of the longest path beginning with mat[i][j].  
# This function mainly uses lookup table dp[n][n]
"""
Find the longest path in a matrix with given constraints
Given a n*n matrix where all numbers are distinct, find the maximum length path 
(starting from any cell) 
such that all cells along the path are in increasing order with a difference of 1.
We can move in 4 directions from a given cell (i, j), i.e., we can move to (i+1, j)
 or (i, j+1) or (i-1, j) or (i, j-1) with the condition that the adjacent cells 
 have a difference of 1.
"""  
def findLongestFromACell(i, j, mat, dp): 
    # Base case  
    if (i<0 or i>= n or j<0 or j>= m): 
        return 0
  
    # If this subproblem is already solved  
    if (dp[i][j] != -1):  
        return dp[i][j] 
  
    # To store the path lengths in all the four directions 
    x, y, z, w = -1, -1, -1, -1
  
    # Since all numbers are unique and in range from 1 to n * n,  
    # there is atmost one possible direction from any cell  
    if (j<m-1 and (ord(mat[i][j]) +1== ord(mat[i][j + 1]))): 
        x = 1 + findLongestFromACell(i, j + 1, mat, dp) 
  
    if (j>0 and (ord(mat[i][j]) +1 == ord(mat[i][j-1]))):  
        y = 1 + findLongestFromACell(i, j-1, mat, dp) 
  
    if (i>0 and (ord(mat[i][j]) +1 == ord(mat[i-1][j]))): 
        z = 1 + findLongestFromACell(i-1, j, mat, dp) 
  
    if (i<n-1 and (ord(mat[i][j]) +1 == ord(mat[i + 1][j]))): 
        w = 1 + findLongestFromACell(i + 1, j, mat, dp) 
  
    # If none of the adjacent fours is one greater we will take 1 
    # otherwise we will pick maximum from all the four directions 
    dp[i][j] = max(x, max(y, max(z, max(w, 1)))) 
    return dp[i][j] 
  
  
# Returns length of the longest path beginning with any cell  
def finLongestOverAll(mat): 
    result = 1 # Initialize result  
  
    # Create a lookup table and fill all entries in it as -1  
    dp =[[-1 for j in range(m)]for i in range(n)] 
  
    # Compute longest path beginning from all cells  
    for i in range(n): 
        for j in range(n): 
            if (dp[i][j] == -1): 
                findLongestFromACell(i, j, mat, dp) 
            # Update result if needed  
            result = max(result, dp[i][j]);  
    return result 
  
# Driver program  
mat = [[1, 2, 9],  
    [5, 3, 8], 
    [4, 6, 7]]  
print("Length of the longest path is ", finLongestOverAll(mat))

n = 3
m = 4

# Driver program  
mat = [['A','B','H','F'],  
       [ 'C','C','D','G'],  
       [ 'A','B','D','F']] 

# Python3 program to find the longest consecutive path   
R=3 
C=4 
    
# four direction tool matrices to recur for adjacent cells
# moves = [(-1, 0), (1, 0), (0,-1), (0, 1)]. 
x = [0, 1, 0, -1]  
y = [1, 0, -1, 0] 
# if 8 directions, then tool matrices to recur for adjacent cells.  
#x = [0, 1, 1, -1, 1, 0, -1, -1] , y = [1, 0, 1, 1, -1, -1, 0, -1]   
 # dp[i][j] Stores length of longest consecutive path  
# starting at arr[i][j].  
dp=[[0 for i in range(C)]for i in range(R)]  

# check whether mat[i][j] is a valid cell or not.  
def isvalid( i, j): 
    if (i < 0 or j < 0 or i >= R or j >= C): 
        return False
    return True 
    
# Check whether current character is adjacent to previous  
# character (character processed in parent call) or not.  
def isadjacent( prev, curr):  
    if (ord(curr) -ord(prev)) == 1: 
        return True    
    return False

isadjacent('b','a')
# i, j are the indices of the current cell and prev is the  
# character processed in the parent call.. also mat[i][j]  
# is our current character.  
def getLenUtil(mat,i,j, prev):  
     # If this cell is not valid or current character is not  
     # adjacent to previous one (e.g. d is not adjacent to b )  
     # or if this cell is already included in the path than return 0.  
    if (isvalid(i, j)==False or isadjacent(prev, mat[i][j])==False):  
         return 0 
    
    # If this subproblem is already solved , return the answer  
    if (dp[i][j] != -1): 
        return dp[i][j]  
    
    ans = 0  # Initialize answer  
    
    # recur for paths with different adjacent cells and store  
    # the length of longest path.  
    for k in range(8): 
        ans = max(ans, 1 + getLenUtil(mat, i + x[k],j + y[k], mat[i][j])) 
    
    # save the answer and return  
    dp[i][j] = ans 
    return dp[i][j] 
    
# Returns length of the longest path with all characters consecutive  
# to each other.  This function first initializes dp array that  
# is used to store results of subproblems, then it calls  
# recursive DFS based function getLenUtil() to find max length path 
def getLen(mat, s): 
    for i in range(R): 
        for j in range(C): 
            dp[i][j]=-10 
    ans = 0
    for i in range(R): 
        for j in range(C): 
            # check for each possible starting po  
            if (mat[i][j] == s):   
                # recur for all eight adjacent cells  
                for k in range(4): 
                    ans = max(ans, 1 + getLenUtil(mat,i + x[k], j + y[k], s));  
    return ans 

print (getLen(mat, 'B'))  

4321//10
len(str(432))
nums = [\
  [3,4,5],\
  [3,2,6],\
  [2,2,1]]  
nums[0]
class Solution:
    def longestIncreasingPath(self, matrix):
        if not matrix or not matrix[0]: return 0
        n, m = len(matrix), len(matrix[0])
        moves = [(-1, 0), (1, 0), (0,-1), (0, 1)]
        memo = {}
        def dp(ii, jj):
            if (ii, jj) in memo: return memo[(ii, jj)]
            ans = 1
            for dx, dy in moves:
                x, y = ii+dx, jj+dy
                if n>x>=0 and m>y>=0:
                    if matrix[x][y] < matrix[ii][jj]:
                        ans = max(dp(x, y)+1, ans)
            memo[(ii, jj)] = ans
            return ans
    
        ret = 0
        for ix in range(n):
            for iy in range(m):
                ret = max(ret, dp(ix, iy)) 
        return ret   
A = Solution()
A.longestIncreasingPath(nums)




