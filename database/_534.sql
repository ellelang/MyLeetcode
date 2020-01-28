-- (player_id, event_date) is the primary key of this table.
-- This table shows the activity of players of some game.
-- Each row is a record of a player who logged in and played a number of games (possibly 0) before logging out on some day using some device.

--Activity table:
--+-----------+-----------+------------+--------------+
--| player_id | device_id | event_date | games_played |
--+-----------+-----------+------------+--------------+
--| 1         | 2         | 2016-03-01 | 5            |
--| 1         | 2         | 2016-05-02 | 6            |
--| 1         | 3         | 2017-06-25 | 1            |
--| 3         | 1         | 2016-03-02 | 0            |
--| 3         | 4         | 2018-07-03 | 5            |
--+-----------+-----------+------------+--------------+

--Write an SQL query that reports for each player and date, how many games played so far by the player. That is, the total number of games played by the player until that date. Check the example for clarity.
 
-- Result table:
-- +-----------+------------+---------------------+
-- | player_id | event_date | games_played_so_far |
-- +-----------+------------+---------------------+
-- | 1         | 2016-03-01 | 5                   |
-- | 1         | 2016-05-02 | 11                  |
-- | 1         | 2017-06-25 | 12                  |
-- | 3         | 2016-03-02 | 0                   |
-- | 3         | 2018-07-03 | 5                   |
-- +-----------+------------+---------------------+
-- For the player with id 1, 5 + 6 = 11 games played by 2016-05-02, and 5 + 6 + 1 = 12 games played by 2017-06-25.
-- For the player with id 3, 0 + 5 = 5 games played by 2018-07-03.
-- Note that for each player we only care about the days when the player logged in.

SELECT
    tb1.player_id,
    tb1.event_date,
    SUM(tb2.games_played) games_played_so_far
FROM
    Activity as tb1
    LEFT JOIN Activity as tb2 ON
    tb2.player_id = tb1.player_id AND
    tb2.event_date <= tb1.event_date  # 自连接 a对b 一对多
GROUP BY
    tb1.player_id,
    tb1.event_date
