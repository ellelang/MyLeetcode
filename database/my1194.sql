use leetcode;
DROP TABLE IF EXISTS Players;
DROP TABLE IF EXISTS Matches;
Create table If Not Exists Players (player_id int, group_id int);
Create table If Not Exists Matches (match_id int, first_player int, second_player int, first_score int, second_score int);
Truncate table Players;
insert into Players (player_id, group_id) values ('10', '2');
insert into Players (player_id, group_id) values ('15', '1');
insert into Players (player_id, group_id) values ('20', '3');
insert into Players (player_id, group_id) values ('25', '1');
insert into Players (player_id, group_id) values ('30', '1');
insert into Players (player_id, group_id) values ('35', '2');
insert into Players (player_id, group_id) values ('40', '3');
insert into Players (player_id, group_id) values ('45', '1');
insert into Players (player_id, group_id) values ('50', '2');
Truncate table Matches;
insert into Matches (match_id, first_player, second_player, first_score, second_score) values ('1', '15', '45', '3', '0');
insert into Matches (match_id, first_player, second_player, first_score, second_score) values ('2', '30', '25', '1', '2');
insert into Matches (match_id, first_player, second_player, first_score, second_score) values ('3', '30', '15', '2', '0');
insert into Matches (match_id, first_player, second_player, first_score, second_score) values ('4', '40', '20', '5', '2');
insert into Matches (match_id, first_player, second_player, first_score, second_score) values ('5', '35', '50', '1', '1');

with cte1 as (
select m1.first_player as id, sum(m1.first_score) as total_point
from matches m1
group by m1.first_player),

cte2 as (
select m2.second_player as id, sum(m2.second_score) as total_point
from matches m2
group by m2.second_player),

cte3 as (
(select id, total_point
from cte1)
union
(select id, total_point 
from cte2)),

cte4 as
(select cte3.id, sum(cte3.total_point) as sum_total, p.group_id,
row_number() over (partition by p.group_id order by sum(cte3.total_point) desc) as rank_total
from cte3
left join players p
on cte3.id = p.player_id
group by cte3.id)

select group_id, id as player_id
from cte4
where rank_total = 1;



with cte1 
as (select match_id, first_player, first_score from matches),
cte2
as(select match_id, second_player, second_score from matches)

select group_id, player_id
from(
select group_id, player_id,
row_number() over w as rank_score
from
(select player_id, group_id, ifnull(first_score,0)+ifnull(second_score,0) as total_g
from players
left join cte1
on player_id = cte1.first_player
left join cte2
on player_id = cte2.second_player)t
window w as (partition by group_id order by total_g desc, player_id))t2
where rank_score = 1;