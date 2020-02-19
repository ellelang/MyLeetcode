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



