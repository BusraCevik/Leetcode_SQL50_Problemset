-- SQL 50 Challenge
-- Day 09: Rising Temperature 
--https://leetcode.com/problems/rising-temperature/description

/*

Table: Weather

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| id            | int     |
| recordDate    | date    |
| temperature   | int     |
+---------------+---------+
id is the column with unique values for this table.
There are no different rows with the same recordDate.
This table contains information about the temperature on a certain day.
 

Write a solution to find all dates' id with higher temperatures compared to its previous dates (yesterday).

Return the result table in any order.

The result format is in the following example.

 

Example 1:

Input: 
Weather table:
+----+------------+-------------+
| id | recordDate | temperature |
+----+------------+-------------+
| 1  | 2015-01-01 | 10          |
| 2  | 2015-01-02 | 25          |
| 3  | 2015-01-03 | 20          |
| 4  | 2015-01-04 | 30          |
+----+------------+-------------+
Output: 
+----+
| id |
+----+
| 2  |
| 4  |
+----+
Explanation: 
In 2015-01-02, the temperature was higher than the previous day (10 -> 25).
In 2015-01-04, the temperature was higher than the previous day (20 -> 30).

*/

--Solution

SELECT A.id
FROM Weather A, Weather B
WHERE A.recordDate = DATE_ADD(B.recordDate, INTERVAL 1 DAY)
AND A.temperature > B.temperature;

--Notes

/*
This query uses a self-join on the Weather table by creating two aliases, A and B.
It matches each record in A with the record in B where A's date is exactly one day after B's date (A.recordDate = DATE_ADD(B.recordDate, INTERVAL 1 DAY)).
Then, it filters these pairs to only include cases where the temperature on day A is higher than the temperature on day B.
Finally, the query returns the IDs of all dates where the temperature was higher than the previous day.*/