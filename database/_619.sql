-- Find the biggest number that only appears once.
-- my_numbers
--
-- +---+
-- |num|
-- +---+
-- | 8 |
-- | 8 |
-- | 3 |
-- | 3 |
-- | 1 |
-- | 4 |
-- | 5 |
-- | 6 |
--
-- +---+
-- |num|
-- +---+
-- | 6 |

SELECT MAX(num) AS num
FROM
(SELECT num FROM number
GROUP BY num
HAVING COUNT(num) = 1) AS t;
