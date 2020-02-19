Create table If Not Exists Numbers (Number int, Frequency int);
Truncate table Numbers;
insert into Numbers (Number, Frequency) values ('0', '7');
insert into Numbers (Number, Frequency) values ('1', '1');
insert into Numbers (Number, Frequency) values ('2', '3');
insert into Numbers (Number, Frequency) values ('3', '1');

SELECT * FROM NUMBERS;

SELECT number,
sum(frequency) over (ORDER BY number ROWS UNBOUNDED PRECEDING) as upper_frequency
from Numbers;

select sum(frequency) as tot_freq 
from Numbers;

select *, LAG(upper_frequency,1,0)over (ORDER BY number) as lower_frequency
from 
(SELECT number,
sum(frequency) over (ORDER BY number ROWS UNBOUNDED PRECEDING) as upper_frequency
from Numbers) as temp;


select avg(number)
from (
select *, LAG(upper_frequency,1,0)over (ORDER BY number) as lower_frequency,
floor(tot_freq/2) as floor_tot, ceil(tot_freq/2) as ceil_tot
from 
(SELECT number,
sum(frequency) over (ORDER BY number ROWS UNBOUNDED PRECEDING) as upper_frequency
from Numbers) as temp, 
(select sum(frequency) as tot_freq 
from Numbers) as temp1
) as temp3
WHERE floor_tot between lower_frequency and upper_frequency
or ceil_tot between lower_frequency and upper_frequency;