
-- ============================================================
-- PROJECT: International Student Mental Health
-- SCRIPT: 04_data_cleaning.sql
-- PURPOSE: Create a reproducible student-level analysis view
-- ============================================================

-- 1. Create cleaned analysis view
-- Retain only records with a valid student classification.
-- Preserve the original students_raw table.

CREATE OR REPLACE VIEW students_clean AS
SELECT
    source_index,
    TRIM(inter_dom) AS inter_dom,
    NULLIF(TRIM(region), '') AS region,
    NULLIF(TRIM(gender), '') AS gender,
    NULLIF(TRIM(academic), '') AS academic,
    age,
    age_cate,
    stay,
    NULLIF(TRIM(stay_cate), '') AS stay_cate,
    japanese,
    NULLIF(TRIM(japanese_cate), '') AS japanese_cate,
    english,
    NULLIF(TRIM(english_cate), '') AS english_cate,
    NULLIF(TRIM(intimate), '') AS intimate,
    NULLIF(TRIM(religion), '') AS religion,
    NULLIF(TRIM(suicide), '') AS suicide,
    NULLIF(TRIM(dep), '') AS dep,
    NULLIF(TRIM(deptype), '') AS deptype,
    todep,
    NULLIF(TRIM(depsev), '') AS depsev,
    tosc,
    apd,
    ahome,
    aph,
    afear,
    acs,
    aguilt,
    amiscell,
    toas,
    partner,
    friends,
    parents,
    relative,
    profess,
    phone,
    doctor,
    reli,
    alone,
    others,
    internet,
    NULLIF(TRIM(partner_bi), '') AS partner_bi,
    NULLIF(TRIM(friends_bi), '') AS friends_bi,
    NULLIF(TRIM(parents_bi), '') AS parents_bi,
    NULLIF(TRIM(relative_bi), '') AS relative_bi,
    NULLIF(TRIM(professional_bi), '') AS professional_bi,
    NULLIF(TRIM(phone_bi), '') AS phone_bi,
    NULLIF(TRIM(doctor_bi), '') AS doctor_bi,
    NULLIF(TRIM(religion_bi), '') AS religion_bi,
    NULLIF(TRIM(alone_bi), '') AS alone_bi,
    NULLIF(TRIM(others_bi), '') AS others_bi,
    NULLIF(TRIM(internet_bi), '') AS internet_bi
FROM students_raw
WHERE TRIM(inter_dom) IN ('Inter', 'Dom');


-- 2. Verify the number of retained records

SELECT
    COUNT(*) AS cleaned_records
FROM students_clean;


-- 3. Verify the distribution of student groups

SELECT
    inter_dom,
    COUNT(*) AS student_count
FROM students_clean
GROUP BY inter_dom
ORDER BY student_count DESC;


-- 4. Verify that no records have missing key scores

SELECT
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
FROM students_clean;


-- 5. Confirm that the raw data remains unchanged

SELECT
    (SELECT COUNT(*) FROM students_raw) AS raw_records,
    (SELECT COUNT(*) FROM students_clean) AS cleaned_records,
    (SELECT COUNT(*) FROM students_raw)
      - (SELECT COUNT(*) FROM students_clean) AS excluded_records;
