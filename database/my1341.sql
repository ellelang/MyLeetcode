SHOW databases;
#CREATE DATABASE leetcode;
USE leetcode;
SHOW TABLES;

Create table If Not Exists Movies (movie_id int, title varchar(30));
Create table If Not Exists Users (user_id int, name varchar(30));
Create table If Not Exists Movie_Rating (movie_id int, user_id int, rating int, created_at date);
Truncate table Movies;
insert into Movies (movie_id, title) values ('1', 'Avengers');
insert into Movies (movie_id, title) values ('2', 'Frozen 2');
insert into Movies (movie_id, title) values ('3', 'Joker');
Truncate table Users;
insert into Users (user_id, name) values ('1', 'Daniel');
insert into Users (user_id, name) values ('2', 'Monica');
insert into Users (user_id, name) values ('3', 'Maria');
insert into Users (user_id, name) values ('4', 'James');
Truncate table Movie_Rating;
insert into Movie_Rating (movie_id, user_id, rating, created_at) values ('1', '1', '3', '2020-01-12');
insert into Movie_Rating (movie_id, user_id, rating, created_at) values ('1', '2', '4', '2020-02-11');
insert into Movie_Rating (movie_id, user_id, rating, created_at) values ('1', '3', '2', '2020-02-12');
insert into Movie_Rating (movie_id, user_id, rating, created_at) values ('1', '4', '1', '2020-01-01');
insert into Movie_Rating (movie_id, user_id, rating, created_at) values ('2', '1', '5', '2020-02-17');
insert into Movie_Rating (movie_id, user_id, rating, created_at) values ('2', '2', '2', '2020-02-01');
insert into Movie_Rating (movie_id, user_id, rating, created_at) values ('2', '3', '2', '2020-03-01');
insert into Movie_Rating (movie_id, user_id, rating, created_at) values ('3', '1', '3', '2020-02-22');
insert into Movie_Rating (movie_id, user_id, rating, created_at) values ('3', '2', '4', '2020-02-25');

SELECT NAME as results
FROM (
SELECT NAME, row_number()OVER(order by cnt desc, name asc) as ranking
from (select movie_rating.user_id, name, count(*) as cnt
     from movie_rating 
	left join USERS ON USERS.USER_ID = movie_rating.USER_ID
     group by movie_rating. user_id) as cn) as sub
     where ranking = 1;


select title from (
select title, row_number()over(order by avg_rating desc, title) as rn
 from
(SELECT movie_id, avg(rating) as avg_rating
from movie_rating
where left(created_at, 7) = '2020-02'
group by movie_id) as feb
left join movies on movies.movie_id = feb.movie_id ) as t
where rn  = 1;
 
 ############################
 SELECT NAME as results
FROM
(
SELECT NAME,
    row_number() over(order by cnt desc, name asc) as ranking
FROM (select user_id, count(*) as cnt
     from movie_rating
     group by user_id) as sub
JOIN USERS ON USERS.USER_ID = sub.USER_ID
) AS SRC
WHERE RANKING = 1

UNION all

SELECT TITLE
FROM
(SELECT title, row_number() over(order by avg_rating desc, title) as rn
 from
 (select movie_id, avg(rating*1.0) as avg_rating
 from movie_rating
 where left(created_at, 7) = '2020-02'
 GROUP BY movie_id) as feb
join movies on movies.movie_id = feb.movie_id ) as t 
where rn = 1;
       