-- SQL 50 Challenge
-- Day 47: Second Highest Salary
--https://leetcode.com/problems/second-highest-salary/description

/*

Table: Employee

+-------------+------+
| Column Name | Type |
+-------------+------+
| id          | int  |
| salary      | int  |
+-------------+------+
id is the primary key (column with unique values) for this table.
Each row of this table contains information about the salary of an employee.
 

Write a solution to find the second highest distinct salary from the Employee table. If there is no second highest salary, return null (return None in Pandas).

The result format is in the following example.

 

Example 1:

Input: 
Employee table:
+----+--------+
| id | salary |
+----+--------+
| 1  | 100    |
| 2  | 200    |
| 3  | 300    |
+----+--------+
Output: 
+---------------------+
| SecondHighestSalary |
+---------------------+
| 200                 |
+---------------------+
Example 2:

Input: 
Employee table:
+----+--------+
| id | salary |
+----+--------+
| 1  | 100    |
+----+--------+
Output: 
+---------------------+
| SecondHighestSalary |
+---------------------+
| null                |
+---------------------+
 


*/

--Solution

SELECT 
    (SELECT DISTINCT salary 
     FROM Employee 
     ORDER BY salary DESC 
     LIMIT 1 OFFSET 1) AS SecondHighestSalary;


--Notes

/*

This query finds the second highest distinct salary from the Employee table. 
The inner subquery selects all unique salaries, orders them from highest to 
lowest (DESC), and then skips the first salary (OFFSET 1) to get the second 
highest. The LIMIT 1 ensures that only one value is returned. If there is no 
second highest salary, the query returns NULL.

*/