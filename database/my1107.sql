DROP TABLE IF EXISTS Traffic;
Create table If Not Exists Traffic (user_id int, activity ENUM('login', 'logout', 'jobs', 'groups', 'homepage'), activity_date date);
Truncate table Traffic;
insert into Traffic (user_id, activity, activity_date) values ('1', 'login', '2019-05-01');
insert into Traffic (user_id, activity, activity_date) values ('1', 'homepage', '2019-05-01');
insert into Traffic (user_id, activity, activity_date) values ('1', 'logout', '2019-05-01');
insert into Traffic (user_id, activity, activity_date) values ('2', 'login', '2019-06-21');
insert into Traffic (user_id, activity, activity_date) values ('2', 'logout', '2019-06-21');
insert into Traffic (user_id, activity, activity_date) values ('3', 'login', '2019-01-01');
insert into Traffic (user_id, activity, activity_date) values ('3', 'jobs', '2019-01-01');
insert into Traffic (user_id, activity, activity_date) values ('3', 'logout', '2019-01-01');
insert into Traffic (user_id, activity, activity_date) values ('4', 'login', '2019-06-21');
insert into Traffic (user_id, activity, activity_date) values ('4', 'groups', '2019-06-21');
insert into Traffic (user_id, activity, activity_date) values ('4', 'logout', '2019-06-21');
insert into Traffic (user_id, activity, activity_date) values ('5', 'login', '2019-03-01');
insert into Traffic (user_id, activity, activity_date) values ('5', 'logout', '2019-03-01');
insert into Traffic (user_id, activity, activity_date) values ('5', 'login', '2019-06-21');
insert into Traffic (user_id, activity, activity_date) values ('5', 'logout', '2019-06-21');

select activity_date as login_date,
count(distinct user_id) as user_count 
from
(select user_id, activity, activity_date,
rank() over w as srank
from Traffic
window w as (partition by user_id order by activity_date))t
where srank = 1
AND activity_date > adddate(DATE("2019-06-23"), INTERVAL -90 DAY) 
AND activity = 'login'
GROUP BY activity_date;