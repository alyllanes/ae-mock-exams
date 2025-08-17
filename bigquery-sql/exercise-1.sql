/*
Exercise 1: Customer Segmentation and RFM Analysis
Using the bigquery-public-data.thelook_ecommerce dataset:

1. Objective: Calculate the Recency, Frequency, and Monetary (RFM) values for each customer.
2. Recency: Calculate the number of days since each customer's most recent order.
3. Frequency: Count the total number of orders for each customer.
4. Monetary: Calculate the total spend for each customer.
5. Output: Your query should return customer_id, recency, frequency, and monetary values.
*/

-- Previewing the first 10 rows of the table
SELECT * FROM `bigquery-public-data.thelook_ecommerce`.orders LIMIT 10;

-- Used CTEs to provide a clear and organized query to do the task:
WITH customer_rfm AS (
  SELECT
    orders.user_id AS customer_id, -- renamed to customer_id as specified in the output
    DATE_DIFF(CURRENT_DATE(), max(date(orders.created_at)), DAY) AS recency, -- (1) the created_at used a timestamp, so it was first converted to a date, (2) then the MAX() function was applied to get the most recent order date, and lastly (3) the date_diff between the most recent order date and the CURRENT_DATE() was calculated 
    COUNT(DISTINCT order_id) AS frequency, -- since the order_items was joined, it can potentially have duplicate order IDs, so COUNT(DISTINCT order_id) was used
    sum(sale_price) AS monetary -- from the ORDER_ITEMS table 
  FROM `bigquery-public-data`.thelook_ecommerce.orders orders
  LEFT JOIN `bigquery-public-data`.thelook_ecommerce.order_items order_items USING(order_id)
  GROUP BY 1
)

SELECT * FROM customer_rfm
ORDER BY customer_id;
