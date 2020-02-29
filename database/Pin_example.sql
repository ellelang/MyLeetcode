USE LEETCODE;
#  get the per-day count since the beginning of the year of users ‍‍‍‍‍‍‍‌‍‌‍‌‌‌‌‌‍‌‌ 
#  who visited at least one page on an iphone and the web on the same day

DROP TABLE IF EXISTS web_request ;
DROP TABLE IF EXISTS api_request ;
Create table If Not Exists web_request (visit_date date, user_id int, browser char(16), request_count int );
Create table If Not Exists api_request(visit_date date, user_id int, device_type char(16), request_count  int);


INSERT INTO web_request (visit_date, user_id,browser,request_count)
  VALUES
    ('2019-03-11','2','chrome', 20),
    ('2019-05-12','3','chrome', 10),
    ('2019-07-12','4','firefox',5),
    ('2019-09-12','5','ie',4),
    ('2019-12-14','1','firefox',12);
    
INSERT INTO api_request (visit_date, user_id, device_type, request_count)
  VALUES
    ('2019-03-11','2','iphone', 60),
    ('2019-09-12','5','iphone', 40),
    ('2019-07-12','4','ipad',30),
    ('2019-09-12','1','iphone',18),
    ('2019-05-12','3','iphone',22);
    

select w.user_id, w.visit_date, count(distinct w.visit_date)
from web_request w
left join
(select *
from api_request a
where a.device_type = 'iphone' and a.visit_date >= '2019-01-01') t
on w.user_id = t.user_id and w.visit_date = t.visit_date
where t.device_type is not null
group by w.visit_date;



select visit_date, count(distinct user_id) from
(
select w.user_id, w.visit_date, w.browser, a.device_type
from web_request w
left join (select * from api_request
where device_type = 'iphone') a
on w.user_id = a.user_id and w.visit_date = a.visit_date) t
where t. device_type is not null
group by visit_date  ;












select * from web_request;
select * from api_request;
with cte as
(
select w.user_id, w.visit_date, w.browser , t.device_type as type
from web_request w left join 
(select * from api_request where device_type = 'iphone')t
on w.user_id = t.user_id and
w.visit_date = t.visit_date)

select *
from cte 
where type is not null;

select visit_date, sum(ct) from (
    select count(1) as ct, user_id, visit_date, 'web' as src from web_request
        where visit_date >= '2019-01-01'
        group by visit_date, user_id
    right join
    (select count(1) as ct, user_id, visit_date, 'api' as src from api_request 
        where device_type = 'iphone' and visit_date >= '2019-01-01'
        group by visit_date, user_id) b
        on web_request.user_id = b.user_id
) t1
group by t1.visit_date;

select visit_date, sum(ct) from
(select count(visit_date) as ct, user_id, visit_date, 'web' as src 
from web_request
where visit_date >= '2019-01-01'
group by visit_date, user_id
union
select count(visit_date) as ct, user_id, visit_date, 'api' as src 
from api_request 
where device_type = 'iphone' and visit_date >= '2019-01-01'
group by visit_date, user_id)t
group by visit_date;



SELECT a.visit_date, count(*) as user_cnt  
FROM  
(  
SELECT visit_date, user_id  
FROM web_request  
WHERE visit_date >= '2019-01-01'  
GROUP BY 1,2  
) a 
JOIN  
(  
SELECT visit_date, user_id
FROM api_request 
WHERE device_type = 'iphone'  
AND visit_date  >= '2019-01-01'  
) b  
ON a.visit_date =b.visit_date  AND a.user_id = b.user_id  
GROUP BY 1;

SELECT w.visit_date, w.user_id  
FROM web_request w 
#GROUP BY 1,2;
inner join
(SELECT visit_date, user_id
FROM api_request 
WHERE device_type = 'iphone') b 
ON w.visit_date =b.visit_date  AND w.user_id = b.user_id ;

select visit_date, sum_v
from
(select visit_date, sum(ct) as sum_v
from (
    select count(1) as ct, user_id, visit_date, 'web' as src from web_request
        where visit_date >= '2017-01-01'
        group by visit_date, user_id
    union
    select count(1) as ct, user_id, visit_date, 'api' as src from api_request
        where device_type = 'iphone' and visit_date >= '2017-01-01'
        group by visit_date, user_id
) t1
group by t1.visit_date)t2
where t2.sum_v >1 ;



 select count(1) as ct, w.user_id, w.visit_date, 'web' as src from web_request w
    right join
    (select count(1) as ct, a.user_id, a.visit_date, 'api' as src from api_request a 
        where device_type = 'iphone' and a.visit_date >= '2019-01-01'
        group by a.visit_date, a.user_id) b
        on w.user_id = b.user_id
	where w.visit_date >= '2019-01-01'
        group by w.visit_date, w.user_id;
