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



