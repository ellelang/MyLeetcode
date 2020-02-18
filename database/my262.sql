drop table if exists Users;
Create table If Not Exists Trips (Id int, Client_Id int, Driver_Id int, City_Id int, Status ENUM('completed', 'cancelled_by_driver', 'cancelled_by_client'), Request_at varchar(50));
Create table If Not Exists Users (Users_Id int, Banned char(50), Role ENUM('client', 'driver', 'partner'));
Truncate table Trips;
insert into Trips (Id, Client_Id, Driver_Id, City_Id, Status, Request_at) values ('1', '1', '10', '1', 'completed', '2013-10-01');
insert into Trips (Id, Client_Id, Driver_Id, City_Id, Status, Request_at) values ('2', '2', '11', '1', 'cancelled_by_driver', '2013-10-01');
insert into Trips (Id, Client_Id, Driver_Id, City_Id, Status, Request_at) values ('3', '3', '12', '6', 'completed', '2013-10-01');
insert into Trips (Id, Client_Id, Driver_Id, City_Id, Status, Request_at) values ('4', '4', '13', '6', 'cancelled_by_client', '2013-10-01');
insert into Trips (Id, Client_Id, Driver_Id, City_Id, Status, Request_at) values ('5', '1', '10', '1', 'completed', '2013-10-02');
insert into Trips (Id, Client_Id, Driver_Id, City_Id, Status, Request_at) values ('6', '2', '11', '6', 'completed', '2013-10-02');
insert into Trips (Id, Client_Id, Driver_Id, City_Id, Status, Request_at) values ('7', '3', '12', '6', 'completed', '2013-10-02');
insert into Trips (Id, Client_Id, Driver_Id, City_Id, Status, Request_at) values ('8', '2', '12', '12', 'completed', '2013-10-03');
insert into Trips (Id, Client_Id, Driver_Id, City_Id, Status, Request_at) values ('9', '3', '10', '12', 'completed', '2013-10-03');
insert into Trips (Id, Client_Id, Driver_Id, City_Id, Status, Request_at) values ('10', '4', '13', '12', 'cancelled_by_driver', '2013-10-03');
Truncate table Users;
insert into Users (Users_Id, Banned, Role) values (1, 'No', 'client');
insert into Users (Users_Id, Banned, Role) values (2, 'Yes', 'client');
insert into Users (Users_Id, Banned, Role) values (3, 'No', 'client');
insert into Users (Users_Id, Banned, Role) values (4, 'No', 'client');
insert into Users (Users_Id, Banned, Role) values (10, 'No', 'driver');
insert into Users (Users_Id, Banned, Role) values (11, 'No', 'driver');
insert into Users (Users_Id, Banned, Role) values (12, 'No', 'driver');
insert into Users (Users_Id, Banned, Role) values (13, 'No', 'driver');


SELECT
    Request_at as 'Day',
    ROUND(CAST(SUM(CASE WHEN Status != 'completed' THEN 1 ELSE 0 END) AS FLOAT)/CAST(COUNT(*) AS FLOAT), 2) AS 'Cancellation Rate'    
FROM 
    Trips
Where Request_at BETWEEN '2013-10-01' AND '2013-10-03' and 
Client_Id NOT IN (SELECT Users_Id FROM Users WHERE Banned = 'Yes')
GROUP BY 
    Request_at;


SELECT
    Request_at as 'Day',
    ROUND(CAST(SUM(CASE WHEN Status != 'completed' THEN 1 ELSE 0 END) AS FLOAT)/CAST(COUNT(*) AS FLOAT), 2) AS 'Cancellation Rate'    
FROM 
    Trips
WHERE
    Request_at BETWEEN '2013-10-01' AND '2013-10-03'
    AND Client_Id NOT IN (SELECT Users_Id FROM Users WHERE Banned = 'Yes')
GROUP BY 
    Request_at;