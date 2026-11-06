
-- ============================================================
-- PROJECT: International Student Mental Health
-- SCRIPT: 05_group_comparison.sql
-- PURPOSE: Compare international and domestic students
-- SOURCE: students_clean
-- ============================================================

-- 1. Sample size and demographic characteristics

SELECT
    inter_dom AS student_group,
    COUNT(*) AS n_students,
    ROUND(AVG(age), 2) AS mean_age,
    ROUND(STDDEV_SAMP(age), 2) AS sd_age,
    ROUND(AVG(stay), 2) AS mean_stay
FROM students_clean
GROUP BY inter_dom
ORDER BY inter_dom;


-- 2. Depression score by student group

SELECT
    inter_dom AS student_group,
    COUNT(todep) AS n_valid,
    ROUND(AVG(todep), 2) AS mean_depression,
    ROUND(STDDEV_SAMP(todep), 2) AS sd_depression,
    MIN(todep) AS min_depression,
    MAX(todep) AS max_depression
FROM students_clean
GROUP BY inter_dom
ORDER BY inter_dom;


-- 3. Median depression score by student group

SELECT
    inter_dom AS student_group,
    ROUND(
        PERCENTILE_CONT(0.5)
        WITHIN GROUP (ORDER BY todep)::NUMERIC,
        2
    ) AS median_depression
FROM students_clean
GROUP BY inter_dom
ORDER BY inter_dom;


-- 4. Social connectedness by student group

SELECT
    inter_dom AS student_group,
    COUNT(tosc) AS n_valid,
    ROUND(AVG(tosc), 2) AS mean_connectedness,
    ROUND(STDDEV_SAMP(tosc), 2) AS sd_connectedness,
    MIN(tosc) AS min_connectedness,
    MAX(tosc) AS max_connectedness
FROM students_clean
GROUP BY inter_dom
ORDER BY inter_dom;


-- 5. Difference in group mean depression scores
-- Positive value: international mean is higher.

WITH group_means AS (
    SELECT
        inter_dom,
        AVG(todep) AS mean_depression
    FROM students_clean
    GROUP BY inter_dom
)
SELECT
    ROUND(
        MAX(mean_depression) FILTER (WHERE inter_dom = 'Inter')
        -
        MAX(mean_depression) FILTER (WHERE inter_dom = 'Dom'),
        2
    ) AS international_minus_domestic
FROM group_means;
