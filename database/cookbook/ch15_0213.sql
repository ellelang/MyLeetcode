SELECT score, COUNT(score) AS counts
FROM testscore 
GROUP BY score;

SET @n = (SELECT COUNT(score) FROM testscore);

SELECT score, (COUNT(score)*100)/@n AS percent
FROM testscore GROUP BY score;

DROP TABLE IF EXISTS ref;
CREATE TABLE ref (score INT);
INSERT INTO ref (score)
VALUES(0),(1),(2),(3),(4),(5),(6),(7),(8),(9),(10);

SELECT ref.score, COUNT(testscore.score) AS counts,
REPEAT('*',COUNT(testscore.score)) AS 'count histogram'
FROM ref LEFT JOIN testscore ON ref.score = testscore.score
GROUP BY ref.score;