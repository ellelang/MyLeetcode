DROP TABLE IF EXISTS courses;
Create table If Not Exists courses (student char(255), class char(255));
Truncate table courses;
insert into courses (student, class) values ('A', 'Math');
insert into courses (student, class) values ('B', 'English');
insert into courses (student, class) values ('C', 'Math');
insert into courses (student, class) values ('D', 'Biology');
insert into courses (student, class) values ('E', 'Math');
insert into courses (student, class) values ('F', 'Computer');
insert into courses (student, class) values ('G', 'Math');
insert into courses (student, class) values ('H', 'Math');
insert into courses (student, class) values ('I', 'Math');

select class from 
(
SELECT CLASS, COUNT(student) as total_student
from courses
group by class) t
where t.total_student >4;

select class from courses group by class having count(Distinct student)>4;