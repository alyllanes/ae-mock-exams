/*
Exercise 7: Subqueries/CTEs, Date Manipulation
Using the bigquery-public-data.google_analytics_sample.ga_sessions table:

1. Objective: Find the number of new visitors and their total revenue for each day. A "new visitor" is someone whose first-ever visit was on that specific day.
2. Task:
  - Use a subquery or a CTE to determine the first visit date for each fullVisitorId.
  - Use this first visit date to identify new visitors for each day.
  - Join the result back to the original table to sum totalTransactionRevenue for those new visitors.
3. Output: A list with date, number_of_new_visitors, and total_revenue_from_new_visitors.
*/

-- Previewing the table
SELECT * FROM `bigquery-public-data.google_analytics_sample.ga_sessions_*` LIMIT 10;

-- CTE 
WITH 
-- gets the date of the first visit per visitor
first_visit AS (
  SELECT 
    fullVisitorId,
    MIN(PARSE_DATE('%Y%m%d', date)) AS first_visit,
  FROM `bigquery-public-data.google_analytics_sample.ga_sessions_*`
  WHERE fullVisitorId IS NOT NULL
  GROUP BY 1
)

SELECT
  PARSE_DATE('%Y%m%d', date) AS date,
  COUNT(DISTINCT fv.fullVisitorId) AS number_of_new_visitors,
  SUM(totals.transactionRevenue)/1000000 AS total_revenue_from_new_visitors -- since the revenue is in a micro unit format in google analytics - primarily used by Universal Analytics (UA) 
FROM `bigquery-public-data.google_analytics_sample.ga_sessions_*` ga
-- joins the first visit CTE to the main table
INNER JOIN first_visit fv ON ga.fullVisitorId = fv.fullVisitorId AND PARSE_DATE('%Y%m%d', ga.date) = fv.first_visit
GROUP BY 1
ORDER BY date;
