DROP TABLE IF EXISTS student;
DROP TABLE IF EXISTS department;
CREATE TABLE IF NOT EXISTS student (student_id INT,student_name CHAR(45), gender CHAR(6), dept_id INT);
CREATE TABLE IF NOT EXISTS department (dept_id INT, dept_name CHAR(255));
Truncate table student;
insert into student (student_id, student_name, gender, dept_id) values ('1', 'Jack', 'M', '1');
insert into student (student_id, student_name, gender, dept_id) values ('2', 'Jane', 'F', '1');
insert into student (student_id, student_name, gender, dept_id) values ('3', 'Mark', 'M', '2');
Truncate table department;
insert into department (dept_id, dept_name) values ('1', 'Engineering');
insert into department (dept_id, dept_name) values ('2', 'Science');
insert into department (dept_id, dept_name) values ('3', 'Law');



Select d.dept_name, count(DISTINCT s.student_id) as 'student_number'
FROM department AS d
LEFT JOIN student AS s
ON d.dept_id = s.dept_id
GROUP BY d.dept_name
ORDER BY student_number DESC, d.dept_name ASC;

Select d.dept_name, s.student_id, count(s.student_id)
FROM department AS d
LEFT JOIN student AS s
ON d.dept_id = s.dept_id
GROUP BY d.dept_name;