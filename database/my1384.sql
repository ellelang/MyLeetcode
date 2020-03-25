USE LEETCODE;
DROP TABLE IF EXISTS Product;
DROP TABLE IF EXISTS Sales;

Create table If Not Exists Product (product_id int, product_name varchar(30));
Create table If Not Exists Sales (product_id varchar(30), period_start date, period_end date, average_daily_sales int);
Truncate table Product;
insert into Product (product_id, product_name) values ('1', 'LC Phone ');
insert into Product (product_id, product_name) values ('2', 'LC T-Shirt');
insert into Product (product_id, product_name) values ('3', 'LC Keychain');
Truncate table Sales;
insert into Sales (product_id, period_start, period_end, average_daily_sales) values ('1', '2019-01-25', '2019-02-28', '100');
insert into Sales (product_id, period_start, period_end, average_daily_sales) values ('2', '2018-12-01', '2020-01-01', '10');
insert into Sales (product_id, period_start, period_end, average_daily_sales) values ('3', '2019-12-01', '2020-01-31', '1');

SELECT a.product_id, b.product_name, a.report_year, a.total_amount
FROM (
    SELECT product_id, '2018' AS report_year,
        average_daily_sales * (DATEDIFF(LEAST(period_end, '2018-12-31'), GREATEST(period_start, '2018-01-01'))+1) AS total_amount
    FROM Sales
    WHERE YEAR(period_start)=2018 OR YEAR(period_end)=2018

    UNION ALL

    SELECT product_id, '2019' AS report_year,
        average_daily_sales * (DATEDIFF(LEAST(period_end, '2019-12-31'), GREATEST(period_start, '2019-01-01'))+1) AS total_amount
    FROM Sales
    WHERE YEAR(period_start)<=2019 AND YEAR(period_end)>=2019

    UNION ALL

    SELECT product_id, '2020' AS report_year,
        average_daily_sales * (DATEDIFF(LEAST(period_end, '2020-12-31'), GREATEST(period_start, '2020-01-01'))+1) AS total_amount
    FROM Sales
    WHERE YEAR(period_start)=2020 OR YEAR(period_end)=2020
) a
LEFT JOIN Product b
ON a.product_id = b.product_id
ORDER BY a.product_id, a.report_year;