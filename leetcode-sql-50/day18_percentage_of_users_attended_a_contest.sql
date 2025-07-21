-- SQL 50 Challenge
-- Day 18: Percentage Of Users Attended a Contest
-- https://leetcode.com/problems/percentage-of-users-attended-a-contest/description

/*

Table: Users

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| user_id     | int     |
| user_name   | varchar |
+-------------+---------+
user_id is the primary key (column with unique values) for this table.
Each row of this table contains the name and the id of a user.
 

Table: Register

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| contest_id  | int     |
| user_id     | int     |
+-------------+---------+
(contest_id, user_id) is the primary key (combination of columns with unique values) for this table.
Each row of this table contains the id of a user and the contest they registered into.
 

Write a solution to find the percentage of the users registered in each contest rounded to two decimals.

Return the result table ordered by percentage in descending order. In case of a tie, order it by contest_id in ascending order.

The result format is in the following example.

 

Example 1:

Input: 
Users table:
+---------+-----------+
| user_id | user_name |
+---------+-----------+
| 6       | Alice     |
| 2       | Bob       |
| 7       | Alex      |
+---------+-----------+
Register table:
+------------+---------+
| contest_id | user_id |
+------------+---------+
| 215        | 6       |
| 209        | 2       |
| 208        | 2       |
| 210        | 6       |
| 208        | 6       |
| 209        | 7       |
| 209        | 6       |
| 215        | 7       |
| 208        | 7       |
| 210        | 2       |
| 207        | 2       |
| 210        | 7       |
+------------+---------+
Output: 
+------------+------------+
| contest_id | percentage |
+------------+------------+
| 208        | 100.0      |
| 209        | 100.0      |
| 210        | 100.0      |
| 215        | 66.67      |
| 207        | 33.33      |
+------------+------------+
Explanation: 
All the users registered in contests 208, 209, and 210. The percentage is 100% and we sort them in the answer table by contest_id in ascending order.
Alice and Alex registered in contest 215 and the percentage is ((2/3) * 100) = 66.67%
Bob registered in contest 207 and the percentage is ((1/3) * 100) = 33.33%

*/

--Solution 1

SELECT DISTINCT r.contest_id, 
                ROUND((COUNT(r.user_id)/(SELECT COUNT(*) FROM Users))*100, 2) AS percentage
FROM Users AS u
INNER JOIN Register AS r
                ON u.user_id = r.user_id
GROUP BY contest_id
ORDER BY percentage DESC, contest_id ASC

--Solution 2, With CTE (Common Table Expression)

WITH total_users AS (
    SELECT COUNT(*) AS total FROM Users
), 
contest_users AS (
    SELECT 
        contest_id,
        COUNT(user_id) AS registered_users
    FROM Register
    GROUP BY contest_id
)
SELECT
    DISTINCT c.contest_id,
    ROUND((c.registered_users/t.total)*100,2) AS percentage
FROM total_users AS t, contest_users AS c
ORDER BY percentage DESC, contest_id ASC;



--Notes

/*

Both solutions calculate the percentage of users registered for each contest.
The first solution uses a **subquery inside ROUND** to dynamically count 
total users and calculate the percentage directly within the SELECT statement.
The second solution uses **CTEs (Common Table Expressions)** to make the query 
cleaner and more readable. One CTE calculates the total number of users, and 
another counts how many users joined each contest. In the final SELECT, we 
simply divide the two columns.Both solutions return the same result, 
but the **CTE version is easier to maintain and extend** in more complex scenarios.

*/
