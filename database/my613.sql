DROP TABLE IF EXISTS point;
CREATE TABLE If Not Exists point (x INT NOT NULL, UNIQUE INDEX x_UNIQUE (x ASC));
Truncate table point;
insert into point (x) values ('-1');
insert into point (x) values ('0');
insert into point (x) values ('2');

select yd as shortest from
(
select abs(p1.x - p2.x) as yd 
from point p1, point p2)t 
where yd<>0.0 
order by  yd
limit 1;