DROP TABLE IF EXISTS Students ;
DROP TABLE IF EXISTS Subjects ;
DROP TABLE IF EXISTS Examinations;
Create table If Not Exists Students (student_id int, student_name varchar(20));
Create table If Not Exists Subjects (subject_name varchar(20));
Create table If Not Exists Examinations (student_id int, subject_name varchar(20));
Truncate table Students;
insert into Students (student_id, student_name) values ('1', 'Alice');
insert into Students (student_id, student_name) values ('2', 'Bob');
insert into Students (student_id, student_name) values ('13', 'John');
insert into Students (student_id, student_name) values ('6', 'Alex');
Truncate table Subjects;
insert into Subjects (subject_name) values ('Math');
insert into Subjects (subject_name) values ('Physics');
insert into Subjects (subject_name) values ('Programming');
Truncate table Examinations;
insert into Examinations (student_id, subject_name) values ('1', 'Math');
insert into Examinations (student_id, subject_name) values ('1', 'Physics');
insert into Examinations (student_id, subject_name) values ('1', 'Programming');
insert into Examinations (student_id, subject_name) values ('2', 'Programming');
insert into Examinations (student_id, subject_name) values ('1', 'Physics');
insert into Examinations (student_id, subject_name) values ('1', 'Math');
insert into Examinations (student_id, subject_name) values ('13', 'Math');
insert into Examinations (student_id, subject_name) values ('13', 'Programming');
insert into Examinations (student_id, subject_name) values ('13', 'Physics');
insert into Examinations (student_id, subject_name) values ('2', 'Math');
insert into Examinations (student_id, subject_name) values ('1', 'Math');

# Write an SQL query to find the number of times each student attended each exam.
#Order the result table by student_id and subject_name.


with cte1 as
(
select student_id, student_name, subject_name
from students, subjects)
select cte1.student_id, cte1.student_name, cte1.subject_name, ifnull(count(e.subject_name),0) as attended_exams 
from cte1 left join examinations e
on cte1.student_id = e.student_id and cte1.subject_name =  e.subject_name
group by cte1.student_name, cte1.subject_name
order by cte1.student_id, cte1.subject_name;

select e.student_id, s.student_name, e.subject_name, ifnull(count(subject_name),0)as attended_exams 
from Examinations e 
left join students s
on e.student_id = s.student_id
group by e.student_id, e.subject_name
order by e.student_id, e.subject_name;

SELECT 
    student_id, 
    student_name, 
    subject_name, 
    (
        SELECT count(*) FROM Examinations AS e 
        WHERE e.student_id = Students.student_id 
        AND e.subject_name = Subjects.subject_name
    ) AS attended_exams
    FROM Students, Subjects
ORDER BY student_id ASC, subject_name ASC;

SELECT a.student_id,a.student_name,a.subject_name,IFNULL(b.attended_exams,0) AS attended_exams FROM
(
    (SELECT student_id,student_name,subject_name FROM students ,subjects ) a
    
LEFT JOIN
    
    (SELECT student_id,subject_name,COUNT(subject_name) AS attended_exams FROM examinations GROUP BY student_id,subject_name)b
    
ON
    a.student_id = b.student_id AND a.subject_name = b.subject_name
) 
ORDER BY a.student_id,a.subject_name;

SELECT student_id,student_name,subject_name FROM students ,subjects;
SELECT student_id,subject_name,COUNT(subject_name) AS attended_exams FROM examinations GROUP BY student_id,subject_name;