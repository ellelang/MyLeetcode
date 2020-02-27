Create table If Not Exists Weather (Id int, RecordDate date, Temperature int);
Truncate table Weather;
insert into Weather (Id, RecordDate, Temperature) values ('1', '2015-01-01', '10');
insert into Weather (Id, RecordDate, Temperature) values ('2', '2015-01-02', '25');
insert into Weather (Id, RecordDate, Temperature) values ('3', '2015-01-03', '20');
insert into Weather (Id, RecordDate, Temperature) values ('4', '2015-01-04', '30');





Select t.ID
From
(Select ID, (Temperature - Prev_temp) as Diff
FROM(
SELECT Id, RecordDate, Temperature,
Lag(Temperature, 1) OVER w as Prev_temp
FROM Weather
window w as (ORDER BY RecordDate) 
)as sub) as t
Where t.Diff > 0 ;


select w2.Id
from Weather w1, Weather w2
where 
w2.RecordDate = date_add(w1.RecordDate, interval 1 day)
and
w2.Temperature > w1.Temperature;
 