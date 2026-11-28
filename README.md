# Superstore Sales Analysis

An end-to-end data analytics project that explores a retail sales dataset to find what drives sales and where demand is weakest. The project follows the full analyst workflow: business questions, data cleaning, SQL analysis, a Power BI dashboard, and written recommendations.

> Status: data cleaning and SQL analysis are complete. The Power BI dashboard is in progress.

## Business problem

A retail business wants to understand its sales performance. This project answers:

Which products, regions, and customer segments drive sales, and where is demand weakest?

## Dataset

- Source: Superstore sales dataset (`train.csv`) from Kaggle
- Size: 9,800 rows and 18 columns
- Key columns: order and ship dates, ship mode, customer and segment, region, state and city, product category and sub-category, product name, and sales

## Tools

| Tool | Used for |
|---|---|
| WPS Office | Exploring and cleaning the data |
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
7. Which states perform best and worst?
8. Which ship mode is used most?
9. How long does shipping take on average?
10. What share of customers place repeat orders?

## Data cleaning summary

| Check | Result |
|---|---|
| Blank values | 11 blank Postal Codes, all in Burlington, Vermont. Filled with "Unknown". |
| Duplicate rows | None found |
| Date columns | Stored as real dates; converted into DATE columns in MySQL |
| Ship Date vs Order Date | No ship date earlier than its order date |
| Text values | Region, category, segment and ship mode each use one spelling |
| Sales range | Minimum and maximum reviewed, no problems found |

The full log is in [`cleaning_log.md`](cleaning_log.md).

## Project workflow

1. Define the business questions
2. Explore and clean the data
3. Load the cleaned data into MySQL
4. Analyse with SQL (aggregations, CASE, CTEs, window functions)
5. Build a Power BI dashboard
6. Write findings and recommendations

## Progress

- [x] Business questions defined
- [x] Data exploration and cleaning
- [x] Load data into MySQL
- [x] SQL analysis
- [ ] Power BI dashboard
- [ ] Findings and recommendations

## Key findings

The dataset has no profit column, so these findings are about sales, not profit. Total sales across 2015 to 2018 are about 2.26 million.

1. Sales grew strongly after a small dip. Sales fell about 4% in 2016 (459,436), then grew about 31% in 2017 (600,193) and about 20% in 2018 (722,052).
2. Sales are concentrated in a few states. California (446,306) and New York (306,361) together make up about a third of all sales. The weakest states, North Dakota (920), West Virginia (1,210) and Maine (1,271), sell very little.
3. Large orders drive most of the revenue. Orders of 500 or more are only about 12% of orders but bring about 64% of sales. Small orders (under 50) are about 49% of orders but only about 4% of sales.
4. West is the top region, Technology is the top category, and Consumer is the top segment. Consumer customers bring in about 51% of sales (1,148,061).
5. Each category has one clear leader. Chairs lead Furniture (322,823), Storage leads Office Supplies (219,343), and Phones lead Technology (327,782). Phones are the top sub-category in the whole store.
6. The best-selling products are expensive office equipment. The top product is the Canon imageCLASS 2200 Advanced Copier (about 61,600 in sales), and the top 10 are mostly copiers, binding machines and printers.
7. Sales swing a lot from month to month. For example, March 2015 sales were about 12 times February's (+1,121%), and sales usually fell back the next month.
8. Most orders ship in 3 to 5 days. The average is about 4 days. About 60% of orders ship in the normal range, 22% ship fast (0 to 2 days) and 18% ship slowly (6 or more days). Standard Class is used in about 60% of orders.
9. Almost every customer comes back. 780 of 793 customers (98.4%) placed more than one order, though the data covers four years, so this measure is generous.

## Dashboard

A Power BI dashboard with total sales, number of orders, average order value, and charts by region, category and month. Screenshot coming soon.

## Recommendations

To be added after the dashboard is complete.

## Repository contents

| File | Description |
|---|---|
| `README.md` | Project overview |
| `cleaning_log.md` | Data cleaning steps and results |
| `superstore_clean.csv` | Cleaned dataset |
| `train.csv` | Original dataset |
| `sql/01_create_table_and_load.sql` | Creates the table, loads the data, and converts dates |
| `sql/02_exploration_and_analysis.sql` | Exploration and business question queries |

The Power BI dashboard file and screenshots will be added next.

## Author

Akansha Rohilla
B.E. in Computer Science and Engineering (AI and ML), Chandigarh University, 2026
Email: rohillaakansha90@gmail.com | GitHub: [AK26rohilla](https://github.com/AK26rohilla)
