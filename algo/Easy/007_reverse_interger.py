_author_ = 'Elle'
_project_ = 'leetcode'

# https://leetcode.com/problems/reverse-integer/
# Reverse digits of an integer.
# Example1: x = 123, return 321
# Example2: x = -123, return -321

# Repeatedly multiply previous result by 10 and add last digit.
# Time - O(n) where n is the number of digits.
# Space - O(n), same number of digits in output as input.

def reverse(x):
        """
        :type x: int
        :rtype: int
        """
        # [-2^31, 2^31]
        num = 0
        a = abs(x)
        
        while (a != 0):
            temp = a % 10
            #print ('a', a)
            #print ('temp', temp)
            num = num * 10 + temp
            #print ('num', num)
            a = int (a/10)
        
        if x > 0:
            return num 
        elif x < 0:
            return -num

reverse(-123)
