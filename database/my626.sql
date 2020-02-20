DROP TABLE IF EXISTS seat;
Create table If Not Exists seat(id int, student char(255));
Truncate table seat;
insert into seat (id, student) values ('1', 'Abbot');
insert into seat (id, student) values ('2', 'Doris');
insert into seat (id, student) values ('3', 'Emerson');
insert into seat (id, student) values ('4', 'Green');
insert into seat (id, student) values ('5', 'Jeames');



select id, ifnull( (case 
when id % 2 = 0 then lag(student) over(order by id asc)
else lead(student) over(order by id asc) 
end),student) as student1
 from seat;

