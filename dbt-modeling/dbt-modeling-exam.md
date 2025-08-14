# dbt Modeling Technical Exam
This exam assesses your ability to use dbt to transform raw data into a clean, well-structured, and reliable data warehouse. You will be provided with a series of tasks to build a simple data pipeline using a public BigQuery dataset. The focus is on best practices, data quality, and creating models that are easy to understand and use.

### Project Setup & Context
**Dataset:** We will continue to use the `bigquery-public-data.google_analytics_sample.ga_sessions_*` dataset for this exam. Imagine this is a raw, messy table from a source system.

**Objective:** Your goal is to build a dbt project that transforms this raw session data into a final `daily_sessions_mart` that can be used by business analysts.

---

### Section 1: Staging Models
The first step in any dbt project is to create clean, raw-to-staging models. These models should be a thin layer of transformation.

**Task:** Create a dbt model named `stg_sessions.sql` that accomplishes the following:
1. **Select relevant columns:** Select only the necessary columns from the raw source table. A good starting point would be `visitId`, `visitStartTime`, `fullVisitorId`, `device`, and `trafficSource`.
2. **Clean & Standardize:**
    - Rename `visitId` to `session_id`.
    - Rename `visitStartTime` to `session_start_timestamp`.
    - Rename `fullVisitorId` to `customer_id`.
    - Create a new column called `session_date` by casting `session_start_timestamp` to a date.
3. **Ensure data quality:** Create a unique key for the model.
4. **Configuration:** Configure this model to be materialized as a view.

**Questions:**
- Why is it a best practice to keep staging models "thin" with minimal business logic?
- What is the benefit of materializing this model as a view instead of a table?

***

### Section 2: Core Models
This layer contains the core business logic. We'll build a model that joins the session data with any transaction data.

**Task:** Create a dbt model named core_sessions.sql that does the following:
1. **Build from staging:** Use your `stg_sessions` model as a source.
2. **Add transaction data:** Join this model with transaction data to determine if a session resulted in a purchase.
    - Look for the `hits.eCommerceAction.action_type` field with a value of 6 (purchase).
    - Create a new boolean column named is_purchase that is TRUE if a purchase occurred and FALSE otherwise.
    - Create a new column named `revenue_amount` which is the total transaction revenue for that session, or 0 if no transaction occurred.
3. **Configuration:** Configure this model to be materialized as a table.

**Questions:**
- How does the is_purchase column help analysts?
- Why is materializing this model as a table (instead of a view) a good choice here?

***

### Section 3: Data Marts
The final layer is the data mart, which provides aggregated data for a specific business use case.

**Task:** Create a dbt model named `daily_sessions_mart.sql` that provides a daily summary of key metrics. This model should:
1. **Build from core:** Use your core_sessions model as a source.
2. **Aggregate:** Group the data by session_date.
3. **Calculate metrics:** For each date, calculate the following:
    - `total_sessions`: The total number of sessions.
    - `total_purchases`: The total number of sessions that resulted in a purchase.
    - `total_revenue`: The total revenue for that day.
    - `conversion_rate`: The conversion rate (total purchases / total sessions).
4. **Configuration:** This model should be materialized as an incremental model.

**Question:**
Briefly describe how dbt's incremental materialization would work for this model.

***

### Section 4: Data Quality & Documentation
A key aspect of dbt is ensuring data quality and making models understandable.

**Task:** Create a `schema.yml` file to document and test your `daily_sessions_mart` model. This file should include:
1. **Model Description:** A brief, clear description of what the daily_sessions_mart model represents.
2. **Column Descriptions:** Descriptions for each of the four columns (`session_date`, `total_sessions`, `total_purchases`, `total_revenue`, `conversion_rate`).
3. Tests: Add the following tests:
    - `not_null` and unique for `session_date`.
    - `not_null` for `total_sessions`, `total_purchases`, and `total_revenue`.
4. A custom `accepted_values` test on a column of your choice, ensuring a specific condition is met. For example, that `total_revenue` is always greater than or equal to 0.

**Question:**
Why is it important to use dbt test in your CI/CD pipeline?
