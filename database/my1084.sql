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


select  s.product_id, p.product_name
from sales s
left join product p
on s.product_id = p.product_id
group by p.product_id
having sum(case when s.sale_date between '2019-01-01' and '2019-03-31'then 0 else 1 end ) = 0;


select s.product_id, p.product_name, sum(case when s.sale_date > '2019-03-31' then 1
else 0 end) as spring
from Sales s 
left join product p
on s.product_id = p.product_id
group by product_id
having spring = 0;



Select s.product_id, p.product_name
from sales s
left join product p
on s.product_id = p.product_id
group by product_id
HAVING SUM(CASE WHEN sale_date BETWEEN '2019-01-01' AND '2019-03-31' THEN 1 ELSE 0 END) > 0
AND SUM(CASE WHEN sale_date < '2019-01-01' THEN 1
WHEN sale_date > '2019-03-31' THEN 1 ELSE 0 END) =0;
