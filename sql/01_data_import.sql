
-- ============================================================
-- PROJECT: International Student Mental Health
-- SCRIPT: 01_data_import.sql
-- DATABASE: student_mental_health
-- PURPOSE: Create raw table and import the source CSV
-- ============================================================

-- Stop execution if a SQL error occurs (psql).
\set ON_ERROR_STOP on

-- 1. Recreate the raw table
-- WARNING: This replaces the existing students_raw table.

DROP TABLE IF EXISTS students_raw;

CREATE TABLE students_raw (
    source_index INTEGER,
    inter_dom TEXT,
    region TEXT,
    gender TEXT,
    academic TEXT,
    age NUMERIC,
    age_cate NUMERIC,
    stay NUMERIC,
    stay_cate TEXT,
    japanese NUMERIC,
    japanese_cate TEXT,
    english NUMERIC,
    english_cate TEXT,
    intimate TEXT,
    religion TEXT,
    suicide TEXT,
    dep TEXT,
    deptype TEXT,
    todep NUMERIC,
    depsev TEXT,
    tosc NUMERIC,
    apd NUMERIC,
    ahome NUMERIC,
    aph NUMERIC,
    afear NUMERIC,
    acs NUMERIC,
    aguilt NUMERIC,
    amiscell NUMERIC,
    toas NUMERIC,
    partner NUMERIC,
    friends NUMERIC,
    parents NUMERIC,
    relative NUMERIC,
    profess NUMERIC,
    phone NUMERIC,
    doctor NUMERIC,
    reli NUMERIC,
    alone NUMERIC,
    others NUMERIC,
    internet NUMERIC,
    partner_bi TEXT,
    friends_bi TEXT,
    parents_bi TEXT,
    relative_bi TEXT,
    professional_bi TEXT,
    phone_bi TEXT,
    doctor_bi TEXT,
    religion_bi TEXT,
    alone_bi TEXT,
    others_bi TEXT,
    internet_bi TEXT
);

-- 2. Import the CSV
-- FORCE_NULL converts quoted empty strings to SQL NULL
-- for the numeric columns.

\copy students_raw FROM 'data/raw/datalab_export_student.csv' WITH (FORMAT CSV, HEADER TRUE, NULL '', FORCE_NULL (source_index, age, age_cate, stay, japanese, english, todep, tosc, apd, ahome, aph, afear, acs, aguilt, amiscell, toas, partner, friends, parents, relative, profess, phone, doctor, reli, alone, others, internet))

-- 3. Verify the import

SELECT COUNT(*) AS total_rows
FROM students_raw;

-- 4. Verify student-group classifications

SELECT
    inter_dom,
    COUNT(*) AS record_count
FROM students_raw
GROUP BY inter_dom
ORDER BY record_count DESC;
