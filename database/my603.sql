Create table If Not Exists cinema (seat_id int primary key auto_increment, free bool);
Truncate table cinema;
insert into cinema (seat_id, free) values ('1', '1');
insert into cinema (seat_id, free) values ('2', '0');
insert into cinema (seat_id, free) values ('3', '1');
insert into cinema (seat_id, free) values ('4', '1');
insert into cinema (seat_id, free) values ('5', '1');


SELECT seat_id
FROM
    (SELECT seat_id, free, 
     LEAD (free) OVER(ORDER BY seat_id) AS nextseat,
     LAG (free) OVER(ORDER BY seat_id) AS lastseat
    FROM cinema) a
WHERE (free = 1 AND nextseat = 1) OR (free = 1 AND lastseat = 1);

SELECT seat_id, free, 
     LEAD (free) OVER(ORDER BY seat_id) AS nextseat,
     LAG (free) OVER(ORDER BY seat_id) AS lastseat
    FROM cinema;