-- Write a SQL query to get the second highest salary from the Employee table.
--
-- +----+--------+
-- | Id | Salary |
-- +----+--------+
-- | 1  | 100    |
-- | 2  | 200    |
-- | 3  | 300    |
-- +----+--------+
-- For example, given the above Employee table, the second highest salary is 200. If there is no second highest salary, then the query should return null.
--Step 1 Find the highest Salary
--   Method 1 max(Salary)
--SELECT max(Salary)
--FROM Employee
--   Method 2 Order by

--Step 2: Find the list which the salary is below the highest Salary
-- Step 3: Order the rest of the table and find the highest salary within the list

SELECT max(Salary) as SecondHighestSalary
FROM Employee
WHERE Salary < (SELECT max(Salary)
        FROM Employee);

-- Don't forget the semi-colon

--Method2

ELECT max(Salary) as SecondHighestSalary
FROM Employee
WHERE Salary < (SELECT Salary
                FROM Employee
                ORDER BY Salary DESC
                LIMIT 1);
