-- 每个项目组里工作年限最长的人（可能多个）。
-- Project table:
-- +-------------+-------------+
-- | project_id  | employee_id |
-- +-------------+-------------+
-- | 1           | 1           |
-- | 1           | 2           |
-- | 1           | 3           |
-- | 2           | 1           |
-- | 2           | 4           |
-- +-------------+-------------+
--
-- Employee table:
-- +-------------+--------+------------------+
-- | employee_id | name   | experience_years |
-- +-------------+--------+------------------+
-- | 1           | Khaled | 3                |
-- | 2           | Ali    | 2                |
-- | 3           | John   | 3                |
-- | 4           | Doe    | 2                |
-- +-------------+--------+------------------+
--
-- Result table:
-- +-------------+---------------+
-- | project_id  | employee_id   |
-- +-------------+---------------+
-- | 1           | 1             |
-- | 1           | 3             |
-- | 2           | 1             |
-- +-------------+---------------+

SELECT
    p.project_id,
    e.employee_id
FROM
    Project p LEFT JOIN Employee e ON
    p.employee_id = e.employee_id
WHERE (p.project_id,
       e.experience_years) IN (SELECT
                                p.project_id,
                                MAX(e.experience_years)
                            FROM
                                Project p LEFT JOIN Employee e ON
                                p.employee_id = e.employee_id
                            GROUP BY
                                p.project_id)
