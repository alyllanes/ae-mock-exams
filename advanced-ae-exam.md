# Advanced Analytics Engineering Technical Exam
This exam goes beyond foundational skills to test your knowledge of data architecture, pipeline automation, and communication. It presents scenarios that an analytics engineer would encounter in a real-world production environment.

---

### Section 1: Data Modeling & Warehousing
**Business Problem:** The marketing team at an e-commerce company wants to analyze campaign performance and customer behavior. They need to understand what products customers are viewing, adding to their cart, and purchasing over time. You need to design a data model that is easy for analysts to query and understand.

**Dataset:** `bigquery-public-data.thelook_ecommerce.events`

**Task:** Design a dimensional model (specifically, a star schema) to answer the business problem.
1. **Fact Table:** Identify the fact table. List the key metrics you would include (e.g., `event_id`, `product_id`).
2. **Dimension Tables:** Identify and describe at least three dimension tables. For each dimension, list the primary key and a few relevant attributes. (e.g., a products dimension with `product_id`, `product_name`, etc.).
3. **Schema Diagram:** Briefly describe how the tables would link together.

**Questions:**
- Why is a star schema generally preferred over a normalized schema for analytical queries?
- Explain the difference between a surrogate key and a natural key in your model. Which would you use and why?

***

### Section 2: Pipeline Orchestration & Automation
**Business Problem:** The dbt models you built in the previous exam need to be run automatically every day at 6 AM. The pipeline should also handle dependencies and notify the team if it fails.

**Tool:** Conceptualize this using an orchestration tool like Apache Airflow.

**Task:** Describe the structure of a pipeline (or DAG) that accomplishes the following:
1. **Define Tasks:** List the individual tasks that would make up this pipeline. For example, a task to run the dbt staging models, another for the core models, etc.
2. **Dependencies:** Define the order in which these tasks should run. For instance, which task must complete before the final mart is built?
3. **Error Handling:** What would you do if a task fails (e.g., the dbt staging model run)?
4. **Notifications:** How would you set up an alert to notify a team channel (like Slack or email) of the success or failure of the pipeline?

**Questions:**
- Why is a directed acyclic graph (DAG) a fundamental concept in data orchestration?
- What is the importance of idempotency in the context of a pipeline that might rerun due to a failure?

***

### Section 3: Software Engineering for Data
**Business Problem:** A new data source provides a list of user transactions. Before loading it into the data warehouse, a custom calculation needs to be performed to determine a "loyalty score" for each user.

**Task:** Write a Python function (pseudocode is acceptable) that:
1. **Input:** Accepts a list of dictionaries, where each dictionary represents a transaction with  `user_id`, `transaction_amount`, and `is_repeat_purchase`.
2. **Logic:** Calculates a `loyalty_score` for each user based on a simple rule: sum of all `transaction_amounts` + (count of repeat purchases * 10).
3. **Output:** Returns a new list of dictionaries, with each user's loyalty_score.
4. **Testing & Documentation:** Include a docstring that explains the function's purpose, parameters, and return value. Provide a simple example of how you would test this function.

**Questions:**
- What are the benefits of writing unit tests for a transformation function like this?
- How does using a function with a clear input/output contract improve the maintainability of your data pipeline?

***

### Section 4: Communication & Business Acumen
**Business Problem:** The Sales team has just run a report from your new data mart and is seeing a discrepancy in "Total Revenue" compared to their source system. They've sent you an urgent email asking why the numbers don't match.

**Task:** Draft a professional and clear email response to the Sales team. Your email should:
1. **Acknowledge the Concern:** Start by acknowledging their concern and the importance of the issue.
2. **Provide a High-Level Explanation:** Explain, in non-technical terms, the most likely cause of the discrepancy (e.g., differences in how returns are handled, different time zone conversions). Avoid jargon.
3. **Outline Next Steps:** Propose a clear plan to investigate the issue, including a timeline.
4. **Reassure:** Conclude by reassuring them that you are on it and will follow up with more details.

**Questions:**
- Why is it crucial to communicate with non-technical stakeholders using business-centric language rather than technical jargon?
- What are some strategies you would use to proactively prevent such data discrepancies in the future?
