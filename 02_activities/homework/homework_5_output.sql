-- Cross Join
/*1. Suppose every vendor in the `vendor_inventory` table had 5 of each of their products to sell to **every** 
customer on record. How much money would each vendor make per product? 
Show this by vendor_name and product name, rather than using the IDs.

HINT: Be sure you select only relevant columns and rows. 
Remember, CROSS JOIN will explode your table rows, so CROSS JOIN should likely be a subquery. 
Think a bit about the row counts: how many distinct vendors, product names are there (x)?
How many customers are there (y). 
Before your final group by you should have the product of those two queries (x*y).  */

SELECT vendor.vendor_name, product.product_name, SUM (5 * vendor_inventory.original_price * customer.total_customers) AS total_price
FROM vendor 
JOIN vendor_inventory ON vendor.vendor_id = vendor_inventory.vendor_id
JOIN product ON vendor_inventory.product_id = product.product_id
CROSS JOIN ( SELECT COUNT(DISTINCT customer_id) AS total_customers FROM customer) AS customer
GROUP BY vendor.vendor_name, product.product_name

vendor_name	product_name	total_price
Annie's Pies	Apple Pie	332280
Annie's Pies	Cherry Pie	332280
Annie's Pies	Whole Wheat Bread	119990.0
Fields of Corn	Sweet Corn	4550.0
Marco's Peppers	Banana Peppers - Jar	73840
Marco's Peppers	Habanero Peppers - Organic	48161.1
Marco's Peppers	Jalapeno Peppers - Organic	24046.1
Marco's Peppers	Poblano Peppers - Organic	3445.0

Execution finished without errors.
Result: 8 rows returned in 11ms
At line 11:
SELECT vendor.vendor_name, product.product_name, SUM (5 * vendor_inventory.original_price * customer.total_customers) AS total_price
FROM vendor 
JOIN vendor_inventory ON vendor.vendor_id = vendor_inventory.vendor_id
JOIN product ON vendor_inventory.product_id = product.product_id
CROSS JOIN ( SELECT COUNT(DISTINCT customer_id) AS total_customers FROM customer) AS customer
GROUP BY vendor.vendor_name, product.product_name



-- INSERT
/*1.  Create a new table "product_units". 
This table will contain only products where the `product_qty_type = 'unit'`. 
It should use all of the columns from the product table, as well as a new column for the `CURRENT_TIMESTAMP`.  
Name the timestamp column `snapshot_timestamp`. */
-- create a new table product_units
CREATE TABLE product_units AS
SELECT * 
FROM product
WHERE product_qty_type = 'unit'

-- add new column snapshot_timestamp
ALTER TABLE product_units
ADD COLUMN snapshot_timestamp TIMESTAMP

--input new column value as "CURRENT_TIMESTAMP"
UPDATE product_units
SET snapshot_timestamp = CURRENT_TIMESTAMP

--display data from newly created table
SELECT * FROM product_units

product_id	product_name	product_size	product_category_id	product_qty_type	snapshot_timestamp
3	Poblano Peppers - Organic	large	1	unit	2024-09-22 03:53:55
4	Banana Peppers - Jar	8 oz	3	unit	2024-09-22 03:53:55
5	Whole Wheat Bread	1.5 lbs	3	unit	2024-09-22 03:53:55
6	Cut Zinnias Bouquet	medium	5	unit	2024-09-22 03:53:55
7	Apple Pie	10"	3	unit	2024-09-22 03:53:55
10	Eggs	1 dozen	6	unit	2024-09-22 03:53:55
12	Baby Salad Lettuce Mix - Bag	1/2 lb	1	unit	2024-09-22 03:53:55
16	Sweet Corn	Ear	1	unit	2024-09-22 03:53:55
18	Carrots - Organic	bunch	1	unit	2024-09-22 03:53:55
19	Farmer's Market Resuable Shopping Bag	medium	7	unit	2024-09-22 03:53:55
20	Homemade Beeswax Candles	6"	7	unit	2024-09-22 03:53:55
21	Organic Cherry Tomatoes	pint	1	unit	2024-09-22 03:53:55
23	Maple Syrup - Jar	8 oz	2	unit	2024-09-22 03:53:55
8	Cherry Pie	10"	3	unit	2024-09-22 03:53:55

Execution finished without errors.
Result: 14 rows returned in 13ms
At line 12:
SELECT * FROM product_units

/*2. Using `INSERT`, add a new row to the product_units table (with an updated timestamp). 	
This can be any product you desire (e.g. add another record for Apple Pie). */
INSERT INTO product_units (product_id, product_name, product_size, product_category_id, product_qty_type, snapshot_timestamp)
VALUES (99, 'Strawberry Pie', '10"', 3, 'unit', CURRENT_TIMESTAMP)

SELECT * FROM product_units

