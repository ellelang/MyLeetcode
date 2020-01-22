--Write a SQL query to find all numbers that appear at least three times consecutively.

--+| Id | Num |
--+----+-----+
--| 1  |  1  |
--| 2  |  1  |
--| 3  |  1  |
--| 4  |  2  |
--| 5  |  1  |
--| 6  |  2  |
--| 7  |  2  |
--+----+-----+
--For example, given the above Logs table, 1 is the only number that appears consecutively for at least three times.

--+-----------------+
--| ConsecutiveNums |
--+-----------------+
--| 1               |
--+-----------------+

--consecutive: following continuously. -- don't forget 'distinct'

SELECT distinct (tb1.Num) as ConsecutiveNums
FROM Logs AS tb1, Logs AS tb2, Logs AS tb3
WHERE tb1.Id + 1 = tb2.Id AND tb2.Id + 1 = tb3.Id
AND tb1.Num = tb2.Num and tb2.Num = tb3.Num

select distinct l1.Num as ConsecutiveNums from Logs l1, Logs l2, Logs l3
where l1.Id = l2.Id-1 and l2.Id = l3.Id-1
and l1.Num = l2.Num and l2.Num = l3.Num
