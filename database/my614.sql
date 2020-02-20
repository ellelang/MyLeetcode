DROP TABLE IF EXISTS follow;
Create table If Not Exists follow (followee char(255), follower char(255));
Truncate table follow;
insert into follow (followee, follower) values ('A', 'B');
insert into follow (followee, follower) values ('B', 'C');
insert into follow (followee, follower) values ('B', 'D');
insert into follow (followee, follower) values ('D', 'E');

SELECT fler.followee as follower, count(fler.follower) as num
FROM follow as flee
LEFT JOIN follow as fler
on flee.follower = fler.followee
group by fler.followee
having fler.followee is not null;

SELECT f1.follower, COUNT(DISTINCT f2.follower) num
FROM
    follow f1
LEFT JOIN
    follow f2
ON f1.follower = f2.followee
WHERE f2.follower IS NOT NULL
GROUP BY f1.follower;