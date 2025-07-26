-- Drop the database if it exists
DROP DATABASE IF EXISTS sql_project_p1;

-- Create the database if it doesn't exist
CREATE DATABASE IF NOT EXISTS sql_project_p1;
USE sql_project_p1;

-- Drop the table if it exists
DROP TABLE IF EXISTS retail_sales;

-- Create the retail_sales table
CREATE TABLE retail_sales (
    transactions_id INT PRIMARY KEY,
    sale_date DATE,
    sale_time TIME,
    customer_id INT,
    gender VARCHAR(15),
    age INT,
    category VARCHAR(15),
    quantity INT NULL,
    price_per_unit FLOAT NULL,
    cogs FLOAT NULL,
    total_sale FLOAT NULL
);




select * from retail_sales
limit 10;

select
 count(*) 
 from retail_sales;
 
 
 
--
select * from retail_sales
where  transactions_id is null;

select * from retail_sales
where  sale_date is null;

select * from retail_sales
where  
      sale_date is null
      or 
      sale_time is null
      or 
      customer_id is null
      or
      gender is null
      or
      age is null
      or 
      category is null
      or
      quantity is null
      or
      price_per_unit is null
      or 
      cogs is null
      or 
      total_sale is null;
 
 --
 SET SQL_SAFE_UPDATES = 0;

 delete from retail_sales
 
where  
      sale_date is null
      or 
      sale_time is null
      or 
      customer_id is null
      or
      gender is null
      or
      age is null
      or 
      category is null
      or
      quantity is null
      or
      price_per_unit is null
      or 
      cogs is null
      or 
      total_sale is null;
 -- Data Analysis & Business Key Problems & Answers

-- My Analysis & Findings
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)
-- Q.11. Identify repeat customers (who made more than 1 purchase)
-- Q.12. Day of the week performance analysis
-- Q.13. Most profitable category (Total Sale - COGS)
-- Q.14. Age group-based sales behavior



-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05'
select * from retail_sales
where sale_date='2022-11-05';

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022
select 
*
from retail_sales
where
	category='Clothing'
    and 
    quantity >=4
    and 
    date_format(sale_date, '%Y-%m')='2022-11';

-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
select 
category,
  SUM(total_sale) as net_sale,
  count(*) as total_orders
from retail_sales
group by category;

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
select 
    round(avg(age),2) as avg_age
from retail_sales
where category='Beauty';

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
select
* 
from retail_sales
where total_sale > 1000;

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
select
	category,
    gender,
    count(*) as total_trans
from retail_sales
group by category, gender
order by 1;

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
select
  year,
  month,
  avg_sale
from
(
select
     extract(year from sale_date) as year,
     extract(month from sale_date) as month,
     round(avg(total_sale),2) as avg_sale,
     rank() over(partition by extract(year from sale_date) order by avg(total_sale) desc) as rnk
from retail_sales
group by 1,2
)
as t1
where rnk=1;


-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
select 
     customer_id,
     sum(total_sale) as total_sales
from retail_sales
group by 1
order by 2 desc
limit 5;

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
select 
    category,
    count(distinct customer_id) as cnt_unique_cs
from retail_sales
group by category;

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)
SELECT
  CASE
    WHEN HOUR(sale_time) < 12 THEN 'Morning'
    WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
    ELSE 'Evening'
  END AS shift,
  COUNT(*) AS total_orders
FROM retail_sales
GROUP BY shift;

-- Q.11. Identify repeat customers (who made more than 1 purchase)
SELECT 
  customer_id,
  COUNT(*) AS total_orders
FROM retail_sales
GROUP BY customer_id
HAVING total_orders > 1;

-- Q.12. Day of the week performance analysis
SELECT 
  DAYNAME(sale_date) AS day_of_week,
  COUNT(*) AS total_orders,
  ROUND(AVG(total_sale)) AS avg_sale
FROM retail_sales
GROUP BY day_of_week
ORDER BY FIELD(day_of_week, 'Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday');

-- Q.13. Most profitable category (Total Sale - COGS)
SELECT 
  category,
  SUM(total_sale - cogs) AS total_profit
FROM retail_sales
GROUP BY category
ORDER BY total_profit DESC
LIMIT 1;

-- Q.14. Age group-based sales behavior
SELECT
  CASE
    WHEN age < 20 THEN '<20'
    WHEN age BETWEEN 20 AND 29 THEN '20-29'
    WHEN age BETWEEN 30 AND 39 THEN '30-39'
    ELSE '40+'
  END AS age_group,
  COUNT(*) AS total_orders,
  AVG(total_sale) AS avg_sale
FROM retail_sales
GROUP BY age_group;

-- end of project
