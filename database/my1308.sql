DROP TABLE IF EXISTS Scores;
Create table If Not Exists Scores (player_name varchar(20), gender varchar(1), day date, score_points int);
Truncate table Scores;
insert into Scores (player_name, gender, day, score_points) values ('Aron', 'F', '2020-01-01', '17');
insert into Scores (player_name, gender, day, score_points) values ('Alice', 'F', '2020-01-07', '23');
insert into Scores (player_name, gender, day, score_points) values ('Bajrang', 'M', '2020-01-07', '7');
insert into Scores (player_name, gender, day, score_points) values ('Khali', 'M', '2019-12-25', '11');
insert into Scores (player_name, gender, day, score_points) values ('Slaman', 'M', '2019-12-30', '13');
insert into Scores (player_name, gender, day, score_points) values ('Joe', 'M', '2019-12-31', '3');
insert into Scores (player_name, gender, day, score_points) values ('Jose', 'M', '2019-12-18', '2');
insert into Scores (player_name, gender, day, score_points) values ('Priya', 'F', '2019-12-31', '23');
insert into Scores (player_name, gender, day, score_points) values ('Priyanka', 'F', '2019-12-30', '17');

select gender, day, sum(score_points) over (partition by gender order by day) as total
from Scores
order by gender, day;