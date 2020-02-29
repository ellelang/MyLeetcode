DROP TABLE IF EXISTS Countries ;
DROP TABLE IF EXISTS Weather ;

Create table If Not Exists Countries (country_id int, country_name varchar(20));
Create table If Not Exists Weather (country_id int, weather_state int, day date);
Truncate table Countries;
insert into Countries (country_id, country_name) values ('2', 'USA');
insert into Countries (country_id, country_name) values ('3', 'Australia');
insert into Countries (country_id, country_name) values ('7', 'Peru');
insert into Countries (country_id, country_name) values ('5', 'China');
insert into Countries (country_id, country_name) values ('8', 'Morocco');
insert into Countries (country_id, country_name) values ('9', 'Spain');
Truncate table Weather;
insert into Weather (country_id, weather_state, day) values ('2', '15', '2019-11-01');
insert into Weather (country_id, weather_state, day) values ('2', '12', '2019-10-28');
insert into Weather (country_id, weather_state, day) values ('2', '12', '2019-10-27');
insert into Weather (country_id, weather_state, day) values ('3', '-2', '2019-11-10');
insert into Weather (country_id, weather_state, day) values ('3', '0', '2019-11-11');
insert into Weather (country_id, weather_state, day) values ('3', '3', '2019-11-12');
insert into Weather (country_id, weather_state, day) values ('5', '16', '2019-11-07');
insert into Weather (country_id, weather_state, day) values ('5', '18', '2019-11-09');
insert into Weather (country_id, weather_state, day) values ('5', '21', '2019-11-23');
insert into Weather (country_id, weather_state, day) values ('7', '25', '2019-11-28');
insert into Weather (country_id, weather_state, day) values ('7', '22', '2019-12-01');
insert into Weather (country_id, weather_state, day) values ('7', '20', '2019-12-02');
insert into Weather (country_id, weather_state, day) values ('8', '25', '2019-11-05');
insert into Weather (country_id, weather_state, day) values ('8', '27', '2019-11-15');
insert into Weather (country_id, weather_state, day) values ('8', '31', '2019-11-25');
insert into Weather (country_id, weather_state, day) values ('9', '7', '2019-10-23');
insert into Weather (country_id, weather_state, day) values ('9', '3', '2019-12-23');

with cte1 as
(select w.country_id, avg(weather_state) as avg_temp
from weather w
group by w.country_id),
cte2 as(
select cte1.country_id, CASE WHEN cte1.avg_temp <= 15 THEN 'Cold' 
WHEN cte1.avg_temp >= 25 THEN 'Hot'
ELSE 'Warm' end as wtype
from cte1)

select cte2.country_id, c.country_name, cte2.wtype as weather_type
from cte2
left join Countries c
on cte2.country_id = c.country_id ;