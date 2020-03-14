USE leetcode;
DROP TABLE IF EXISTS Queue ;

Create table If Not Exists Queue (person_id int, person_name varchar(30), weight int, turn int);
Truncate table Queue;
insert into Queue (person_id, person_name, weight, turn) values ('5', 'George Washington', '250', '1');
insert into Queue (person_id, person_name, weight, turn) values ('4', 'Thomas Jefferson', '175', '5');
insert into Queue (person_id, person_name, weight, turn) values ('3', 'John Adams', '350', '2');
insert into Queue (person_id, person_name, weight, turn) values ('6', 'Thomas Jefferson', '400', '3');
insert into Queue (person_id, person_name, weight, turn) values ('1', 'James Elephant', '500', '6');
insert into Queue (person_id, person_name, weight, turn) values ('2', 'Will Johnliams', '200', '4');

select temp.person_name
from(
select t1.*,
sum(weight) over (order by turn) as total_weight
from  Queue t1) temp
where total_weight >=1000
order by turn asc limit 1;



###
#The maximum weight the elevator can hold is 1000.
#Write an SQL query to find the person_name of the last person who will fit in the elevator without exceeding the weight limit. It is guaranteed that the person who is first in the queue can fit in the elevator.
#The query result format is in the following example:
###

select person_name
from
(select *,
sum(weight) over w as total_weight
from Queue
window w as ( order by turn))t
where total_weight <= 1000
order by total_weight desc
Limit 1;