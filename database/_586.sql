--Customer Placing the Largest Number of Orders
-- orders
--
-- | order_number | customer_number | order_date | required_date | shipped_date | status | comment |
-- |--------------|-----------------|------------|---------------|--------------|--------|---------|
-- | 1            | 1               | 2017-04-09 | 2017-04-13    | 2017-04-12   | Closed |         |
-- | 2            | 2               | 2017-04-15 | 2017-04-20    | 2017-04-18   | Closed |         |
-- | 3            | 3               | 2017-04-16 | 2017-04-25    | 2017-04-20   | Closed |         |
-- | 4            | 3               | 2017-04-18 | 2017-04-28    | 2017-04-25   | Closed |         |
--
-- Output
-- | customer_number |
-- |-----------------|
-- | 3               |



SELECT customer_number
FROM orders
GROUP BY customer_number
ORDER BY COUNT(1) DESC LIMIT 1;

SELECT customer_number
FROM orders
GROUP BY customer_number
HAVING COUNT(1) = (SELECT COUNT(1)
                   FROM orders
                   GROUP BY customer_number
                   ORDER BY COUNT(1) DESC
                   LIMIT 1)
