--Activity table:
--+-----------+-----------+------------+--------------+
--| player_id | device_id | event_date | games_played |
--+-----------+-----------+------------+--------------+
--| 1         | 2         | 2016-03-01 | 5            |
--| 1         | 2         | 2016-05-02 | 6            |
--| 2         | 3         | 2017-06-25 | 1            |
--| 3         | 1         | 2016-03-02 | 0            |
--| 3         | 4         | 2018-07-03 | 5            |
--+-----------+-----------+------------+--------------+
--Write a SQL query that reports the device that is first logged in for each player.

SELECT
    player_id,
    device_id
FROM
    Activity
WHERE
    (player_id,event_date) IN (SELECT player_id, MIN(event_date)
                               FROM Activity
                               GROUP BY player_id)
