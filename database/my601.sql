Create table If Not Exists stadium (id int, visit_date DATE NULL, people int);
Truncate table stadium;
insert into stadium (id, visit_date, people) values ('1', '2017-01-01', '10');
insert into stadium (id, visit_date, people) values ('2', '2017-01-02', '109');
insert into stadium (id, visit_date, people) values ('3', '2017-01-03', '150');
insert into stadium (id, visit_date, people) values ('4', '2017-01-04', '99');
insert into stadium (id, visit_date, people) values ('5', '2017-01-05', '145');
insert into stadium (id, visit_date, people) values ('6', '2017-01-06', '1455');
insert into stadium (id, visit_date, people) values ('7', '2017-01-07', '199');
insert into stadium (id, visit_date, people) values ('8', '2017-01-08', '188');


select s0.id as s0_id, s1.id as id, s1.visit_date as visit_date, s1.people as people,
    min(s1.people) over(partition by s0.id) as min_people,
    count(s1.id) over (partition by s0.id) as num_consecutive
    from
    stadium s0 left join stadium s1
    on s1.id >= s0.id and s1.id <= s0.id + 2;


select distinct id, visit_date, people from
    (select s0.id as s0_id, s1.id as id, s1.visit_date as visit_date, s1.people as people,
    min(s1.people) over(partition by s0.id) as min_people,
    count(s1.id) over (partition by s0.id) as num_consecutive
    from
    stadium s0 left join stadium s1
    on s1.id >= s0.id and s1.id <= s0.id + 2) t1
where min_people >= 100
and num_consecutive >= 3;