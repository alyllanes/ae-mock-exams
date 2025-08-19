/*
Exercise 6: Working with Arrays
Using the bigquery-public-data.stackoverflow.posts_questions table:

1. Objective: Find the top 5 most used tags on Stack Overflow questions in the last year.
2. Task:
  - Filter the table for questions asked in the last 12 months.
  - The tags column is an array of strings. You'll need to unnest it to count the frequency of each tag.
  - Use GROUP BY and COUNT() to aggregate the counts for each tag.
  - Order the results in descending order and limit to 5.
3. Output: A list of the top 5 tags and their respective counts.
*/

-- Previewing the first 10 rows of the table
SELECT * FROM `bigquery-public-data.stackoverflow.posts_questions` LIMIT 10;

-- Output
WITH unnest_tags AS (
  SELECT * FROM `bigquery-public-data.stackoverflow.posts_questions`, UNNEST(SPLIT(tags, '|')) AS tag
  ),

  tag_frequency AS (
    SELECT 
      tag, 
      COUNT(id) AS count_per_tag
    FROM unnest_tags
    GROUP BY 1
  )

SELECT * FROM tag_frequency
ORDER BY count_per_tag DESC
LIMIT 5;
