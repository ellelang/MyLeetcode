DROP TABLE IF EXISTS Failed ;
DROP TABLE IF EXISTS Succeeded;
Create table If Not Exists Failed (fail_date date);
Create table If Not Exists Succeeded (success_date date);
Truncate table Failed;
insert into Failed (fail_date) values ('2018-12-28');
insert into Failed (fail_date) values ('2018-12-29');
insert into Failed (fail_date) values ('2019-01-04');
insert into Failed (fail_date) values ('2019-01-05');
Truncate table Succeeded;
insert into Succeeded (success_date) values ('2018-12-30');
insert into Succeeded (success_date) values ('2018-12-31');
insert into Succeeded (success_date) values ('2019-01-01');
insert into Succeeded (success_date) values ('2019-01-02');
insert into Succeeded (success_date) values ('2019-01-03');
insert into Succeeded (success_date) values ('2019-01-06');

# Write an SQL query to generate a report of period_state for each continuous interval of days in the period from 2019-01-01 to 2019-12-31.

with cte1 as
(select *, 'succeeded'as period_state,
lag(success_date,1) over (order by success_date) as previous_date
from Succeeded),
cte2 as
(select *, 'failed'as period_state,
lag(fail_date,1) over (order by fail_date) as previous_date,
lead(fail_date,1) over (order by fail_date) as follow_date
from Failed)

#select period_state, previous_date as start_date, fail_date as end_date, datediff(fail_date, previous_date) as diff
#from cte2;

select period_state, previous_date, success_date, datediff(success_date, previous_date) as diff
from cte1
where ;
