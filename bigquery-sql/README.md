### [Exercise 1: Customer Segmentation and RFM Analysis](https://github.com/alyllanes/ae-mock-exams/blob/main/bigquery-sql/exercise-1.sql)
Using the `bigquery-public-data.thelook_ecommerce` dataset:

1. **Objective:** Calculate the Recency, Frequency, and Monetary (RFM) values for each customer.
2. **Recency:** Calculate the number of days since each customer's most recent order.
3. **Frequency:** Count the total number of orders for each customer.
4. **Monetary:** Calculate the total spend for each customer.
5. **Output:** Your query should return customer_id, recency, frequency, and monetary values.

### [Exercise 2: Time Series Analysis with Window Functions](https://github.com/alyllanes/ae-mock-exams/blob/main/bigquery-sql/exercise-2.sql)
Using the `bigquery-public-data.google_analytics_sample.ga_sessions` table:

1. **Objective:** Find the running total of `totalTransactionRevenue` over time, partitioned by `fullVisitorId`.
2. **Challenge:** The `totalTransactionRevenue` field is a record or struct, and you'll need to use (.) to access a value. (ex. `totals.TransactionRevenue`) 
3. **Task:** Write a query that shows the daily cumulative revenue for each visitor.
4. **Output:** The result should include `date`, `fullVisitorId`, `totalTransactionRevenue`, and the `running_total_revenue`.

### [Exercise 3: Complex Joins and Aggregation](https://github.com/alyllanes/ae-mock-exams/blob/main/bigquery-sql/exercise-3.sql)
Using the `bigquery-public-data.stackoverflow` dataset, specifically the posts_questions and posts_answers tables:

1. **Objective:** Find the top 10 questions (by view count) that have a "good" accepted answer. A "good" answer is defined as one with an `accepted_answer_id` and a score greater than 5.
2. **Task:**
    - Join posts_questions with posts_answers on the `accepted_answer_id` to link questions to their accepted answers.
    - Filter for answers with a score > 5.
    - Select the title and view_count from the questions table.
    - Order the results by view_count in descending order and limit to 10.
3. **Output:** Your query should return the title and view_count of the top 10 questions that meet the criteria.

### [Exercise 4: Data Deduplication and CTEs (Common Table Expressions)](https://github.com/alyllanes/ae-mock-exams/blob/main/bigquery-sql/exercise-4.sql)
Using the `bigquery-public-data.chicago_crime.crime` table:

1. **Objective:** Identify and remove duplicate crime records. A record is considered a duplicate if it has the same ID and Case Number.
2. **Task:**
    - Use a Common Table Expression (CTE) and a window function like `ROW_NUMBER()` to assign a unique number to each row within a partition of ID and Case Number.
    - Filter for rows where the row number is equal to 1 to get only the unique records.
3. **Output:** The final query should return a result set containing only the distinct crime records.

### Exercise 5: Handling Nested and Repeated Data
Using the `bigquery-public-data.github_repos.sample_contents` table:

1. **Objective:** Count the number of distinct programming languages used across all files in a specific GitHub repository.
2. **Task:**
    - Filter the table for a repository of your choice (e.g., google/go-github).
    - The content field is a `STRING` that contains nested JSON-like data. You'll need to extract the file extension (e.g., .py, .js, .go) from the path field to determine the language.
    - Use the `UNNEST()` function to flatten the sample_contents nested array.
    - Count the number of distinct file extensions/languages.
3. **Output:** A single row with the repository name and the count of distinct languages.

### Exercise 6: Working with Arrays
Using the `bigquery-public-data.stackoverflow.posts_questions` table:

1. **Objective:** Find the top 5 most used tags on Stack Overflow questions in the last year.
2. **Task:**
    - Filter the table for questions asked in the last 12 months.
    - The tags column is an array of strings. You'll need to unnest it to count the frequency of each tag.
    - Use `GROUP BY` and `COUNT()` to aggregate the counts for each tag.
    - Order the results in descending order and limit to 5.
3. **Output:** A list of the top 5 tags and their respective counts.

### Exercise 7: Subqueries and Date Manipulation
Using the `bigquery-public-data.google_analytics_sample.ga_sessions` table:

1. **Objective:*8 Find the number of new visitors and their total revenue for each day. A "new visitor" is someone whose first-ever visit was on that specific day.
2. **Task:**
    - Use a subquery or a CTE to determine the first visit date for each `fullVisitorId`.
    - Use this first visit date to identify new visitors for each day.
    - Join the result back to the original table to sum `totalTransactionRevenue` for those new visitors.
3. **Output:** A list with `date`, `number_of_new_visitors`, and `total_revenue_from_new_visitors`.

Exercise 8: Performance and Query Optimization
Using the `bigquery-public-data.chicago_taxi_trips.taxi_trips` table:

1. **Objective:** Calculate the average trip duration for each hour of the day.
2. **Challenge:** The `trip_start_timestamp` column is a `TIMESTAMP`. You must extract the hour of the day efficiently. This is a very large table, so wildcard tables and partitioning are important concepts here.
3. **Task:**
    - Use a wildcard table query (e.g., `bigquery-public-data.chicago_taxi_trips.taxi_trips_*`) to scan data only from a specific year (e.g., 2018) to reduce the data processed.
    - Use a date function like `EXTRACT` to get the hour from the `trip_start_timestamp`.
    - Calculate the trip_seconds as the difference between the start and end timestamps.
    - Group by the hour and calculate the average `trip_seconds`.
4. **Output:** A list showing the `hour_of_day` and the `average_trip_duration_seconds`.

### Exercise 9: Geospatial Data and GEOGRAPHY Functions
Using the `bigquery-public-data.london_bicycles.cycle_hire` table:

1. **Objective:** Find the top 5 starting stations that are closest to a specific point of interest. Assume the point is at coordinates (51.5173, -0.1402) for this exercise.
2. **Task:**
    - Use BigQuery's `GEOGRAPHY` data type and functions.
    - Convert the latitude and longitude of each station into a GEOGRAPHY point using `ST_GEOGPOINT()`.
    - Use `ST_DISTANCE()` to calculate the distance between each station's point and the specified point of interest.
    - Order the results by distance and limit to 5.
3. **Output:** A list of the `start_station_name` and the `distance_to_point_of_interest_meters`.

### Exercise 10: Combining Multiple Datasets with UNION ALL
Using the `bigquery-public-data.new_york_taxi_trips.tlc_green_trips` and `bigquery-public-data.new_york_taxi_trips.tlc_yellow_trips` tables:

1. **Objective:** Find the total number of rides and average fare for each month across both green and yellow taxi trips in 2018.
2. **Task:**
    - Use `UNION ALL` to combine the datasets from the two different taxi tables.
    - **Note:** You'll need to select consistent columns and data types from both tables before performing the `UNION ALL`. A common approach is to select `trip_start_timestamp` and `total_amount` from both.
    - Filter the combined result for records from the year 2018.
    - Group by month and calculate the `COUNT()` of rides and `AVG()` of the total fare.
3. **Output:** A list of `year`, `month`, `total_rides`, and `average_fare`.
