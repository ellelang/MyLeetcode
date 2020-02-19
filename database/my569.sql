DROP TABLE IF EXISTS Employee;
Create table If Not Exists Employee (Id int, Company char(255), Salary int);
Truncate table Employee;
insert into Employee (Id, Company, Salary) values ('1', 'A', '2341');
insert into Employee (Id, Company, Salary) values ('2', 'A', '341');
insert into Employee (Id, Company, Salary) values ('3', 'A', '15');
insert into Employee (Id, Company, Salary) values ('4', 'A', '15314');
insert into Employee (Id, Company, Salary) values ('5', 'A', '451');
insert into Employee (Id, Company, Salary) values ('6', 'A', '513');
insert into Employee (Id, Company, Salary) values ('7', 'B', '15');
insert into Employee (Id, Company, Salary) values ('8', 'B', '13');
insert into Employee (Id, Company, Salary) values ('9', 'B', '1154');
insert into Employee (Id, Company, Salary) values ('10', 'B', '1345');
insert into Employee (Id, Company, Salary) values ('11', 'B', '1221');
insert into Employee (Id, Company, Salary) values ('12', 'B', '234');
insert into Employee (Id, Company, Salary) values ('13', 'C', '2345');
insert into Employee (Id, Company, Salary) values ('14', 'C', '2645');
insert into Employee (Id, Company, Salary) values ('15', 'C', '2645');
insert into Employee (Id, Company, Salary) values ('16', 'C', '2652');
insert into Employee (Id, Company, Salary) values ('17', 'C', '65');




Select Id, Company, Salary, 
row_number() over w as salary_rank,
cume_dist() over w as salary_dist,
percent_rank() over w as salary_percent,
count(id) over (partition by company) as tot_num
from employee
window w as (partition by Company order by Salary);

select id, company, salary from
    (select *,
    (case when (tot_num%2 = 0 and rowrank = tot_num/2) then 'Yes'
          when (tot_num%2 = 0 and rowrank = 1 + (tot_num/2)) then 'Yes'
          when (tot_num%2 != 0 and rowrank = ((tot_num+1)/2)) then 'Yes'
          else 'No'
     end) as median
     from
        (select *,
        row_number() over(partition by company order by salary) as rowrank,
        count(id) over (partition by company) as tot_num
        from employee) a) b
where median = 'Yes';
     