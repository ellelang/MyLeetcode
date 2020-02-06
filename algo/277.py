# The knows API is already defined for you.
# return a bool, whether a knows b
# def knows(a: int, b: int) -> bool:


class Solution:
    def findCelebrity(self, n: int) -> int:
        candidate = 0
        for i in range(1,n):
            if knows(candidate,i):
                candidate = i
        for i in range(0,candidate):
            if not knows(i,candidate) or knows(candidate,i):
                return -1
        for i in range(candidate+1,n):
            if not knows(i,candidate):
                return -1
        return candidate
