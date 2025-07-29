-- SQL 50 Challenge
-- Day 22: Game Play Analysis IV
-- https://leetcode.com/problems/game-play-analysis-iv/description

/*

Table: Activity

+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| player_id    | int     |
| device_id    | int     |
| event_date   | date    |
| games_played | int     |
+--------------+---------+
(player_id, event_date) is the primary key (combination of columns with unique values) of this table.
This table shows the activity of players of some games.
Each row is a record of a player who logged in and played a number of games (possibly 0) before logging out on someday using some device.

Write a solution to report the fraction of players that logged in again on the day after the day they first logged in, rounded to 2 decimal places. In other words, you need to determine the number of players who logged in on the day immediately following their initial login, and divide it by the number of total players.

The result format is in the following example.

 

Example 1:

Input: 
Activity table:
+-----------+-----------+------------+--------------+
| player_id | device_id | event_date | games_played |
+-----------+-----------+------------+--------------+
| 1         | 2         | 2016-03-01 | 5            |
| 1         | 2         | 2016-03-02 | 6            |
| 2         | 3         | 2017-06-25 | 1            |
| 3         | 1         | 2016-03-02 | 0            |
| 3         | 4         | 2018-07-03 | 5            |
+-----------+-----------+------------+--------------+
Output: 
+-----------+
| fraction  |
+-----------+
| 0.33      |
+-----------+
Explanation: 
Only the player with id 1 logged back in after the first day he had logged in so the answer is 1/3 = 0.33

*/

--Solution

WITH total_players AS (
    SELECT COUNT(DISTINCT player_id) AS total_player
    FROM Activity
),
first_login AS (
    SELECT player_id, MIN(event_date) AS first_date
    FROM Activity
    GROUP BY player_id
),
second_logged_players AS (
    SELECT COUNT(DISTINCT a.player_id) AS player_logged_in
    FROM Activity a
    JOIN first_login f ON a.player_id = f.player_id
    WHERE a.event_date = DATE_ADD(f.first_date, INTERVAL 1 DAY)
)
SELECT ROUND(s.player_logged_in / t.total_player, 2) AS fraction
FROM total_players t, second_logged_players s;

--Notes

/*

This query calculates the fraction of players who logged in again on the day 
immediately following their first login. First, the total_players Common Table 
Expression (CTE) counts the total number of unique players. Then, the first_login 
CTE identifies each player’s earliest login date. The second_logged_players CTE 
counts how many players logged in exactly one day after their first login by joining 
the original activity records with the first login dates and filtering for logins that 
occurred the next day. Finally, the main query divides the number of players who logged 
in the day after their first login by the total number of players, rounding the result to 
two decimal places to produce the desired fraction.

*/