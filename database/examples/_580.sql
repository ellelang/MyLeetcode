-- student
-- | Column Name  | Type      |
-- |--------------|-----------|
-- | student_id   | Integer   |
-- | student_name | String    |
-- | gender       | Character |
-- | dept_id      | Integer   |
--
-- department
-- | Column Name | Type    |
-- |-------------|---------|
-- | dept_id     | Integer |
-- | dept_name   | String  |
--
-- student table:
-- | student_id | student_name | gender | dept_id |
-- |------------|--------------|--------|---------|
-- | 1          | Jack         | M      | 1       |
-- | 2          | Jane         | F      | 1       |
-- | 3          | Mark         | M      | 2       |
--
-- department table:
-- | dept_id | dept_name   |
-- |---------|-------------|
-- | 1       | Engineering |
-- | 2       | Science     |
-- | 3       | Law         |
--
-- Output:
-- | dept_name   | student_number |
-- |-------------|----------------|
-- | Engineering | 2              |
-- | Science     | 1              |
-- | Law         | 0              |


SELECT
    tb2.dept_name
    ,COUNT(tb1.student_id) student_number
FROM
    student as tb1 RIGHT JOIN department as tb2
    ON tb1.dept_id = tb2.dept_id
GROUP BY
    tb2.dept_name
ORDER BY
    2 DESC, 1




select d.dept_name, count(s.student_id) as student_number
    from department d left join student s on d.dept_id = s.dept_id
    group by d.dept_name
    order by student_number desc, d.dept_name;
