USE LEETCODE;
DROP TABLE IF EXISTS Spending ;
Create table If Not Exists Spending (user_id int, spend_date date, platform ENUM('desktop', 'mobile'), amount int);
Truncate table Spending;
insert into Spending (user_id, spend_date, platform, amount) values ('1', '2019-07-01', 'mobile', '100');
insert into Spending (user_id, spend_date, platform, amount) values ('1', '2019-07-01', 'desktop', '100');
insert into Spending (user_id, spend_date, platform, amount) values ('2', '2019-07-01', 'mobile', '100');
insert into Spending (user_id, spend_date, platform, amount) values ('2', '2019-07-02', 'mobile', '100');
insert into Spending (user_id, spend_date, platform, amount) values ('3', '2019-07-01', 'desktop', '100');
insert into Spending (user_id, spend_date, platform, amount) values ('3', '2019-07-02', 'desktop', '100');

WITH CTE1
AS (SELECT s1.user_id, s1.spend_date,  
case when  s2.platform is null then s1.platform
else 'both' end as platform
FROM spending s1
left join Spending s2
on s1.user_id = s2.user_id and
s1.spend_date = s2.spend_date and s1.platform!=s2.platform ),

CTE2
as (select user_id, spend_date, sum(amount) as amount
from Spending
group by user_id, spend_date),

CTE3
as (select distinct spend_date, 'mobile' platform from spending
union 
select distinct spend_date , 'desktop' platform from spending
union
select distinct spend_date , 'both' platform from spending)

select cte3.spend_date,cte3.platform, case when sum(t2.amount) is not null then sum(t2.amount) else 0 end total_amount, sum(case when t2.user_id is not null then 1 else 0 end) total_users
from 
CTE3 
left join
(
select distinct c1.user_id,c1.spend_date,c1.platform,c2.amount
from cte1 c1 inner join cte2 c2 on c1.user_id = c2.user_id and c1.spend_date=c2.spend_date)t2
on  cte3.spend_date = t2.spend_date and cte3.platform=t2.platform
group by cte3.spend_date,cte3.platform;

select * from Spending;

select *
from spending s1 left outer join spending s2
on s1.user_id = s2.user_id and s1.spend_date = s2.spend_date and s1.platform!=s2.platform;

select s1.user_id,s1.spend_date,
case when s2.platform is null then s1.platform
else 'both' end platform
from spending s1 left outer join spending s2
on s1.user_id = s2.user_id and s1.spend_date = s2.spend_date and s1.platform!=s2.platform;

select user_id,spend_date,sum(amount) amount from spending 
group by user_id,spend_date;


select distinct spend_date ,'desktop' platform from spending
union
(select distinct spend_date , 'mobile' platform from spending)
union
(select distinct spend_date ,'both' platform from spending);

with cte1 
as(select s1.user_id,s1.spend_date,
case when s2.platform is null then s1.platform
else 'both' end platform
from spending s1 left outer join spending s2
on s1.user_id = s2.user_id and s1.spend_date = s2.spend_date and s1.platform!=s2.platform),

cte2 as 
(select user_id,spend_date,sum(amount) amount from spending group by user_id,spend_date)
select t1.spend_date,t1.platform, case when sum(t2.amount) is not null then sum(t2.amount) else 0 end total_amount, sum(case when t2.user_id is not null then 1 else 0 end) total_users
from
((select distinct spend_date ,'desktop' platform from spending)
union
(select distinct spend_date , 'mobile' platform from spending)
union
(select distinct spend_date ,'both' platform from spending)) t1
left join
(select distinct c1.user_id,c1.spend_date,c1.platform,c2.amount
from cte1 c1 inner join cte2 c2 on c1.user_id = c2.user_id and c1.spend_date=c2.spend_date) t2
on t1.spend_date = t2.spend_date and t1.platform=t2.platform
group by t1.spend_date,t1.platform;


select *
from spending s1 
left outer join spending s2
on s1.user_id = s2.user_id and s1.spend_date = s2.spend_date and s1.platform!=s2.platform;

select s1.user_id,s1.spend_date,
case when s2.platform is null then s1.platform
else 'both' end platform
from spending s1 left outer join spending s2
on s1.user_id = s2.user_id and s1.spend_date = s2.spend_date and s1.platform!=s2.platform;

select user_id,spend_date,sum(amount) amount from spending 
group by user_id,spend_date;


select distinct spend_date ,'desktop' platform from spending
union
(select distinct spend_date , 'mobile' platform from spending)
union
(select distinct spend_date ,'both' platform from spending);


with cte1 
as(select s1.user_id,s1.spend_date,
case when s2.platform is null then s1.platform
else 'both' end platform
from spending s1 left outer join spending s2
on s1.user_id = s2.user_id and s1.spend_date = s2.spend_date and s1.platform!=s2.platform),

cte2 as 
(select user_id,spend_date,sum(amount) amount from spending group by user_id,spend_date)
select t1.spend_date,t1.platform, case when sum(t2.amount) is not null then sum(t2.amount) else 0 end total_amount, sum(case when t2.user_id is not null then 1 else 0 end) total_users
from
((select distinct spend_date ,'desktop' platform from spending)
union
(select distinct spend_date , 'mobile' platform from spending)
union
(select distinct spend_date ,'both' platform from spending)) t1
left join
(select distinct c1.user_id,c1.spend_date,c1.platform,c2.amount
from cte1 c1 inner join cte2 c2 on c1.user_id = c2.user_id and c1.spend_date=c2.spend_date) t2
on t1.spend_date = t2.spend_date and t1.platform=t2.platform
group by t1.spend_date,t1.platform;