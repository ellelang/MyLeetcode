DROP TABLE IF EXISTS survey_log;
Create table If Not Exists survey_log (id int, action char(255), question_id int, answer_id int, q_num int, timestamp int);
Truncate table survey_log;
insert into survey_log (id, action, question_id, answer_id, q_num, timestamp) values ('5', 'show', '285', null, '1', '123');
insert into survey_log (id, action, question_id, answer_id, q_num, timestamp) values ('5', 'answer', '285', '124124', '1', '124');
insert into survey_log (id, action, question_id, answer_id, q_num, timestamp) values ('5', 'show', '369', null, '2', '125');
insert into survey_log (id, action, question_id, answer_id, q_num, timestamp) values ('5', 'skip', '369', null, '2', '126');

select * from survey_log;


SELECT question_id AS survey_log
FROM(
    SELECT question_id,
    SUM(CASE WHEN action = 'answer' THEN 1 ELSE 0 END)
    /
    SUM(CASE WHEN action = 'show' THEN 1 ELSE 0 END) AS rate
    FROM survey_log
    GROUP BY question_id
    ) tem
ORDER BY rate DESC 
LIMIT 1;