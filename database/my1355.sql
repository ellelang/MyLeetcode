USE LEETCODE;
DROP TABLE IF EXISTS Friends ;
DROP TABLE IF EXISTS Activities;
Create table If Not Exists Friends (id int, name varchar(30), activity varchar(30));
Create table If Not Exists Activities (id int, name varchar(30));
Truncate table Friends;
insert into Friends (id, name, activity) values ('1', 'Jonathan D.', 'Eating');
insert into Friends (id, name, activity) values ('2', 'Jade W.', 'Singing');
insert into Friends (id, name, activity) values ('3', 'Victor J.', 'Singing');
insert into Friends (id, name, activity) values ('4', 'Elvis Q.', 'Eating');
insert into Friends (id, name, activity) values ('5', 'Daniel A.', 'Eating');
insert into Friends (id, name, activity) values ('6', 'Bob B.', 'Horse Riding');
Truncate table Activities;
insert into Activities (id, name) values ('1', 'Eating');
insert into Activities (id, name) values ('2', 'Singing');
insert into Activities (id, name) values ('3', 'Horse Riding');

WITH cte1 as 
(select activity, count(*)  as cnt from friends group by 1)
select activity
from Friends
Group by Activity
Having count(*) != (select min(cnt) as min_cnt from cte1) AND 
 count(*) != (select max(cnt) as max_cnt from cte1);


select activity 
from friends 
group by activity
having (
    count(*) != (   
    select max(cnt) as max_cnt from 
    (select activity, count(*)  as cnt from friends group by 1)s 
    )
    and count(*) != (   
    select min(cnt) as min_cnt from 
    (select activity, count(*)  as cnt from friends group by 1)s 
    )
);