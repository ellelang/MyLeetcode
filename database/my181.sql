DROP TABLE IF EXISTS Employee;
Create table If Not Exists Employee (Id int, Name CHAR(255), Salary int, ManagerId int);
Truncate table Employee;
insert into Employee (Id, Name, Salary, ManagerId) values ('1', 'Joe', '70000', '3');
insert into Employee (Id, Name, Salary, ManagerId) values ('2', 'Henry', '80000', '4');
insert into Employee (Id, Name, Salary, ManagerId) values ('3', 'Sam', '60000', null);
insert into Employee (Id, Name, Salary, ManagerId) values ('4', 'Max', '90000', null);

select t1.Name as Employee
from employee t1
LEFT JOIN employee t2
ON t1.ManagerId = t2.Id
Where t1.Salary > t2.Salary;