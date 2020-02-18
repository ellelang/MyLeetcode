-- point_2d
-- | x  | y  |
-- |----|----|
-- | -1 | -1 |
-- | 0  | 0  |
-- | -1 | -2 |
--
-- output
-- | shortest |
-- |----------|
-- | 1.00     |


SELECT
    ROUND(
        SQRT(
            MIN(POW(a.x-b.x,2) + POW(a.y-b.y,2))
            ),2
        ) shortest
FROM point_2d a CROSS JOIN point_2d b
WHERE NOT (a.x = b.x AND a.y = b.y)

select round(sqrt(min(power(p1.x - p2.x, 2) + power(p1.y - p2.y, 2))), 2) as shortest
from point_2d as p1
join point_2d as p2
where p1.x <> p2.x or p1.y <> p2.y;--it should be OR here instead of AND
