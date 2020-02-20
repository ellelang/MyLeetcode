DROP TABLE IF EXISTS salary;
DROP TABLE IF EXISTS employee;
Create table If Not Exists salary (id int, employee_id int, amount int, pay_date date);
Create table If Not Exists employee (employee_id int, department_id int);
Truncate table salary;
insert into salary (id, employee_id, amount, pay_date) values ('1', '1', '9000', '2017/03/31');
insert into salary (id, employee_id, amount, pay_date) values ('2', '2', '6000', '2017/03/31');
insert into salary (id, employee_id, amount, pay_date) values ('3', '3', '10000', '2017/03/31');
insert into salary (id, employee_id, amount, pay_date) values ('4', '1', '7000', '2017/02/28');
insert into salary (id, employee_id, amount, pay_date) values ('5', '2', '6000', '2017/02/28');
insert into salary (id, employee_id, amount, pay_date) values ('6', '3', '8000', '2017/02/28');
Truncate table employee;
insert into employee (employee_id, department_id) values ('1', '1');
insert into employee (employee_id, department_id) values ('2', '2');
insert into employee (employee_id, department_id) values ('3', '2');


SELECT
    pay_month,
    department_id,
    CASE 
        WHEN avg_depart > avg_company THEN 'higher'
        WHEN avg_depart = avg_company THEN 'same'
        WHEN avg_depart < avg_company THEN 'lower'
    END as comparison
FROM
(
    SELECT
        DISTINCT LEFT(s.pay_date,7) AS pay_month,
        e.department_id AS department_id,
        AVG(amount) OVER(PARTITION BY LEFT(s.pay_date,7), e.department_id) AS avg_depart,
        AVG(amount) OVER(PARTITION BY LEFT(s.pay_date,7)) AS avg_company
    FROM
        salary s JOIN employee e
    ON
        s.employee_id = e.employee_id
    
) a;



SELECT
        DISTINCT LEFT(s.pay_date,7) AS pay_month,
        e.department_id AS department_id,
        AVG(amount) OVER(PARTITION BY LEFT(s.pay_date,7), e.department_id) AS avg_depart,
        AVG(amount) OVER(PARTITION BY LEFT(s.pay_date,7)) AS avg_company
    FROM
        salary s JOIN employee e
    ON
        s.employee_id = e.employee_id;