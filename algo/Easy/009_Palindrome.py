_author_ = 'Elle'
_project_ = 'leetcode'

# https://leetcode.com/problems/palindrome-number/
# Determine whether an integer is a palindrome. Do this without extra space.

# Check equivalence of first and last characters, moving inwards.
# Time - O(n)
# Space - O(1)


def isPalindrome(x):
    num = 0
    a = abs(x)
    
    while (a != 0):
        temp = a % 10
        print ('temp', temp)
        num = num * 10 + temp
        print ('num', num)
        a = int(a/10)
        print ('a', a)
            
    if x >=0 and x == num:
        return True
    else:
        return False
    
isPalindrome(121)   
