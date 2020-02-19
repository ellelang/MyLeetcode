USE leetcode;
DROP TABLE IF EXISTS Activity;
Create table If Not Exists Activity (player_id int, device_id int, event_date date, games_played int);
Truncate table Activity;
insert into Activity (player_id, device_id, event_date, games_played) values ('1', '2', '2016-03-01', '5');
insert into Activity (player_id, device_id, event_date, games_played) values ('1', '2', '2016-03-02', '6');
insert into Activity (player_id, device_id, event_date, games_played) values ('2', '3', '2017-06-25', '1');
insert into Activity (player_id, device_id, event_date, games_played) values ('3', '1', '2016-03-02', '0');
insert into Activity (player_id, device_id, event_date, games_played) values ('3', '4', '2018-07-03', '5');

with tmp as (
select player_id, event_date, 
datediff(event_date, lag(event_date,1) over w) as dd
from activity
window w as (partition by player_id order by event_date)
)
select round(cast(count(distinct player_id) as float)/(select count(distinct player_id) from tmp), 2) as fraction
from tmp
where dd = 1;



select player_id, event_date, 
row_number() over w as rnk,
datediff(event_date, lag(event_date,1) over w) as dd
from activity
window w as (partition by player_id order by event_date);