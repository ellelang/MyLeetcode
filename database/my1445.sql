USE leetcode;
Create table If Not Exists Sales (sale_date date, fruit ENUM('apples', 'oranges'), sold_num int);
Truncate table Sales;
insert into Sales (sale_date, fruit, sold_num) values ('2020-05-01', 'apples', '10');
insert into Sales (sale_date, fruit, sold_num) values ('2020-05-01', 'oranges', '8');
insert into Sales (sale_date, fruit, sold_num) values ('2020-05-02', 'apples', '15');
insert into Sales (sale_date, fruit, sold_num) values ('2020-05-02', 'oranges', '15');
insert into Sales (sale_date, fruit, sold_num) values ('2020-05-03', 'apples', '20');
insert into Sales (sale_date, fruit, sold_num) values ('2020-05-03', 'oranges', '0');
insert into Sales (sale_date, fruit, sold_num) values ('2020-05-04', 'apples', '15');
insert into Sales (sale_date, fruit, sold_num) values ('2020-05-04', 'oranges', '16');


with cte as
(
Select
sale_date,
case when fruit = 'apples' then sold_num end as apples,
case when fruit = 'oranges' then sold_num end as oranges
from Sales
)

-- select *
-- from cte;

Select
distinct sale_date as SALE_DATE,
sum(apples) - sum(oranges) as DIFF
from cte
group by sale_date;