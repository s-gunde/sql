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

customer_id	product_id	number_of_times_product_purchased
1	1	9
1	2	13
1	3	29
1	4	64
1	5	47
1	7	31
1	8	27
1	16	26
2	1	13
2	2	16
2	3	20
2	4	86
2	5	41
2	7	41
2	8	37
2	16	35
3	1	6
3	2	11
3	3	22
3	4	67
3	5	38
3	7	39
3	8	38
3	16	23
4	1	14
4	2	18
4	3	20
4	4	79
4	5	36
4	7	24
4	8	25
4	16	42
5	1	8
5	2	22
5	3	24
5	4	62
5	5	45
5	7	34
5	8	42
5	16	26
6	1	4
6	2	24
6	3	21
6	4	52
6	5	28
6	7	23
6	8	33
6	16	27
7	1	8
7	2	11
7	3	16
7	4	69
7	5	35
7	7	20
7	8	23
7	16	20
8	1	7
8	2	11
8	3	18
8	4	43
8	5	45
8	7	33
8	8	34
8	16	16
9	1	7
9	2	10
9	3	7
9	4	48
9	5	44
9	7	28
9	8	28
9	16	22
10	1	6
10	2	13
10	3	19
10	4	73
10	5	26
10	7	21
10	8	11
10	16	22
11	1	7
11	2	10
11	3	12
11	4	70
11	5	38
11	7	26
11	8	32
11	16	15
12	1	7
12	2	19
12	3	12
12	4	62
12	5	40
12	7	31
12	8	26
12	16	19
13	1	5
13	2	9
13	3	14
13	4	34
13	5	21
13	7	16
13	8	13
13	16	13
14	1	11
14	2	13
14	3	19
14	4	28
14	5	20
14	7	25
14	8	18
14	16	13
15	1	7
15	2	12
15	3	13
15	4	29
15	5	17
15	7	10
15	8	15
15	16	14
16	1	4
16	2	7
16	3	5
16	4	41
16	5	28
16	7	15
16	8	13
16	16	15
17	1	4
17	2	6
17	3	14
17	4	57
17	5	21
17	7	13
17	8	12
17	16	10
18	1	3
18	2	9
18	3	6
18	4	33
18	5	29
18	7	12
18	8	16
18	16	22
19	1	5
19	2	12
19	3	10
19	5	28
19	7	10
19	8	14
19	16	7
20	1	3
20	2	6
20	3	7
20	5	21
20	7	15
20	8	14
20	16	10
21	1	6
21	2	6
21	3	5
21	5	20
21	7	11
21	8	15
21	16	9
22	1	6
22	2	7
22	3	9
22	5	21
22	7	17
22	8	18
22	16	13
23	1	6
23	2	8
23	3	6
23	5	27
23	7	16
23	8	18
23	16	8
24	1	6
24	2	5
24	3	7
24	5	26
24	7	18
24	8	26
24	16	7
25	1	7
25	2	4
25	3	3
25	5	26
25	7	19
25	8	11
25	16	18
26	1	5
26	2	15
26	3	8
26	5	26
26	7	20
26	8	16
26	16	18

Execution finished without errors.
Result: 200 rows returned in 16ms
At line 4:
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



/* 2. Filter the query to show any product_size value that contain a number with REGEXP. */



-- UNION
/* 1. Using a UNION, write a query that displays the market dates with the highest and lowest total sales.

HINT: There are a possibly a few ways to do this query, but if you're struggling, try the following: 
1) Create a CTE/Temp Table to find sales values grouped dates; 
2) Create another CTE/Temp table with a rank windowed function on the previous query to create 
"best day" and "worst day"; 
3) Query the second temp table twice, once for the best day, once for the worst day, 
with a UNION binding them. */




