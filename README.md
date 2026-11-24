# Superstore Sales Analysis

An end-to-end data analytics project that explores a retail sales dataset to find what drives sales and where demand is weakest. The project follows the full analyst workflow: business questions, data cleaning, SQL analysis, a Power BI dashboard, and written recommendations.

> **Status:** in progress. Data cleaning is complete; SQL analysis and the dashboard are being added step by step.

## Business problem

A retail business wants to understand its sales performance. This project answers:

**Which products, regions, and customer segments drive sales, and where is demand weakest?**

## Dataset

- **Source:** Superstore sales dataset (`train.csv`) from Kaggle
- **Size:** 9,800 rows and 18 columns
- **Key columns:** order and ship dates, ship mode, customer and segment, region, state and city, product category and sub-category, product name, and sales

## Tools

| Tool | Used for |
|---|---|
| WPS Office / Excel | Exploring and cleaning the data |
| MySQL | Storing the data and answering questions with SQL |
| Power BI | Building the dashboard |
| GitHub | Version control and documentation |

## Business questions

1. Which regions generate the most sales?
2. Which categories and sub-categories sell the most and least?
3. What are the top 10 products by sales?
4. How do sales change month by month and year by year?
5. Which customer segment brings in the most sales?
6. Who are the top 10 customers by sales?
7. Which states and cities have the highest and lowest sales?
8. Which ship mode is used most?
9. How long does shipping take on average?
10. What share of customers place repeat orders?

## Data cleaning summary

| Check | Result |
|---|---|
| Blank values | 11 blank Postal Codes, all in Burlington, Vermont. Filled with "Unknown". |
| Duplicate rows | None found |
| Date columns | Stored as real dates |
| Ship Date vs Order Date | No ship date earlier than its order date |
| Sales range | Minimum and maximum reviewed, no problems found |

The full log is in [`cleaning_log.md`](cleaning_log.md).

## Project workflow

1. Define the business questions
2. Explore and clean the data
3. Load the cleaned data into MySQL
4. Analyse with SQL (aggregations, CASE, window functions)
5. Build a Power BI dashboard
6. Write findings and recommendations

## Progress

- [x] Business questions defined
- [x] Data exploration and cleaning
- [ ] Load data into MySQL
- [ ] SQL analysis
- [ ] Power BI dashboard
- [ ] Findings and recommendations

## Key findings

*To be added after the analysis is complete.*

## Recommendations

*To be added after the analysis is complete.*

## Repository contents

| File | Description |
|---|---|
| `README.md` | Project overview |
| `cleaning_log.md` | Data cleaning steps and results |
| `superstore_clean.xlsx` | Cleaned dataset |

More files (SQL queries, dashboard, screenshots) will be added as the project progresses.

## Author

**Akansha Rohilla**
B.E. in Computer Science and Engineering (AI and ML), Chandigarh University, 2026
Email: rohillaakansha90@gmail.com | GitHub: [AK26rohilla](https://github.com/AK26rohilla)
