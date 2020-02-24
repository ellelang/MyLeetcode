DROP TABLE IF EXISTS  Queries ;
Create table If Not Exists Queries (query_name varchar(30), result varchar(50), position int, rating int);
Truncate table Queries;
insert into Queries (query_name, result, position, rating) values ('Dog', 'Golden Retriever', '1', '5');
insert into Queries (query_name, result, position, rating) values ('Dog', 'German Shepherd', '2', '5');
insert into Queries (query_name, result, position, rating) values ('Dog', 'Mule', '200', '1');
insert into Queries (query_name, result, position, rating) values ('Cat', 'Shirazi', '5', '2');
insert into Queries (query_name, result, position, rating) values ('Cat', 'Siamese', '3', '3');
insert into Queries (query_name, result, position, rating) values ('Cat', 'Sphynx', '7', '4');

# We define query quality as: The average of the ratio between query rating and its position.
# We also define poor query percentage as: The percentage of all queries with rating less than 3.
#Write an SQL query to find each query_name, the quality and poor_query_percentage.
#Both quality and poor_query_percentage should be rounded to 2 decimal places

with cte1 as
(select *, rating / position as ratio_q, 
if(rating< 3, 1,0) as poor
from Queries)
select query_name, round(avg(ratio_q),2) as quality, 
round(sum(poor)/count(poor) ,2) as poor_query_percentage
from cte1
group by query_name;