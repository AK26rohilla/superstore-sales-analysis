-- 02_exploration_and_analysis.sql
-- Project: Superstore Sales Analysis
-- Table: superstore (9,800 rows). Run 01_create_table_and_load.sql first.

USE superstore_project;

-- ==========================
-- PART 1: EXPLORATION
-- ==========================

-- 1. How many rows are in the table?
SELECT COUNT(*) FROM superstore;
-- 9800

-- 2. How many order dates are empty?
SELECT COUNT(*) FROM superstore WHERE order_date_clean IS NULL;
-- 0

-- 3. Which regions exist?
SELECT DISTINCT region FROM superstore;
-- South, West, Central, East

-- 4. Which categories exist?
SELECT DISTINCT category FROM superstore;
-- Furniture, Office Supplies, Technology

-- 5. Which segments exist?
SELECT DISTINCT segment FROM superstore;
-- Consumer, Corporate, Home Office

-- 6. Which ship modes exist?
SELECT DISTINCT ship_mode FROM superstore;
-- Second Class, Standard Class, First Class, Same Day

-- 7. Smallest, biggest and average sale
SELECT MIN(sales), MAX(sales), AVG(sales) FROM superstore;
-- min = 0.44, max = 22,638, average = about 230
-- A few very large sales pull the average up

-- ==========================
-- PART 2: BUSINESS QUESTIONS
-- ==========================

-- Business question 1: Which regions generate the most sales?
SELECT region, SUM(sales) AS total_sales
FROM superstore
GROUP BY region
ORDER BY total_sales DESC;
-- West sells the most

-- Business question 2a: Which categories sell the most?
SELECT category, SUM(sales) AS total_sales
FROM superstore
GROUP BY category
ORDER BY total_sales DESC;
-- Technology sells the most

-- Business question 2b: Which sub-categories sell the most?
SELECT sub_category, SUM(sales) AS total_sales
FROM superstore
GROUP BY sub_category
ORDER BY total_sales DESC;
-- Phones sell the most

-- Business question 2c: Which sub-categories sell the least?
SELECT sub_category, SUM(sales) AS total_sales
FROM superstore
GROUP BY sub_category
ORDER BY total_sales ASC;
-- Fasteners sell the least

-- Business question 3: What are the top 10 products by sales?
SELECT product_name, SUM(sales) AS total_sales
FROM superstore
GROUP BY product_name
ORDER BY total_sales DESC
LIMIT 10;
-- Top product: Canon imageCLASS 2200 Advanced Copier (about 61,600 in sales)
-- Top 10 products are mostly copiers, binding machines and printers

-- Business question 4a: How do sales change by year?
SELECT YEAR(order_date_clean) AS order_year, SUM(sales) AS total_sales
FROM superstore
GROUP BY order_year
ORDER BY order_year;
-- 2015: 479,856 | 2016: 459,436 | 2017: 600,193 | 2018: 722,052
-- Sales dipped in 2016, then grew about 31% in 2017 and 20% in 2018

-- Business question 4b: How do sales change month by month?
-- Step 1: total sales for each month
SELECT YEAR(order_date_clean) AS yr,
       MONTH(order_date_clean) AS mth,
       SUM(sales) AS monthly_sales
FROM superstore
GROUP BY yr, mth
ORDER BY yr, mth;

-- Step 2: add the previous month's sales and the percent change
WITH monthly AS (
  SELECT YEAR(order_date_clean) AS yr,
         MONTH(order_date_clean) AS mth,
         SUM(sales) AS monthly_sales
  FROM superstore
  GROUP BY yr, mth
)
SELECT yr, mth, monthly_sales,
       LAG(monthly_sales) OVER (ORDER BY yr, mth) AS previous_month_sales,
       ROUND((monthly_sales - LAG(monthly_sales) OVER (ORDER BY yr, mth)) * 100.0
             / LAG(monthly_sales) OVER (ORDER BY yr, mth), 1) AS pct_change
FROM monthly;
-- Month-over-month sales swing a lot; March 2015 jumped 1,121% over February
-- Sales usually fall back after a big month (for example April 2015 fell 49% after March)

-- Business question 5: Which customer segment brings in the most sales?
SELECT segment, SUM(sales) AS total_sales
FROM superstore
GROUP BY segment
ORDER BY total_sales DESC;
-- Consumer 1,148,061 | Corporate 688,494 | Home Office 424,982
-- Consumer is the biggest segment (about 51% of sales)

