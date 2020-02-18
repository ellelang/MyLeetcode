DROP TABLE IF EXISTS Employee;
DROP TABLE IF EXISTS Department;
Create table If Not Exists Employee (Id int, Name varchar(255), Salary int, DepartmentId int);
Create table If Not Exists Department (Id int, Name varchar(255));
Truncate table Employee;
insert into Employee (Id, Name, Salary, DepartmentId) values ('1', 'Joe', '70000', '1');
insert into Employee (Id, Name, Salary, DepartmentId) values ('2', 'Jim', '90000', '1');
insert into Employee (Id, Name, Salary, DepartmentId) values ('3', 'Henry', '80000', '2');
insert into Employee (Id, Name, Salary, DepartmentId) values ('4', 'Sam', '60000', '2');
insert into Employee (Id, Name, Salary, DepartmentId) values ('5', 'Max', '90000', '1');
Truncate table Department;
insert into Department (Id, Name) values ('1', 'IT');
insert into Department (Id, Name) values ('2', 'Sales');

Select D.Name, sub.Employee, sub.Salary
FROM
(Select DepartmentId,
Name as Employee,
Salary,
dense_rank () over w as salaryrank
FROM Employee
window w as (PARTITION BY DepartmentId Order by Salary DESC) ) AS sub
LEFT JOIN Department D
ON sub.DepartmentId = D.Id
Where sub.salaryrank = 1
;