USE COOKBOOK;
SELECT * FROM 
query_two_mobile;

WITH full_table AS(
SELECT DISTINCT m.user_id as m_id, w.user_id as w_id
FROM query_two_mobile AS m
LEFT JOIN query_two_web AS w
ON m.user_id = w.user_id
UNION
SELECT DISTINCT m.user_id as m_id, w.user_id as w_id
FROM query_two_mobile AS m
RIGHT JOIN query_two_web AS w
ON m.user_id = w.user_id)

SELECT SUM(CASE WHEN m_id IS NOT NULL AND w_id IS NOT NULL THEN 1 ELSE 0 END)/COUNT(*) AS percent_both,
SUM(CASE WHEN m_id IS NOT NULL AND w_id IS NULL THEN 1 ELSE 0 END)/COUNT(*) AS percent_mobile,
SUM(CASE WHEN m_id IS NULL AND w_id IS NOT NULL THEN 1 ELSE 0 END)/COUNT(*) AS percent_web
FROM full_table;


WITH TOTAL AS
(SELECT DISTINCT m.user_id as m_user, w.user_id as w_user
FROM query_two_mobile m
LEFT JOIN  query_two_web  w
ON m.user_id = w.user_id
UNION
SELECT DISTINCT DISTINCT m.user_id as m_user, w.user_id as w_user
FROM query_two_mobile m
RIGHT JOIN query_two_web w
ON m.user_id = w.user_id)

SELECT 100* sum(CASE WHEN w_user IS NULL THEN 1 ELSE 0 END)/COUNT(*) AS mobile_only, 
100* sum(CASE WHEN m_user IS NULL THEN 1 ELSE 0 END)/COUNT(*) AS web_only,
100* sum(CASE WHEN w_user IS NOT NULL AND m_user IS NOT NULL THEN 1 ELSE 0 END)/COUNT(*) AS M_W
FROM TOTAL;