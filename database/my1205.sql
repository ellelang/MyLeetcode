DROP TABLE IF EXISTS Transactions ;
DROP TABLE IF EXISTS Chargebacks;

create table if not exists Transactions (id int, country varchar(4), state enum('approved', 'declined'), amount int, trans_date date);
create table if not exists Chargebacks (trans_id int, trans_date date);
Truncate table Transactions;
insert into Transactions (id, country, state, amount, trans_date) values ('101', 'US', 'approved', '1000', '2019-05-18');
insert into Transactions (id, country, state, amount, trans_date) values ('102', 'US', 'declined', '2000', '2019-05-19');
insert into Transactions (id, country, state, amount, trans_date) values ('103', 'US', 'approved', '3000', '2019-06-10');
insert into Transactions (id, country, state, amount, trans_date) values ('104', 'US', 'declined', '4000', '2019-06-13');
insert into Transactions (id, country, state, amount, trans_date) values ('105', 'US', 'approved', '5000', '2019-06-15');
Truncate table Chargebacks;
insert into Chargebacks (trans_id, trans_date) values ('102', '2019-05-29');
insert into Chargebacks (trans_id, trans_date) values ('101', '2019-06-30');
insert into Chargebacks (trans_id, trans_date) values ('105', '2019-09-18');

# Write an SQL query to find for each month and country, the number of approved transactions and their total amount, the number of chargebacks and their total amount.
#Note: In your query, given the month and country, ignore rows with all zeros.


SELECT 
    LEFT(trans_date, 7) AS month, 
    country, 
    SUM(state = "approved") AS approved_count, 
    SUM(IF(state = "approved", amount, 0)) AS approved_amount, 
    SUM(state = "chargebacks") AS chargeback_count, 
    SUM(IF(state = "chargebacks", amount, 0)) AS chargeback_amount
FROM ((SELECT * FROM Transactions WHERE state = "approved") 
      UNION ALL
      (SELECT a.id, country, "chargebacks" AS state, amount, b.trans_date 
       FROM Transactions a 
       RIGHT JOIN Chargebacks b ON a.id = b.trans_id)) c
GROUP BY LEFT(trans_date, 7), country; 

