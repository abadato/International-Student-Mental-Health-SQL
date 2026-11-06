
-- ============================================================
-- PROJECT: International Student Mental Health
-- SCRIPT: 03_data_quality.sql
-- PURPOSE: Assess data quality before analysis
-- ============================================================

-- 1. Check total records and student classification

SELECT
    COUNT(*) AS total_records,
    COUNT(*) FILTER (
        WHERE inter_dom = 'Inter'
    ) AS international_students,
    COUNT(*) FILTER (
        WHERE inter_dom = 'Dom'
    ) AS domestic_students,
    COUNT(*) FILTER (
        WHERE NULLIF(TRIM(inter_dom), '') IS NULL
    ) AS missing_classification
FROM students_raw;


-- 2. Check missing values in key variables
-- Include both NULL and empty strings where relevant.

SELECT
    COUNT(*) AS total_records,
    COUNT(*) FILTER (
        WHERE age IS NULL
    ) AS missing_age,
    COUNT(*) FILTER (
        WHERE stay IS NULL
    ) AS missing_stay,
    COUNT(*) FILTER (
        WHERE todep IS NULL
    ) AS missing_depression,
    COUNT(*) FILTER (
        WHERE tosc IS NULL
    ) AS missing_social_connectedness,
    COUNT(*) FILTER (
        WHERE toas IS NULL
    ) AS missing_acculturative_stress
FROM students_raw;


-- 3. Check duplicate source indices

SELECT
    source_index,
    COUNT(*) AS occurrences
FROM students_raw
WHERE source_index IS NOT NULL
GROUP BY source_index
HAVING COUNT(*) > 1
ORDER BY occurrences DESC;


-- 4. Inspect unclassified records

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
WHERE NULLIF(TRIM(inter_dom), '') IS NULL
ORDER BY source_index;


-- 5. Check score ranges among classified students

SELECT
    MIN(age) AS min_age,
    MAX(age) AS max_age,
    MIN(todep) AS min_depression,
    MAX(todep) AS max_depression,
    MIN(tosc) AS min_social_connectedness,
    MAX(tosc) AS max_social_connectedness,
    MIN(toas) AS min_acculturative_stress,
    MAX(toas) AS max_acculturative_stress
FROM students_raw
WHERE inter_dom IN ('Inter', 'Dom');
