--626. Exchange Seats
--
--Mary is a teacher in a middle school and she has a table seat storing students' names and their corresponding seat ids.
--
--The column id is continuous increment.
--Mary wants to change seats for the adjacent students.
--Can you write a SQL query to output the result for Mary?
--+---------+---------+
--|    id   | student |
--+---------+---------+
--|    1    | Abbot   |
--|    2    | Doris   |
--|    3    | Emerson |
--|    4    | Green   |
--|    5    | Jeames  |
--+---------+---------+
--For the sample input, the output is:
--+---------+---------+
--|    id   | student |
--+---------+---------+
--|    1    | Doris   |
--|    2    | Abbot   |
--|    3    | Green   |
--|    4    | Emerson |
--|    5    | Jeames  |
--+---------+---------+
--Note:
--1.IF the id is odd number & id equals to the count of students, then id = id
--2.IF the id is odd number & id not equals to the count of students, then id = id + 1
--3.IF the id is even number, then id = id -1

--CASE
--WHEN condition1 THEN result1
--WHEN condition2 THEN result2
--WHEN condition3 THEN result3
--ELSE result 4
--END

SELECT (CASE
  WHEN mod(id, 2) = 1 AND id = counts THEN id
  WHEN mod(id, 2) = 1 AND id != counts THEN id + 1
  ELSE id - 1
END) AS id, student
FROM seat, (SELECT count(*) AS counts FROM seat) AS counts
ORDER BY id;





SELECT
    (CASE
        WHEN MOD(id, 2) != 0 AND counts != id THEN id + 1
        WHEN MOD(id, 2) != 0 AND counts = id THEN id
        ELSE id - 1
    END) AS id,
    student
FROM
    seat,
    (SELECT
        COUNT(*) AS counts
    FROM
        seat) AS seat_counts
ORDER BY id ASC;
