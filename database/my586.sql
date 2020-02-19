DROP TABLE IF EXISTS orders;

Create table If Not Exists orders (order_number int, customer_number int, order_date date, required_date date, shipped_date date, status char(15), comment char(200), key(order_number));
Truncate table orders;
insert into orders (order_number, customer_number) values (1, 1);
insert into orders (order_number, customer_number) values (2, 2);
insert into orders (order_number, customer_number) values (3, 3);
insert into orders (order_number, customer_number) values (4, 3);

select * from orders;

SELECT 
    customer_number
FROM
    (SELECT 
        customer_number, COUNT(order_number) AS total
    FROM
        orders
    GROUP BY customer_number
    ORDER BY total DESC
    LIMIT 1) t;





WITH cte
AS
    (SELECT customer_number, COUNT(customer_number) AS total
    FROM orders
    GROUP BY customer_number)
SELECT customer_number
FROM cte
WHERE total = (SELECT MAX(total) FROM cte);
