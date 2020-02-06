schedule = [[[1,2],[5,6]],[[1,3]],[[4,10]]]

# Definition for an Interval.
class Interval:
    def __init__(self, start: int = None, end: int = None):
        self.start = start
        self.end = end

"""
It's like a processing in chronological order
starts[i] -> time, when someone starts new work
ends[i - 1] -> time, when someone ends previous work
And the difference between starts[i] - ends[i - 1] (only if it's positive number) it's a time when no one working
"""
class Solution(object):
    def employeeFreeTime(self, avails):
        OPEN, CLOSE = 0, 1

        events = []
        for emp in avails:
            for iv in emp:
                events.append((iv.start, OPEN))
                events.append((iv.end, CLOSE))

        events.sort()
        ans = []
        prev = None
        bal = 0
        for t, cmd in events:
            if bal == 0 and prev is not None:
                ans.append(Interval(prev, t))

            bal += 1 if cmd is OPEN else -1
            prev = t

        return ans
