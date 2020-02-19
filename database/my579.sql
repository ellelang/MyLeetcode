DROP TABLE IF EXISTS Employee;
Create table If Not Exists Employee (Id int, Month int, Salary int);
Truncate table Employee;
insert into Employee (Id, Month, Salary) values ('1', '1', '20');
insert into Employee (Id, Month, Salary) values ('2', '1', '20');
insert into Employee (Id, Month, Salary) values ('1', '2', '30');
insert into Employee (Id, Month, Salary) values ('2', '2', '30');
insert into Employee (Id, Month, Salary) values ('3', '2', '40');
insert into Employee (Id, Month, Salary) values ('1', '3', '40');
insert into Employee (Id, Month, Salary) values ('3', '3', '60');
insert into Employee (Id, Month, Salary) values ('1', '4', '60');
insert into Employee (Id, Month, Salary) values ('3', '4', '70');



SELECT Id, Month, SUM(Salary) OVER(PARTITION BY Id ORDER BY Month ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS Salary
FROM 
(SELECT Id, Month, Salary, MAX(Month) OVER(PARTITION BY Id) AS recent_month
FROM Employee) sub
WHERE sub.Month != recent_month
ORDER BY Id, Month DESC;