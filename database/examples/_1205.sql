-- SQL Schema
-- Table: Transactions
--
-- +----------------+---------+
-- | Column Name    | Type    |
-- +----------------+---------+
-- | id             | int     |
-- | country        | varchar |
-- | state          | enum    |
-- | amount         | int     |
-- | trans_date     | date    |
-- +----------------+---------+
-- id is the primary key of this table.
-- The table has information about incoming transactions.
-- The state column is an enum of type ["approved", "declined"].
-- Table: Chargebacks
--
-- +----------------+---------+
-- | Column Name    | Type    |
-- +----------------+---------+
-- | trans_id       | int     |
-- | charge_date    | date    |
-- +----------------+---------+
-- Chargebacks contains basic information regarding incoming chargebacks from some transactions placed in Transactions table.
-- trans_id is a foreign key to the id column of Transactions table.
-- Each chargeback corresponds to a transaction made previously even if they were not approved.
--
--
-- Write an SQL query to find for each month and country, the number of approved transactions and their total amount, the number of chargebacks and their total amount.
--
-- Note: In your query, given the month and country, ignore rows with all zeros.
--
-- The query result format is in the following example:
--
-- Transactions table:
-- +------+---------+----------+--------+------------+
-- | id   | country | state    | amount | trans_date |
-- +------+---------+----------+--------+------------+
-- | 101  | US      | approved | 1000   | 2019-05-18 |
-- | 102  | US      | declined | 2000   | 2019-05-19 |
-- | 103  | US      | approved | 3000   | 2019-06-10 |
-- | 104  | US      | approved | 4000   | 2019-06-13 |
-- | 105  | US      | approved | 5000   | 2019-06-15 |
-- +------+---------+----------+--------+------------+
--
-- Chargebacks table:
-- +------------+------------+
-- | trans_id   | trans_date |
-- +------------+------------+
-- | 102        | 2019-05-29 |
-- | 101        | 2019-06-30 |
-- | 105        | 2019-09-18 |
-- +------------+------------+
--
-- Result table:
-- +----------+---------+----------------+-----------------+-------------------+--------------------+
-- | month    | country | approved_count | approved_amount | chargeback_count  | chargeback_amount  |
-- +----------+---------+----------------+-----------------+-------------------+--------------------+
-- | 2019-05  | US      | 1              | 1000            | 1                 | 2000               |
-- | 2019-06  | US      | 3              | 12000           | 1                 | 1000               |
-- | 2019-09  | US      | 0              | 0               | 1                 | 5000               |
-- +----------+---------+----------------+-----------------+-------------------+--------------------+

SELECT left(trans_date, 7) as month,
country,
SUM(CASE WHEN STATE = 'approved' THEN 1 ELSE 0 END) AS approved_count,
SUM(CASE WHEN STATE = 'approved' THEN amount ELSE 0 END) AS approved_amount,
SUM(CASE WHEN STATE = 'back' THEN 1 ELSE 0 END) AS chargeback_count,
SUM(CASE WHEN STATE = 'back' THEN amount ELSE 0 END) AS chargeback_amount
FROM
(SELECT *
FROM Transactions
UNION ALL
SELECT trans_id, t.country, "back",t.amount, c.trans_date
FROM Chargebacks c left join Transactions t
ON c.trans_id = t.id)a
GROUP BY month, country
HAVING approved_count+approved_amount+chargeback_count+chargeback_amount!=0;

---elect DATE_FORMAT(trans_date,"%Y-%m") AS month, country,
