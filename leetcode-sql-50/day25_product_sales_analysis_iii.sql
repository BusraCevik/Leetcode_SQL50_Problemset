-- SQL 50 Challenge
-- Day 25: Product Sales Analysis III
-- https://leetcode.com/problems/product-sales-analysis-iii/description

/*

Table: Sales

+-------------+-------+
| Column Name | Type  |
+-------------+-------+
| sale_id     | int   |
| product_id  | int   |
| year        | int   |
| quantity    | int   |
| price       | int   |
+-------------+-------+
(sale_id, year) is the primary key (combination of columns with unique values) of this table.
product_id is a foreign key (reference column) to Product table.
Each row records a sale of a product in a given year.
A product may have multiple sales entries in the same year.
Note that the per-unit price.

Write a solution to find all sales that occurred in the first year each product was sold.

For each product_id, identify the earliest year it appears in the Sales table.

Return all sales entries for that product in that year.

Return a table with the following columns: product_id, first_year, quantity, and price.
Return the result in any order.

 

Example 1:

Input: 
Sales table:
+---------+------------+------+----------+-------+
| sale_id | product_id | year | quantity | price |
+---------+------------+------+----------+-------+ 
| 1       | 100        | 2008 | 10       | 5000  |
| 2       | 100        | 2009 | 12       | 5000  |
| 7       | 200        | 2011 | 15       | 9000  |
+---------+------------+------+----------+-------+

Output: 
+------------+------------+----------+-------+
| product_id | first_year | quantity | price |
+------------+------------+----------+-------+ 
| 100        | 2008       | 10       | 5000  |
| 200        | 2011       | 15       | 9000  |
+------------+------------+----------+-------+

*/

--Solution

WITH first_year_record AS(
    SELECT product_id, MIN(year) AS first_year
    FROM Sales
    GROUP BY product_id
)
SELECT s.product_id, f.first_year, s.quantity, s.price
FROM Sales AS s
INNER JOIN first_year_record AS f
ON s.product_id = f.product_id AND s.year = f.first_year


--Notes

/*

This query finds all sales that occurred in the first year each product 
was sold. First, it creates a temporary table called first_year_record 
that stores the earliest sale year for each product using the MIN(year) 
function grouped by product_id. Then, it joins this temporary table with 
the original Sales table, matching both the product_id and the year to 
ensure only the records from the product's first year of sale are selected. 
Finally, it returns the product ID, the first year, quantity sold, and price 
for those specific sales.

*/