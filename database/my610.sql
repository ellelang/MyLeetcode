Create table If Not Exists triangle (x int, y int, z int);
Truncate table triangle;
insert into triangle (x, y, z) values ('13', '15', '30');
insert into triangle (x, y, z) values ('10', '20', '15');


select x, y, z, 
if(x+y>z and x+z>y and y+z>x, 'Yes', 'No') as triangle 
from triangle;