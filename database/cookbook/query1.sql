USE COOKBOOK;
SELECT * FROM 
query_one;

select user_id, unix_timestamp- prev_time as DeltaTime
FROM 
(SELECT user_id, unix_timestamp,
LAG(unix_timestamp, 1) OVER (PARTITION BY user_id ORDER BY unix_timestamp ASC) as prev_time,
ROW_NUMBER()OVER (PARTITION BY user_id ORDER BY unix_timestamp DESC) as Rank_desc 
FROM query_one)temp
WHERE Rank_desc = 1
ORDER BY user_id;

SELECT user_id,
unix_timestamp - previous_time AS Delta_SecondLast0ne_LastOne
FROM
(SELECT user_id,
unix_timestamp,
LAG(unix_timestamp, 1) OVER (PARTITION BY user_id ORDER BY
unix_timestamp) AS previous_time,
ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY
unix_timestamp DESC) AS order_desc
FROM query_one
) tmp
WHERE order_desc = 1
ORDER BY user_id
LIMIT 5;

