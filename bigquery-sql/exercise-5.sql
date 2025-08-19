/*
Exercise 5: Handling Nested and Repeated Data
Using the bigquery-public-data.github_repos.sample_contents table:

1. Objective: Count the number of distinct programming languages used across all files in each Github Repository.
2. Task:
  - (Optional) Filter the table for a repository of your choice (e.g., google/go-github).
  - You'll need to extract the file extension (e.g., .py, .js, .go) from the path field to determine the language.
  - Count the number of distinct file extensions/languages.
3. Output: The repository name and the count of distinct languages.
*/

-- Previewing the first 10 rows of the table
SELECT * FROM `bigquery-public-data.github_repos.sample_contents` LIMIT 10;

-- Testing the extracted file extension using the array length - 1 
SELECT 
  sample_path, 
  SPLIT(sample_path, '.')[SAFE_OFFSET(ARRAY_LENGTH(SPLIT(sample_path, '.'))-1)] AS file_extension
FROM `bigquery-public-data.github_repos.sample_contents`
WHERE 
  sample_repo_name = 'npgall/cqengine' 
  AND 
  -- was looking for a specific extracted value to test
  regexp_contains(sample_path, '.*CloseableResourceGroup');

-- The Final output that counts the distinct file extensions per Github repository
SELECT
  sample_repo_name,
  COUNT(DISTINCT SPLIT(sample_path, '.')[SAFE_OFFSET(ARRAY_LENGTH(SPLIT(sample_path, '.'))-1)]) AS file_extension_count
FROM `bigquery-public-data.github_repos.sample_contents`
GROUP BY 1
LIMIT 10;

-- Testing the extracted file extension from a specific repository
SELECT 
  DISTINCT
  SPLIT(sample_path, '.')[SAFE_OFFSET(ARRAY_LENGTH(SPLIT(sample_path, '.'))-1)] AS file_extension
FROM `bigquery-public-data.github_repos.sample_contents`
WHERE 
  sample_repo_name = 'apache/logging-log4j2';
