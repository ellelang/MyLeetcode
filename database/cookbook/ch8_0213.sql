SELECT
COUNT(IF(DAYOFWEEK(trav_date) IN (1,7),1,NULL)) AS 'weekend trips',
COUNT(IF(DAYOFWEEK(trav_date) IN (1,7),NULL,1)) AS 'weekday trips'
FROM driver_log;


SELECT SUM(TIME_TO_SEC(t1)) AS 'total seconds',
SEC_TO_TIME(SUM(TIME_TO_SEC(t1))) AS 'total time'
FROM time_val;


SELECT subject,
COUNT(score) AS n,
IFNULL(SUM(score),0) AS total,
IFNULL(AVG(score),0) AS average,
IFNULL(MIN(score),'Unknown') AS lowest,
IFNULL(MAX(score),'Unknown') AS highest
FROM expt WHERE score IS NULL GROUP BY subject;

SELECT srcuser, dstuser FROM mail
GROUP BY srcuser, dstuser HAVING COUNT(*) = 1;

SELECT
MONTHNAME(statehood) AS month,
DAYOFMONTH(statehood) AS day,
COUNT(*) AS count
FROM states GROUP BY month, day HAVING count > 1;

SELECT LEFT(name,1) AS letter, COUNT(*) FROM states
GROUP BY letter ORDER BY COUNT(*) DESC LIMIT 1;

SELECT COUNT(*) FROM states
GROUP BY LEFT(name,1) 
ORDER BY COUNT(*) 
DESC LIMIT 1;

SET @max = (SELECT COUNT(*) FROM states
GROUP BY LEFT(name,1) ORDER BY COUNT(*) DESC LIMIT 1);
SELECT LEFT(name,1) AS letter, COUNT(*) FROM states
GROUP BY letter HAVING COUNT(*) = @max;


SELECT @total := SUM(miles) AS 'total miles' FROM driver_log;
SELECT name,
SUM(miles) AS 'miles/driver',
(SUM(miles)*100)/@total AS 'percent of total miles'
FROM driver_log
GROUP BY name;


SELECT name, AVG(miles) AS driver_avg FROM driver_log
GROUP BY name WITH ROLLUP;

