# Data Quality and Cleaning Decisions

## Dataset Validation

- Original records: 286
- Original variables: 51
- International students: 201
- Domestic students: 67
- Unclassified records: 18
- Duplicate non-null source indices: 0

## Exclusion Criteria

Records were excluded from student-level analysis when `inter_dom` was not classified as `Inter` or `Dom`.

The excluded source indices were:

`34, 35, 70, 105, 106, 273–285`

Some excluded records contained values in other columns, so they were not all completely empty. Several trailing records appeared to contain summary information rather than individual student responses.

## Missing Data

The raw dataset contained 18 missing values in each of these variables:

- Age (`age`)
- Length of stay (`stay`)
- Depression score (`todep`)
- Social connectedness (`tosc`)
- Acculturative stress (`toas`)

Following exclusion of unclassified records, none of these five variables had missing values in the 268 retained observations.

Missingness in other variables has not yet been comprehensively assessed.

## Cleaning Strategy

The raw imported table, `students_raw`, was preserved.

A SQL view, `students_clean`, was created to:

- Retain only valid international and domestic student classifications.
- Trim whitespace from student-group labels.
- Convert empty strings to SQL `NULL` in selected text fields.
- Preserve numeric measurements without imputation or transformation.

## Verification

Expected counts:

| Dataset | Records |
|---|---:|
| Raw table | 286 |
| Cleaned view | 268 |
| Excluded | 18 |

## Outstanding Validation

Before publication or substantive interpretation, verify the dataset provenance, redistribution rights, scoring direction and theoretical ranges of the mental health scales, and units of length of stay.