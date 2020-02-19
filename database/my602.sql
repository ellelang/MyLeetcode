DROP TABLE IF EXISTS request_accepted;
Create table If Not Exists request_accepted ( requester_id INT NOT NULL, accepter_id INT NULL, accept_date DATE NULL);
Truncate table request_accepted;
insert into request_accepted (requester_id, accepter_id, accept_date) values ('1', '2', '2016/06/03');
insert into request_accepted (requester_id, accepter_id, accept_date) values ('1', '3', '2016/06/08');
insert into request_accepted (requester_id, accepter_id, accept_date) values ('2', '3', '2016/06/08');
insert into request_accepted (requester_id, accepter_id, accept_date) values ('3', '4', '2016/06/09');

select id, sum(num) as num
from 
(select requester_id as id, count(accepter_id) as num
from request_accepted 
group by requester_id
UNION ALL
select accepter_id as id, count(requester_id) as num
from request_accepted 
group by accepter_id)t
group by id
order by sum(num) DESC LIMIT 1;


select requester_id as id, count(accepter_id) as num
from request_accepted 
group by requester_id
UNION ALL
select accepter_id as id, count(requester_id) as num
from request_accepted 
group by accepter_id;

SELECT A.ids AS id,
       COUNT(*) AS num
FROM (
    SELECT requester_id AS ids
    FROM request_accepted

    # union all does not remove duplicate
    UNION ALL

    SELECT accepter_id
    FROM request_accepted) AS A
GROUP BY A.ids
ORDER BY COUNT(*) DESC
LIMIT 1