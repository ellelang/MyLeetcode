--Find the Start and End Number of Continuous Ranges
-- Table: Logs
--
-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | log_id        | int     |
-- +---------------+---------+
-- id is the primary key for this table.
-- Each row of this table contains the ID in a log Table.
--
-- Since some IDs have been removed from Logs. Write an SQL query to find the start and end number of continuous ranges in table Logs.
--
-- Order the result table by start_id.
--
-- The query result format is in the following example:
--
-- Logs table:
-- +------------+
-- | log_id     |
-- +------------+
-- | 1          |
-- | 2          |
-- | 3          |
-- | 7          |
-- | 8          |
-- | 10         |
-- +------------+
--
-- Result table:
-- +------------+--------------+
-- | start_id   | end_id       |
-- +------------+--------------+
-- | 1          | 3            |
-- | 7          | 8            |
-- | 10         | 10           |
-- +------------+--------------+
-- The result table should contain all ranges in table Logs.
-- From 1 to 3 is contained in the table.
-- From 4 to 6 is missing in the table
-- From 7 to 8 is contained in the table.
-- Number 9 is missing in the table.
-- Number 10 is contained in the table.

# Write your MySQL query statement below
SELECT l1.log_id AS start_id,
(SELECT MIN(l3.log_id)
FROM
Logs l3 LEFT JOIN Logs l4
ON l3.log_id +1 = l4.log_id
WHERE l4.log_id IS NULL
AND l3.log_id >= l1.log_id
) AS end_id
FROM
Logs l1 LEFT JOIN Logs l2
ON l1.log_id -1 = l2.log_id
WHERE l2.log_id IS NULL
