DROP TABLE IF EXISTS Enrollments;
Create table If Not Exists Enrollments (student_id int, course_id int, grade int);
Truncate table Enrollments;
insert into Enrollments (student_id, course_id, grade) values ('2', '2', '95');
insert into Enrollments (student_id, course_id, grade) values ('2', '3', '95');
insert into Enrollments (student_id, course_id, grade) values ('1', '1', '90');
insert into Enrollments (student_id, course_id, grade) values ('1', '2', '99');
insert into Enrollments (student_id, course_id, grade) values ('3', '1', '80');
insert into Enrollments (student_id, course_id, grade) values ('3', '2', '75');
insert into Enrollments (student_id, course_id, grade) values ('3', '3', '82');

select student_id, course_id, grade
from 
(select student_id, course_id, grade,
rank() over w as grades_rank
from Enrollments
window w as (partition by student_id order by grade DESC, course_id ))t
where grades_rank = 1
order by student_id ASC;