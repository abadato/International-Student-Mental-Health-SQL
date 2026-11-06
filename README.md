# International Student Mental Health | SQL Data Analysis

**Exploratory Data Analysis | PostgreSQL | Data Cleaning | Statistical Analysis**

## Project Overview

This project explores relationships between student status, social connectedness, acculturative stress, length of stay, and depression scores using PostgreSQL.

The analysis demonstrates a reproducible SQL workflow, from importing and validating raw data to cleaning records, calculating descriptive statistics, examining correlations, and fitting simple linear regression models.

**Tools:** PostgreSQL 17, SQL, VS Code, Git/GitHub

**Dataset:** Student mental health survey data (286 imported records; 268 retained for student-level analysis).

*Dataset source, licensing information, questionnaire definitions, and measurement units will be documented after verification.*

## Research Questions

1. Do international and domestic students differ in depression scores and social connectedness?
2. Is social connectedness associated with depression scores?
3. Is acculturative stress associated with depression scores among international students?
4. Is length of stay associated with depression, acculturative stress, or social connectedness among international students?

## Data Preparation and Quality Assessment

The original dataset contained 286 records and 51 variables.

Data validation identified:

- 201 international students and 67 domestic students.
- 18 records without valid student-group classifications.
- No duplicate non-null source indices.
- Missing values in key numeric measures confined to the 18 unclassified records.

A cleaned SQL view, `students_clean`, was created to retain the 268 classified observations while preserving the original `students_raw` table.

The 18 excluded records included entries without essential participant-level information and some apparent summary or aggregate values. Exclusion was based on the absence of a valid student classification.

## Key Findings

### 1. International vs. Domestic Students

| Measure | International (n = 201) | Domestic (n = 67) |
|---|---:|---:|
| Mean age | 21.03 | 20.40 |
| Mean depression score | 8.04 | 8.61 |
| SD depression score | 4.90 | 5.12 |
| Mean social connectedness | 37.42 | 37.64 |

International students had slightly lower mean depression scores than domestic students (difference = −0.57 points). Social connectedness scores were similar across groups.

These differences are descriptive and have not been subjected to inferential testing.

### 2. Social Connectedness and Depression

Social connectedness was negatively correlated with depression scores across the full sample:

**Pearson's r = −0.552 (n = 268)**

The association was observed in both groups:

- International students: r = −0.537
- Domestic students: r = −0.598

Mean depression scores declined from 11.91 in the lowest connectedness quartile to 4.93 in the highest quartile.

Simple linear regression explained 28.8% of depression-score variance among international students and 35.8% among domestic students.

### 3. Acculturative Stress and Depression

Among international students (n = 201), acculturative stress was positively correlated with depression scores:

**Pearson's r = +0.412**

Mean depression scores increased from 5.18 in the lowest stress quartile to 10.76 in the highest quartile.

Simple linear regression yielded a slope of 0.089 and R² = 0.169.

### 4. Length of Stay and Mental Health

Among international students (n = 201), length of stay showed very weak linear associations with the three mental health measures.

| Relationship | Pearson's r |
|---|---:|
| Length of stay and depression | +0.073 |
| Length of stay and acculturative stress | +0.022 |
| Length of stay and social connectedness | −0.052 |

The simple regression of depression scores on length of stay produced R² = 0.005.

Length of stay therefore had very limited explanatory value for depression scores in this unadjusted linear model.

## SQL Methods

The project uses:

- Data import and schema definition with PostgreSQL.
- Data-quality checks for missing values, duplicates, and group classifications.
- Reproducible cleaning through a SQL view.
- Descriptive statistics using `COUNT()`, `AVG()`, `STDDEV_SAMP()`, `MIN()`, and `MAX()`.
- Median estimation with `PERCENTILE_CONT()`.
- Quartile-based summaries with `NTILE()`.
- Pearson correlations with `CORR()`.
- Simple linear regression with `REGR_SLOPE()`, `REGR_INTERCEPT()`, and `REGR_R2()`.
- Common table expressions (CTEs) for structured analysis queries.

## Project Structure

```text
SQL_nternational-student-mental-health/
├── README.md
├── .gitignore
├── data/
│   └── raw/
│       └── datalab_export_student.csv
├── sql/
│   ├── 01_data_import.sql
│   ├── 02_data_exploration.sql
│   ├── 03_data_quality.sql
│   ├── 04_data_cleaning.sql
│   ├── 05_group_comparison.sql
│   ├── 06_social_connectedness.sql
│   ├── 07_acculturative_stress.sql
│   └── 08_length_of_stay.sql
├── documentation/
│   └── data_quality.md
└── results/
```

The raw CSV is kept locally and should not be committed to a public repository until its redistribution permissions and privacy status are verified.

## Reproducibility

**Requirements:** PostgreSQL 17 and the original dataset, obtained from its authorized source.

1. Clone the repository.
2. Obtain the dataset and place it in `data/raw/datalab_export_student.csv`.
3. Create a PostgreSQL database named `student_mental_health`.
4. From the project root, execute the SQL scripts sequentially using `psql`.
5. Verify that the imported table contains 286 records and the cleaned analysis view contains 268 observations.

Example:

```bash
createdb student_mental_health
psql -d student_mental_health -f sql/01_data_import.sql
psql -d student_mental_health -f sql/02_data_exploration.sql
psql -d student_mental_health -f sql/03_data_quality.sql
psql -d student_mental_health -f sql/04_data_cleaning.sql
psql -d student_mental_health -f sql/05_group_comparison.sql
psql -d student_mental_health -f sql/06_social_connectedness.sql
psql -d student_mental_health -f sql/07_acculturative_stress.sql
psql -d student_mental_health -f sql/08_length_of_stay.sql
```

Commands should be run from the project root in a terminal. The import script uses `psql`-specific commands and is not intended to run directly through the SQLTools query editor.

## Limitations

- The analyses are observational and cannot establish causal relationships.
- Regression models are exploratory and unadjusted for potential confounding variables.
- The domestic and international groups have unequal sample sizes.
- The questionnaire scoring rules, clinical thresholds, and length-of-stay units require verification against the original documentation.
- Quartiles generated using `NTILE()` may split observations with identical scores across adjacent groups.
- The length-of-stay distribution is concentrated at lower values, with few observations at longer stays.
- Statistical significance tests, confidence intervals, and model diagnostics have not yet been performed.
- The findings should not be interpreted as clinical diagnoses or generalized beyond the sampled population without further evidence.

## Future Improvements

Potential extensions include multivariable regression, confidence intervals, model diagnostics, visualizations, and sensitivity analyses.

## Data Source and Acknowledgments

The dataset used in this project was accessed through resources discovered on DataSciencePortfol.io – SQL Projects.

## Author

Dato Abashidze

*Data Science portfolio project demonstrating SQL-based data validation, exploratory analysis, and reproducible analytical workflows.*
