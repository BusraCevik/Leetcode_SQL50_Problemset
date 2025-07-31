-- SQL 50 Challenge
-- Day 28: Biggest Single Number
--https://leetcode.com/problems/biggest-single-number/description

/*

Table: MyNumbers

+-------------+------+
| Column Name | Type |
+-------------+------+
| num         | int  |
+-------------+------+
This table may contain duplicates (In other words, there is no primary key for this table in SQL).
Each row of this table contains an integer.
 

A single number is a number that appeared only once in the MyNumbers table.

Find the largest single number. If there is no single number, report null.

The result format is in the following example.

 

Example 1:

Input: 
MyNumbers table:
+-----+
| num |
+-----+
| 8   |
| 8   |
| 3   |
| 3   |
| 1   |
| 4   |
| 5   |
| 6   |
+-----+
Output: 
+-----+
| num |
+-----+
| 6   |
+-----+
Explanation: The single numbers are 1, 4, 5, and 6.
Since 6 is the largest single number, we return it.
Example 2:

Input: 
MyNumbers table:
+-----+
| num |
+-----+
| 8   |
| 8   |
| 7   |
| 7   |
| 3   |
| 3   |
| 3   |
+-----+
Output: 
+------+
| num  |
+------+
| null |
+------+
Explanation: There are no single numbers in the input table so we return null.

*/

--Solution 

WITH single_numbers AS (
    SELECT num AS single_nums
    FROM MyNumbers
    GROUP BY num
    HAVING COUNT(num) = 1 
)
SELECT MAX(single_nums) AS num
FROM single_numbers

----

SELECT MAX(num) AS num
FROM MyNumbers
GROUP BY num
HAVING COUNT(num)



--Notes

/*

This problem can be solved either by using a Common Table Expression (CTE) 
or in a single aggregated query. In the CTE approach, we first identify 
all numbers that appear exactly once by grouping the dataset and filtering 
with HAVING COUNT(num) = 1. From this intermediate result set, we then select 
the maximum value. Alternatively, in the single-query approach, we apply the 
same grouping and HAVING condition directly, using MAX(num) to retrieve the 
largest single-occurrence number. In both cases, if no number meets the single-
occurrence condition, the HAVING clause eliminates all rows, and MAX() evaluated 
over an empty result set will return NULL, ensuring the correct output format.

*/