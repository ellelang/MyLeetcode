use cookbook;
With cte1 AS (
SELECT s.user_id, t.transaction_amount
FROM query_five_users s
left join query_five_transactions t
on s.user_id = t.user_id AND 
s.sign_up_date = date(t.transaction_date)
WHERE t.transaction_amount IS NOT NULL),

cte2 as(
SELECT user_id, transaction_amount,
ROW_NUMBER () OVER (ORDER BY transaction_amount ASC) AS tran_asc,
COUNT(*)OVER() - ROW_NUMBER () OVER (ORDER BY transaction_amount ASC)+ 1 AS tran_desc
FROM cte1)

SELECT AVG(transaction_amount) AS mean_tran,
AVG(CASE WHEN tran_asc BETWEEN tran_desc -1 AND tran_desc -1 THEN transaction_amount ELSE NULL END) AS median_tran
FROM cte2;












with cte1 as(
select u.user_id, u.sign_up_date, t.transaction_date, t.transaction_amount
from query_five_users u
LEFT JOIN query_five_transactions t
ON u.user_id = t.user_id
AND u.sign_up_date= DATE(t.transaction_date)),

CTE2 AS(
select user_id, 
transaction_amount,
ROW_NUMBER () OVER (ORDER BY transaction_amount ASC) AS RANK_ASC,
COUNT(*) OVER() - ROW_NUMBER() OVER(ORDER BY transaction_amount ASC)
+ 1 as RANK_DESC,
ROW_NUMBER () OVER (ORDER BY transaction_amount DESC) AS RANK_DESC2
from cte1)

/*SELECT AVG(transaction_amount) AS mean_amount,
AVG(CASE WHEN RANK_ASC BETWEEN RANK_DESC -1 AND RANK_DESC+1 THEN transaction_amount 
ELSE NULL END) AS median_amount
FROM cte2;*/

SELECT * FROM cte2;
