-- SQL 50 Challenge
-- Day 19: Queries Quality and Percentage
-- https://leetcode.com/problems/queries-quality-and-percentage/description

/*

Table: Queries

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| query_name  | varchar |
| result      | varchar |
| position    | int     |
| rating      | int     |
+-------------+---------+
This table may have duplicate rows.
This table contains information collected from some queries on a database.
The position column has a value from 1 to 500.
The rating column has a value from 1 to 5. Query with rating less than 3 is a poor query.
 

We define query quality as:

The average of the ratio between query rating and its position.

We also define poor query percentage as:

The percentage of all queries with rating less than 3.

Write a solution to find each query_name, the quality and poor_query_percentage.

Both quality and poor_query_percentage should be rounded to 2 decimal places.

Return the result table in any order.

The result format is in the following example.

 

Example 1:

Input: 
Queries table:
+------------+-------------------+----------+--------+
| query_name | result            | position | rating |
+------------+-------------------+----------+--------+
| Dog        | Golden Retriever  | 1        | 5      |
| Dog        | German Shepherd   | 2        | 5      |
| Dog        | Mule              | 200      | 1      |
| Cat        | Shirazi           | 5        | 2      |
| Cat        | Siamese           | 3        | 3      |
| Cat        | Sphynx            | 7        | 4      |
+------------+-------------------+----------+--------+
Output: 
+------------+---------+-----------------------+
| query_name | quality | poor_query_percentage |
+------------+---------+-----------------------+
| Dog        | 2.50    | 33.33                 |
| Cat        | 0.66    | 33.33                 |
+------------+---------+-----------------------+
Explanation: 
Dog queries quality is ((5 / 1) + (5 / 2) + (1 / 200)) / 3 = 2.50
Dog queries poor_ query_percentage is (1 / 3) * 100 = 33.33

Cat queries quality equals ((2 / 5) + (3 / 3) + (4 / 7)) / 3 = 0.66
Cat queries poor_ query_percentage is (1 / 3) * 100 = 33.33

*/

--Solution

WITH stats AS (
    SELECT 
        query_name,
        COUNT(*) AS total_count,
        SUM(CASE WHEN rating < 3 THEN 1 ELSE 0 END) AS poor_count,
        AVG(rating * 1.0 / position) AS avg_quality
    FROM Queries
    GROUP BY query_name
)

SELECT 
    query_name,
    ROUND(avg_quality, 2) AS quality,
    ROUND(poor_count * 100.0 / total_count, 2) AS poor_query_percentage
FROM stats;

--Notes

/*

This query calculates some statistics for each query_name using a common table expression 
called stats. It counts the total number of queries, the number of poor queries where the rating 
is less than 3, and also calculates the average of the rating divided by the position to measure 
the quality of the queries. In the final selection, it rounds the average quality to two decimal 
places and computes the poor query percentage by dividing the number of poor queries by the total 
number of queries and multiplying by 100.

*/