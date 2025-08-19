# API Data Ingestion Technical Exam
This exam is designed to test your ability to use Python to interact with APIs, handle different data formats, and transform the data into a usable structure for a data warehouse. This is a core skill for an analytics engineer who often needs to ingest data from third-party services.

### Project Setup & Context
**Scenario:** A marketing team wants to analyze the performance of their social media content. They need a daily pipeline that extracts data from a hypothetical social media analytics API, transforms it, and makes it ready for loading into a data warehouse like BigQuery.

**Mock API Endpoint:** For the purpose of this exam, assume there is a REST API endpoint that returns a list of social media posts.
- **URL:** `https://api.mock-social-media.com/v1/posts`
- **Method:** GET
- **Authentication:** Requires an API key in a header: X-API-KEY: YOUR_API_KEY
- **Response Format:** A JSON array of objects. Each object represents a post and may contain nested data.

**Example Response (abbreviated):**
```
[
  {
    "id": "post_123",
    "metadata": {
      "author_id": "user_abc",
      "platform": "facebook",
      "created_at": "2024-07-25T10:00:00Z"
    },
    "metrics": {
      "likes_count": 150,
      "comments_count": 25,
      "shares_count": 10
    },
    "content": "This is the post's text content."
  },
  {
    "id": "post_456",
    "metadata": {
      "author_id": "user_xyz",
      "platform": "instagram",
      "created_at": "2024-07-25T11:30:00Z"
    },
    "metrics": {
      "likes_count": 300,
      "comments_count": 55,
      "shares_count": 0
    },
    "content": "Another example post."
  }
]
```

---

### Section 1: Data Extraction
**Task:** Write a Python script or pseudocode that performs the following steps:
1. **Define Constants:** Store the API endpoint URL and your API key (as a placeholder) in variables.
2. **Make the Request:** Use a library like requests to make a GET request to the API endpoint, including the API key in the request headers.
3. **Handle Errors:** Implement a try...except block to gracefully handle potential network errors (e.g., requests.exceptions.RequestException) or non-200 HTTP status codes (e.g., 401 Unauthorized, 404 Not Found).
4. **Parse JSON:** If the request is successful, parse the JSON response body into a Python object (e.g., a list of dictionaries).

**Questions:**
- Why is it a bad practice to hardcode API keys directly in your script? What is a more secure alternative?
- What information is typically contained in an HTTP request header, and why is it important for an API call?

***

### Section 2: Data Transformation & Modeling
**Task:** Extend your Python script from Section 1 to include a transformation step.
1. **Define a Schema:** Create a function that takes the raw JSON data and flattens it into a list of dictionaries, where each dictionary represents a row for a final table. The final schema should have the following columns:
    - `post_id` (string)
    - `author_id` (string)
    - `platform` (string)
    - `created_at` (timestamp)
    - `likes_count` (integer)
    - `comments_count` (integer)
    - `shares_count` (integer)
    - `content` (string)
2. **Handle Missing Data:** Your function should handle cases where a post might not have all the metrics fields (e.g., `shares_count` might be missing). Ensure the final value is 0 or NULL instead of causing the script to fail.

**Questions:**
- How would you handle the created_at timestamp in Python to ensure it's in a standardized format before loading it into BigQuery?
- Why is it important to flatten nested JSON structures before loading them into a relational data warehouse?

***

### Section 3: Final Integration & Concepts
**Task:** Briefly describe how you would integrate this Python script into a larger data pipeline.
1. **Incremental Loading:** How would you modify your script to only pull new data since the last successful run? What parameter would you likely need to add to your API request?
2. **Data Loading:** After the data is transformed, how would you programmatically load this data into a BigQuery table using a Python library (e.g., `google-cloud-bigquery`)?

**Questions:**
- What is idempotency in the context of data pipelines, and why is it a crucial concept for a data ingestion script?
- What is the difference between a REST API and a GraphQL API?
