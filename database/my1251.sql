USE LEETCODE;
DROP TABLE IF EXISTS Prices ;
DROP TABLE IF EXISTS UnitsSold;
Create table If Not Exists Prices (product_id int, start_date date, end_date date, price int);
Create table If Not Exists UnitsSold (product_id int, purchase_date date, units int);
Truncate table Prices;
insert into Prices (product_id, start_date, end_date, price) values ('1', '2019-02-17', '2019-02-28', '5');
insert into Prices (product_id, start_date, end_date, price) values ('1', '2019-03-01', '2019-03-22', '20');
insert into Prices (product_id, start_date, end_date, price) values ('2', '2019-02-01', '2019-02-20', '15');
insert into Prices (product_id, start_date, end_date, price) values ('2', '2019-02-21', '2019-03-31', '30');
Truncate table UnitsSold;
insert into UnitsSold (product_id, purchase_date, units) values ('1', '2019-02-25', '100');
insert into UnitsSold (product_id, purchase_date, units) values ('1', '2019-03-01', '15');
insert into UnitsSold (product_id, purchase_date, units) values ('2', '2019-02-10', '200');
insert into UnitsSold (product_id, purchase_date, units) values ('2', '2019-03-22', '30');

# Write an SQL query to find the average selling price for each product.
#average_price should be rounded to 2 decimal places.

select t.product_id, round(sum(t.total_sale)/sum(t.units),2) as average_price
from(
select p.product_id, u.units, p.price*u.units as total_sale
from Prices p
left join UnitsSold u
on p.product_id = u.product_id and (u.purchase_date >= p.start_date and u.purchase_date <= p.end_date))t
group by t.product_id;