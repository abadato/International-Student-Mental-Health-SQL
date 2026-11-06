
-- ============================================================
-- PROJECT: International Student Mental Health
-- SCRIPT: 08_length_of_stay.sql
-- PURPOSE: Examine length of stay and mental health
-- POPULATION: International students only
-- ============================================================

-- 1. Inspect length-of-stay values and frequencies
-- Verify the unit of stay against the dataset codebook.

SELECT
    stay,
    COUNT(*) AS n_students
FROM students_clean
WHERE inter_dom = 'Inter'
GROUP BY stay
ORDER BY stay;


-- 2. Descriptive statistics for length of stay

SELECT
    COUNT(stay) AS n_valid,
    ROUND(AVG(stay), 2) AS mean_stay,
    ROUND(STDDEV_SAMP(stay), 2) AS sd_stay,
    MIN(stay) AS min_stay,
    MAX(stay) AS max_stay
FROM students_clean
WHERE inter_dom = 'Inter';


-- 3. Correlations with length of stay

SELECT
    COUNT(*) AS n_complete,
    ROUND(CORR(stay, todep)::NUMERIC, 3)
        AS r_stay_depression,
    ROUND(CORR(stay, toas)::NUMERIC, 3)
        AS r_stay_stress,
    ROUND(CORR(stay, tosc)::NUMERIC, 3)
        AS r_stay_connectedness
FROM students_clean
WHERE inter_dom = 'Inter'
  AND stay IS NOT NULL
  AND todep IS NOT NULL
  AND toas IS NOT NULL
  AND tosc IS NOT NULL;


-- 4. Depression and stress by stay category
-- Categories are retained as recorded in the source.

SELECT
    stay_cate,
    COUNT(*) AS n_students,
    ROUND(AVG(stay), 2) AS mean_stay,
    ROUND(AVG(todep), 2) AS mean_depression,
    ROUND(AVG(toas), 2) AS mean_stress,
    ROUND(AVG(tosc), 2) AS mean_connectedness
FROM students_clean
WHERE inter_dom = 'Inter'
GROUP BY stay_cate
ORDER BY mean_stay;


-- 5. Linear regression: depression and length of stay

SELECT
    ROUND(REGR_SLOPE(todep, stay)::NUMERIC, 3)
        AS regression_slope,
    ROUND(REGR_INTERCEPT(todep, stay)::NUMERIC, 3)
        AS regression_intercept,
    ROUND(REGR_R2(todep, stay)::NUMERIC, 3)
        AS r_squared
FROM students_clean
WHERE inter_dom = 'Inter'
  AND stay IS NOT NULL
  AND todep IS NOT NULL;
