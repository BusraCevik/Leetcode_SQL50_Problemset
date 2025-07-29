-- SQL 50 Challenge
-- Day 24: User Activity for the Past 30 Days I
-- https://leetcode.com/problems/user-activity-for-the-past-30-days-i/description

/*

Table: Activity

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| user_id       | int     |
| session_id    | int     |
| activity_date | date    |
| activity_type | enum    |
+---------------+---------+
This table may have duplicate rows.
The activity_type column is an ENUM (category) of type ('open_session', 'end_session', 'scroll_down', 'send_message').
The table shows the user activities for a social media website. 
Note that each session belongs to exactly one user.
 

Write a solution to find the daily active user count for a period of 30 days ending 2019-07-27 inclusively. A user was active on someday if they made at least one activity on that day.

Return the result table in any order.

The result format is in the following example.

 

Example 1:

Input: 
Activity table:
+---------+------------+---------------+---------------+
| user_id | session_id | activity_date | activity_type |
+---------+------------+---------------+---------------+
| 1       | 1          | 2019-07-20    | open_session  |
| 1       | 1          | 2019-07-20    | scroll_down   |
| 1       | 1          | 2019-07-20    | end_session   |
| 2       | 4          | 2019-07-20    | open_session  |
| 2       | 4          | 2019-07-21    | send_message  |
| 2       | 4          | 2019-07-21    | end_session   |
| 3       | 2          | 2019-07-21    | open_session  |
| 3       | 2          | 2019-07-21    | send_message  |
| 3       | 2          | 2019-07-21    | end_session   |
| 4       | 3          | 2019-06-25    | open_session  |
| 4       | 3          | 2019-06-25    | end_session   |
+---------+------------+---------------+---------------+
Output: 
+------------+--------------+ 
| day        | active_users |
+------------+--------------+ 
| 2019-07-20 | 2            |
| 2019-07-21 | 2            |
+------------+--------------+ 
Explanation: Note that we do not care about days with zero active users.

*/

--Solution

SELECT 
  activity_date AS day,
  COUNT(DISTINCT user_id) AS active_users
FROM Activity
WHERE activity_date BETWEEN DATE_SUB('2019-07-27', INTERVAL 29 DAY) AND '2019-07-27'
GROUP BY activity_date
ORDER BY activity_date;

--Notes

/*

This query retrieves the number of unique active users for each day within a 30-day period 
ending on July 27, 2019. It filters the activities to only include those dates between June 28, 2019,
and July 27, 2019, then groups the results by each activity date, counting distinct user IDs to ensure 
each user is counted only once per day. Finally, the results are ordered by the date.

*/