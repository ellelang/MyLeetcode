SET @max_price = (SELECT MAX(price) FROM painting);
SELECT artist.name, painting.title, painting.price
FROM artist INNER JOIN painting
on artist.a_id = painting.a_id
where painting.price = @max_price;

CREATE TABLE tmp
SELECT a_id, MAX(price) AS max_price FROM painting GROUP BY a_id;
select * from tmp;
SELECT artist.name, painting.title, painting.price
FROM artist INNER JOIN painting INNER JOIN tmp
ON painting.a_id = artist.a_id
AND painting.a_id = tmp.a_id
AND painting.price = tmp.max_price;

SELECT artist.name, p1.title, p1.price
FROM painting AS p1 LEFT JOIN painting AS p2
ON p1.a_id = p2.a_id AND p1.price < p2.price
INNER JOIN artist ON p1.a_id = artist.a_id
WHERE p2.a_id IS NULL;

##########
SELECT trav_date, COUNT(trav_date) AS drivers
FROM driver_log
GROUP BY trav_date 
ORDER BY trav_date;

DROP TABLE IF EXISTS tmp;
CREATE TABLE tmp
SELECT name, SUM(miles) AS driver_miles FROM driver_log GROUP BY name;

SELECT tmp.driver_miles, driver_log.*
FROM driver_log INNER JOIN
(SELECT name, SUM(miles) AS driver_miles
FROM driver_log GROUP BY name) AS tmp
ON driver_log.name = tmp.name
ORDER BY tmp.driver_miles DESC, driver_log.trav_date;