-- 601. Human Traffic of Stadium
--
--X city built a new stadium, each day many people visit it and the stats are saved as these columns: id, date, people
--
--Please write a query to display the records which have 3 or more consecutive rows
-- and the amount of people more than 100(inclusive).
--For example, the table stadium:
--
--+------+------------+-----------+
--| id   | visit_date       | people    |
--+------+------------+-----------+
--| 1    | 2017-01-01 | 10        |
--| 2    | 2017-01-02 | 109       |
--| 3    | 2017-01-03 | 150       |
--| 4    | 2017-01-04 | 99        |
--| 5    | 2017-01-05 | 145       |
--| 6    | 2017-01-06 | 1455      |
--| 7    | 2017-01-07 | 199       |
--| 8    | 2017-01-08 | 188       |
--+------+------------+-----------+
--
--For the sample data above, the output is:
--
--+------+------------+-----------+
--| id   | date       | people    |
--+------+------------+-----------+
--| 5    | 2017-01-05 | 145       |
--| 6    | 2017-01-06 | 1455      |
--| 7    | 2017-01-07 | 199       |
--| 8    | 2017-01-08 | 188       |
--+------+------------+-----------+
--
--Note:
--Each day only have one row record, and the dates are increasing with id increasing.

SELECT
    s0.*
FROM
    stadium s0 LEFT JOIN
    stadium s1 ON s1.id = s0.id + 1 LEFT JOIN
    stadium s2 ON s2.id = s0.id + 2 LEFT JOIN
    stadium s_1 ON s_1.id = s0.id - 1 LEFT JOIN
    stadium s_2 ON s_2.id = s0.id - 2
WHERE
    (s0.people > 99 AND s1.people > 99 AND s2.people > 99) OR
    (s_1.people > 99 AND s0.people > 99 AND s1.people > 99) OR
    (s_2.people > 99 AND s_1.people > 99 AND s0.people > 99)
ORDER BY s0.id

--思想：1. 自连接得到「前后两天」的数据，2.分别对三种情况进行筛选。好处是不会筛选出重复记录。


SELECT
    DISTINCT a.*
FROM
    stadium a,
    stadium b,
    stadium c
WHERE
    ((b.id = a.id + 1 AND c.id = a.id + 2) OR   --a是第一天
     (b.id = a.id - 1 AND c.id = a.id + 1) OR   --a是第二天
     (b.id = a.id - 1 AND c.id = a.id - 2)) AND --a是第三天
    (a.people > 99 AND b.people > 99 AND c.people > 99)
ORDER BY a.id
--- 语法和逻辑上都要简单明了一些，但是会选出重复记录，执行效率也略微低一点。个人习惯「能用JOIN的时候尽量用JOIN」




select distinct t1.*
from stadium t1, stadium t2, stadium t3
where t1.people >= 100 and t2.people >= 100 and t3.people >= 100
and
(
	  (t1.id - t2.id = 1 and t1.id - t3.id = 2 and t2.id - t3.id =1)  -- t1, t2, t3
    or
    (t2.id - t1.id = 1 and t2.id - t3.id = 2 and t1.id - t3.id =1) -- t2, t1, t3
    or
    (t3.id - t2.id = 1 and t2.id - t1.id =1 and t3.id - t1.id = 2) -- t3, t2, t1
)
order by t1.id;


SELECT s1.* FROM stadium AS s1, stadium AS s2, stadium as s3
    WHERE
    ((s1.id + 1 = s2.id
    AND s1.id + 2 = s3.id)
    OR
    (s1.id - 1 = s2.id
    AND s1.id + 1 = s3.id)
    OR
    (s1.id - 2 = s2.id
    AND s1.id - 1 = s3.id)
    )
    AND s1.people>=100
    AND s2.people>=100
    AND s3.people>=100

    GROUP BY s1.id;
