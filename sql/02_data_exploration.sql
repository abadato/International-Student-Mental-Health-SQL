
-- =====================================================
-- PROJECT: International Student Mental Health
-- SCRIPT: 02_data_exploration.sql
-- PURPOSE: Initial exploratory data analysis
-- =====================================================

-- 1. Total number of imported records
SELECT COUNT(*) AS total_rows
FROM students_raw;

-- 2. Inspect column names and data types
SELECT
    column_name,
    data_type
FROM information_schema.columns
WHERE table_schema = 'public'
  AND table_name = 'students_raw'
ORDER BY ordinal_position;

-- 3. Inspect the first 10 records
SELECT
    source_index,
    inter_dom,
    region,
    gender,
    academic,
    age,
    stay,
    dep,
    todep,
    tosc,
    toas
FROM students_raw
ORDER BY source_index
LIMIT 10;

-- 4. Count records by student classification
SELECT
    NULLIF(TRIM(inter_dom), '') AS student_group,
    COUNT(*) AS record_count
FROM students_raw
GROUP BY NULLIF(TRIM(inter_dom), '')
ORDER BY record_count DESC;
