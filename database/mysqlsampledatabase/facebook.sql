use leetcode;
DROP TABLE IF EXISTS region_company;
CREATE TABLE If Not Exists region_company ( Country varchar(50), Region varchar(50), Sales int );
INSERT INTO region_company (Country, Region, Sales)  VALUES ('Canada', 'Alberta', 100);
INSERT INTO region_company (Country, Region, Sales)  VALUES ('Canada', 'British Columbia', 200);
INSERT INTO region_company (Country, Region, Sales)  VALUES ('Canada', 'British Columbia', 300);
INSERT INTO region_company (Country, Region, Sales)  VALUES ('United States', 'Montana', 100);

SELECT Country, Region, AVG(sales) AS avg_sales
FROM  region_company
GROUP BY Country, Region WITH ROLLUP;

SELECT IF(GROUPING (Country), 'whole_country', Country) as Country,
IF(GROUPING (Region), 'whole_region', Region) as Region,
AVG(sales) as avg_sales
FROM region_company
GROUP BY Country, Region WITH ROLLUP;


DROP TABLE IF EXISTS instagram;
CREATE TABLE If Not Exists instagram ( dates DATE, caller_id INT, receiver_id INT, duration float, caller_country VARCHAR(32),  receiver_country VARCHAR(32) );
INSERT INTO instagram (dates, caller_id,  receiver_id,duration, caller_country , receiver_country)  VALUES ('2018-05-21', 1234, 7567, 63.4, 'ES', 'ES');
INSERT INTO instagram (dates, caller_id,  receiver_id,duration, caller_country , receiver_country)  VALUES ('2018-05-12',1234, 3669, 50.8,'ES', 'ES');
INSERT INTO instagram (dates, caller_id,  receiver_id,duration, caller_country , receiver_country)  VALUES ('2018-05-08', 1234, 8998, 0.0, 'ES', 'PT');
INSERT INTO instagram (dates, caller_id,  receiver_id,duration, caller_country , receiver_country)  VALUES ('2018-05-08', 7567, 1234, 63.4, 'ES', 'ES');

WITH cte1 as(
SELECT dates, caller_id as uid
FROM instagram
UNION
SELECT dates, receiver_id as uid
FROM instagram),

cte2 as(
SELECT uid, MIN(dates) as first_day
FROM cte1
GROUP BY uid
HAVING MIN(dates) = '2018-05-08')

SELECT 
DATEDIFF(cte1.dates, '2018-05-08') as X_DAY,
COUNT(DISTINCT cte1.uid) as cnt_users
FROM cte1
LEFT JOIN cte2
ON cte1.uid = cte2.uid
GROUP BY X_DAY
ORDER BY X_DAY;




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
insert into friending (ds, action_stat, actor_uid,  target_uid) values ('2016/06/03','send_request','2', '4');
insert into friending (ds, action_stat, actor_uid,  target_uid) values ('2016/06/02','send_request','4', '1');
insert into friending(ds, action_stat, actor_uid,  target_uid) values ('2016/06/08', 'send_request', '2', '3');
insert into friending(ds, action_stat, actor_uid,  target_uid) values ('2016/06/10','accept_request', '3', '4');
insert into friending (ds, action_stat, actor_uid,  target_uid) values ('2016/06/08','accept_request','4', '2');
insert into friending(ds, action_stat, actor_uid,  target_uid) values ('2016/06/02', 'accept_request', '3', '1');
insert into friending(ds, action_stat, actor_uid,  target_uid) values ('2016/06/02','accept_request', '2', '1');
insert into friending (ds, action_stat, actor_uid,  target_uid) values ('2016/06/17', 'accept_request', '1', '4');
insert into friending (ds, action_stat, actor_uid,  target_uid) values ('2016/06/10', 'unfriend', '2', '4');

SELECT tb1.ds, tb1.actor_uid as sendid, tb1.target_uid as wait_id, tb2.actor_uid as acceptid, tb2.ds as backds
FROM  friending tb1
LEFT JOIN friending tb2
ON tb1.target_uid = tb2.actor_uid
WHERE  tb1.action_stat = 'send_request';


