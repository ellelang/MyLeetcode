DROP TABLE IF EXISTS Customer;
DROP TABLE IF EXISTS Product;
Create table If Not Exists Customer (customer_id int, product_key int);
Create table Product (product_key int);
Truncate table Customer;
insert into Customer (customer_id, product_key) values ('1', '5');
insert into Customer (customer_id, product_key) values ('2', '6');
insert into Customer (customer_id, product_key) values ('3', '5');
insert into Customer (customer_id, product_key) values ('3', '6');
insert into Customer (customer_id, product_key) values ('1', '6');
Truncate table Product;
insert into Product (product_key) values ('5');
insert into Product (product_key) values ('6');

select t.customer_id
from(
select *, count(distinct c.product_key) as total_order
from customer c 
group by c.customer_id) t
where total_order = (select count(distinct product_key) from product p);

select customer_id
from customer
group by customer_id
having count(distinct product_key)=(
    select count(distinct product_key)
    from product
);
