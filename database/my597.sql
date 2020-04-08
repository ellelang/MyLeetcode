Create table If Not Exists friend_request ( sender_id INT NOT NULL, send_to_id INT NULL, request_date DATE NULL);
Create table If Not Exists request_accepted ( requester_id INT NOT NULL, accepter_id INT NULL, accept_date DATE NULL);
Truncate table friend_request;
insert into friend_request (sender_id, send_to_id, request_date) values ('1', '2', '2016/06/01');
insert into friend_request (sender_id, send_to_id, request_date) values ('1', '3', '2016/06/01');
insert into friend_request (sender_id, send_to_id, request_date) values ('1', '4', '2016/06/01');
insert into friend_request (sender_id, send_to_id, request_date) values ('2', '3', '2016/06/02');
insert into friend_request (sender_id, send_to_id, request_date) values ('3', '4', '2016/06/09');
Truncate table request_accepted;
insert into request_accepted (requester_id, accepter_id, accept_date) values ('1', '2', '2016/06/03');
insert into request_accepted (requester_id, accepter_id, accept_date) values ('1', '3', '2016/06/08');
insert into request_accepted (requester_id, accepter_id, accept_date) values ('2', '3', '2016/06/08');
insert into request_accepted (requester_id, accepter_id, accept_date) values ('3', '4', '2016/06/09');
insert into request_accepted (requester_id, accepter_id, accept_date) values ('3', '4', '2016/06/10');


select ifnull(round(count(distinct r1.requester_id,r1.accepter_id)/count(distinct f1.send_to_id,f1.sender_id),2),0) as 'accept_rate'
from friend_request f1
inner join
request_accepted r1
on f1.sender_id = r1.requester_id;

select round(count(distinct c.requester_id, accepter_id)/count(distinct c.sender_id, c.send_to_id),2) as accept_rate from
(select a.requester_id, a.accepter_id, b.sender_id, b.send_to_id 
from request_accepted a
right join friend_request b
on a.requester_id=b.sender_id and a.accepter_id=b.send_to_id) c;


select
round(
    ifnull(
    (select count(*) from (select distinct requester_id, accepter_id from request_accepted) as A)
    /
    (select count(*) from (select distinct sender_id, send_to_id from friend_request) as B),
    0)
, 2) as accept_rate;

SELECT ROUND( 
    IFNULL(
        (SELECT COUNT(*) FROM (SELECT DISTINCT requester_id, accepter_id FROM request_accepted) as A)/(SELECT COUNT(*) FROM (SELECT DISTINCT sender_id, send_to_id FROM friend_request) as B),
    0),
2) as accept_rate;
# first one
select round(coalesce(1.0* (select count(distinct requester_id, accepter_id) from request_accepted)/
(select count(distinct sender_id, send_to_id) from friend_request), 0.0),2) as accept_rate;

# second one
select  coalesce(round(1.0*acnt/scnt,2),0.0) as accept_rate, b.smonth as month
from
(select count(distinct requester_id, accepter_id) as acnt, month(accept_date) as amonth
from request_accepted
group by 2) a
join
(select count(distinct sender_id, send_to_id) as scnt, month(request_date) as smonth
from friend_request
group by 2) b
on a.amonth=b.smonth;

# third one
select round(coalesce(1.0*count(distinct requester_id, accepter_id)/count(distinct sender_id, send_to_id),0.0),2) as accept_rate, rate_date
from
(select distinct accept_date as rate_date
from request_accepted
union
select distinct request_date as rate_date
from friend_request) dt
left join request_accepted ra
on dt.rate_date >= ra.accept_date
left join friend_request fr
on dt.rate_date >= fr.request_date
group by 2;

# Follow-up 1: return the accept rate for every month
SELECT IF(req.req = 0, 0.00, round(acp.acp / req.req, 2)) AS accept_rate, acp.month 
FROM (SELECT COUNT(DISTINCT requester_id, accepter_id) AS acp, Month(accept_date) AS month FROM request_accepted) acp
  LEFT JOIN  (SELECT COUNT(DISTINCT sender_id, send_to_id) AS req, Month(request_date) AS month FROM friend_request) req 
ON acp.month = req.month 
GROUP BY acp.month;

# Follow-up 2: return the cumulative accept rate for every day
# Without null check
SELECT ROUND(
    COUNT(DISTINCT requester_id, accepter_id) / COUNT(DISTINCT sender_id, send_to_id), 2
) AS rate, date_table.dates

FROM request_accepted acp, friend_request req, 
(SELECT request_date AS dates FROM friend_request
UNION
SELECT accept_date FROM request_accepted
ORDER BY dates) as date_table

WHERE acp.accept_date <= date_table.dates
AND req.request_date <= date_table.dates
GROUP BY date_table.dates;


SELECT ROUND(
    COUNT(DISTINCT requester_id, accepter_id) / COUNT(DISTINCT sender_id, send_to_id), 2
) AS rate
FROM request_accepted acp, friend_request req;