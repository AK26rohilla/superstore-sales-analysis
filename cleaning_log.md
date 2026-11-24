# Data Cleaning Log

**Project:** Superstore Sales Analysis

**Original file:** train.csv from the Superstore dataset on Kaggle

**Cleaned file:** superstore_clean.xlsx

**Tool used:** WPS Office (spreadsheet)

## Dataset overview

- Rows: 9800
- Columns: 18

## Issues found and fixes

| # | Column | Problem found | How I found it | Fix applied | Rows affected |
| --- | --- | --- | --- | --- | --- |
| 1 | Postal Code | Blank values. COUNTBLANK showed 11, but they were hard to see among thousands of rows. All were in Burlington, Vermont. | Compared COUNTA with the total row count, then sorted the column so blank cells moved to the bottom | Filled the blanks with "Unknown". Postal Code kept as text so leading zeros are not lost. | 11 |

## Checks completed with no issue

| Check | Result |
| --- | --- |
| Dataset size (rows and columns) | Reviewed |
| Minimum and maximum of Sales | Reviewed, no problems found |

## Other checks

- Duplicate rows (same Order ID and Product ID): Done, no duplicates found.
- Dates stored as real dates, not text: Done, no issue.
- Ship Date is not earlier than Order Date: Done, no issue.
- Same value spelled differently (for example, region or category names)

## What I learned

COUNTBLANK showed 11 blanks that I could not see. I checked in a second way, found them by sorting, and fixed them. Always cross-check a number that looks surprising.
