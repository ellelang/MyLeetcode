With total AS(
SELECT *
FROM query_four_march
UNION
SELECT *
FROM query_four_april)

select user_id, SUM(transaction_amount) AS sum_trans
from total
GROUP BY user_id
order by user_id asc;

select user_id, date,
sum(sum_tran) over (PARTITION BY user_id ORDER BY date) as cusum_tran
FROM 
(SELECT user_id, date, SUM(transaction_amount) AS sum_tran
FROM query_four_march
GROUP BY user_id, date
UNION
SELECT user_id, date, SUM(transaction_amount) AS sum_tran
FROM query_four_april
GROUP BY user_id, date)temp;



SELECT user_id,
SUM(transaction_amount) as total_amount
FROM
(
SELECT * FROM query_four_march
UNION ALL
SELECT * FROM query_four_april
) tmp
GROUP BY user_id
ORDER BY user_id
LIMIT 5;

SELECT user_id,
date,
SUM(amount) over(PARTITION BY user_id ORDER BY date) as total_amount
FROM
(
SELECT user_id, date, SUM(transaction_amount) as amount
FROM query_four_march
GROUP BY user_id, date
UNION ALL
SELECT user_id, date, SUM(transaction_amount) as amount
FROM query_four_april
GROUP BY user_id, date
) tmp
ORDER BY user_id, date
LIMIT 5;