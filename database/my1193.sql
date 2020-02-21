DROP TABLE IF EXISTS Transactions ;
create table if not exists Transactions (id int, country varchar(4), state enum('approved', 'declined'), amount int, trans_date date);
Truncate table Transactions;
insert into Transactions (id, country, state, amount, trans_date) values ('121', 'US', 'approved', '1000', '2018-12-18');
insert into Transactions (id, country, state, amount, trans_date) values ('122', 'US', 'declined', '2000', '2018-12-19');
insert into Transactions (id, country, state, amount, trans_date) values ('123', 'US', 'approved', '2000', '2019-01-01');
insert into Transactions (id, country, state, amount, trans_date) values ('124', 'DE', 'approved', '2000', '2019-01-07');



select date_format(trans_date, '%Y-%m') as month, country,
count(*) as trans_count, sum(ifnull(state= 'approved',0)) as approved_count, 
sum(amount) as tran_total, sum(case when state = 'approved' then amount else 0 end) as approve_amount
from transactions
group by month, country;