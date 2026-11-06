
-- ============================================================
-- PROJECT: International Student Mental Health
-- SCRIPT: 07_acculturative_stress.sql
-- PURPOSE: Examine acculturative stress and depression
-- POPULATION: International students only
-- ============================================================

-- 1. Descriptive statistics

SELECT
    COUNT(*) AS n_students,
    ROUND(AVG(toas), 2) AS mean_stress,
    ROUND(STDDEV_SAMP(toas), 2) AS sd_stress,
    MIN(toas) AS min_stress,
    MAX(toas) AS max_stress
FROM students_clean
WHERE inter_dom = 'Inter';


-- 2. Pearson correlation between stress and depression

SELECT
    COUNT(*) AS n_students,
    ROUND(CORR(toas, todep)::NUMERIC, 3)
        AS correlation_stress_depression
FROM students_clean
WHERE inter_dom = 'Inter'
  AND toas IS NOT NULL
  AND todep IS NOT NULL;


-- 3. Mean depression scores across stress quartiles

WITH stress_groups AS (
    SELECT
        toas,
        todep,
        NTILE(4) OVER (ORDER BY toas)
            AS stress_quartile
    FROM students_clean
    WHERE inter_dom = 'Inter'
      AND toas IS NOT NULL
      AND todep IS NOT NULL
)
SELECT
    stress_quartile,
    COUNT(*) AS n_students,
    ROUND(AVG(toas), 2) AS mean_stress,
    ROUND(AVG(todep), 2) AS mean_depression
FROM stress_groups
GROUP BY stress_quartile
ORDER BY stress_quartile;


-- 4. Simple linear regression
-- Outcome: depression score
-- Predictor: acculturative stress

SELECT
    ROUND(REGR_SLOPE(todep, toas)::NUMERIC, 3)
        AS regression_slope,
    ROUND(REGR_INTERCEPT(todep, toas)::NUMERIC, 3)
        AS regression_intercept,
    ROUND(REGR_R2(todep, toas)::NUMERIC, 3)
        AS r_squared
FROM students_clean
WHERE inter_dom = 'Inter'
  AND toas IS NOT NULL
  AND todep IS NOT NULL;
