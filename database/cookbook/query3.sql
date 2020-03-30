SELECT *
FROM query_three;

SELECT user_id, date
FROM(
SELECT 
user_id, date,
ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY date) as rank_tran
FROM query_three) TEMP
WHERE rank_tran = 10;










SELECT user_id, date
FROM 
(SELECT 
user_id,
date,
ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY date) as rank_order
FROM query_three) temp
WHERE rank_order = 10
LIMIT 5;