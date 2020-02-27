DROP TABLE IF EXISTS Person;
Create table If Not Exists Person (Id int, Email varchar(255));
Truncate table Person;
insert into Person (Id, Email) values (1, 'a@b.com');
insert into Person (Id, Email) values (2, 'c@d.com');
insert into Person (Id, Email) values (3, 'a@b.com');


DELETE FROM Person WHERE Id in
(
    SELECT Id FROM 
    (
        SELECT P1.Id FROM Person P1 join Person P2
        on P1.Email=P2.Email
        WHERE P1.Id > P2.Id
    )As Temp_Table
);

   SELECT P1.Id FROM Person P1 join Person P2
        on P1.Email=P2.Email
        WHERE P1.Id > P2.Id;