SELECT ds, count(DISTINCT actor_uid) + COUNT(DISTINCT target_uid) as cnt_num
FROM(
SELECT ds, actor_uid, target_uid 
FROM friending tb1
WHERE action_stat = 'accept_request') t
GROUP BY ds
ORDER BY ds;

SELECT B.ds, COUNT(DISTINCT B.actor_uid) 
FROM(
(SELECT ds, actor_uid, target_uid
FROM friending
WHERE action_stat='send_request'
) A
JOIN
(SELECT ds, actor_uid, target_uid
FROM friending
WHERE action_stat='accept_request'
) B
ON A.target_uid=B.actor_uid and A.actor_uid = B.target_uid)
GROUP BY B.ds;


WITH send_accept as (
SELECT actor_uid as id1, target_uid as id2
FROM friending
WHERE action_stat = 'send_request'
UNION
SELECT actor_uid as id1, target_uid as id2
FROM friending
WHERE action_stat = 'accept_request'),

unfriend as
(SELECT actor_uid as id1, target_uid as id2
FROM friending
WHERE action_stat = 'unfriend'),

except_unfriend as (
SELECT A.* 
FROM send_accept A
LEFT JOIN  unfriend B
ON (A.id1  = B.id1 AND A.id2 = B.id2) or (A.id2  = B.id1 AND A.id1 = B.id2)
WHERE B. id2 IS NULL)

SELECT id1, COUNT(DISTINCT id2) AS cnt_friend
FROM except_unfriend
GROUP BY id1;


SELECT id1, COUNT(DISTINCT id2) as cnt_friend
FROM send_accept
GROUP BY id1;


/* Q1: How is the overall friending acceptance rate changing over time? */  
select *,
sum(if(action_stat = 'accept_request',1,0))/count(ds) as acc_cnt
from friending
group by ds
order by ds asc;

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

SELECT A.actor_uid,
COUNT(DISTINCT B.actor_uid) as friend_cnt
FROM
(
SELECT actor_uid, target_uid
FROM friending
WHERE action_stat='sent_request'
AND (actor_uid, target_uid) NOT IN
(
SELECT actor_uid, target_uid
FROM friending
WHERE action_stat='unfriend'
)
) A
JOIN
(
SELECT actor_uid, target_uid
FROM friending
WHERE action_stat='accept_request'
AND (actor_uid, target_uid) NOT IN
(
SELECT actor_uid, target_uid
FROM friending
WHERE action_stat='unfriend'
)
) B ON A.actor_uid=B.target_uid AND A.target_uid=B.actor_uid;











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
INSERT INTO stories VALUES ("Jan-2",2, 3,"photo",2);
INSERT INTO stories VALUES ("Jan-3",3, 4,"comment",2);
INSERT INTO stories VALUES ("Jan-4",6, 5,"video",NULL);
INSERT INTO stories VALUES ("Jan-1",7, 6,"comment",5);
INSERT INTO stories VALUES ("Jan-2",8, 7,"comment",6);


# Question: find the distribution of stories based on comment count
WITH story_tb AS
(SELECT content_id as story_id
FROM stories
WHERE content_type IN ('photo', 'post' ,'video')),

cte2 as (
SELECT story_id, 
SUM(IF(tb1.target_id IS NULL,0,1)) AS cnt_comment
FROM story_tb
LEFT JOIN stories tb1
ON story_tb.story_id = tb1.target_id
GROUP BY story_id)

SELECT cnt_comment, COUNT(DISTINCT story_id ) as freq
FROM cte2
GROUP BY cnt_comment;

-- Q4: Percent of post having at least one comment
WITH post_tb AS(
SELECT content_id as post_id
FROM stories
WHERE content_type = 'post'),

cte2 as
(SELECT post_id,
IF(tb1.content_type = 'comment',1,0) as comments
FROM post_tb
LEFT JOIN stories tb1
ON post_id = tb1.target_id),

cte3 as(
SELECT post_id, SUM(comments) as cnts
FROM cte2
GROUP BY post_id)


