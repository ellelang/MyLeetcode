DROP TABLE IF EXISTS Actions ;
DROP TABLE IF EXISTS Removals;
Create table If Not Exists Actions (user_id int, post_id int, action_date date, action ENUM('view', 'like', 'reaction', 'comment', 'report', 'share'), extra varchar(10));
create table if not exists Removals (post_id int, remove_date date);
Truncate table Actions;
insert into Actions (user_id, post_id, action_date, action, extra) values ('1', '1', '2019-07-01', 'view', 'None');
insert into Actions (user_id, post_id, action_date, action, extra) values ('1', '1', '2019-07-01', 'like', 'None');
insert into Actions (user_id, post_id, action_date, action, extra) values ('1', '1', '2019-07-01', 'share', 'None');
insert into Actions (user_id, post_id, action_date, action, extra) values ('2', '2', '2019-07-04', 'view', 'None');
insert into Actions (user_id, post_id, action_date, action, extra) values ('2', '2', '2019-07-04', 'report', 'spam');
insert into Actions (user_id, post_id, action_date, action, extra) values ('3', '4', '2019-07-04', 'view', 'None');
insert into Actions (user_id, post_id, action_date, action, extra) values ('3', '4', '2019-07-04', 'report', 'spam');
insert into Actions (user_id, post_id, action_date, action, extra) values ('4', '3', '2019-07-02', 'view', 'None');
insert into Actions (user_id, post_id, action_date, action, extra) values ('4', '3', '2019-07-02', 'report', 'spam');
insert into Actions (user_id, post_id, action_date, action, extra) values ('5', '2', '2019-07-03', 'view', 'None');
insert into Actions (user_id, post_id, action_date, action, extra) values ('5', '2', '2019-07-03', 'report', 'racism');
insert into Actions (user_id, post_id, action_date, action, extra) values ('5', '5', '2019-07-03', 'view', 'None');
insert into Actions (user_id, post_id, action_date, action, extra) values ('5', '5', '2019-07-03', 'report', 'racism');
Truncate table Removals;
insert into Removals (post_id, remove_date) values ('2', '2019-07-20');
insert into Removals (post_id, remove_date) values ('3', '2019-07-18');

select round(avg(remove_status)*100,2)  as average_daily_percent
from (
select post_id, action_date,remove_date, sum(case when remove_date is null Then 0 else 1 end)/count(*) as remove_status
from
(select a.post_id, a.action_date, r.remove_date
from Actions a
left join removals r
on a.post_id = r.post_id
where a.extra = 'spam')t
group by action_date)t2;

#numerator = the number of date that occurred removal
#denominator = the number of date that occurred report and spam

SELECT ROUND(AVG(removed_post/total_post) * 100, 2) AS average_daily_percent
FROM
    (
    SELECT action_date, 
           COUNT(DISTINCT r.post_id) AS removed_post,
           COUNT(DISTINCT a.post_id) AS total_post
    FROM Actions a
    LEFT JOIN Removals r
    ON a.post_id = r.post_id
    WHERE action = 'report' AND extra = 'spam'
    GROUP BY action_date
    ) tem;
    
    
SELECT action_date, 
           COUNT(DISTINCT r.post_id) AS removed_post,
           COUNT(DISTINCT a.post_id) AS total_post
    FROM Actions a
    LEFT JOIN Removals r
    ON a.post_id = r.post_id
    WHERE action = 'report' AND extra = 'spam'
    GROUP BY action_date;