DROP TABLE IF EXISTS Products ;
Create table If Not Exists Products (product_id int, new_price int, change_date date);
Truncate table Products;
insert into Products (product_id, new_price, change_date) values ('1', '20', '2019-08-14');
insert into Products (product_id, new_price, change_date) values ('2', '50', '2019-08-14');
insert into Products (product_id, new_price, change_date) values ('1', '30', '2019-08-15');
insert into Products (product_id, new_price, change_date) values ('1', '35', '2019-08-16');
insert into Products (product_id, new_price, change_date) values ('2', '65', '2019-08-17');
insert into Products (product_id, new_price, change_date) values ('3', '20', '2019-08-18');




select product_id, new_price as price 
    from (select *, rank() over(partition by product_id order by change_date desc) as ranking 
          from Products 
          where change_date <= '2019-08-16') tem
    where ranking = 1
union
    select distinct product_id, 10 as price
    from Products
    where product_id not in (select product_id from Products where change_date <= '2019-08-16');