/*
Exercise 3: Complex Joins and Aggregation
Using the bigquery-public-data.stackoverflow dataset, specifically the posts_questions and posts_answers tables:

1. Objective: Find the top 10 questions (by view count) that have a "good" accepted answer. A "good" answer is defined as one with an accepted_answer_id and a score greater than 5.
2. Task:
  - Join posts_questions with posts_answers on the accepted_answer_id to link questions to their accepted answers.
  - Filter for answers with a score > 5.
  - Select the title and view_count from the questions table.
  - Order the results by view_count in descending order and limit to 10.
3. Output: Your query should return the title and view_count of the top 10 questions that meet the criteria.
*/

SELECT * FROM `bigquery-public-data.stackoverflow.posts_questions` LIMIT 10;

SELECT * FROM `bigquery-public-data.stackoverflow.posts_answers` LIMIT 10;

SELECT
  q.title,
  q.view_count
FROM `bigquery-public-data.stackoverflow.posts_questions` q
INNER JOIN `bigquery-public-data.stackoverflow.posts_answers` a ON q.accepted_answer_id = a.id -- uses inner join such that it only gets the question title and view count with an answer with a score > 5
WHERE a.score > 5
ORDER BY view_count DESC
LIMIT 10;
