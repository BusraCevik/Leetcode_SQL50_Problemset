-- SQL 50 Challenge
-- Day 33: Consecutive Numbers
--https://leetcode.com/problems/consecutive-numbers/description

/*

Table: Logs

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| num         | varchar |
+-------------+---------+
In SQL, id is the primary key for this table.
id is an autoincrement column starting from 1.
 

Find all numbers that appear at least three times consecutively.

Return the result table in any order.

The result format is in the following example.

 

Example 1:

Input: 
Logs table:
+----+-----+
| id | num |
+----+-----+
| 1  | 1   |
| 2  | 1   |
| 3  | 1   |
| 4  | 2   |
| 5  | 1   |
| 6  | 2   |
| 7  | 2   |
+----+-----+
Output: 
+-----------------+
| ConsecutiveNums |
+-----------------+
| 1               |
+-----------------+
Explanation: 1 is the only number that appears consecutively for at least three times.

*/

--Solution

SELECT DISTINCT num AS ConsecutiveNums
From (
     SELECT 
        num,
        LAG(num, 1) OVER (ORDER BY id) AS priv1,
        LAG(num, 2) OVER (ORDER BY id) AS priv2
    FROM Logs
)AS t
WHERE num= priv1 AND num=priv2;

--Notes

/*

This SQL query solves the classic LeetCode Consecutive Numbers problem. 
It uses the LAG() window function to compare the current row’s value with 
the previous two rows. If all three values are the same, it means the number 
appears at least three times consecutively. The query selects those numbers 
using a DISTINCT clause to avoid duplicates. This approach is clean, efficient, 
and avoids complex grouping logic, making it ideal for sequence-based problems.

*/