
_author_ = 'elle'
_project_ = 'leetcode'

# https://leetcode.com/problems/roman-to-integer/
# Given a roman numeral, convert it to an integer.
# Input is guaranteed to be within the range from 1 to 3999.

# Check for 2-character matches and if none there must be a single char match.
# Time - O(n) where len(s) = n
# Space - O(1)
def romanToInt(s):
        """
        :type s: str
        :rtype: int
        result = M + C
        temp = M - C
        result += temp
        result = M+C+M-C = 2M  NOT CORRECT
        SHOULD be = M + (M - C)
        
        """
        numeral_map = {'I' : 1, 'V' : 5, 'X' : 10, 'L' : 50, 'C' :100, 'D': 500, 'M' : 1000}
        result = 0
        for i in range (len(s)):
            if i > 0 and numeral_map[s[i]] > numeral_map[s[i-1]]:
                result += numeral_map[s[i]] - 2 * numeral_map[s[i-1]]
            else:
                result += numeral_map[s[i]]
        return result
    
romanToInt("MCMXCIV")
