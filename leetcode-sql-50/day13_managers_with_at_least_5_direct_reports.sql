-- SQL 50 Challenge
-- Day 13: Managers With At Least 5 Direct Reports
-- https://leetcode.com/problems/managers-with-at-least-5-direct-reports/description

/*

Table: Employee

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| name        | varchar |
| department  | varchar |
| managerId   | int     |
+-------------+---------+
id is the primary key (column with unique values) for this table.
Each row of this table indicates the name of an employee, their department, and the id of their manager.
If managerId is null, then the employee does not have a manager.
No employee will be the manager of themself.
 

Write a solution to find managers with at least five direct reports.

Return the result table in any order.

The result format is in the following example.

 

Example 1:

Input: 
Employee table:
+-----+-------+------------+-----------+
| id  | name  | department | managerId |
+-----+-------+------------+-----------+
| 101 | John  | A          | null      |
| 102 | Dan   | A          | 101       |
| 103 | James | A          | 101       |
| 104 | Amy   | A          | 101       |
| 105 | Anne  | A          | 101       |
| 106 | Ron   | B          | 101       |
+-----+-------+------------+-----------+
Output: 
+------+
| name |
+------+
| John |
+------+

*/

--Solution

Select e.name
From Employee As e
Join(
Select managerId 
From Employee
Where managerId Is Not Null
Group By managerId
Having count(*)>=5
) sub
On e.id = sub.managerId

--Notes

/*

This query finds the names of employees who are managers 
with at least 5 direct reports. First, the subquery groups 
employees by managerId and filters only those managers who 
have 5 or more people reporting to them. Then, the main query 
joins this result with the Employee table to find the names of 
those managers by matching id to managerId. Finally, it returns 
the names of these managers.

*/
