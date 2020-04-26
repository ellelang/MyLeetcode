USE LEETCODE;
DROP TABLE IF exists NPV;
DROP TABLE IF exists Queries;
Create Table If Not Exists NPV (id int, year int, npv int);
Create Table If Not Exists Queries (id int, year int);
Truncate table NPV;
insert into NPV (id, year, npv) values ('1', '2018', '100');
insert into NPV (id, year, npv) values ('7', '2020', '30');
insert into NPV (id, year, npv) values ('13', '2019', '40');
insert into NPV (id, year, npv) values ('1', '2019', '113');
insert into NPV (id, year, npv) values ('2', '2008', '121');
insert into NPV (id, year, npv) values ('3', '2009', '21');
insert into NPV (id, year, npv) values ('11', '2020', '99');
insert into NPV (id, year, npv) values ('7', '2019', '0');
Truncate table Queries;
insert into Queries (id, year) values ('1', '2019');
insert into Queries (id, year) values ('2', '2008');
insert into Queries (id, year) values ('3', '2009');
insert into Queries (id, year) values ('7', '2018');
insert into Queries (id, year) values ('7', '2019');
insert into Queries (id, year) values ('7', '2020');
insert into Queries (id, year) values ('13', '2019');

SELECT q.id, q.year, ifnull(n.npv, 0) as npv
FROM Queries q
LEFT JOIN NPV n
ON q.id = n.id AND q.year = n.year
order by q.id;