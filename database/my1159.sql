DROP TABLE IF EXISTS Users;
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Items;
Create table If Not Exists Users (user_id int, join_date date, favorite_brand varchar(10));
create table if not exists Orders (order_id int, order_date date, item_id int, buyer_id int, seller_id int);
create table if not exists Items (item_id int, item_brand varchar(10));
Truncate table Users;
insert into Users (user_id, join_date, favorite_brand) values ('1', '2019-01-01', 'Lenovo');
insert into Users (user_id, join_date, favorite_brand) values ('2', '2019-02-09', 'Samsung');
insert into Users (user_id, join_date, favorite_brand) values ('3', '2019-01-19', 'LG');
insert into Users (user_id, join_date, favorite_brand) values ('4', '2019-05-21', 'HP');
Truncate table Orders;
insert into Orders (order_id, order_date, item_id, buyer_id, seller_id) values ('1', '2019-08-01', '4', '1', '2');
insert into Orders (order_id, order_date, item_id, buyer_id, seller_id) values ('2', '2019-08-02', '2', '1', '3');
insert into Orders (order_id, order_date, item_id, buyer_id, seller_id) values ('3', '2019-08-03', '3', '2', '3');
insert into Orders (order_id, order_date, item_id, buyer_id, seller_id) values ('4', '2019-08-04', '1', '4', '2');
insert into Orders (order_id, order_date, item_id, buyer_id, seller_id) values ('5', '2019-08-04', '1', '3', '4');
insert into Orders (order_id, order_date, item_id, buyer_id, seller_id) values ('6', '2019-08-05', '2', '2', '4');
Truncate table Items;
insert into Items (item_id, item_brand) values ('1', 'Samsung');
insert into Items (item_id, item_brand) values ('2', 'Lenovo');
insert into Items (item_id, item_brand) values ('3', 'LG');
insert into Items (item_id, item_brand) values ('4', 'HP');

select user_id as seller_id, case 
when favorite_brand = item_brand then 'yes'
else 'no' end as 2nd_item_fav_brand
from users
left join
(select seller_id, item_brand
from (
select seller_id, order_id, order_date, i.item_id, i.item_brand,
row_number() over w as rank_date
from orders o
left join items i
on o.item_id = i.item_id
window w as (partition by seller_id order by order_date))t
where rank_date = 2)t2
on users.user_id = t2.seller_id;