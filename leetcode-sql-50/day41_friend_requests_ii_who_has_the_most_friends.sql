-- SQL 50 Challenge
-- Day 41: Friend Requests II: Who Has the Most Friends
-- https://leetcode.com/problems/friend-requests-ii-who-has-the-most-friends/description

/*

Table: RequestAccepted

+----------------+---------+
| Column Name    | Type    |
+----------------+---------+
| requester_id   | int     |
| accepter_id    | int     |
| accept_date    | date    |
+----------------+---------+
(requester_id, accepter_id) is the primary key (combination of columns with unique values) for this table.
This table contains the ID of the user who sent the request, the ID of the user who received the request, and the date when the request was accepted.
 

Write a solution to find the people who have the most friends and the most friends number.

The test cases are generated so that only one person has the most friends.

The result format is in the following example.

 

Example 1:

Input: 
RequestAccepted table:
+--------------+-------------+-------------+
| requester_id | accepter_id | accept_date |
+--------------+-------------+-------------+
| 1            | 2           | 2016/06/03  |
| 1            | 3           | 2016/06/08  |
| 2            | 3           | 2016/06/08  |
| 3            | 4           | 2016/06/09  |
+--------------+-------------+-------------+
Output: 
+----+-----+
| id | num |
+----+-----+
| 3  | 3   |
+----+-----+
Explanation: 
The person with id 3 is a friend of people 1, 2, and 4, so he has three friends in total, which is the most number than any others.
 

Follow up: In the real world, multiple people could have the same most number of friends. Could you find all these people in this case?



*/

--Solution

WITH all_friends AS (
    SELECT requester_id AS id, accepter_id AS friend_id
    FROM RequestAccepted
    UNION
    SELECT accepter_id AS id, requester_id AS friend_id
    FROM RequestAccepted
),
friend_counts AS (
    SELECT id, COUNT(DISTINCT friend_id) AS num
    FROM all_friends
    GROUP BY id
),
max_count AS (
    SELECT MAX(num) AS max_num
    FROM friend_counts
)
SELECT f.id, f.num
FROM friend_counts f
JOIN max_count m
  ON f.num = m.max_num;


--Notes
/*

This query finds the user or users with the highest number of friends.
It first uses the all_friends CTE to unify both directions of friendships 
by combining (requester_id, accepter_id) and (accepter_id, requester_id) 
with a UNION, ensuring each relationship is represented in both directions.
Then, the friend_counts CTE groups by each user (id) and counts their distinct 
friends to get the total number of unique friends for each person.
The max_count CTE retrieves the highest friend count among all users.
Finally, the main query joins friend_counts with max_count to return only the user(s) whose friend count matches the maximum, covering both the single-winner case and situations where multiple people share the top count.

*/