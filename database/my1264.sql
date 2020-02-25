DROP TABLE IF EXISTS Friendship ;
DROP TABLE IF EXISTS Likes;
Create table If Not Exists Friendship (user1_id int, user2_id int);
Create table If Not Exists Likes (user_id int, page_id int);
Truncate table Friendship;
insert into Friendship (user1_id, user2_id) values ('1', '2');
insert into Friendship (user1_id, user2_id) values ('1', '3');
insert into Friendship (user1_id, user2_id) values ('1', '4');
insert into Friendship (user1_id, user2_id) values ('2', '3');
insert into Friendship (user1_id, user2_id) values ('2', '4');
insert into Friendship (user1_id, user2_id) values ('2', '5');
insert into Friendship (user1_id, user2_id) values ('6', '1');
Truncate table Likes;
insert into Likes (user_id, page_id) values ('1', '88');
insert into Likes (user_id, page_id) values ('2', '23');
insert into Likes (user_id, page_id) values ('3', '24');
insert into Likes (user_id, page_id) values ('4', '56');
insert into Likes (user_id, page_id) values ('5', '11');
insert into Likes (user_id, page_id) values ('6', '33');
insert into Likes (user_id, page_id) values ('2', '77');
insert into Likes (user_id, page_id) values ('3', '77');
insert into Likes (user_id, page_id) values ('6', '88');

with cte1 as
(select * from
Friendship f
where f.user1_id = 1 or f.user2_id = 1),

cte2 as(
select c1.user2_id as user_id, l.page_id
from cte1 c1
left join Likes l
on c1.user2_id = l.user_id
union
select c1.user1_id as user_id, l.page_id
from cte1 c1
left join Likes l
on c1.user1_id = l.user_id)

select distinct page_id as recommend_page
from cte2 
where page_id not in (select page_id from cte2 where user_id = 1);
#where page_id =! (select page_id from cte2 where user_id = 1);

select distinct page_id as recommended_page from 
likes where user_id in 
(select distinct user2_id from friendship 
where user1_id=1 
union 
select distinct user1_id from friendship 
where user2_id =1) 
and page_id not in (select page_id from likes where user_id=1)