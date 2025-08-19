# Analytics Engineering Technical Exam
This exam is designed to assess your skills in SQL, data modeling, and business problem-solving. The questions are based on common business domains and utilize publicly available BigQuery datasets. For each section, you are presented with a business problem and a series of tasks. You should write a single SQL query (or a set of queries if necessary) to answer all the questions in that section.

---

### Section 1: E-commerce & Sales Analysis
**Business Problem:** A new product manager at a global e-commerce company wants to understand customer behavior and sales performance. They are particularly interested in a specific product category and the journey customers take before making a purchase.

**Dataset:** `bigquery-public-data.google_analytics_sample.ga_sessions_*`

**Task:** Write a SQL query to answer the following questions.
1. **Calculate the conversion rate:** What is the conversion rate (number of sessions with a transaction divided by total sessions) for users who viewed a product page in the 'Apparel' category?
2. **Identify top-selling products:** What are the top 5 most frequently purchased product names and their total revenue within the 'Apparel' category?
3. **Analyze user journey:** For the top-selling product you identified, what are the most common page paths (sequences of page titles) users take before adding the product to their cart? Limit your analysis to the last 3 pages visited.

**Hints:**
- You'll need to use ga_sessions_20170801 as your table for a specific date.
- The hits.page.pagePath and hits.page.pageTitle fields will be useful.
- Look for `hits.eCommerceAction.action_type` to identify specific user events like product_view or purchase.

***

### Section 2: Financial & Market Analysis
**Business Problem:** A finance team is exploring how to predict daily ride-sharing demand in New York City. They suspect that weather conditions and the day of the week are significant factors.

**Dataset:** `bigquery-public-data.new_york.citibike_trips`

**Task:** Write a SQL query to create a table that could be used for a machine learning model to predict daily ridership. The table should include the following columns:
1. **trip_date:** The date of the trip.
2. **day_of_week:** The day of the week (e.g., 'Monday', 'Tuesday').
3. **total_trips:** The total number of trips for that day.
4. **avg_trip_duration:** The average duration of a trip in seconds for that day.
5. **station_density:** The number of unique start stations used on that day.

**Questions:**
- Which day of the week has the highest average number of total trips?
- Is there a clear relationship between station density and total trips? Explain your reasoning.

**Hints:**
- You'll need to use date and time functions.
- Consider using `UNIX_MILLIS` and `EXTRACT` to work with timestamps.

***

### Section 3: Data Quality & Performance Optimization
**Business Problem:** The data engineering team is concerned about data quality in the company's product catalog. They've also been asked to find ways to improve query performance for a common report.

**Dataset:** `bigquery-public-data.thelook_ecommerce.products`

**Task:** Perform two separate tasks on this dataset.
**Part A:** Data Quality
1. **Identify Anomalies:** Write a query that finds products where the cost is greater than the retail_price. How many such products exist?
2. **Find Missing Data:** Write a query that identifies the top 3 product categories with the highest number of missing category values.
**Part B:** Performance Optimization
**Explain a Strategy:** You are told that analysts frequently query this table to find products within a specific brand and category. Explain a strategy to optimize these queries using BigQuery's features. Specifically, mention a partitioning or clustering strategy and justify your choice.
