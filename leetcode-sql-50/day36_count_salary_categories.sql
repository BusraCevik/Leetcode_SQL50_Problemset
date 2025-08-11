-- SQL 50 Challenge
-- Day 36: Count Salary Categories
-- https://leetcode.com/problems/count-salary-categories/description

/*

Table: Accounts

+-------------+------+
| Column Name | Type |
+-------------+------+
| account_id  | int  |
| income      | int  |
+-------------+------+
account_id is the primary key (column with unique values) for this table.
Each row contains information about the monthly income for one bank account.
 

Write a solution to calculate the number of bank accounts for each salary category. The salary categories are:

"Low Salary": All the salaries strictly less than $20000.
"Average Salary": All the salaries in the inclusive range [$20000, $50000].
"High Salary": All the salaries strictly greater than $50000.
The result table must contain all three categories. If there are no accounts in a category, return 0.

Return the result table in any order.

The result format is in the following example.

 

Example 1:

Input: 
Accounts table:
+------------+--------+
| account_id | income |
+------------+--------+
| 3          | 108939 |
| 2          | 12747  |
| 8          | 87709  |
| 6          | 91796  |
+------------+--------+
Output: 
+----------------+----------------+
| category       | accounts_count |
+----------------+----------------+
| Low Salary     | 1              |
| Average Salary | 0              |
| High Salary    | 3              |
+----------------+----------------+
Explanation: 
Low Salary: Account 2.
Average Salary: No accounts.
High Salary: Accounts 3, 6, and 8.

*/

--Solution

# Write your MySQL query statement below
WITH all_categories AS (
    SELECT 'Low Salary' AS category
    UNION ALL
    SELECT 'Average Salary'
    UNION ALL
    SELECT 'High Salary'
),
categories AS (
    SELECT account_id, income,
    CASE
        WHEN income < 20000 THEN 'Low Salary'
        WHEN income BETWEEN 20000 AND 50000 THEN 'Average Salary'
        ELSE 'High Salary'
    END AS category
    FROM Accounts
)
SELECT ac.category, 
       COALESCE(COUNT(c.account_id), 0) AS accounts_count
FROM all_categories ac
LEFT JOIN categories c 
    ON ac.category = c.category
GROUP BY ac.category;


--Notes

/*

This query first defines all possible salary categories. Then, it assigns 
each account to a category based on income. Finally, it left joins the full 
list of categories with the assigned accounts to ensure all categories are 
included, counting the number of accounts in each. If a category has no 
accounts, it returns zero instead of excluding it.

*/
