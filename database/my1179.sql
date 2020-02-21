DROP TABLE IF EXISTS Department ;
Create table If Not Exists Department (id int, revenue int, month varchar(5));
Truncate table Department;
insert into Department (id, revenue, month) values ('1', '8000', 'Jan');
insert into Department (id, revenue, month) values ('2', '9000', 'Jan');
insert into Department (id, revenue, month) values ('3', '10000', 'Feb');
insert into Department (id, revenue, month) values ('1', '7000', 'Feb');
insert into Department (id, revenue, month) values ('1', '6000', 'Mar');

SELECT /* Just select everything you see in expected result  using CASE WHEN contidition THEN statement END*/
	id, 
	SUM(CASE WHEN month = 'Jan' THEN revenue END) AS Jan_Revenue,
	SUM(CASE WHEN month = 'Feb' THEN revenue END) AS Feb_Revenue,
	SUM(CASE WHEN month = 'Mar' THEN revenue END) AS Mar_Revenue,
	SUM(CASE WHEN month = 'Apr' THEN revenue END) AS Apr_Revenue,
	SUM(CASE WHEN month = 'May' THEN revenue END) AS May_Revenue,
	SUM(CASE WHEN month = 'Jun' THEN revenue END) AS Jun_Revenue,
	SUM(CASE WHEN month = 'Jul' THEN revenue END) AS Jul_Revenue,
	SUM(CASE WHEN month = 'Aug' THEN revenue END) AS Aug_Revenue,
	SUM(CASE WHEN month = 'Sep' THEN revenue END) AS Sep_Revenue,
	SUM(CASE WHEN month = 'Oct' THEN revenue END) AS Oct_Revenue,
	SUM(CASE WHEN month = 'Nov' THEN revenue END) AS Nov_Revenue,
	SUM(CASE WHEN month = 'Dec' THEN revenue END) AS Dec_Revenue
FROM Department
GROUP BY id;