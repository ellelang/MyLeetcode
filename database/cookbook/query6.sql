
USE COOKBOOK;

with cte1 as
(
SELECT country, COUNT(*) AS NUM
FROM query_six
GROUP BY country),
cte2 as(
select country,
row_number()over(order by num asc) as rank_asc,
row_number() over (order by num desc) as rank_desc
from cte1)
select country 
from cte2
WHERE rank_asc = 1 OR rank_desc = 1;

with cte3 as (
select country, created_at, user_id,
rank() over(partition by country order by created_at asc) as rank_asc,
rank() over (partition by country order by created_at desc) as rank_desc
from query_six)

select user_id, country
from cte3
where rank_asc = 1 OR rank_desc = 1 ;
















with cte1 as (
SELECT Country, COUNT(*) AS num_user
FROM query_six
GROUP BY Country
ORDER BY num_user DESC),
cte2 as(
SELECT Country,
num_user,
RANK() OVER (ORDER BY num_user DESC) DESC_RANK,
RANK() OVER (ORDER BY num_user ASC) ASC_RANK
FROM cte1)
SELECT Country,num_user
FROM cte2
WHERE DESC_RANK = 1 OR ASC_RANK = 1;

SELECT user_id,
created_at,
country
FROM
(
SELECT *,
ROW_NUMBER() OVER (PARTITION BY country ORDER BY created_at) count_asc,
ROW_NUMBER() OVER (PARTITION BY country ORDER BY created_at desc)
count_desc
FROM query_six
) tmp
WHERE count_asc = 1 or count_desc = 1
LIMIT 5;