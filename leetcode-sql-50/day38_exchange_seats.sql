-- SQL 50 Challenge
-- Day 38: Exchange Seats
-- https://leetcode.com/problems/exchange-seats/description

/*

Table: Seat

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| student     | varchar |
+-------------+---------+
id is the primary key (unique value) column for this table.
Each row of this table indicates the name and the ID of a student.
The ID sequence always starts from 1 and increments continuously.
 

Write a solution to swap the seat id of every two consecutive students. If the number of students is odd, the id of the last student is not swapped.

Return the result table ordered by id in ascending order.

The result format is in the following example.

 

Example 1:

Input: 
Seat table:
+----+---------+
| id | student |
+----+---------+
| 1  | Abbot   |
| 2  | Doris   |
| 3  | Emerson |
| 4  | Green   |
| 5  | Jeames  |
+----+---------+
Output: 
+----+---------+
| id | student |
+----+---------+
| 1  | Doris   |
| 2  | Abbot   |
| 3  | Green   |
| 4  | Emerson |
| 5  | Jeames  |
+----+---------+
Explanation: 
Note that if the number of students is odd, there is no need to change the last one's seat.

*/

--Solution

SELECT 
    CASE
        WHEN id  %2 = 1 AND id + 1 in (SELECT id FROM Seat) then id + 1
        WHEN id %2 = 0 THEN id - 1
        ELSE id
    END AS id, student
FROM Seat
ORDER BY id

--Notes

/*

his query goes through each seat in the Seat table and checks whether the seat number (id) is odd or even. 
If the id is odd and the next seat (id + 1) exists in the table, the query returns the next seat's id. If 
the id is even, it returns the previous seat's id. For all other cases, it returns the original id. Essentially, 
this logic pairs each odd-numbered seat with the following even-numbered seat and each even-numbered seat with 
the preceding odd-numbered seat. The results are then ordered by these paired seat numbers, effectively grouping 
adjacent seats together.

*/