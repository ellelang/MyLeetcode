DROP TABLE IF EXISTS Project;
DROP TABLE IF EXISTS Employee;
Create table If Not Exists Project (project_id int, employee_id int);
Create table If Not Exists Employee (employee_id int, name varchar(10), experience_years int);
Truncate table Project;
insert into Project (project_id, employee_id) values ('1', '1');
insert into Project (project_id, employee_id) values ('1', '2');
insert into Project (project_id, employee_id) values ('1', '3');
insert into Project (project_id, employee_id) values ('2', '1');
insert into Project (project_id, employee_id) values ('2', '4');
Truncate table Employee;
insert into Employee (employee_id, name, experience_years) values ('1', 'Khaled', '3');
insert into Employee (employee_id, name, experience_years) values ('2', 'Ali', '2');
insert into Employee (employee_id, name, experience_years) values ('3', 'John', '1');
insert into Employee (employee_id, name, experience_years) values ('4', 'Doe', '2');

SELECT p.project_id
FROM Project p
group by project_id
order by count(distinct e.employee_id) DESC LIMIT 1;

select test.project_id from (
select project_id, rank() over( order by count(distinct employee_id) DESC ) as total from Project group by project_id
) as test 
where test.total=1;

Select project_id
from Project
group by project_id
having count(distinct employee_id) IN
(Select max(emp_cnt) from
(select project_id, count(distinct employee_id) as emp_cnt
from Project group by project_id)As A);