--Write an SQL query that reports the fraction of players that logged in again on the day after the day they first logged in, rounded to 2 decimal places. In other words, you need to count the number of players that logged in for at least two consecutive days starting from their first login date, then divide that number by the total number of players.

-- Activity table:
-- +-----------+-----------+------------+--------------+
-- | player_id | device_id | event_date | games_played |
-- +-----------+-----------+------------+--------------+
-- | 1         | 2         | 2016-03-01 | 5            |
-- | 1         | 2         | 2016-03-02 | 6            |
-- | 2         | 3         | 2017-06-25 | 1            |
-- | 3         | 1         | 2016-03-02 | 0            |
-- | 3         | 4         | 2018-07-03 | 5            |
-- +-----------+-----------+------------+--------------+
--
-- Result table:
-- +-----------+
-- | fraction  |
-- +-----------+
-- | 0.33      |
-- +-----------+
-- Only the player with id 1 logged back in after the first day he had logged in
-- so the answer is 1/3 = 0.33

SELECT ROUND(COUNT(tb2.event_date)/ COUNT(tb1.player_id),2) as fraction
FROM Activity AS tb1
LEFT JOIN Activity as tb2 ON
tb1.player_id = tb2.player_id AND
DATEDIFF(b.event_date,a.event_date) = 1
WHERE --first day
(tb1.player_id, tb1.event_date) IN (SELECT player_id, MIN(event_date)
                               FROM Activity
                               GROUP BY player_id)




SELECT
    ROUND(
        COUNT(b.event_date)/ COUNT(a.player_id),
        2) fraction
FROM
    Activity a LEFT JOIN Activity b ON
    b.player_id = a.player_id AND
    DATEDIFF(b.event_date,a.event_date) = 1 --b作a的次日
WHERE --first day
    (a.player_id,a.event_date) IN (SELECT player_id, MIN(event_date)
                                   FROM Activity
                                   GROUP BY player_id)
