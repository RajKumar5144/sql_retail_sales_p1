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
 
