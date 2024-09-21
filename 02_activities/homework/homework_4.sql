-- COALESCE
/* 1. Our favourite manager wants a detailed long list of products, but is afraid of tables! 
We tell them, no problem! We can produce a list with all of the appropriate details. 

Using the following syntax you create our super cool and not at all needy manager a list:

SELECT 
product_name || ', ' || product_size|| ' (' || product_qty_type || ')'
FROM product

But wait! The product table has some bad data (a few NULL values). 
Find the NULLs and then using COALESCE, replace the NULL with a 
blank for the first problem, and 'unit' for the second problem. 

HINT: keep the syntax the same, but edited the correct components with the string. 
The `||` values concatenate the columns into strings. 
Edit the appropriate columns -- you're making two edits -- and the NULL rows will be fixed. 
All the other rows will remain the same.) */

--to display which columns have NULL values
SELECT *
FROM product
WHERE ( product_name IS NULL
      OR product_size IS NULL
	  OR product_qty_type IS NULL)
	  
--replacing null values with coalesce
SELECT product_name || ', ' || COALESCE(product_size, ' ')  || ' (' || COALESCE(product_qty_type, 'unit') || ')' 
FROM product
--WHERE product_id IN (14, 15) --checking if null values are correctly replaced with coalesce values
	


--Windowed Functions
/* 1. Write a query that selects from the customer_purchases table and numbers each customer’s  
visits to the farmer’s market (labeling each market date with a different number). 
Each customer’s first visit is labeled 1, second visit is labeled 2, etc. 

You can either display all rows in the customer_purchases table, with the counter changing on
each new market date for each customer, or select only the unique market dates per customer 
(without purchase details) and number those visits. 
HINT: One of these approaches uses ROW_NUMBER() and one uses DENSE_RANK(). */

--displaying customer unique visits to market
SELECT DISTINCT customer_id, market_date
FROM customer_purchases
ORDER BY customer_id, market_date

--assigned ranking for customer market visits with including cases with ties and no ties
SELECT customer_id, market_date, DENSE_RANK() OVER (PARTITION BY customer_id ORDER BY market_date) AS tied_customer_visits_ranking, 
ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY market_date) AS no_tied_customer_visits_ranking
FROM customer_purchases 

--assigned ranking for customer unique visits
SELECT DISTINCT customer_id, market_date, DENSE_RANK() OVER (PARTITION BY customer_id ORDER BY market_date) AS unique_market_visits
FROM customer_purchases



/* 2. Reverse the numbering of the query from a part so each customer’s most recent visit is labeled 1, 
then write another query that uses this one as a subquery (or temp table) and filters the results to 
only the customer’s most recent visit. */
DROP TABLE IF EXISTS temp_customer_unique_visits

--create temporary table to store customer unique visits ranking
CREATE TEMPORARY TABLE temp_customer_unique_visits AS
SELECT DISTINCT customer_id, market_date, DENSE_RANK() OVER (PARTITION BY customer_id ORDER BY market_date DESC) AS unique_market_visits_rank
FROM customer_purchases

--display only latest customer visits to market
SELECT * FROM temp_customer_unique_visits
WHERE unique_market_visits_rank = 1


/* 3. Using a COUNT() window function, include a value along with each row of the 
customer_purchases table that indicates how many different times that customer has purchased that product_id. */

SELECT DISTINCT customer_id, product_id, COUNT(product_id) OVER (PARTITION BY customer_id, product_id) AS number_of_times_product_purchased
FROM customer_purchases




-- String manipulations
/* 1. Some product names in the product table have descriptions like "Jar" or "Organic". 
These are separated from the product name with a hyphen. 
Create a column using SUBSTR (and a couple of other commands) that captures these, but is otherwise NULL. 
Remove any trailing or leading whitespaces. Don't just use a case statement for each product! 

| product_name               | description |
|----------------------------|-------------|
| Habanero Peppers - Organic | Organic     |

Hint: you might need to use INSTR(product_name,'-') to find the hyphens. INSTR will help split the column. */

SELECT product_name, IIF(INSTR(product_name, '-')= 0, NULL, TRIM(SUBSTR(product_name, INSTR(product_name, '-') + 1))) AS description
FROM product

/* 2. Filter the query to show any product_size value that contain a number with REGEXP. */

SELECT product_name, product_size, IIF(INSTR(product_name, '-')= 0, NULL, TRIM(SUBSTR(product_name, INSTR(product_name, '-') + 1))) AS description
FROM product
WHERE product_size REGEXP '[0-9]'

-- UNION
/* 1. Using a UNION, write a query that displays the market dates with the highest and lowest total sales.

HINT: There are a possibly a few ways to do this query, but if you're struggling, try the following: 
1) Create a CTE/Temp Table to find sales values grouped dates;
2) Create another CTE/Temp table with a rank windowed function on the previous query to create 
"best day" and "worst day"; 
3) Query the second temp table twice, once for the best day, once for the worst day, 
with a UNION binding them. */

--1) Create a CTE/Temp Table to find sales values grouped dates;
DROP TABLE IF EXISTS temp_sales_by_date

CREATE TEMP TABLE temp_sales_by_date AS
SELECT market_date, ROUND (SUM(quantity * cost_to_customer_per_qty),2) AS sales
FROM customer_purchases
GROUP BY market_date
ORDER BY market_date

SELECT * FROM temp_sales_by_date

--2) Create another CTE/Temp table with a rank windowed function on the previous query to create "best day" and "worst day"; 
DROP TABLE IF EXISTS temp_ranked_sales

CREATE TEMP TABLE temp_ranked_sales AS
SELECT market_date, sales, RANK() OVER (ORDER BY sales DESC) AS sales_rank,
CASE
        WHEN RANK() OVER (ORDER BY sales DESC) = 1 THEN 'best day'
        WHEN RANK() OVER (ORDER BY sales DESC) = COUNT(market_date) OVER () THEN 'worst day'
        ELSE 'normal day'
    END AS day_description
FROM temp_sales_by_date

SELECT * FROM temp_ranked_sales

--3) Query the second temp table twice, once for the best day, once for the worst day, with a UNION binding them. 
SELECT * FROM temp_ranked_sales WHERE day_description = 'best day'
UNION
SELECT * FROM temp_ranked_sales WHERE day_description = 'worst day'





