-- triangle
-- | x  | y  | z  |
-- |----|----|----|
-- | 13 | 15 | 30 |
-- | 10 | 20 | 15 |
--
-- output
-- | x  | y  | z  | triangle |
-- |----|----|----|----------|
-- | 13 | 15 | 30 | No       |
-- | 10 | 20 | 15 | Yes      |

--In Math, three segments can form a triangle only if the sum of any of the two segments is larger than the third one.

SELECT
    *
    , (CASE
       WHEN (x<y+z AND y<x+z AND z<x+y) THEN 'Yes'
       ELSE 'No'
       END) triangle
FROM
    triangle

select x, y, z,
case when x+y <= z or
        x+z <= y or
        y+z <= x
    then "No"
    else "Yes"
end as "triangle"
from triangle;
