# End-to-End Analytics Engineering Pipeline Exam

This exam is the culmination of the skills we've discussed, designed to simulate a complete project lifecycle for an analytics engineer. The goal is to build a full data pipeline, from raw data ingestion to a final dashboard for a business user.

---

### Section 1: Data Ingestion & Extraction (Python)

**Business Problem:** A digital marketing team needs to track the daily performance of their online campaigns. You must build an automated script to ingest data from a hypothetical social media analytics API and land it in a staging table in BigQuery.

**Task:** Write a Python script (or detailed pseudocode) that performs the following:

1.  **Ingest from API:** Make a series of authenticated API calls to a hypothetical endpoint like `https://api.marketing-analytics.com/campaigns`. The API requires an `api_key` in the header. The endpoint supports **pagination** to handle large datasets.
2.  **Handle Incremental Loading:** The API has a `last_updated_at` filter. Your script should be able to query the BigQuery staging table to find the maximum `last_updated_at` value from the previous run and only fetch new or updated records since that time.
3.  **Data Transformation:** Flatten the nested JSON response into a list of dictionaries that match your target schema.
4.  **Load to BigQuery:** Use the `google-cloud-bigquery` library to load the transformed data into a staging table named `raw_campaigns` in your BigQuery project.

**Questions:**

* How would you handle potential API rate limits within your script?
* Explain the importance of **idempotency** for this ingestion script.

***

### Section 2: Data Transformation & Modeling (dbt)

**Business Problem:** The raw campaign data is now in the `raw_campaigns` staging table. The marketing team needs to understand the performance of campaigns by `date`, `region`, and `platform`.

**Task:** Design and describe a dbt project to transform this raw data.

1.  **Staging Model:** Describe a `stg_campaigns` model. What are the key cleaning steps (e.g., column renaming, casting data types) you would perform in this layer?
2.  **Core Model:** Describe a `core_campaign_performance` model that combines data from your staging model. This model should calculate a **`total_cost`** and a **`total_revenue`** for each campaign. It should also join with a separate table (e.g., `lookup_regions`) to enrich the data with a **`region`** dimension.
3.  **Data Mart:** Describe a final `daily_campaign_summary` data mart. This model should aggregate the core model data by `date`, `region`, and `platform` and calculate metrics like **`daily_clicks`**, **`daily_cost`**, and **`daily_revenue`**.
4.  **Testing:** What dbt tests would you apply to ensure the quality of your `daily_campaign_summary` model?

**Questions:**

* Why is it good practice to separate your transformation logic into staging, core, and mart layers?
* Which dbt materialization would you choose for your final `daily_campaign_summary` model and why?

***

### Section 3: Data Warehouse Architecture & Optimization (BigQuery)

**Business Problem:** The marketing team's business intelligence dashboard is running slowly. The dashboard primarily filters by **`date`** and **`platform`**.

**Task:** Describe how you would optimize your final `daily_campaign_summary` table in BigQuery.

1.  **Table Design:** What is the full schema of the `daily_campaign_summary` table? Be sure to include the data types.
2.  **Partitioning:** How would you **partition** the table to optimize for filtering by a specific time range?
3.  **Clustering:** How would you **cluster** the table to optimize for filtering by `platform`?

**Questions:**

* Explain how partitioning and clustering work together to improve query performance and reduce costs.
* What is the difference between an internal and an external table in BigQuery, and when might you use each?

***

### Section 4: Dashboarding & Visualization (Looker)

**Business Problem:** The marketing team needs a dashboard in Looker to answer key questions. The final `daily_campaign_summary` table is the source for this dashboard.

**Task:** Describe the design of a Looker dashboard to meet the following requirements:

1.  **Key Metrics:** What are the three most important metrics you would display (e.g., total clicks, total revenue)?
2.  **Dimensions:** What dimensions would you use for filtering and grouping data (e.g., date, platform, region)?
3.  **Visualizations:** What types of visualizations would you use to represent:
    * Campaign performance over time?
    * Performance across different regions?
    * The breakdown of performance by platform?
4.  **Filters:** What interactive dashboard filters would you provide to the user, and why are they important?

**Questions:**

* Why is it crucial to define the data model in dbt before building the Looker dashboard?
* How does a tool like Looker help bridge the gap between technical data models and business user needs?
