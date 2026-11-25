USE superstore_project;
-- 1. How many rows are in the table?
SELECT COUNT(*) FROM superstore;
-- 9800

-- 2. How many order dates are empty? 
SELECT COUNT(*) FROM superstore WHERE order_date_clean IS NULL;
-- 0 


-- 3. Which regions exist?
SELECT DISTINCT region FROM superstore;
-- South,west,central,east

-- 4. Which categories exist?
SELECT DISTINCT category FROM superstore;
-- Furniture,Office Supplies,Technology

-- 5. what are diffrent segments?
SELECT DISTINCT segment FROM superstore;
-- Consumer,Corporate,Home Office

-- 6. what are various ship modes?
SELECT DISTINCT ship_mode FROM superstore;
-- second class,standard class, first class, same day

-- 5. Smallest, biggest and average sale
SELECT MIN(sales), MAX(sales), AVG(sales) FROM superstore;
-- min=0.44,max=22638,avg=230

-- Business question 1: Total sales by region
SELECT region, SUM(sales) AS total_sales
FROM superstore
GROUP BY region
ORDER BY total_sales DESC;
-- West sells the most 

-- Business question 1: Total sales by category
SELECT category ,sum(sales) as total_sales
FROM superstore
GROUP BY category
order by total_sales desc;
-- technology sold the most

-- Business question 2: Which sub-categories sell the most and least?
SELECT sub_category ,sum(sales) as total_sales
FROM superstore
group by sub_category
order by total_sales desc;
-- mostly sold is phones

SELECT sub_category, sum(sales) as total_sales
FROM superstore
group by sub_category
order by total_sales asc;
-- least sold is fastners 

-- Business question 3: What are the top 10 products by sales?
SELECT product_name , sum(sales) as total_sales
from superstore
group by product_name
order by total_sales desc limit 10 ;
-- Top product: Canon imageCLASS 2200 Advanced Copier (about 61,600 in sales)
-- Top 10 products are mostly copiers, binding machines and printers

-- Business question 4: What are the top 10 costumers by sales?
SELECT customer_name , sum(sales) as total_sales
from superstore
group by customer_name
order by total_sales desc 
limit 10;
-- Top customer: Sean Miller (about 25,043 in sales)

-- Business question 5: How do sales change by year?
SELECT YEAR(order_date_clean) AS order_year, SUM(sales) AS total_sales
FROM superstore
GROUP BY order_year
ORDER BY  order_year desc;
-- Sales dipped in 2016, then grew about 31% in 2017 and 20% in 2018
-
-- Business Question 6 : Find total sales by segment
SELECT segment ,sum(sales) as total_sales
from superstore
group by segment
order by total_sales desc;
-- Consumer is the biggest segment (about 51% of sales)

-- Business question 8: Which ship mode is used most?
SELECT ship_mode ,count(*)as number_of_orders
from superstore
group by ship_mode
order by number_of_orders desc;
-- Standard Class is used in about 60% of orders; Same Day only about 5%

-- Business question 7: find the top 10 states by sales, and then the bottom 10. 
select state , sum(sales) as total_sales
from superstore
group by state
order by total_sales desc;

select state , sum(sales) as total_sales
from superstore
group by state
order by total_sales asc;
-- Top states: California (446,306), New York (306,361), Texas (168,573)
-- Weakest states: North Dakota (920), West Virginia (1,210), Maine (1,271)
-- California and New York together are about a third of all sales
