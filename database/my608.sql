DROP TABLE IF EXISTS tree;
Create table If Not Exists tree (id int, p_id int);
Truncate table tree;
insert into tree (id, p_id) values ('1', null);
insert into tree (id, p_id) values ('2', '1');
insert into tree (id, p_id) values ('3', '1');
insert into tree (id, p_id) values ('4', '2');
insert into tree (id, p_id) values ('5', '2');


SELECT 
    id, 
    CASE WHEN p_id IS NULL THEN "Root" 
         WHEN id IN (SELECT p_id FROM tree) THEN "Inner"
    ELSE "Leaf" END AS Type
FROM tree
ORDER BY id; 


select distinct t.id, 
case
when (parent is null and p_id is not null) then "Leaf"
when (p_id is null and parent is not null) then "Root"
else "Inner"
END AS Type
from
(select s0.id, sp.p_id as parent
from tree s0
LEFT JOIN tree sp
on s0.id = sp.p_id) t
left join tree sc
on t.id = sc.id;