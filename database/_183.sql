-- Suppose that a website contains two tables, the Customers table and the Orders table. Write a SQL query to find all customers who never order anything.
--
-- Table: Customers.
--
-- +----+-------+
-- | Id | Name  |
-- +----+-------+
-- | 1  | Joe   |
-- | 2  | Henry |
-- | 3  | Sam   |
-- | 4  | Max   |
-- +----+-------+
-- Table: Orders.
--
-- +----+------------+
-- | Id | CustomerId |
-- +----+------------+
-- | 1  | 3          |
-- | 2  | 1          |
-- +----+------------+
-- Using the above tables as example, return the following:
--
-- +-----------+
-- | Customers |
-- +-----------+
-- | Henry     |
-- | Max       |
-- +-----------+

SELECT tb1.Name as Customers
FROM Customers AS tb1
LEFT JOIN Orders AS tb2
ON tb1.Id = tb2.CustomersId
WHERE tb2.Id is Null;

--Method 2
select Name as Customers from Customers left join Orders on Customers.Id = Orders.CustomerId where Orders.CustomerId is Null;
