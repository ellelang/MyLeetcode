_author_ = 'Elle'
_project_ = 'leetcode'

# https://leetcode.com/problems/two-sum/
# Given an array of integers, return indices of the two numbers
# such that they add up to a specific target.
# You may assume that each input would have exactly one solution.

# Maintain a mapping from each number to its index.
# Check if target - num has already been found.
# Time - O(n)
# Space - O(n) for the dictionary

# List comprehensin: 
list1 = [i * 3 + 1 for i in range(10) ]
list1

# Enumerate
for i, ele in enumerate(list1): 
    print ([i, ele])

# Dictionray
thisdict =	{
  9: 4,
  16: 5,
  25: 6
}   

# input the key, return the value:    
thisdict[9]

# Assign new key and new value to a dictionary
thisdict[36] = 7

[thisdict[36], 3]


list1
def twoSum(nums, target):
        dic = {}
        for i, num in enumerate(nums):
            if num in dic:
                return[dic[num], i]
            else:
                diff = target - num
                dic[diff] = i
                
twoSum(list1, 10)
