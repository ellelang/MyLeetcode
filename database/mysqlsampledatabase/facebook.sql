DROP TABLE IF EXISTS friend_request ;
DROP TABLE IF EXISTS request_accepted;
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

# How is the overall friending acceptance rate changing over time? 
with cte1 as(
select distinct requester_id, accepter_id
from request_accepted),
cte2 as (
SELECT distinct sender_id, send_to_id 
FROM friend_request)

select 
round(ifnull((select count(*) from cte1 )/(select count(*) from cte2),0),2) as accepte_rate;


select if(d.req =0, 0.00, round(c.acp/d.req,2)) as accept_rate, c.month from 
(select count(distinct requester_id, accepter_id) as acp, Month(accept_date) as month from request_accepted) c, 
(select count(distinct sender_id, send_to_id) as req, Month(request_date) as month from friend_request) d 
where c.month = d.month 
group by c.month;


# Define how long you have to wait before a friend request is considered rejected (e.g. 1 week) 
with cte1 as
(select distinct requester_id, accepter_id,  accept_date
from request_accepted),
cte2 as (
SELECT distinct sender_id, send_to_id, request_date
FROM friend_request),
cte3 as(
select cte1.*, cte2.*
from cte1 
right join cte2
on cte1.requester_id = cte2.sender_id
and cte1.accepter_id = cte2.send_to_id)

select 
(select count(requester_id)
from cte3
where accepter_id is null 
OR datediff(accept_date,request_date) >=7)/(select count(request_date) from cte3) as reject_rate;


DROP TABLE IF EXISTS friending;
Create table If Not Exists friending (ds DATE NULL,  action_stat varchar(64) NOT NULL, actor_uid INT NOT NULL, target_uid INT NULL);
Truncate table friending;
insert into friending (ds, action_stat, actor_uid,  target_uid) values ('2016/06/01', 'send_request', '1', '2');
insert into friending (ds, action_stat, actor_uid,  target_uid) values ('2016/06/02','send_request','1', '3');
insert into friending (ds, action_stat, actor_uid,  target_uid) values ('2016/06/02','send_request','4', '1');
insert into friending(ds, action_stat, actor_uid,  target_uid) values ('2016/06/08', 'send_request', '2', '3');
insert into friending(ds, action_stat, actor_uid,  target_uid) values ('2016/06/10','accept_request', '3', '4');
insert into friending(ds, action_stat, actor_uid,  target_uid) values ('2016/06/02', 'accept_request', '3', '1');
insert into friending(ds, action_stat, actor_uid,  target_uid) values ('2016/06/03','accept_request', '2', '1');
insert into friending (ds, action_stat, actor_uid,  target_uid) values ('2016/06/17', 'accept_request', '1', '4');
insert into friending (ds, action_stat, actor_uid,  target_uid) values ('2016/06/10', 'unfriend', '2', '4');


/* Q1: How is the overall friending acceptance rate changing over time? */  


SELECT ds,
       AVG(acceptance) AS acce_rate
FROM
(SELECT a.ds AS dates,
        CASE WHEN b.action='accept_request' THEN 1 ELSE 0 END AS acceptance
FROM friending a
LEFT JOIN friending b
ON a.action='send_request' AND a.actor_uid=b.target_uid AND a.target_uid=b.actor_uid) temp
ORDER BY dates;


/* Q2: Who has the most number of friends?*/
select ids as id, cnt as num
from(
select ids, count(*) as cnt
from(
select requester_id as ids from request_accepted
union all
select accepter_id as ids from request_accepted) tb1
group by ids) tb2
order by cnt desc
limit 1;

DROP TABLE IF EXISTS stories;
CREATE TABLE stories (
  
  date_time varchar(20),
  user_id int,
  content_id int,
  content_type varchar(20),
  target_id int
);
  
INSERT INTO stories VALUES ("Jan-1",1, 1,"post",NULL);
INSERT INTO stories VALUES ("Jan-1",1, 2,"comment",1);
INSERT INTO stories VALUES ("Jan-2",2, 3,"comment",2);
INSERT INTO stories VALUES ("Jan-3",3, 4,"comment",2);
INSERT INTO stories VALUES ("Jan-4",6, 5,"video",NULL);
INSERT INTO stories VALUES ("Jan-1",7, 6,"comment",5);
INSERT INTO stories VALUES ("Jan-2",8, 7,"comment",6);

# Question: find the distribution of stories based on comment count
select *
from stories;
