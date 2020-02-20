DROP TABLE IF EXISTS student;
Create table If Not Exists student (name varchar(50), continent varchar(7));
Truncate table student;
insert into student (name, continent) values ('Jane', 'America');
insert into student (name, continent) values ('Pascal', 'Europe');
insert into student (name, continent) values ('Xi', 'Asia');
insert into student (name, continent) values ('Jack', 'America');

SELECT MAX(America) as America, MAX(Asia) as Asia, MAX(Europe) as Europe
FROM (SELECT ID,  CASE WHEN continent = 'America' THEN name END as America,
CASE WHEN continent = 'Asia' THEN name END as Asia,
CASE WHEN continent = 'Europe' THEN name END as Europe
FROM (SELECT ROW_NUMBER() OVER (PARTITION BY continent ORDER BY name) AS ID, name ,continent
FROM student) tmp) a
GROUP BY ID;

SELECT ID, MAX(America) as America, MAX(Asia) as Asia, MAX(Europe) as Europe
FROM (
SELECT ID,  CASE WHEN continent = 'America' THEN name END as America,
CASE WHEN continent = 'Asia' THEN name END as Asia,
CASE WHEN continent = 'Europe' THEN name END as Europe
FROM (
SELECT name ,continent,
ROW_NUMBER() OVER w  AS ID
FROM student
window w as (PARTITION BY continent ORDER BY name))t)t2
GROUP BY ID;

SELECT America, Asia, Europe
FROM
    (SELECT *
    FROM
        (SELECT name as America ,
        row_number() OVER (PARTITION BY continent ORDER BY name) as         ind
        FROM student
        WHERE continent = 'America') temp
    LEFT JOIN 
        (SELECT name as Asia,
        row_number() OVER (PARTITION BY continent ORDER BY name) as         ind_asia
        FROM student
        WHERE continent = 'Asia') temp1
    ON ind = temp1.ind_asia) temp2
LEFT JOIN 
(SELECT name as Europe,
        row_number() OVER (PARTITION BY continent ORDER BY name) as         ind_eur
        FROM student
        WHERE continent = 'Europe') temp3
ON temp2.ind = temp3.ind_eur;


Select name ,ROW_NUMBER ( ) over (partition by continent order by name) as rnk from student
    where continent = 'America';
    
Select name ,ROW_NUMBER ( ) over (partition by continent order by name) as rnk from student
    where continent = 'Asia';
    
Select name ,ROW_NUMBER ( ) over (partition by continent order by name) as rnk from student
    where continent = 'Europe';
    

SELECT *
    FROM
        (SELECT name as America ,
        row_number() OVER (PARTITION BY continent ORDER BY name) as         ind
        FROM student
        WHERE continent = 'America') temp
    LEFT JOIN 
        (SELECT name as Asia,
        row_number() OVER (PARTITION BY continent ORDER BY name) as         ind_asia
        FROM student
        WHERE continent = 'Asia') temp1
    ON ind = temp1.ind_asia;