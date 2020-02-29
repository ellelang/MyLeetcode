DROP TABLE IF EXISTS Employee;
Create table If Not Exists Employee (employee_id int, team_id int);
Truncate table Employee;
insert into Employee (employee_id, team_id) values ('1', '8');
insert into Employee (employee_id, team_id) values ('2', '8');
insert into Employee (employee_id, team_id) values ('3', '8');
insert into Employee (employee_id, team_id) values ('4', '7');
insert into Employee (employee_id, team_id) values ('5', '9');
insert into Employee (employee_id, team_id) values ('6', '9');

select team_id, count(distinct employee_id) as num  
from Employee 
group by team_id;

with cte1 as(
select team_id, count(distinct employee_id) as num  
from Employee 
group by team_id)

select e.employee_id, cte1.num as team_size
from Employee e
left join cte1
on e.team_id = cte1.team_id;

