DROP TABLE IF EXISTS point_2d;
CREATE TABLE If Not Exists point_2d (x INT NOT NULL, y INT NOT NULL);
Truncate table point_2d;
insert into point_2d (x, y) values ('-1', '-1');
insert into point_2d (x, y) values ('0', '0');
insert into point_2d (x, y) values ('-1', '-2');

select round(yd ,2)as shortest from 
(select SQRT(POWER((p1.x-p2.x),2) + POWER((p1.y-p2.y),2)) as yd 
from point_2d p1, point_2d p2 )t 
where yd<>0.0 order by yd limit 1;


select SQRT(POWER((p1.x-p2.x),2) + POWER((p1.y-p2.y),2)) as yd 
from point_2d p1, point_2d p2 ;