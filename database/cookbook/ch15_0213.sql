SELECT score, COUNT(score) AS counts
FROM testscore 
GROUP BY score;

SET @n = (SELECT COUNT(score) FROM testscore);

SELECT score, (COUNT(score)*100)/@n AS percent
FROM testscore GROUP BY score;

DROP TABLE IF EXISTS ref;
CREATE TABLE ref (score INT);
INSERT INTO ref (score)
VALUES(0),(1),(2),(3),(4),(5),(6),(7),(8),(9),(10);




SELECT * FROM die;
SELECT n FROM die ORDER BY RAND() LIMIT 1;
SELECT * FROM die ORDER BY RAND() LIMIT 5;

SELECT seq, city, miles FROM trip_log ORDER BY seq;

SELECT t1.id AS id1, t2.id AS id2,
  t1.ab AS ab1, t2.ab AS ab2,
  t1.h AS h1, t2.h AS h2,
  t2.ab-t1.ab AS abdiff,
  t2.h-t1.h AS hdiff,
  TRUNCATE(IFNULL((t2.h-t1.h)/(t2.ab-t1.ab),0),3) AS ba
FROM player_stats AS t1, player_stats AS t2
WHERE t1.id+1 = t2.id
ORDER BY t1.id
;

SELECT t1.date, t1.precip AS 'daily precip',
SUM(t2.precip) AS 'cum. precip'
FROM rainfall AS t1 INNER JOIN rainfall AS t2
ON t1.date >= t2.date
GROUP BY t1.date;

SELECT t1.date, t1.precip AS 'daily precip',
SUM(t2.precip) AS 'cum. precip',
COUNT(t2.precip) AS 'days elapsed',
AVG(t2.precip) AS 'avg. precip'
FROM rainfall AS t1 INNER JOIN rainfall AS t2
ON t1.date >= t2.date
GROUP BY t1.date;

SELECT t1.date, t1.precip AS 'daily precip',
SUM(t2.precip) AS 'cum. precip',
DATEDIFF(MAX(t2.date),MIN(t2.date)) + 1 AS 'days elapsed',
SUM(t2.precip) / (DATEDIFF(MAX(t2.date),MIN(t2.date)) + 1)
AS 'avg. precip'
FROM rainfall AS t1 INNER JOIN rainfall AS t2
ON t1.date >= t2.date
GROUP BY t1.date;

SELECT t1.stage, t1.km, SUM(t2.km) AS 'cum. km'
FROM marathon AS t1 INNER JOIN marathon AS t2
ON t1.stage >= t2.stage
GROUP BY t1.stage;

SELECT t1.stage, t1.km, t1.t,
SUM(t2.km) AS 'cum. km',
SEC_TO_TIME(SUM(TIME_TO_SEC(t2.t))) AS 'cum. t',
SUM(t2.km)/(SUM(TIME_TO_SEC(t2.t))/(60*60)) AS 'avg. km/hour'
FROM marathon AS t1 INNER JOIN marathon AS t2
ON t1.stage >= t2.stage
GROUP BY t1.stage;

SELECT score FROM testscore ORDER BY score DESC;

SET @rownum = 0;
SELECT @rownum := @rownum + 1 AS rank, score
FROM testscore ORDER BY score DESC;

SET @rank = 0, @prev_val = NULL;
SELECT @rank := IF(@prev_val=score,@rank,@rank+1) AS rank,
@prev_val := score AS score
FROM t ORDER BY score DESC;

SELECT name, wins FROM al_winner ORDER BY wins DESC, name;

SET @n = 0;
SET @val = 0;
SELECT @n:=IF(@val=wins,@n,@n+1) AS rank, name, @val:=wins AS wins
FROM al_winner ORDER BY wins DESC, name;

SELECT MAX(wins-losses) FROM standings1;
SET @wl_diff = (SELECT MAX(wins-losses) FROM standings1);
SELECT team, wins AS W, losses AS L,
wins/(wins+losses) AS PCT,
(@wl_diff - (wins-losses)) / 2 AS GB
FROM standings1
ORDER BY wins-losses DESC, PCT DESC;

DROP TABLE IF EXISTS firstplace;
CREATE TEMPORARY TABLE firstplace
SELECT half, division, MAX(wins-losses) AS wl_diff
FROM standings2
GROUP BY half, division;


SELECT wl.half, wl.division, wl.team, wl.wins AS W, wl.losses AS L,
TRUNCATE(wl.wins/(wl.wins+wl.losses),3) AS PCT,
IF(fp.wl_diff = wl.wins-wl.losses,
'-',TRUNCATE((fp.wl_diff - (wl.wins-wl.losses)) / 2,1)) AS GB
FROM standings2 AS wl INNER JOIN firstplace AS fp
ON wl.half = fp.half AND wl.division = fp.division
ORDER BY wl.half, wl.division, wl.wins-wl.losses DESC, PCT DESC;