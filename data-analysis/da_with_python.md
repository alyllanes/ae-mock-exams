# Data Analysis with Python Technical Exam
This exam is designed to assess your ability to use Python, particularly the pandas library, for data cleaning, analysis, and reporting. The questions are based on a common e-commerce business problem and will test your practical skills in a typical data analysis workflow.

**Project Setup & Context**

**Scenario:** You have been provided with a CSV file containing raw e-commerce transaction data. Your task is to use Python to clean, analyze, and summarize this data to answer key business questions.

**Dataset:** For this exam, imagine you have access to a CSV file named ecommerce_transactions.csv. It has the following columns:
  - `order_id` (string): A unique identifier for each order.
  - `customer_id` (string): A unique identifier for each customer.
  - `order_timestamp` (string): The date and time of the order.
  - `product_category` (string): The category of the product.
  - `quantity` (integer): The number of items purchased.
  - `unit_price` (float): The price of a single item.

---

### Section 1: Data Ingestion & Cleaning
**Task:** Write a Python script that performs the following steps.
1. **Load Data:** Use pandas to load the ecommerce_transactions.csv file into a DataFrame. Assume the file is in the same directory as your script.
2. **Inspect Data:** Display the first 5 rows and the data types of each column to understand the structure.
3. **Handle Missing Values:** Identify any columns with missing values and implement a strategy to handle them. For this exam, you should drop any rows with missing data.
4. **Correct Data Types:** The order_timestamp column is currently a string. Convert it to a proper datetime object.

**Questions:**
- Why is it a critical first step to check for missing values and incorrect data types?
- If you had missing values in the quantity column, what imputation strategies (besides dropping rows) could you use, and when might you use them?

***

### Section 2: Exploratory Data Analysis (EDA)
**Task:** Using the cleaned DataFrame from Section 1, write Python code to answer the following business questions.
1. **Total Revenue:** Calculate the total_revenue for each transaction and add a new column to the DataFrame with this value. Then, calculate the total revenue for the entire dataset.
2. **Monthly Sales:** Group the data by month and calculate the total revenue for each month.
3. **Top Products:** Identify the top 5 product categories by total revenue.
4. **Visualize Trends:** Using a library like matplotlib or seaborn, create a line chart showing the monthly revenue trend. Make sure to include a title and axis labels.

**Questions:**
- Why is visualizing data, in addition to calculating metrics, a valuable step in the analysis process?
- What is the difference between a Series and a DataFrame in pandas?

***

### Section 3: Advanced Analysis & Reporting
**Task:** The marketing team wants a final report on customer performance.
1. **Calculate Customer Lifetime Value (CLV):** For each customer_id, calculate their Total CLV (defined as the sum of all their orders).
2. **Final Report:** Create a new DataFrame that contains customer_id and their corresponding total_clv. Sort this DataFrame in descending order by CLV.
3. **Export to CSV:** Export this final report DataFrame to a new CSV file named customer_clv_report.csv without including the index.

**Questions:**
- Briefly describe the purpose of the `groupby()` method in pandas and how you used it in this exam.
- Why is it important to export a clean, aggregated report for stakeholders instead of giving them the raw data?
