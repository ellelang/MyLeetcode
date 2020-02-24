DROP TABLE IF EXISTS Submissions;
Create table If Not Exists Submissions (sub_id int, parent_id int);
Truncate table Submissions;
insert into Submissions (sub_id, parent_id) values ('1', null);
insert into Submissions (sub_id, parent_id) values ('2', null);
insert into Submissions (sub_id, parent_id) values ('1', null);
insert into Submissions (sub_id, parent_id) values ('12', null);
insert into Submissions (sub_id, parent_id) values ('3', '1');
insert into Submissions (sub_id, parent_id) values ('5', '2');
insert into Submissions (sub_id, parent_id) values ('3', '1');
insert into Submissions (sub_id, parent_id) values ('4', '1');
insert into Submissions (sub_id, parent_id) values ('9', '1');
insert into Submissions (sub_id, parent_id) values ('10', '2');
insert into Submissions (sub_id, parent_id) values ('6', '7');

with cte1 as
(select *
from Submissions
where parent_id is null),
cte2 as
(select *
from Submissions
where parent_id is not null)

#select parent_id, count(distinct sub_id) as comments
#from cte2
#group by parent_id;


select distinct cte1.sub_id as post_id, ifnull(t.comments,0) as number_of_comments
from cte1
left join (select parent_id, count(distinct sub_id) as comments
from cte2
group by parent_id) t
on cte1.sub_id = t. parent_id;
