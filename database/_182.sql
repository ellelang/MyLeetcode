--write a SQL query to find all duplicate emails in a table named Person.

-- +----+---------+
-- | Id | Email   |
-- +----+---------+
-- | 1  | a@b.com |
-- | 2  | c@d.com |
-- | 3  | a@b.com |
-- +----+---------+
-- For example, your query should return the following for the above table:
--
-- +---------+
-- | Email   |
-- +---------+
-- | a@b.com |
-- +---------+
-- Note: All emails are in lowercase.



--Method1
SELECT Email
FROM Person
Group BY Email
HAVING count(*) > 1;



--Method 2
SELECT distinct tb1.Email
FROM Person as tb1
INNER JOIN Person AS tb2
ON tb1.Email = tb2.Email AND
tb1.Id != tb2.Id;
