DROP TABLE IF EXISTS Employee;
Create table If Not Exists Employee (Id int, Name char(255), Department char(255), ManagerId int);
Truncate table Employee;
insert into Employee (Id, Name, Department, ManagerId) values ('101', 'John', 'A', Null);
insert into Employee (Id, Name, Department, ManagerId) values ('102', 'Dan', 'A', '101');
insert into Employee (Id, Name, Department, ManagerId) values ('103', 'James', 'A', '101');
insert into Employee (Id, Name, Department, ManagerId) values ('104', 'Amy', 'A', '101');
insert into Employee (Id, Name, Department, ManagerId) values ('105', 'Anne', 'A', '101');
insert into Employee (Id, Name, Department, ManagerId) values ('106', 'Ron', 'B', '101');

select manager as Name
from (
Select E.Id, E.Name as Employee, M.Name as Manager
FROM Employee E
INNER JOIN employee M
ON E.ManagerId = M.Id)sub
having count(Manager) >=5;

Select E.Id, E.Name as Employee, M.Name as Manager
FROM Employee E
INNER JOIN employee M
ON E.ManagerId = M.Id;

SELECT Name From Employee
Where Id IN(
SELECT ManagerId
From Employee Group By ManagerId
Having count(ManagerId) >= 5);

SELECT Id, ManagerId
From Employee G
Group By ManagerId
Having count(ManagerId) >= 5;