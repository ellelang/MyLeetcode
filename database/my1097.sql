DROP TABLE IF EXISTS Activity ;
Create table If Not Exists Activity (player_id int, device_id int, event_date date, games_played int);
Truncate table Activity;
insert into Activity (player_id, device_id, event_date, games_played) values ('1', '2', '2016-03-01', '5');
insert into Activity (player_id, device_id, event_date, games_played) values ('1', '2', '2016-03-02', '6');
insert into Activity (player_id, device_id, event_date, games_played) values ('2', '3', '2017-06-25', '1');
insert into Activity (player_id, device_id, event_date, games_played) values ('3', '1', '2016-03-01', '0');
insert into Activity (player_id, device_id, event_date, games_played) values ('3', '4', '2018-07-03', '5');


select install_dt, installs, 
       round(cast(num_retention as float)/installs, 2) as Day1_retention
from(
select install_dt,
    count(distinct player_id) as installs,
    sum(case when (srank = 2 and datediff(event_date,install_dt)=1) then 1 else 0 end) as num_retention
    from
(select player_id, event_date, 
rank() over(partition by player_id order by event_date) as srank,
min(event_date) over(partition by player_id) as install_dt 
from activity)t1
group by install_dt)t2;