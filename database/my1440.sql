Create Table If Not Exists Variables (name varchar(3), value int);
Create Table If Not Exists Expressions (left_operand varchar(3), operator ENUM('>', '<', '='), right_operand varchar(3));
Truncate table Variables;
insert into Variables (name, value) values ('x', '66');
insert into Variables (name, value) values ('y', '77');
Truncate table Expressions;
insert into Expressions (left_operand, operator, right_operand) values ('x', '>', 'y');
insert into Expressions (left_operand, operator, right_operand) values ('x', '<', 'y');
insert into Expressions (left_operand, operator, right_operand) values ('x', '=', 'y');
insert into Expressions (left_operand, operator, right_operand) values ('y', '>', 'x');
insert into Expressions (left_operand, operator, right_operand) values ('y', '<', 'x');
insert into Expressions (left_operand, operator, right_operand) values ('x', '=', 'x');

# Write an SQL query to evaluate the boolean expressions in Expressions table. Return the result table in any order.
Select * 
FROM Variables v1
right join expressions e on v1.name = e.left_operand
left join Variables v2 on v2.name = e.right_operand;


SELECT left_operand, operator, right_operand,
(CASE WHEN v1.value > v2.value AND operator = '>' THEN 'true'
WHEN v1.value < v2.value AND operator = '<' THEN 'true'
WHEN v1.value = v2.value AND operator = '=' THEN 'true'
ELSE 'false' END) AS value
FROM variables v1 RIGHT JOIN expressions e ON v1.name = e.left_operand LEFT JOIN variables v2 ON e.right_operand = v2.name