SELECT
SUM(IF(cte3.cnts >= 1,1,0)) / COUNT(*) AS p_five_comments
FROM cte3;


-- SELECT SUM(case when comments >0 then 1 else 0 end)/count(*) as pnc
-- FROM cte2;

/*cte3 as(
SELECT post_id, SUM(comments)
FROM cte2
GROUP BY post_id
HAVING SUM(comments) >= 1)*/







-- select * from cte2;



select content_type, count(content_type)/(select count(*) from stories) as cnt
from stories
group by content_type;


DROP TABLE IF EXISTS Ads;
Create table If Not Exists Ads (ad_id int, user_id int, action ENUM('Clicked', 'Viewed', 'Ignored'));
Truncate table Ads;
insert into Ads (ad_id, user_id, action) values ('1', '1', 'Clicked');
insert into Ads (ad_id, user_id, action) values ('2', '2', 'Clicked');
insert into Ads (ad_id, user_id, action) values ('3', '3', 'Viewed');
insert into Ads (ad_id, user_id, action) values ('5', '5', 'Ignored');
insert into Ads (ad_id, user_id, action) values ('1', '7', 'Ignored');
insert into Ads (ad_id, user_id, action) values ('2', '7', 'Viewed');
insert into Ads (ad_id, user_id, action) values ('3', '5', 'Clicked');
insert into Ads (ad_id, user_id, action) values ('1', '4', 'Viewed');
insert into Ads (ad_id, user_id, action) values ('2', '11', 'Viewed');
insert into Ads (ad_id, user_id, action) values ('1', '2', 'Clicked');

select * from Ads;

select ad_id,
round(ifnull(100*sum(if(action = 'Clicked',1,0))/sum(if( action = 'Clicked' or action = 'Viewed', 1,0)),0),2) as total_ctr
from Ads
group by ad_id
order by ad_id asc;

select t.ad_id from 
(
select ad_id,
round(ifnull(100*sum(if(action = 'Clicked',1,0))/sum(if( action = 'Clicked' or action = 'Viewed', 1,0)),0),2) as total_ctr
from Ads
group by ad_id
order by total_ctr) t where t.ad_id not in (
Select ad_id 
from Ads
where user_id = 2 and action = 'Clicked');

select user_id, 
round(ifnull(sum(if(action = 'Clicked',1,0))/sum(if(action = 'Clicked',1,0)) + sum(if(action = 'Viewed',1,0)),0),2) as cnt_user
from Ads
group by user_id;

#Leetcode 1113