product_id	product_name	product_size	product_category_id	product_qty_type	snapshot_timestamp
3	Poblano Peppers - Organic	large	1	unit	2024-09-22 03:53:55
4	Banana Peppers - Jar	8 oz	3	unit	2024-09-22 03:53:55
5	Whole Wheat Bread	1.5 lbs	3	unit	2024-09-22 03:53:55
6	Cut Zinnias Bouquet	medium	5	unit	2024-09-22 03:53:55
7	Apple Pie	10"	3	unit	2024-09-22 03:53:55
10	Eggs	1 dozen	6	unit	2024-09-22 03:53:55
12	Baby Salad Lettuce Mix - Bag	1/2 lb	1	unit	2024-09-22 03:53:55
16	Sweet Corn	Ear	1	unit	2024-09-22 03:53:55
18	Carrots - Organic	bunch	1	unit	2024-09-22 03:53:55
19	Farmer's Market Resuable Shopping Bag	medium	7	unit	2024-09-22 03:53:55
20	Homemade Beeswax Candles	6"	7	unit	2024-09-22 03:53:55
21	Organic Cherry Tomatoes	pint	1	unit	2024-09-22 03:53:55
23	Maple Syrup - Jar	8 oz	2	unit	2024-09-22 03:53:55
8	Cherry Pie	10"	3	unit	2024-09-22 03:53:55
99	Strawberry Pie	10"	3	unit	2024-09-22 04:07:44

Execution finished without errors.
Result: 15 rows returned in 21ms
At line 15:
--display data from newly created table
SELECT * FROM product_units

-- DELETE
/* 1. Delete the older record for the whatever product you added. 

HINT: If you don't specify a WHERE clause, you are going to have a bad time.*/
DELETE FROM product_units
WHERE product_id = 99

Execution finished without errors.
Result: query executed successfully. Took 0ms, 1 rows affected
At line 21:
DELETE FROM product_units
WHERE product_id = 99



-- UPDATE
/* 1.We want to add the current_quantity to the product_units table. 
First, add a new column, current_quantity to the table using the following syntax.

ALTER TABLE product_units
ADD current_quantity INT;

Then, using UPDATE, change the current_quantity equal to the last quantity value from the vendor_inventory details.

HINT: This one is pretty hard. 
First, determine how to get the "last" quantity per product. 
Second, coalesce null values to 0 (if you don't have null values, figure out how to rearrange your query so you do.) 
Third, SET current_quantity = (...your select statement...), remembering that WHERE can only accommodate one column. 
Finally, make sure you have a WHERE statement to update the right row, 
	you'll need to use product_units.product_id to refer to the correct row within the product_units table. 
When you have all of these components, you can run the update statement. */
--display product_units table
SELECT * 
FROM product_units

--add new column current_quantity
ALTER TABLE product_units
ADD current_quantity INT

--create temp table to store last product quantity 
CREATE TEMP TABLE temp_last_product_quantity AS
SELECT product.product_id, MAX(vendor_inventory.market_date) as last_sold_on, COALESCE(vendor_inventory.quantity, 0) AS last_quantity
FROM product
LEFT JOIN vendor_inventory
ON product.product_id = vendor_inventory.product_id 
GROUP BY product.product_id

SELECT * FROM temp_last_product_quantity

--update last quantity for products in product_units table
UPDATE product_units 
SET current_quantity = (
  SELECT last_quantity 
  FROM temp_last_product_quantity
  WHERE temp_last_product_quantity.product_id = product_units.product_id)

product_id	product_name	product_size	product_category_id	product_qty_type	snapshot_timestamp	current_quantity
3	Poblano Peppers - Organic	large	1	unit	2024-09-22 03:53:55	60
4	Banana Peppers - Jar	8 oz	3	unit	2024-09-22 03:53:55	30
5	Whole Wheat Bread	1.5 lbs	3	unit	2024-09-22 03:53:55	20
6	Cut Zinnias Bouquet	medium	5	unit	2024-09-22 03:53:55	0
7	Apple Pie	10"	3	unit	2024-09-22 03:53:55	10
10	Eggs	1 dozen	6	unit	2024-09-22 03:53:55	0
12	Baby Salad Lettuce Mix - Bag	1/2 lb	1	unit	2024-09-22 03:53:55	0
16	Sweet Corn	Ear	1	unit	2024-09-22 03:53:55	140
18	Carrots - Organic	bunch	1	unit	2024-09-22 03:53:55	0
19	Farmer's Market Resuable Shopping Bag	medium	7	unit	2024-09-22 03:53:55	0
20	Homemade Beeswax Candles	6"	7	unit	2024-09-22 03:53:55	0
21	Organic Cherry Tomatoes	pint	1	unit	2024-09-22 03:53:55	0
23	Maple Syrup - Jar	8 oz	2	unit	2024-09-22 03:53:55	0
8	Cherry Pie	10"	3	unit	2024-09-22 03:53:55	10

Execution finished without errors.
Result: 14 rows returned in 21ms
At line 1:
--display product_units table
SELECT * 
FROM product_units

