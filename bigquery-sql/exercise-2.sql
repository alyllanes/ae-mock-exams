/*
Exercise 2: Time Series Analysis with Window Functions
Using the bigquery-public-data.google_analytics_sample.ga_sessions_* table:

1. Objective: Find the running total of totalTransactionRevenue over time, partitioned by fullVisitorId.
2. Challenge: The totalTransactionRevenue field is nested and you'll need to use UNNEST() to access it.
3. Task: Write a query that shows the daily cumulative revenue for each visitor.
4. Output: The result should include date, fullVisitorId, totalTransactionRevenue, and the running_total_revenue.
*/

-- Previewing the first 10 rows of the table
SELECT * FROM `bigquery-public-data.google_analytics_sample.ga_sessions_*` LIMIT 10;

-- Used CTEs to provide a clear and organized query to do the task:
WITH daily_total_revenue AS (
  SELECT
    date,
    fullVisitorId,
    sum(totals.TransactionRevenue) AS totalTransactionRevenue -- Have to get the sum of the totals.TransactionRevenue since it is possible for one date to have multiple Transaction Revenues in one day
  FROM `bigquery-public-data.google_analytics_sample.ga_sessions_*`
  GROUP BY 1, 2
),

running_total_revenue as (
  select
    date,
    fullVisitorId,
    totalTransactionRevenue,
    sum(totalTransactionRevenue) over (partition by fullVisitorId order by date range between unbounded preceding and current row) as running_total_revenue -- this gets the running total of the totalTransactionRevenue; the use of the "range between unbounded preceding and current row" is used as the window frame
  from daily_total_revenue
)

select * from running_total_revenue
-- testing the query using one fullVisitorId, optional and can be commented out:
where fullVisitorId = '0111624627546859050'
order by date asc;
