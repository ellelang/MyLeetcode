USE LEETCODE;
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

select t.ad_id, round(case when t.total_num = 0 then 0 *100 else 100*t.click_num/t.total_num end,2) as ctr
from
(select ad_id,
sum(case when action = 'Clicked' then 1 else 0 end) as 'click_num',
sum(case when action = 'Clicked' or action = 'Viewed' then 1 else 0 end) as 'total_num'
from Ads
group by ad_id)t
order by ctr desc;


SELECT ad_id, IFNULL(ROUND(100*SUM(action='Clicked') / (SUM(action='Clicked')+SUM(action='Viewed')),2),0.00 )AS ctr
FROM Ads
GROUP BY ad_id
ORDER BY ctr desc, ad_id;