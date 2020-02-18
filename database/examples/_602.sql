-- request_accepted
-- | requester_id | accepter_id | accept_date|
-- |--------------|-------------|------------|
-- | 1            | 2           | 2016_06-03 |
-- | 1            | 3           | 2016-06-08 |
-- | 2            | 3           | 2016-06-08 |
-- | 3            | 4           | 2016-06-09 |
--
-- Write a query to find the the people who has most friends and the most friends number.
-- | id | num |
-- |----|-----|
-- | 3  | 3   |

SELECT
    id,
    COUNT(1) num
FROM
    (
        (SELECT requester_id id FROM request_accepted)
            UNION ALL
        (SELECT accepter_id id FROM request_accepted)
    ) a
GROUP BY
    id
ORDER BY
    num DESC
LIMIT 1



 SELECT id, count(*) num from
(
    (select requester_id id from request_accepted)
    union all
    (select accepter_id id from request_accepted)
) as A
group by id order by num desc limit 1;
