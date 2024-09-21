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