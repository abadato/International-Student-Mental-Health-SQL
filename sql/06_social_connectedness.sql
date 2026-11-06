
-- ============================================================
-- PROJECT: International Student Mental Health
-- SCRIPT: 06_social_connectedness.sql
-- PURPOSE: Examine connectedness and depression associations
-- ============================================================

-- 1. Overall Pearson correlation

SELECT
    COUNT(*) AS n_students,
    ROUND(CORR(tosc, todep)::NUMERIC, 3)
        AS correlation_connectedness_depression
FROM students_clean
WHERE tosc IS NOT NULL
  AND todep IS NOT NULL;


-- 2. Pearson correlation by student group

SELECT
    inter_dom AS student_group,
    COUNT(*) AS n_students,
    ROUND(CORR(tosc, todep)::NUMERIC, 3)
        AS pearson_r
FROM students_clean
WHERE tosc IS NOT NULL
  AND todep IS NOT NULL
GROUP BY inter_dom
ORDER BY inter_dom;


-- 3. Depression scores across connectedness quartiles
-- NTILE creates four groups ranked by connectedness.
-- Equal connectedness values may fall into different quartiles.

WITH connectedness_groups AS (
    SELECT
        inter_dom,
        tosc,
        todep,
        NTILE(4) OVER (ORDER BY tosc)
            AS connectedness_quartile
    FROM students_clean
    WHERE tosc IS NOT NULL
      AND todep IS NOT NULL
)
SELECT
    connectedness_quartile,
    COUNT(*) AS n_students,
    ROUND(AVG(tosc), 2) AS mean_connectedness,
    ROUND(AVG(todep), 2) AS mean_depression
FROM connectedness_groups
GROUP BY connectedness_quartile
ORDER BY connectedness_quartile;


-- 4. Simple linear regression coefficients by group
-- Depression score is the outcome variable.
-- Connectedness score is the predictor.

SELECT
    inter_dom AS student_group,
    ROUND(REGR_SLOPE(todep, tosc)::NUMERIC, 3)
        AS regression_slope,
    ROUND(REGR_INTERCEPT(todep, tosc)::NUMERIC, 3)
        AS regression_intercept,
    ROUND(REGR_R2(todep, tosc)::NUMERIC, 3)
        AS r_squared
FROM students_clean
WHERE tosc IS NOT NULL
  AND todep IS NOT NULL
GROUP BY inter_dom
ORDER BY inter_dom;
