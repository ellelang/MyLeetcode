USE leetcode;
DROP TABLE IF EXISTS Events ;
Create table If Not Exists Events (business_id int, event_type varchar(10), occurences int);
Truncate table Events;
insert into Events (business_id, event_type, occurences) values ('1', 'reviews', '7');
insert into Events (business_id, event_type, occurences) values ('3', 'reviews', '3');
insert into Events (business_id, event_type, occurences) values ('1', 'ads', '11');
insert into Events (business_id, event_type, occurences) values ('2', 'ads', '7');
insert into Events (business_id, event_type, occurences) values ('3', 'ads', '6');
insert into Events (business_id, event_type, occurences) values ('1', 'page views', '3');
insert into Events (business_id, event_type, occurences) values ('2', 'page views', '12');

select a.business_id
from events a
join
(select event_type, avg(occurences) as avg_occ
from events 
group by event_type) b
on b.event_type = a.event_type
where (a.occurences - b.avg_occ)>0
group by a.business_id
having count(a.business_id)>1
order by business_id;