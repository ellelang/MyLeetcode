Create table If Not Exists Candidate (id int, Name char(255));
Create table If Not Exists Vote (id int, CandidateId int);
Truncate table Candidate;
insert into Candidate (id, Name) values ('1', 'A');
insert into Candidate (id, Name) values ('2', 'B');
insert into Candidate (id, Name) values ('3', 'C');
insert into Candidate (id, Name) values ('4', 'D');
insert into Candidate (id, Name) values ('5', 'E');
Truncate table Vote;
insert into Vote (id, CandidateId) values ('1', '2');
insert into Vote (id, CandidateId) values ('2', '4');
insert into Vote (id, CandidateId) values ('3', '3');
insert into Vote (id, CandidateId) values ('4', '2');
insert into Vote (id, CandidateId) values ('5', '5');



SELECT c.Name, c.Id, v.CandidateId
FROM Vote v
LEFT JOIN Candidate c ON c.id=v.CandidateId
group by v.CandidateId
ORDER BY COUNT(v.id) DESC
Limit 1;


SELECT Name FROM (
    SELECT Name, count(*) as Total 
    FROM Candidate RIGHT JOIN Vote 
    ON Candidate.id = Vote.CandidateId 
    GROUP BY Candidate.id
    ORDER BY Total DESC
    LIMIT 1
) AS Count;

Select Name FROM 
(Select v.CandidateId, c.Name, count(v.CandidateId) as Total
from vote v 
left join Candidate c
on v.CandidateId = c.id
group by v.CandidateId
Order by Total desc
LIMIT 1)T;
 
