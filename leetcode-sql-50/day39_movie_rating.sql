-- SQL 50 Challenge
-- Day 39: Movie Rating
-- https://leetcode.com/problems/movie-rating

/*

able: Movies

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| movie_id      | int     |
| title         | varchar |
+---------------+---------+
movie_id is the primary key (column with unique values) for this table.
title is the name of the movie.
 

Table: Users

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| user_id       | int     |
| name          | varchar |
+---------------+---------+
user_id is the primary key (column with unique values) for this table.
The column 'name' has unique values.
Table: MovieRating

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| movie_id      | int     |
| user_id       | int     |
| rating        | int     |
| created_at    | date    |
+---------------+---------+
(movie_id, user_id) is the primary key (column with unique values) for this table.
This table contains the rating of a movie by a user in their review.
created_at is the user's review date. 
 

Write a solution to:

Find the name of the user who has rated the greatest number of movies. In case of a tie, return the lexicographically smaller user name.
Find the movie name with the highest average rating in February 2020. In case of a tie, return the lexicographically smaller movie name.
The result format is in the following example.

 

Example 1:

Input: 
Movies table:
+-------------+--------------+
| movie_id    |  title       |
+-------------+--------------+
| 1           | Avengers     |
| 2           | Frozen 2     |
| 3           | Joker        |
+-------------+--------------+
Users table:
+-------------+--------------+
| user_id     |  name        |
+-------------+--------------+
| 1           | Daniel       |
| 2           | Monica       |
| 3           | Maria        |
| 4           | James        |
+-------------+--------------+
MovieRating table:
+-------------+--------------+--------------+-------------+
| movie_id    | user_id      | rating       | created_at  |
+-------------+--------------+--------------+-------------+
| 1           | 1            | 3            | 2020-01-12  |
| 1           | 2            | 4            | 2020-02-11  |
| 1           | 3            | 2            | 2020-02-12  |
| 1           | 4            | 1            | 2020-01-01  |
| 2           | 1            | 5            | 2020-02-17  | 
| 2           | 2            | 2            | 2020-02-01  | 
| 2           | 3            | 2            | 2020-03-01  |
| 3           | 1            | 3            | 2020-02-22  | 
| 3           | 2            | 4            | 2020-02-25  | 
+-------------+--------------+--------------+-------------+
Output: 
+--------------+
| results      |
+--------------+
| Daniel       |
| Frozen 2     |
+--------------+
Explanation: 
Daniel and Monica have rated 3 movies ("Avengers", "Frozen 2" and "Joker") but Daniel is smaller lexicographically.
Frozen 2 and Joker have a rating average of 3.5 in February but Frozen 2 is smaller lexicographically.

*/

--Solution

(
    SELECT u.name AS results
    FROM Users u
    JOIN (
        SELECT user_id, COUNT(*) AS cnt
        FROM MovieRating
        GROUP BY user_id
    ) AS counts ON u.user_id = counts.user_id
    WHERE counts.cnt = (
        SELECT MAX(cnt)
        FROM (
            SELECT user_id, COUNT(*) AS cnt
            FROM MovieRating
            GROUP BY user_id
        ) AS counts2
    )
    ORDER BY u.name
    LIMIT 1
)
UNION ALL
(
    SELECT m.title AS results
    FROM Movies m
    JOIN (
        SELECT movie_id, AVG(rating) AS avg_rating
        FROM MovieRating
        WHERE created_at >= '2020-02-01' AND created_at < '2020-03-01'
        GROUP BY movie_id
    ) AS avg_ratings ON m.movie_id = avg_ratings.movie_id
    WHERE avg_ratings.avg_rating = (
        SELECT MAX(avg_rating)
        FROM (
            SELECT movie_id, AVG(rating) AS avg_rating
            FROM MovieRating
            WHERE created_at >= '2020-02-01' AND created_at < '2020-03-01'
            GROUP BY movie_id
        ) AS max_avg
    )
    ORDER BY m.title
    LIMIT 1
);


--Notes

/*

This query is split into two main parts joined with UNION ALL, so the results appear in 
two separate rows in the final output. The first part finds the user who has rated the 
greatest number of movies. It groups MovieRating by user_id, counts the number of ratings 
per user, and compares it with the maximum count to get only the top user(s). In case of a tie, 
it uses ORDER BY name and LIMIT 1 to return the lexicographically smallest name.
The second part finds the movie with the highest average rating in February 2020. It filters 
MovieRating for reviews within February 2020, groups by movie_id, calculates the average rating 
for each movie, and compares it with the maximum average rating. In case of a tie, it orders by 
the movie title alphabetically and picks the first one. UNION ALL is used instead of UNION because 
we want to keep both results — one for the user name and one for the movie title — without removing 
duplicates, even though in this problem they will be different values.

*/