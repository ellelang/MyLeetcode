DROP TABLE IF EXISTS my_numbers;
Create table If Not Exists my_numbers (num int);
Truncate table my_numbers;
insert into my_numbers (num) values ('8');
insert into my_numbers (num) values ('8');
insert into my_numbers (num) values ('3');
insert into my_numbers (num) values ('3');
insert into my_numbers (num) values ('1');
insert into my_numbers (num) values ('4');
insert into my_numbers (num) values ('5');
insert into my_numbers (num) values ('6');

select max(t.num) as num from
(select num
from my_numbers
group by num
having count(*) = 1)t;

