-- point
-- | x   |
-- |-----|
-- | -1  |
-- | 0   |
-- | 2   |
--
-- output
-- | shortest|
-- |---------|
-- | 1       |

SELECT MIN(ABS(a.x-b.x)) shortest
FROM point a join point b
WHERE a.x != b.x


select min(abs(p1.x - p2.x)) as shortest from point p1
join point p2 where p1.x <> p2.x;
