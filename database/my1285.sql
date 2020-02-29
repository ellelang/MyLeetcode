DROP TABLE IF EXISTS Logs ;
Create table If Not Exists Logs (log_id int);
Truncate table Logs;
insert into Logs (log_id) values ('1');
insert into Logs (log_id) values ('2');
insert into Logs (log_id) values ('3');
insert into Logs (log_id) values ('7');
insert into Logs (log_id) values ('8');
insert into Logs (log_id) values ('10');


SELECT log_id
,(log_id - ROW_NUMBER() OVER (ORDER BY log_id)) AS diff
FROM Logs;


WITH temp1 AS(SELECT log_id
,log_id-ROW_NUMBER() OVER(ORDER BY log_id) AS difference
FROM Logs)

SELECT MIN(log_id) AS start_id
,MAX(log_id) AS end_id
FROM temp1
GROUP BY difference
ORDER BY start_id