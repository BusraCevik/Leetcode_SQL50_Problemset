-- SQL 50 Challenge
-- Day 21: Immediate Food Delivery II
-- https://leetcode.com/problems/immediate-food-delivery-ii/description

/*

Table: Delivery

+-----------------------------+---------+
| Column Name                 | Type    |
+-----------------------------+---------+
| delivery_id                 | int     |
| customer_id                 | int     |
| order_date                  | date    |
| customer_pref_delivery_date | date    |
+-----------------------------+---------+
delivery_id is the column of unique values of this table.
The table holds information about food delivery to customers that make orders at some date and specify a preferred delivery date (on the same order date or after it).
 

If the customer's preferred delivery date is the same as the order date, then the order is called immediate; otherwise, it is called scheduled.

The first order of a customer is the order with the earliest order date that the customer made. It is guaranteed that a customer has precisely one first order.

Write a solution to find the percentage of immediate orders in the first orders of all customers, rounded to 2 decimal places.

The result format is in the following example.

 

Example 1:

Input: 
Delivery table:
+-------------+-------------+------------+-----------------------------+
| delivery_id | customer_id | order_date | customer_pref_delivery_date |
+-------------+-------------+------------+-----------------------------+
| 1           | 1           | 2019-08-01 | 2019-08-02                  |
| 2           | 2           | 2019-08-02 | 2019-08-02                  |
| 3           | 1           | 2019-08-11 | 2019-08-12                  |
| 4           | 3           | 2019-08-24 | 2019-08-24                  |
| 5           | 3           | 2019-08-21 | 2019-08-22                  |
| 6           | 2           | 2019-08-11 | 2019-08-13                  |
| 7           | 4           | 2019-08-09 | 2019-08-09                  |
+-------------+-------------+------------+-----------------------------+
Output: 
+----------------------+
| immediate_percentage |
+----------------------+
| 50.00                |
+----------------------+
Explanation: 
The customer id 1 has a first order with delivery id 1 and it is scheduled.
The customer id 2 has a first order with delivery id 2 and it is immediate.
The customer id 3 has a first order with delivery id 5 and it is scheduled.
The customer id 4 has a first order with delivery id 7 and it is immediate.
Hence, half the customers have immediate first orders.

*/

--Solution

WITH order_status AS (
  SELECT 
    delivery_id,
    customer_id,
    order_date,
    customer_pref_delivery_date,
    IF(order_date = customer_pref_delivery_date, 'immediate', 'scheduled') AS status
  FROM Delivery
),
first_orders AS (
  SELECT 
    customer_id, 
    MIN(order_date) AS first_order_date
  FROM Delivery
  GROUP BY customer_id
),
first_order_status AS (
  SELECT 
    os.customer_id,
    os.status
  FROM order_status os
  JOIN first_orders fo 
    ON os.customer_id = fo.customer_id AND os.order_date = fo.first_order_date
)

SELECT 
  ROUND(SUM(status = 'immediate') * 100.0 / COUNT(*), 2) AS immediate_percentage
FROM first_order_status;

--Notes

/*

This SQL query calculates the percentage of customers whose first order was delivered 
immediately, meaning their preferred delivery date was the same as their order date. First, 
it labels each order as either "immediate" or "scheduled" by comparing the order_date with 
the customer_pref_delivery_date. Then, it identifies the first order for each customer based 
on the earliest order_date. After that, it filters the dataset to keep only these first orders 
and their corresponding statuses. Finally, it computes the percentage of these first orders that 
were immediate by dividing the count of "immediate" ones by the total number of first orders, 
rounding the result to two decimal places.

*/