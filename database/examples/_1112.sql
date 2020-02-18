-- 1112.(Medium) Highest Grade For Each Student
-- Get highest grade for each student
--
-- In case of a tie, choose the course with smaller course_id
--
-- sorted by increasing student_id
--
-- +------------+-------------------+
-- | student_id | course_id | grade |
-- +------------+-----------+-------+
-- | 2          | 2         | 95    |
-- | 2          | 3         | 95    |
-- | 1          | 1         | 90    |
-- | 1          | 2         | 99    |
-- | 3          | 1         | 80    |
-- | 3          | 2         | 75    |
-- | 3          | 3         | 82    |
-- +------------+-----------+-------+
-- ​
-- Result table:
-- +------------+-------------------+
-- | student_id | course_id | grade |
-- +------------+-----------+-------+
-- | 1          | 2         | 99    |
-- | 2          | 2         | 95    |
-- | 3          | 3         | 82    |
-- +------------+-----------+-------+

SELECT student_id, MIN(course_id) course_id, grade
FROM Enrollments
WHERE (student_id, grade) IN
        (SELECT student_id, MAX(grade)
        FROM Enrollments
        GROUP BY student_id)
GROUP BY student_id
ORDER BY student_id
