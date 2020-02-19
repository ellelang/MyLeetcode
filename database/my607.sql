DROP TABLE IF EXISTS salesperson;
DROP TABLE IF EXISTS company;
DROP TABLE IF EXISTS orders;
Create table If Not Exists salesperson (sales_id int, name char(255), salary int,commission_rate int, hire_date char(255));
Create table If Not Exists company (com_id int, name char(255), city char(255));
Create table If Not Exists orders (order_id int8, order_date char(255), com_id int, sales_id int, amount int);
Truncate table salesperson;
insert into salesperson (sales_id, name, salary, commission_rate, hire_date) values ('1', 'John', '100000', '6', '4/1/2006');
insert into salesperson (sales_id, name, salary, commission_rate, hire_date) values ('2', 'Amy', '12000', '5', '5/1/2010');
insert into salesperson (sales_id, name, salary, commission_rate, hire_date) values ('3', 'Mark', '65000', '12', '12/25/2008');
insert into salesperson (sales_id, name, salary, commission_rate, hire_date) values ('4', 'Pam', '25000', '25', '1/1/2005');
insert into salesperson (sales_id, name, salary, commission_rate, hire_date) values ('5', 'Alex', '5000', '10', '2/3/2007');
Truncate table company;
insert into company (com_id, name, city) values ('1', 'RED', 'Boston');
insert into company (com_id, name, city) values ('2', 'ORANGE', 'New York');
insert into company (com_id, name, city) values ('3', 'YELLOW', 'Boston');
insert into company (com_id, name, city) values ('4', 'GREEN', 'Austin');
Truncate table orders;
insert into orders (order_id, order_date, com_id, sales_id, amount) values (1, '1/1/2014', '3', '4', '10000');
insert into orders (order_id, order_date, com_id, sales_id, amount) values (2, '2/1/2014', '4', '5', '5000');
insert into orders (order_id, order_date, com_id, sales_id, amount) values (3, '3/1/2014', '1', '1', '50000');
insert into orders (order_id, order_date, com_id, sales_id, amount) values (4, '4/1/2014', '1', '4', '25000');

with ct1 as (
select t.name, c.name as company
from
(select p.sales_id, p.name, o.com_id 
from salesperson p
left join orders o
on p.sales_id = o.sales_id)t
left join company c
on t.com_id = c.com_id
where c.name = 'RED')

select name from salesperson 
where name not in (select name from ct1)
;


select name from salesperson where sales_id not in
(
select o.sales_id from orders o
join company c
on o.com_id = c.com_id
where c.name = 'RED')