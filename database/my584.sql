CREATE TABLE IF NOT EXISTS customer (id INT,name CHAR(25),referee_id INT);
Truncate table customer;
insert into customer (id, name, referee_id) values ('1', 'Will', null);
insert into customer (id, name, referee_id) values ('2', 'Jane', null);
insert into customer (id, name, referee_id) values ('3', 'Alex', '2');
insert into customer (id, name, referee_id) values ('4', 'Bill', null);
insert into customer (id, name, referee_id) values ('5', 'Zack', '1');
insert into customer (id, name, referee_id) values ('6', 'Mark', '2');

select name
from
(select name, ifnull(referee_id, 0) as referee
from customer)t
where t.referee != 2;


select name from customer
where referee_id <> 2
or referee_id is null;