DROP TABLE IF EXISTS Actions;
Create table If Not Exists Actions (user_id int, post_id int, action_date date, action ENUM('view', 'like', 'reaction', 'comment', 'report', 'share'), extra varchar(10));
Truncate table Actions;
insert into Actions (user_id, post_id, action_date, action, extra) values ('1', '1', '2019-07-01', 'view', 'None');
insert into Actions (user_id, post_id, action_date, action, extra) values ('1', '1', '2019-07-01', 'like', 'None');
insert into Actions (user_id, post_id, action_date, action, extra) values ('1', '1', '2019-07-01', 'share', 'None');
insert into Actions (user_id, post_id, action_date, action, extra) values ('2', '4', '2019-07-04', 'view', 'None');
insert into Actions (user_id, post_id, action_date, action, extra) values ('2', '4', '2019-07-04', 'report', 'spam');
insert into Actions (user_id, post_id, action_date, action, extra) values ('3', '4', '2019-07-04', 'view', 'None');
insert into Actions (user_id, post_id, action_date, action, extra) values ('3', '4', '2019-07-04', 'report', 'spam');
insert into Actions (user_id, post_id, action_date, action, extra) values ('4', '3', '2019-07-02', 'view', 'None');
insert into Actions (user_id, post_id, action_date, action, extra) values ('4', '3', '2019-07-02', 'report', 'spam');
insert into Actions (user_id, post_id, action_date, action, extra) values ('5', '2', '2019-07-04', 'view', 'None');
insert into Actions (user_id, post_id, action_date, action, extra) values ('5', '2', '2019-07-04', 'report', 'racis
m');
insert into Actions (user_id, post_id, action_date, action, extra) values ('5', '5', '2019-07-04', 'view', 'None');
insert into Actions (user_id, post_id, action_date, action, extra) values ('5', '5', '2019-07-04', 'report', 'racism');

# how many posts were reported yesterday for each report reason？ '2019-07-05' is the current date
select extra, count(distinct post_id)
from actions
where action = 'report' and datediff('2019-07-05', action_date) =1
group by extra;

# Introduce a new table: reviewer_removals, please calculate what percent of daily
# content that users view on FB is actually spam?

select *
from actions;

select action_date,
sum(if(extra = 'spam',1,0))/sum(if(action = 'view',1,0)) as view_spam
from actions
group by action_date;


DROP TABLE IF EXISTS traffic_v;
CREATE TABLE IF NOT EXISTS traffic_v(
    date_time TIMESTAMP,
    volume INT,
    platform TEXT,
    country TEXT);
    
INSERT INTO traffic_v  VALUES
    ('2017-01-01 00:00:00',231,'iOS','Finland'),
    ('2017-01-01 00:00:00',446,'iOS','Belgium'),
    ('2017-01-01 00:00:00',353,'iOS','Italy'),
    ('2017-01-01 00:00:00',342,'Android','Finland'),
    ('2017-01-01 00:00:00',468,'Android','Belgium'),
    ('2017-01-01 00:00:00',296,'Android','Italy'),
    ('2017-01-02 00:00:00',461,'iOS','Finland'),
    ('2017-01-02 00:00:00',382,'iOS','Belgium'),
    ('2017-01-02 00:00:00',357,'iOS','Italy'),
    ('2017-01-02 00:00:00',224,'Android','Finland'),
    ('2017-01-02 00:00:00',216,'Android','Belgium'),
    ('2017-01-02 00:00:00',331,'Android','Italy');



select date_time, diff
from 
(select date_time,
abs(ifnull(total_v - lag(total_v,1)over (partition by date_time order by platform),0)) as diff
from (select date_time, platform, sum(volume) as total_v
from traffic_v 
group by date_time, platform) temp1) temp2
where temp2.diff !=0;

select temp1.date_time, total_v,
total_v - lag(total_v,1) over(partition by date_time order by country) as diff_lag_1,
total_v - lag(total_v,2) over(partition by date_time order by country) as diff_lag_2
from(
select date_time, country, sum(volume) as total_v
from traffic_v
group by date_time, country) temp1 ;


with date_country as
(Select date_time, country, sum(volume) as tot_volume
From traffic_v
Group by date_time, country)
Select a.date_time, a.country, b.country, (a.tot_volume - b.tot_volume) as diff
From date_country a
Join date_country b
On a.date_time = b.date_time
And a.country < b.country
Order by date_time;


DROP TABLE IF EXISTS cus;
CREATE TABLE IF NOT EXISTS cus(
    ds DATE,
    cus_id TEXT,
    count INT);
    
INSERT INTO cus  VALUES
    ('2019-12-01','c1',0),
    ('2019-12-02','c1',1),
    ('2019-12-03','c2',1),
	('2019-12-09','c2',2);
    
select a.ds, count(distinct b.cus_id)
From cus a 
left join cus b
On a.ds - b.ds between 1 and 7
Group by a.ds
Order by a.ds;

select ds, 
count(cus_id) over (order by ds range between interval '7' day preceding and current row) as running_count 
from cus;

DROP TABLE IF EXISTS searches;
CREATE TABLE IF NOT EXISTS searches(
    dates DATE,
    search_id  INT,
    user_id INT,
    age_group TEXT,
    search_query varchar(64));
    
INSERT INTO searches  VALUES
    ('2020-01-01',101,9991,'U30','michael jackson'),
    ('2020-01-01',102,9991,'U30','menlon park'),
    ('2020-01-01',103,5555,'30-50','john'),
	('2019-01-01',104,1234,'50+','funny dogs');
    
DROP TABLE IF EXISTS search_results;
CREATE TABLE IF NOT EXISTS search_results(
    dates DATE,
    search_id  INT,
    result_id INT,
    result_type TEXT,
    clicked boolean);
    
INSERT INTO search_results  VALUES
    ('2020-01-01',101,1001,'page',TRUE),
    ('2020-01-01',101,1002,'event',FALSE),
    ('2020-01-01',101,1003,'event',FALSE),
	('2020-01-01',101,1004,'group',FALSE),
    ('2020-01-02',102,1005,'page',TRUE),
    ('2020-01-02',102,1006,'event',FALSE),
	('2020-01-02',102,1007,'group',FALSE);
    
    
SELECT age_group, count(distinct user_id) as search_john
FROM searches
where search_query = 'john' AND
  datediff('2020-01-07',dates)<=7
group by age_group; 

SELECT search_id, likeli_event
from(
SELECT search_id, ifnull(sum(if(result_type = 'event', 1,0))/count(result_type),0) as likeli_event
FROM search_results
group by search_id) t
order by likeli_event;

with cte1 as(
SELECT t1.search_id, t1.search_query, t2.result_type
FROM searches t1
LEFT JOIN search_results t2
ON t1.search_id = t2.search_id)

select search_id, count(*) as cnt
from cte1
where result_type = 'event'
group by cte1.search_query
order by cnt desc;


# In the last 7 days, how many users conducted more than 10 searches?


select user_id, count(search_id) as cnt_search
from searches
where datediff( '2020-01-07',dates)<=7
group by user_id
having cnt_search >= 2;

SELECT SUM(CASE WHEN cnt_result >=2 THEN 1 ELSE 0 END)/COUNT(*) as percent
FROM(
SELECT s.user_id, count(result_id) as cnt_result
FROM searches s
LEFT JOIN search_results r
ON s.search_id = r.search_id
GROUP BY s.user_id) tmp;




# how many users conducted searches that lead to multiple result_type?
select t1.user_id, count(distinct t2.result_type) as cnt_type
from searches t1
left join  search_results t2
on t1.search_id = t2.search_id
group by t1.user_id
having cnt_type >1;


DROP TABLE IF EXISTS composer;
CREATE TABLE IF NOT EXISTS composer(
    user_id INT,
    dates DATE,
    d_events varchar(16));
    
INSERT INTO composer  VALUES
    (101, '2020-01-01','post'),
    (102, '2020-01-03','exist'),
    (101, '2020-01-05','enter'),
	(103, '2019-01-02','post'),
    (104, '2019-01-04','enter'),
    (102, '2019-01-01','post'),
    (104, '2019-01-06','exist');
    
DROP TABLE IF EXISTS user;
CREATE TABLE IF NOT EXISTS user(
    user_id INT,
    country varchar(16),
    dau_flag INT);
    
INSERT INTO user  VALUES
    (101, 'USA',1),
    (102, 'USA',0),
    (103, 'AUS',1),
	(104, 'CHN',1);
    
# Q1 what is the post success rate for each day in the last week?

select dates, round(ifnull(sum(case when d_events = 'post' then 1 else 0 end)/ifnull(SUM(CASE WHEN d_events = 'enter' or d_events = 'post' THEN 1 ELSE 0 END),0),0),2) as post_rate
from composer 
where DATEDIFF('2019-01-07', dates) <= 7
group by dates;

# Q2 what is the average number of post per daily active user by country today?



select tc.dates, tc.user_id, round(ifnull(sum(if(tc.d_events = 'post',1,0))/count(tc.dates),0),2) as post_avg
from composer tc
left join user tu
on tc.user_id = tu.user_id
where tu.dau_flag = 1
group by tc.dates, tc.user_id;

DROP TABLE IF EXISTS user_actions;
CREATE TABLE IF NOT EXISTS user_actions(
    dates DATE,
    user_id BIGINT,
    post_id BIGINT,
    action VARCHAR(16),
    extra VARCHAR(64));
    
INSERT INTO user_actions  VALUES
    ( '2020-01-01',1209283021 ,329482048384792 , 'view',NULL),
    ( '2020-01-01',1209283021 ,329482048384792,'like', NULL),
    ( '2020-01-01',1938409273 ,349573908750923, 'reaction', 'LOVE'),
	( '2020-01-01',1209283021 , 329482048384792, 'comment', 'Such nice Raybans'),
    ( '2020-01-01',1238472931 ,329482048384792 ,'report','SPAM'),
    ( '2020-01-01',1298349287, 328472938472087 ,'report','NUDITY'),
    ( '2019-01-01',1238712388 , 329482048384792,'reshare','I want to share with you all');
    
    
DROP TABLE IF EXISTS reviewer_removals;
CREATE TABLE IF NOT EXISTS reviewer_removals(
    dates DATE,
    reviewer_id BIGINT,
    post_id BIGINT);
INSERT INTO reviewer_removals  VALUES
    ( '2020-01-01', 3894729384729078, 329482048384792  ),
    ( '2020-01-01', 8477594743909585, 388573002873499  );
    
# Q1: How many posts were reported yesterday for each report Reason?

select dates, extra, count(distinct extra) as cnt_reason
from user_actions
where action = 'report' and
datediff('2020-01-02', dates) = 1
group by extra;

# Q2: What percent of daily content that users view on Facebook is actually Spam? . 

select tb1.dates,round(ifnull(sum(if(tb2.reviewer_id is not null,1,0))/count(tb1.post_id),0),2) as te
from user_actions tb1
left join reviewer_removals tb2
on tb1.post_id = tb2.post_id
where tb1.action = 'view'
group by tb1.dates;

SELECT u.dates, COUNT(DISTINCT r.post_id)/COUNT(DISTINCT u.post_id) as spam_percentage
FROM user_actions u
LEFT JOIN reviewer_removals r
ON u.post_id = r.post_id
WHERE u.action = 'view'
GROUP BY u.dates;

# Q3: How to find the user who abuses this spam system?
select u1.user_id
from user_actions u1
left join reviewer_removals r1
on u1.post_id = r1.post_id
where u1.extra = 'spam' and r1.post_id is null;

# Q4 What percent of yesterday's content views were on content reported for spam?

SELECT dates, round(ifnull(sum(if (extra = 'SPAM',1,0))/count(extra),0),2) as per_spam
FROM user_actions
WHERE action = 'report' and datediff('2020-01-02', dates) = 1;


DROP TABLE IF EXISTS ad4ad;
CREATE TABLE IF NOT EXISTS ad4ad(
    dates DATE,
    user_id INT,
    ad_event VARCHAR(16),
    unit_id INT,
    cost INT,
    spend INT);
    
INSERT INTO ad4ad  VALUES
    ( '2020-01-01', 101, 'impression', 9991, 300, NULL ),
    ( '2020-01-02', 101, 'click', 9992, 400, NULL),
    ( '2020-01-02', 102, 'create_ad', 9993, 120, 300  ),
    ( '2020-01-03', 101, 'create_ad', 9991, 300, 500 ),
    ( '2020-01-01', 103, 'impression', 9994, 300,NULL),
    ( '2020-01-03', 103, 'create_ad', 9994, 234, 400),
	( '2020-01-03', 104, 'create_ad', 9995, 300, 500 ),
    ( '2020-01-01', 104, 'impression', 9995, 300,NULL),
    ( '2020-01-02', 104, 'click', 9995, 300, NULL),
    ( '2020-01-03', 105, 'create_ad', 9990, 234, NULL);
    
    
DROP TABLE IF EXISTS ad_user;
CREATE TABLE IF NOT EXISTS ad_user(
    user_id INT,
    country VARCHAR(16),
    age VARCHAR(16));

INSERT INTO ad_user  VALUES
    ( 101, 'USA', 'U30'),
    ( 102, 'UK', 'U30'),
    ( 103, 'USA', '40-50'),
    ( 104, 'CAN', '30-40'),
    ( 105, 'CHN', '40-40');
    
# last 30 days, by country, total spend (问的是facebook的spend就是表里的cost） of the product

SELECT t2.country, COUNT(DISTINCT t1.user_id) AS num_users, ifnull(sum(t1.cost),0) as total_cost
FROM ad4ad t1
LEFT JOIN ad_user t2
on t1.user_id = t2.user_id
where datediff('2020-01-15', t1.dates) <= 30
group by t2.country;

# how many impressions before a user create an ad given an unit?
with cte1 as(
SELECT tb1.user_id, tb1.unit_id, tb1.ad_event as allevent, tb2.ad_event as before_event
FROM  ad4ad tb1
LEFT JOIN ad4ad tb2
ON tb1.unit_id = tb2.unit_id AND
tb2.dates <= tb1.dates AND
tb1.ad_event = 'created_ad' and tb2.ad_event = 'impression')

SELECT AVG(cnt_occ) 
FROM(
SELECT unit_id, SUM(IF(allevent = 'impression',1,0)) as cnt_occ
FROM cte1
GROUP BY unit_id, user_id)T;


select avg(t.num_impression) as avg_imp_num
from(
select t1.user_id, t1.unit_id, t1.ad_event as first_eve, t2.ad_event as second_eve, sum(case when t1.ad_event = 'impression' then 1 else 0 end) as num_impression
from ad4ad t1
join ad4ad t2
on t1.user_id = t2.user_id 
and t1.unit_id = t2.unit_id 
and t1.ad_event = 'impression'
and t2.ad_event = 'create_ad'
WHERE t1.dates < t2.dates
group by t1.user_id, t1.unit_id)t;

DROP TABLE IF EXISTS ulog;
CREATE TABLE IF NOT EXISTS ulog(
    dates DATE,
    sessionid varchar(64),
    user_id VARCHAR(16),
    event varchar(64));
    
INSERT INTO ulog  VALUES
    ( '2020-01-01', 'session 1', 'user 1', 'surface_enter' ),
    ( '2020-01-01', 'session 1', 'user 1', 'click'),
    ( '2020-01-01', 'session 1', 'user 1','surface_exit'),
    ( '2020-01-01', 'session 2', 'user 1','surface_enter' ),
    ( '2020-01-01', 'session 2', 'user 1','first_scroll'),
	( '2020-01-01', 'session 2', 'user 1','surface_exit' ),
    ( '2020-01-01', 'session 3', 'user 2','surface_enter');

# Q1. Calculate the average number of sessions/user per day for the last 30 days
select avg(num)
from(
SELECT user_id, dates, COUNT(sessionid) num
FROM ulog
GROUP BY 1,2)t;

SELECT (COUNT(session_id) / COUNT(DISTINCT user_id) ) as average
FROM table ulog
WHERE DATEDIFF(curdate(), dates)<=30

#Q2: daily active user for the past 30 days

SELECT dates, COUNT(DISTINCT user_id) as cnt_active
FROM (
SELECT *
FROM ulog 
WHERE event IN ('click','first_scroll' ,'surface_enter')
AND DATEDIFF('2020-01-21', dates) <= 30) TEMP
GROUP BY dates;

Create table If Not Exists messages ( user_A INT NOT NULL, user_B INT NULL, n_messages INT NULL);
Truncate table messages;
insert into messages (user_A , user_B, n_messages) values ('1', '2', '20');
insert into messages (user_A , user_B, n_messages) values ('1', '3', '30');
insert into messages (user_A , user_B, n_messages) values ('2', '3', '50');
insert into messages (user_A , user_B, n_messages) values ('3', '4', '30');
insert into messages (user_A , user_B, n_messages) values ('4', '2', '50');

WITH cte1 as (
SELECT user_A, user_B,
SUM(n_messages) OVER(PARTITION BY user_A, user_B) as total
FROM  messages),

cte2 as (
SELECT user_A, user_B,
RANK() OVER (PARTITION BY user_A ORDER BY total DESC) as rank_message
FROM cte1)

select user_A, user_B
from cte2
WHERE rank_message = 1;

DROP table IF EXISTS cus;
Create table If Not Exists cus( cus_id INT NOT NULL, dates DATE);
insert into cus values ('1', '2019-12-1');
insert into cus values ('1', '2019-12-2');
insert into cus values ('2', '2019-12-3');
insert into cus values ('3', '2019-12-9');