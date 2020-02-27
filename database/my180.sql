use leetcode;
Create table If Not Exists Logs (Id int, Num int);
Truncate table Logs;
insert into Logs (Id, Num) values ('1', '1');
insert into Logs (Id, Num) values ('2', '1');
insert into Logs (Id, Num) values ('3', '1');
insert into Logs (Id, Num) values ('4', '2');
insert into Logs (Id, Num) values ('5', '1');
insert into Logs (Id, Num) values ('6', '2');
insert into Logs (Id, Num) values ('7', '2');


select id, count(num) as cnt
from logs 
group by num;

Select Id as ConsecutiveNums
from 
(SELECT Id, COUNT(*) as cnt
FROM Logs
Group by Num) as sub 
where cnt > 3;

select distinct Num as ConsecutiveNums from 
(select Num, Id, (row_number() over (order by Id)) - (row_number() over (partition by Num order by Id)) 
as grp from Logs)src 
group by Num, grp 
having count(Num)>=3;

with cte as (
    select distinct
        case when (Num = lead(Num,1)over(order by Id) and Num = lead(Num,2)over(order by Id)) or # the
                  (Num = lag(Num,1)over(order by Id) and Num = lead(Num,1)over(order by Id)) or
                  (Num = lag(Num,2)over(order by Id) and Num = lag(Num,1)over(order by Id)) #
             then Num end as ConsecutiveNums
    from Logs
)

select ConsecutiveNums from cte where ConsecutiveNums is not null;



select distinct
        case when (Num = lead(Num,1)over(order by Id) and Num = lead(Num,2)over(order by Id)) or # the
                  (Num = lag(Num,1)over(order by Id) and Num = lead(Num,1)over(order by Id)) or
                  (Num = lag(Num,2)over(order by Id) and Num = lag(Num,1)over(order by Id)) #
             then Num end as ConsecutiveNums
    from Logs;