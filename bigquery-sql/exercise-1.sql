/*
Exercise 1: Customer Segmentation and RFM Analysis
Using the bigquery-public-data.thelook_ecommerce dataset:

1. Objective: Calculate the Recency, Frequency, and Monetary (RFM) values for each customer.
2. Recency: Calculate the number of days since each customer's most recent order.
3. Frequency: Count the total number of orders for each customer.
4. Monetary: Calculate the total spend for each customer.
5. Output: Your query should return customer_id, recency, frequency, and monetary values.
*/

select * from `bigquery-public-data.thelook_ecommerce`.orders order by rand() limit 10;

with customer_rfm as (
  select
    orders.user_id as customer_id,
    date_diff(current_date(), max(date(orders.created_at)), DAY) as recency,
    count(distinct order_id) as frequency,
    sum(sale_price) as monetary
  from `bigquery-public-data`.thelook_ecommerce.orders orders
  left join `bigquery-public-data`.thelook_ecommerce.order_items order_items using(order_id)
  group by 1
)

select *
from customer_rfm
order by customer_id;
