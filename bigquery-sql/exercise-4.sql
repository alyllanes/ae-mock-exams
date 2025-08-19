/*
Exercise 4: Data Deduplication and CTEs (Common Table Expressions)
Using the bigquery-public-data.chicago_crime.crime table:

1. Objective: Identify and remove duplicate crime records. A record is considered a duplicate if it has the same ID and Case Number.
2. Task:
  - Use a Common Table Expression (CTE) and a window function like ROW_NUMBER() to assign a unique number to each row within a partition of ID and Case Number.
  - Filter for rows where the row number is equal to 1 to get only the unique records.
3. Output: The final query should return a result set containing only the distinct crime records.
*/

SELECT * FROM `bigquery-public-data.chicago_crime.crime` LIMIT 10;

-- Checking for ID fields since the unique key is different for every row despite having the same case number, IUCR (Illinois Uniform Crime Reporting), and FBI Code
SELECT 
  case_number, 
  iucr, 
  fbi_code, 
  -- SHA256 is a hash function to create a unique key using a combination of case number, IUCR, and FBI Code
  COUNT(sha256(concat(case_number,iucr, fbi_code))) AS count 
FROM `bigquery-public-data.chicago_crime.crime` 
GROUP BY ALL
HAVING count > 1;

SELECT * FROM `bigquery-public-data.chicago_crime.crime` 
-- Sample Case Number where duplicates where found
WHERE case_number = 'HZ140230';

-- Method 1: Using CTE and ROW_NUMBER()
WITH row_number AS (
  SELECT 
    *,
    -- adds a row number for rows grouped by case number, IUCR, and FBI Code and ordered by the latest updated date
    ROW_NUMBER() OVER (PARTITION BY case_number, iucr, fbi_code ORDER BY updated_on DESC) AS rn
FROM `bigquery-public-data.chicago_crime.crime`
)

SELECT * FROM row_number
-- filters rn= 1 since the first row number would be the latest updated date for that particular case number, IUCR, and FBI Code
WHERE rn = 1;

-- Method 2: Using QUALIFY and ROW_NUMBER()
SELECT * FROM `bigquery-public-data.chicago_crime.crime`
-- instead of using a separate query to add the row numbers, QUALIFY is used to filter the results of the window function
QUALIFY 1=ROW_NUMBER() OVER (PARTITION BY case_number, iucr, fbi_code ORDER BY updated_on DESC);

-- Testing for duplicates
WITH qualified AS (
  SELECT * FROM `bigquery-public-data.chicago_crime.crime`
  QUALIFY 1=ROW_NUMBER() OVER (PARTITION BY case_number, iucr, fbi_code ORDER BY updated_on DESC)
)
SELECT 
  case_number, 
  iucr, 
  fbi_code, 
  count(sha256(concat(case_number,iucr, fbi_code))) as count 
FROM qualified 
GROUP BY 1,2,3 
HAVING count > 1;

