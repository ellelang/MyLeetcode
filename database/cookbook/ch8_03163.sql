use cookbook;
SELECT * FROM driver_log;
select * from states;

SET @max = (SELECT MAX(records) FROM states);
SELECT records AS 'highest population', statename 
FROM states WHERE records = @max;

DROP TABLE IF EXISTS mail;
#@ _CREATE_TABLE_
CREATE TABLE mail
(
  t       DATETIME,    # when message was sent
  srcuser VARCHAR(8),  # sender (source user and host)
  srchost VARCHAR(20),
  dstuser VARCHAR(8),  # recipient (destination user and host)
  dsthost VARCHAR(20),
  size    BIGINT,      # message size in bytes
  INDEX (t)
);
#@ _CREATE_TABLE_

INSERT INTO mail (t,srchost,srcuser,dsthost,dstuser,size)
  VALUES
    ('2014-05-11 10:15:08','saturn','barb','mars','tricia',58274),
    ('2014-05-12 12:48:13','mars','tricia','venus','gene',194925),
    ('2014-05-12 15:02:49','mars','phil','saturn','phil',1048),
    ('2014-05-12 18:59:18','saturn','barb','venus','tricia',271),
    ('2014-05-14 09:31:37','venus','gene','mars','barb',2291),
    ('2014-05-14 11:52:17','mars','phil','saturn','tricia',5781),
    ('2014-05-14 14:42:21','venus','barb','venus','barb',98151),
    ('2014-05-14 17:03:01','saturn','tricia','venus','phil',2394482),
    ('2014-05-15 07:17:48','mars','gene','saturn','gene',3824),
    ('2014-05-15 08:50:57','venus','phil','venus','phil',978),
    ('2014-05-15 10:25:52','mars','gene','saturn','tricia',998532),
    ('2014-05-15 17:35:31','saturn','gene','mars','gene',3856),
    ('2014-05-16 09:00:28','venus','gene','mars','barb',613),
    ('2014-05-16 23:04:19','venus','phil','venus','barb',10294),
    ('2014-05-19 12:49:23','mars','phil','saturn','tricia',873),
    ('2014-05-19 22:21:51','saturn','gene','venus','gene',23992)
;
SELECT *
FROM mail;

SELECT srcuser, COUNT(*) FROM mail GROUP BY srcuser;

SELECT srcuser, srchost, COUNT(srcuser) FROM mail
GROUP BY srcuser, srchost;

select name,trav_date, miles
from
(select *,
dense_rank()over (partition by name order by miles desc) as rank_mile
from driver_log)t
where rank_mile = 1;

SELECT subject, test, score FROM expt ORDER BY subject, test;

SELECT LEFT(statename,1) AS letter, COUNT(*) FROM states
GROUP BY letter ORDER BY COUNT(*) DESC LIMIT 1;

SET @max = (SELECT COUNT(*) FROM states
GROUP BY LEFT(statename,1) ORDER BY COUNT(*) DESC LIMIT 1);
SELECT LEFT(statename,1) AS letter, COUNT(*) FROM states
GROUP BY letter HAVING COUNT(*) = @max;

SELECT trav_date,
COUNT(*) AS 'number of drivers', SUM(miles) As 'miles logged'
FROM driver_log GROUP BY trav_date;

SELECT YEAR(trav_date) AS year, MONTH(trav_date) AS month,
 COUNT(*) AS 'number of drivers', SUM(miles) As 'miles logged'
FROM driver_log 
GROUP BY year, month;

SELECT @total := SUM(miles) AS 'total miles' FROM driver_log;
SELECT name,
SUM(miles) AS 'miles/driver',
(SUM(miles)*100)/@total AS 'percent of total miles'
FROM driver_log 
GROUP BY name;

SELECT name,
SUM(miles) AS 'miles/driver',
(SUM(miles)*100)/(SELECT SUM(miles) FROM driver_log)
AS 'percent of total miles'
FROM driver_log GROUP BY name;