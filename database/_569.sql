--569. Median Employee Salary
-- The Employee table holds all employees. The employee table has three columns:
--Employee Id, Company Name, and Salary.
--
--+-----+------------+--------+
--|Id   | Company    | Salary |
--+-----+------------+--------+
--|1    | A          | 2341   |
--|2    | A          | 341    |
--|3    | A          | 15     |
--|4    | A          | 15314  |
--|5    | A          | 451    |
--|6    | A          | 513    |
--|7    | B          | 15     |
--|8    | B          | 13     |
--|9    | B          | 1154   |
--|10   | B          | 1345   |
--|11   | B          | 1221   |
--|12   | B          | 234    |
--|13   | C          | 2345   |
--|14   | C          | 2645   |
--|15   | C          | 2645   |
--|16   | C          | 2652   |
--|17   | C          | 65     |
--+-----+------------+--------+
--
--Write a SQL query to find the median salary of each company.
--Bonus points if you can solve it without using any built-in SQL functions.
--
--+-----+------------+--------+
--|Id   | Company    | Salary |
--+-----+------------+--------+
--|5    | A          | 451    |
--|6    | A          | 513    |
--|12   | B          | 234    |
--|9    | B          | 1154   |
--|14   | C          | 2645   |
--+-----+------------+--------+

SELECT Id, Company, Median(Salary)
FROM employees
GROUP BY Company

SELECT
    tb1.id,
    tb1.company,
    tb1.salary
FROM
    Employee as tb1 LEFT JOIN Employee as tb2 ON
    tb1.company = tb2.company
GROUP BY tb1.id
HAVING
    ABS(SUM(CASE
            WHEN tb1.salary > tb2.salary THEN -1   --小于当前
            WHEN tb1.salary < tb2.salary THEN 1   --大于当前  相互cancel out
            WHEN tb1.salary = tb2.salary AND tb1.id < tb2.id THEN 1
            WHEN tb1.salary = tb2.salary AND tb1.id > tb2.id THEN -1 --相等时按id大小归+-
            ELSE 0 END)) <= 1 --必须添加else 0否则单个records的情况会返回空表
ORDER BY
    tb1.company, tb1.salary



select Id, Company, Salary from
(
select e.Id, e.Salary, e.Company,  if( @prev = e.Company , @Rank := @Rank + 1, @Rank := 1) as rank, @prev := e.Company
from Employee e , (select @Rank := 0, @prev := 0) as temp order by e.Company, e.Salary, e.Id
) Ranking
INNER JOIN
(
select count(*) as totalcount, Company as name from Employee e2 group by e2.Company
) companycount
on companycount.name = Ranking.Company
where Rank = floor((totalcount+1)/2) or Rank = floor((totalcount+2)/2)
