----Write a SQL query to get the nth highest salary from the Employee table.

--+----+--------+
--| Id | Salary |
--+----+--------+
--| 1  | 100    |
--| 2  | 200    |
--| 3  | 300    |
---+----+--------+
--For example, given the above Employee table, the nth highest salary where n = 2 is 200. If there is no nth highest salary, then the query should return null.

---+------------------------+
---| getNthHighestSalary(2) |
---+------------------------+
---| 200                    |
---+------------------------+

-- Similar to 176, but need to use group by or DISCTINCT
--Duplicate ones are only counted as 1

SELECT distinct Salary
FROM Employee
ORDER BY Salary desc
LIMIT m, 1

SELECT Salary
FROM Employee
GROUP BY Salary
ORDER BY Salary desc
LIMIT m, 1

--LIMIT OFFEST, COUNT
-- OFFSET: specifies the offest of the first row to return
-- COUNT: specifies the maximum number of row to retrun



CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN
declare m INT;
set m=N-1;
  RETURN (
      --Write your MySQL query statement below.
      ELECT distinct Salary
      FROM Employee
      ORDER BY Salary desc
      LIMIT m, 1
  );
END
