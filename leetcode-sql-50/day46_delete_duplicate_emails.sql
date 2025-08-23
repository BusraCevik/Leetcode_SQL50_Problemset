-- SQL 50 Challenge
-- Day 46: Delete Duplicate Emails
--https://leetcode.com/problems/delete-duplicate-emails/description

/*

Table: Person

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| email       | varchar |
+-------------+---------+
id is the primary key (column with unique values) for this table.
Each row of this table contains an email. The emails will not contain uppercase letters.
 

Write a solution to delete all duplicate emails, keeping only one unique email with the smallest id.

For SQL users, please note that you are supposed to write a DELETE statement and not a SELECT one.

For Pandas users, please note that you are supposed to modify Person in place.

After running your script, the answer shown is the Person table. The driver will first compile and run your piece of code and then show the Person table. The final order of the Person table does not matter.

The result format is in the following example.

 

Example 1:

Input: 
Person table:
+----+------------------+
| id | email            |
+----+------------------+
| 1  | john@example.com |
| 2  | bob@example.com  |
| 3  | john@example.com |
+----+------------------+
Output: 
+----+------------------+
| id | email            |
+----+------------------+
| 1  | john@example.com |
| 2  | bob@example.com  |
+----+------------------+
Explanation: john@example.com is repeated two times. We keep the row with the smallest Id = 1.


*/

--Solution

DELETE FROM Person
WHERE id NOT IN (
    SELECT id FROM (
        SELECT MIN(id) as id
        FROM Person
        GROUP BY email
    ) AS t
);

--Notes

/*

This query deletes all duplicate emails from the Person table while keeping 
only the row with the smallest id for each unique email. The inner subquery 
SELECT MIN(id) ... GROUP BY email finds the smallest id for every email, 
ensuring we keep one unique entry. Since MySQL does not allow deleting from 
the same table that is used in a subquery, we wrap this result inside another 
subquery (AS t). Finally, the DELETE removes every row whose id is not in that 
list of smallest IDs, leaving only one record per email in the table.

*/
