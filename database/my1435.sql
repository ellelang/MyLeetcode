USE Leetcode;
DROP TABLE IF EXISTS Sessions;
Create table If Not Exists Sessions (session_id int, duration int);
Truncate table Sessions;
insert into Sessions (session_id, duration) values ('1', '30');
insert into Sessions (session_id, duration) values ('2', '199');
insert into Sessions (session_id, duration) values ('3', '299');
insert into Sessions (session_id, duration) values ('4', '580');
insert into Sessions (session_id, duration) values ('5', '1000');

WITH cte1 as (
select session_id,
CASE WHEN duration >= 0 and duration < 300 THEN '[0-5>'
WHEN duration >= 300 and duration < 600 THEN '[5-10>'
WHEN duration >= 600 and duration < 900 THEN '[10-15>'
ELSE '15 or more' end AS dur_type
FROM Sessions 
)

select dur_type as bin,
IFNULL(COUNT(*),0) as count
from CTE1
group by dur_type;


