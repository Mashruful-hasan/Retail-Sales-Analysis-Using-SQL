Use sales_analysis
SELECT * FROM retail_sales 


SELECT 
Count(*)
from retail_sales


--Checking whether any null values are exist or not
---Data cleaning part

SELECT *
FROM retail_sales
WHERE transactions_id = NULL
   OR sale_date IS NULL
   OR sale_time IS NULL
   OR customer_id IS NULL
   OR gender IS NULL
   OR age IS NULL
   OR category IS NULL
   OR quantiy IS NULL
   OR price_per_unit IS NULL
   OR cogs IS NULL
   OR total_sale IS NULL;

---Now deleting null values from the database


Delete FROM retail_sales
WHERE transactions_id = NULL
   OR sale_date IS NULL
   OR sale_time IS NULL
   OR customer_id IS NULL
   OR gender IS NULL
   OR age IS NULL
   OR category IS NULL
   OR quantiy IS NULL
   OR price_per_unit IS NULL
   OR cogs IS NULL
   OR total_sale IS NULL;
   
---Data Exploration 
---Count of sales

Select * from retail_sales

Select 
Count(*) As total_sales
from retail_sales

---Count of Unique Customer

Select 
Count(Distinct customer_id) As customer_id
from retail_sales


Select 
Distinct category as Category
from 
retail_sales

--Q1: Write a SQL query to retrieve all columns for sales made on 2022-11-05


Select * from retail_sales 

Select * 
from retail_sales
where sale_date = '2022-11-05'

--Q2: Write a SQL query to retrieve all transactions where the category is Clothing and the quantity is sold more than 10 in the month of November-2022

SELECT *
FROM retail_sales
WHERE category = 'Clothing'
  AND DATE_FORMAT(sale_date, '%Y-%m') = '2022-11'
  AND quantiy >= 4;


-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.

Select * from retail_sales

SELECT
category,
sum(total_sale) As Total_Sale
from retail_sales
Group BY category

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

SELECT
    category,
    AVG(age) AS Average_Age
FROM retail_sales
WHERE category = 'Beauty'
GROUP BY category;


-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.

SELECT *
FROM retail_sales
WHERE total_sale > 1000; 

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

Select 
category,
gender,
count(transactions_id) As Total_transaction
from retail_sales
Group BY category, gender

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year

Select * from retail_sales


CREATE TEMPORARY TABLE Monthly_Sales
Select 
Year(sale_date) As Year,
Month(sale_date) As Month,
Round(Avg(total_sale),2) As Average_Sale
from retail_sales
Group BY Year(sale_date), Month(sale_date)
ORDER BY Year, Month


SELECT *
FROM (
    SELECT
        Year,
        Month,
        Average_Sale,
        RANK() OVER (PARTITION BY Year ORDER BY Average_Sale DESC) AS Ranking
    FROM Monthly_Sales
) AS Ranked_Sales
WHERE Ranking = 1
ORDER BY Year;


-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 

Select * from retail_sales

Select 
customer_id,
sum(total_sale) As Highest_Sale
from retail_sales
Group BY customer_id
Order By Highest_Sale Desc
Limit 5


-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.

Select
category,
Count(DIStinct customer_id)
from retail_sales
Group BY category


-- Q.10 Which product categories sell the most units?

Select * from retail_sales

Select 
category,
Sum(quantiy) As Total_Quantity_Sold
from retail_sales
GROUP BY category
ORDER BY Total_Quantity_Sold DESC;


--Q.11 Which product categories generate the most profit?

SELECT
    category,
    SUM(total_sale) AS Total_Revenue,
    Round(SUM(cogs),2) AS Total_COGS,
    Round(SUM(total_sale - cogs),2) AS Total_Profit
FROM retail_sales
GROUP BY category
ORDER BY Total_Profit DESC;









