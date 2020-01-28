--596. Classes More Than 5 Students
--SQL Schema
--There is a table courses with columns: student and class
--
--Please list out all classes which have more than or equal to 5 students.
--
--For example, the table:
--
--+---------+------------+
--| student | class      |
--+---------+------------+
--| A       | Math       |
--| B       | English    |
--| C       | Math       |
--| D       | Biology    |
--| E       | Math       |
--| F       | Computer   |
--| G       | Math       |
--| H       | Math       |
--| I       | Math       |
--+---------+------------+
--Should output:
--
--+---------+
--| class   |
--+---------+
--| Math    |
--+---------+
--
--
--Note:
--The students should not be counted duplicate in each course.
SELECT class
FROM courses
GROUP BY class
HAVING count (DISTINCT(student)) >= 5;

-- SQL Syntax running priority
-- FROM --> on-->JOIN --> WHERE --> GROUP BY --> WITH --> HAVING --> SELECT --> DISTINCT --> ORDER BY







select class from courses
group by class
having count(distinct student) >= 5;
