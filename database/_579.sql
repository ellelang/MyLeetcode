-- 选出每个ID每个月的「过去三个月累计薪水」，排除最近的月份
-- Employee
--
-- | Id | Month | Salary |
-- |----|-------|--------|
-- | 1  | 1     | 20     |
-- | 2  | 1     | 20     |
-- | 1  | 2     | 30     |
-- | 2  | 2     | 30     |
-- | 3  | 2     | 40     |
-- | 1  | 3     | 40     |
-- | 3  | 3     | 60     |
-- | 1  | 4     | 60     |
-- | 3  | 4     | 70     |
--
-- Output
--
-- | Id | Month | Salary |
-- |----|-------|--------|
-- | 1  | 3     | 90     |
-- | 1  | 2     | 50     |
-- | 1  | 1     | 20     |
-- | 2  | 1     | 20     |
-- | 3  | 3     | 100    |
-- | 3  | 2     | 40     |

SELECT
    tb1.id,
    tb1.month,
    SUM(tb2.salary) Salary
FROM
    Employee as tb1 INNER JOIN Employee as tb2 ON
    tb1.id = tb2.id AND
    tb1.month - tb2.month >= 0 AND
    tb1.month - tb2.month < 3
GROUP BY
    tb1.id, tb1.month
HAVING
    (tb1.id, tb1.month) NOT IN (SELECT id, MAX(month) FROM Employee GROUP BY id)
ORDER BY
    tb1.id, tb1.month DESC
