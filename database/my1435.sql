USE Leetcode;
DROP TABLE IF EXISTS Sessions;
Create table If Not Exists Sessions (session_id int, duration int);
Truncate table Sessions;
insert into Sessions (session_id, duration) values ('1', '30');
insert into Sessions (session_id, duration) values ('2', '199');
insert into Sessions (session_id, duration) values ('3', '299');
insert into Sessions (session_id, duration) values ('4', '580');
insert into Sessions (session_id, duration) values ('5', '1000');

with CTE1 as
(
select session_id, CASE 
     WHEN duration/60>= 0 and duration/60<5 then '[0-5>'
     WHEN duration/60>= 5 and duration/60<10 then '[5-10>'
     WHEN duration/60>=10 and duration/60<15 then '[10-15>'
     else '15 or more' end as bin
    from Sessions),
    
CTE2 as
(
    select '[0-5>' as Bin
    Union All
    select '[5-10>' as Bin
    Union All
    select '[10-15>' as Bin
    Union All
    select '15 or more' as Bin
)
Select B.bin as BIN, Coalesce(count(session_id),0) as Total from CTE1 A Right Join CTE2 B
on A.Bin=B.bin
group by B.Bin;