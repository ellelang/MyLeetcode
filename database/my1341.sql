SHOW databases;
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

SELECT
         rating,
         movie_id,
         ROW_NUMBER() OVER w AS 'row_number',
         RANK()       OVER w AS 'rank',
         DENSE_RANK() OVER w AS 'dense_rank'
       FROM movie_rating
       WINDOW w AS (ORDER BY rating);