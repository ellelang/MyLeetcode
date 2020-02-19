CREATE TABLE IF NOT EXISTS insurance (PID INTEGER(11), TIV_2015 NUMERIC(15,2), TIV_2016 NUMERIC(15,2), LAT NUMERIC(5,2), LON NUMERIC(5,2) );
Truncate table insurance;
insert into insurance (PID, TIV_2015, TIV_2016, LAT, LON) values ('1', '10', '5', '10', '10');
insert into insurance (PID, TIV_2015, TIV_2016, LAT, LON) values ('2', '20', '20', '20', '20');
insert into insurance (PID, TIV_2015, TIV_2016, LAT, LON) values ('3', '10', '30', '20', '20');
insert into insurance (PID, TIV_2015, TIV_2016, LAT, LON) values ('4', '10', '40', '40', '40');


select count(pid) over (partition by lat,lon) ctl, 
count(pid) over (partition by tiv_2015) ctt, 
TIV_2016 from insurance;


with cte1 as (
select count(pid) over (partition by lat,lon) ctl, 
count(pid) over (partition by tiv_2015) ctt, TIV_2016 from insurance
), 

cte2 as (
select TIV_2016 from cte1 where ctl = 1 and ctt >= 2
)
select sum(TIV_2016) TIV_2016 from cte2;