-- Business question 6: Who are the top 10 customers by sales?
SELECT customer_name, SUM(sales) AS total_sales
FROM superstore
GROUP BY customer_name
ORDER BY total_sales DESC
LIMIT 10;
-- Top customer: Sean Miller (about 25,043 in sales)

-- Business question 7a: Which are the top 10 states by sales?
SELECT state, SUM(sales) AS total_sales
FROM superstore
GROUP BY state
ORDER BY total_sales DESC
LIMIT 10;
-- Top states: California (446,306), New York (306,361), Texas (168,573)
-- California and New York together are about a third of all sales

-- Business question 7b: Which are the bottom 10 states by sales?
SELECT state, SUM(sales) AS total_sales
FROM superstore
GROUP BY state
ORDER BY total_sales ASC
LIMIT 10;
-- Weakest states: North Dakota (920), West Virginia (1,210), Maine (1,271)

-- Business question 8: Which ship mode is used most?
SELECT ship_mode, COUNT(*) AS number_of_orders
FROM superstore
GROUP BY ship_mode
ORDER BY number_of_orders DESC;
-- Standard Class 5,859 | Second Class 1,902 | First Class 1,501 | Same Day 538
-- Standard Class is used in about 60% of orders; Same Day only about 5%

-- Business question 9: How long does shipping take on average?
-- Check on 5 rows first
SELECT order_date_clean, ship_date_clean,
       DATEDIFF(ship_date_clean, order_date_clean) AS days_to_ship
FROM superstore
LIMIT 5;

SELECT AVG(DATEDIFF(ship_date_clean, order_date_clean)) AS avg_days_to_ship
FROM superstore;
-- On average, orders ship in about 4 days (3.96)

-- Business question 10: What share of customers place repeat orders?
WITH customer_orders AS (
  SELECT customer_id, COUNT(DISTINCT order_id) AS number_of_orders
  FROM superstore
  GROUP BY customer_id
)
SELECT
  (SELECT COUNT(*) FROM customer_orders) AS total_customers,
  (SELECT COUNT(*) FROM customer_orders WHERE number_of_orders > 1) AS repeat_customers,
  ROUND((SELECT COUNT(*) FROM customer_orders WHERE number_of_orders > 1) * 100.0
        / (SELECT COUNT(*) FROM customer_orders), 1) AS repeat_pct;
-- Repeat customers: 780 of 793 (780 / 793 x 100 = 98.4%)
-- Only 13 customers ordered just once, so almost every customer comes back
-- Note: the data covers four years, so this repeat rate is high; a tighter measure
-- (for example, repeat within one year) would be more telling

-- ==========================
-- PART 3: CASE AND WINDOW FUNCTIONS
-- ==========================

-- Order size: how many orders are small, medium or large?
SELECT
  CASE
    WHEN sales < 50 THEN 'Small order'
    WHEN sales < 500 THEN 'Medium order'
    ELSE 'Large order'
  END AS order_size,
  COUNT(*) AS number_of_orders,
  SUM(sales) AS total_sales
FROM superstore
GROUP BY order_size;
-- Small 4,754 orders, Medium 3,900, Large 1,146 (total 9,800)
-- Large orders are about 12% of orders but about 64% of sales
-- Small orders are about 49% of orders but only about 4% of sales

-- Shipping speed: how many orders ship fast, normal or slow?
SELECT
  CASE
    WHEN DATEDIFF(ship_date_clean, order_date_clean) <= 2 THEN 'Fast'
    WHEN DATEDIFF(ship_date_clean, order_date_clean) <= 5 THEN 'Normal'
    ELSE 'Slow'
  END AS shipping_speed,
  COUNT(*) AS number_of_orders
FROM superstore
GROUP BY shipping_speed;
-- Fast 2,172 | Normal 5,843 | Slow 1,785 (total 9,800)
-- About 60% of orders ship in 3 to 5 days; about 18% are slow (6+ days)

-- Rank within category: inside each category, which sub-category sells the most?
SELECT category, sub_category,
       SUM(sales) AS total_sales,
       RANK() OVER (PARTITION BY category ORDER BY SUM(sales) DESC) AS rank_in_category
FROM superstore
GROUP BY category, sub_category
ORDER BY category, rank_in_category;
-- Phones are the top Technology sub-category (327,782) and also the top sub-category in the store, ahead of Chairs (322,823)
-- Each category has one leader: Chairs (Furniture), Storage (Office Supplies), Phones (Technology)
-- Chairs and Tables together are about 72% of Furniture sales
