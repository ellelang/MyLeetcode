DROP TABLE IF EXISTS Employees;

Create table If Not Exists Employees (employee_id int, employee_name varchar(30), manager_id int);
Truncate table Employees;
insert into Employees (employee_id, employee_name, manager_id) values ('1', 'Boss', '1');
insert into Employees (employee_id, employee_name, manager_id) values ('3', 'Alice', '3');
insert into Employees (employee_id, employee_name, manager_id) values ('2', 'Bob', '1');
insert into Employees (employee_id, employee_name, manager_id) values ('4', 'Daniel', '2');
insert into Employees (employee_id, employee_name, manager_id) values ('7', 'Luis', '4');
insert into Employees (employee_id, employee_name, manager_id) values ('8', 'John', '3');
insert into Employees (employee_id, employee_name, manager_id) values ('9', 'Angela', '8');
insert into Employees (employee_id, employee_name, manager_id) values ('77', 'Robert', '1');

select employee_id from employees
where manager_id in
(select employee_id from employees where manager_id in
(select employee_id from employees where manager_id = 1))
and employee_id !=1;

SELECT e0.employee_id 
FROM Employees e0
INNER JOIN Employees e1
ON e0.manager_id = e1.employee_id
AND e0.employee_id<>1
INNER JOIN Employees e2
ON e1.manager_id = e2.employee_id
WHERE (e0.manager_id = 1
OR e1.manager_id = 1
OR e2.manager_id = 1);