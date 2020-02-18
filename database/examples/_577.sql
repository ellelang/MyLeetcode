-- Employee
--
-- +-------+--------+-----------+--------+
-- | empId |  name  | supervisor| salary |
-- +-------+--------+-----------+--------+
-- |   1   | John   |  3        | 1000   |
-- |   2   | Dan    |  3        | 2000   |
-- |   3   | Brad   |  null     | 4000   |
-- |   4   | Thomas |  3        | 4000   |
-- +-------+--------+-----------+--------+
--
-- Bonus
--
-- +-------+-------+
-- | empId | bonus |
-- +-------+-------+
-- | 2     | 500   |
-- | 4     | 2000  |
-- +-------+-------+
-- Select all employee's name and bonus whose bonus is < 1000.
-- output
-- +-------+-------+
-- | name  | bonus |
-- +-------+-------+
-- | John  | null  |
-- | Dan   | 500   |
-- | Brad  | null  |
-- +-------+-------+
--
SELECT tb1.Name, tb2.bonus
FROM Employee as tb1
LEFT JOIN Bonus as tb2 ON
tb1.empId = tb2.empId
WHERE tb2.bonus < 1000 OR
tb2.bonus IS NULL; 








select name, bonus from
(Employee left join Bonus on Employee.empId = Bonus.empId)
where (bonus < 1000 or bonus is null);
