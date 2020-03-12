USE LEETCODE;
DROP TABLE IF EXISTS UserActivity;
Create table If Not Exists UserActivity (username varchar(30), activity varchar(30), startDate date, endDate date);
Truncate table UserActivity;
insert into UserActivity (username, activity, startDate, endDate) values ('Alice', 'Travel', '2020-02-12', '2020-02-20');
insert into UserActivity (username, activity, startDate, endDate) values ('Alice', 'Dancing', '2020-02-21', '2020-02-23');
insert into UserActivity (username, activity, startDate, endDate) values ('Alice', 'Travel', '2020-02-24', '2020-02-28');
insert into UserActivity (username, activity, startDate, endDate) values ('Bob', 'Travel', '2020-02-11', '2020-02-18');

select * from UserActivity;

select *
from UserActivity
group by username
having count(1) = 1;


select a.*, b.*
from UserActivity as a left join UserActivity as b
on a.username = b.username and a.endDate<b.endDate
group by a.username, a.endDate;


select username, activity, startDate, endDate,
    row_number() over(partition by username order by endDate desc) as row_num,
    count(activity)  over (partition by username) as cnt
    from useractivity;
    
    
select username, activity, startDate, endDate
from (
    select username, activity, startDate, endDate,
    row_number() over(partition by username order by endDate desc) as row_num,
    count(activity)  over (partition by username) as cnt
    from useractivity) t
where t.cnt = 1
or (t.cnt>1 and t.row_num=2);