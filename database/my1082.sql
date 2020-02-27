DROP TABLE IF EXISTS Product;
DROP TABLE IF EXISTS Sales;
Create table If Not Exists Product (product_id int, product_name varchar(10), unit_price int);
Create table If Not Exists Sales (seller_id int, product_id int, buyer_id int, sale_date date, quantity int, price int);
Truncate table Product;
insert into Product (product_id, product_name, unit_price) values ('1', 'S8', '1000');
insert into Product (product_id, product_name, unit_price) values ('2', 'G4', '800');
insert into Product (product_id, product_name, unit_price) values ('3', 'iPhone', '1400');
Truncate table Sales;
insert into Sales (seller_id, product_id, buyer_id, sale_date, quantity, price) values ('1', '1', '1', '2019-01-21', '2', '2000');
insert into Sales (seller_id, product_id, buyer_id, sale_date, quantity, price) values ('1', '2', '2', '2019-02-17', '1', '800');
insert into Sales (seller_id, product_id, buyer_id, sale_date, quantity, price) values ('2', '2', '3', '2019-06-02', '1', '800');
insert into Sales (seller_id, product_id, buyer_id, sale_date, quantity, price) values ('3', '3', '4', '2019-05-13', '2', '2800');

select  seller_id
from sales
group by seller_id 
having sum(price) >= all(
select sum(price) as total_price
from sales
group by seller_id);


with cte as(
select seller_id, price,
rank() over w as prank,
sum(price) over w as total_price
from sales
window w as (partition by seller_id order by price))

select seller_id from cte
where total_price in (select max(total_price) as total_price from cte);


SELECT seller_id
FROM Sales
GROUP BY seller_id
HAVING SUM(price) >= ALL
(SELECT SUM(price) FROM Sales GROUP BY seller_id);

SELECT SUM(price) FROM Sales GROUP BY seller_id;
