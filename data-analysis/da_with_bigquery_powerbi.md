# Data Analysis with BigQuery and Power BI Technical Exam
This exam assesses your ability to perform data analysis in a cloud data warehouse and present your findings in a professional business intelligence tool. The exam is split into two sections: a hands-on BigQuery task and a conceptual Power BI dashboard design task.

---

### Section 1: Data Analysis with BigQuery SQL
**Business Problem:** You are a data analyst at a global fashion retailer. The marketing team has asked you to provide key metrics for a recent campaign focusing on customer acquisition. They want to understand customer behavior and sales performance over a specific period.

**Dataset:**  `bigquery-public-data.thelook_ecommerce`

**Task:** Using the orders, order_items, users, and products tables, write a single SQL query (or a set of queries if necessary) to create a final report table that answers the following questions:
1. **Overall Metrics:** Calculate the total revenue, total orders, and total customers for the entire period.
2. **Top 5 Products:** Identify the top 5 products by revenue. The output should include product_id, product_name, and total_revenue.
3. **Customer Lifetime Value (CLV):** For each customer, calculate their Total CLV (defined as the sum of all their orders).
4. **Monthly Trends:** For each month, calculate the total revenue and the number of unique customers.

Your final query should produce a result set that is ready to be loaded into Power BI.

**Hints:**
- You will need to join several tables together. Pay close attention to the join keys.
- The status field in the orders table is important to filter out invalid or returned orders. Consider only orders with status = 'Complete'.
- You'll need to use date functions to group by month.
- Use `SUM()` and `COUNT(DISTINCT ...)` for aggregations.

***

### Section 2: Reporting & Visualization with Power BI
**Business Problem:** The final report table from your BigQuery query is now in Power BI. The marketing team wants to visualize this data in an intuitive dashboard to track campaign performance.

**Task:** Describe the design of a Power BI dashboard based on your query results.
1. **Dashboard Layout:** Describe the overall layout. What are the main sections or pages? What is the title?
2. **Key Metrics (Cards):** What are the three most important metrics you would display as large, easy-to-read "cards" at the top of the dashboard?
3. **Visualizations:** For each of the following, describe the type of visualization you would use and why:
    - **Monthly Revenue Trend:** How would you show revenue changing over time?
    - **Top 5 Products:** How would you visually rank the top-performing products?
    - **Customer Lifetime Value:** How would you visualize the distribution of CLV across all customers (e.g., showing that most customers have a low CLV, and a few have a very high CLV)?
4. **Interactivity:** What filters or slicers would you include to allow the marketing team to interact with the data? How would a user select a specific time frame or product category?
5. **DAX Formulas:** Write the DAX formula for the following two measures:
6. **Total Revenue YTD:** A measure that calculates the total revenue from the start of the current year up to the latest date in the dataset.
7. **Average Order Value:** A measure that calculates the average value of all orders.
