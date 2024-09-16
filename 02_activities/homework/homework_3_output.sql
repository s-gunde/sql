-- AGGREGATE
/* 1. Write a query that determines how many times each vendor has rented a booth 
at the farmer’s market by counting the vendor booth assignments per vendor_id. */
SELECT vendor_id, COUNT(booth_number) as times_booth_rented
FROM vendor_booth_assignments
GROUP BY vendor_id

vendor_id	times_booth_rented
1	142
3	142
4	211
7	142
8	142
9	142

Execution finished without errors.
Result: 6 rows returned in 12ms
At line 1:
SELECT vendor_id, COUNT(booth_number) as times_booth_rented
FROM vendor_booth_assignments
GROUP BY vendor_id



/* 2. The Farmer’s Market Customer Appreciation Committee wants to give a bumper 
sticker to everyone who has ever spent more than $2000 at the market. Write a query that generates a list 
of customers for them to give stickers to, sorted by last name, then first name. 

HINT: This query requires you to join two tables, use an aggregate function, and use the HAVING keyword. */
SELECT customer.customer_id, customer.customer_first_name, customer.customer_last_name, SUM(customer_purchases.cost_to_customer_per_qty) as total_amount_spent
FROM customer
JOIN customer_purchases
ON customer.customer_id = customer_purchases.customer_id
GROUP BY customer_purchases.customer_id
HAVING SUM(customer_purchases.cost_to_customer_per_qty) >  2000
ORDER BY customer.customer_last_name, customer.customer_first_name

customer_id	customer_first_name	customer_last_name	total_amount_spent
2	Mei	Chen	2181.03
3	Amir	Khan	2000.13
5	Hiro	Yamamoto	2059.6

Execution finished without errors.
Result: 3 rows returned in 13ms
At line 1:
SELECT customer.customer_id, customer.customer_first_name, customer.customer_last_name, SUM(customer_purchases.cost_to_customer_per_qty)as total_amount_spent
FROM customer
JOIN customer_purchases
ON customer.customer_id = customer_purchases.customer_id
GROUP BY customer_purchases.customer_id
HAVING SUM(customer_purchases.cost_to_customer_per_qty) >  2000
ORDER BY customer.customer_last_name, customer.customer_first_name



--Temp Table
/* 1. Insert the original vendor table into a temp.new_vendor and then add a 10th vendor: 
Thomass Superfood Store, a Fresh Focused store, owned by Thomas Rosenthal

HINT: This is two total queries -- first create the table from the original, then insert the new 10th vendor. 
When inserting the new vendor, you need to appropriately align the columns to be inserted 
(there are five columns to be inserted, I've given you the details, but not the syntax) 

-> To insert the new row use VALUES, specifying the value you want for each column:
VALUES(col1,col2,col3,col4,col5) 
*/
SELECT * 
FROM vendor --run this query to see columns setup in vendor table to create temp table)

--create a temporary table
CREATE TEMPORARY TABLE temp.new_vendor AS
SELECT * FROM vendor

--DROP TABLE temp.new_vendor

--verify everything is copied correctly to temp table
SELECT * 
FROM temp.new_vendor

--insert a new value
INSERT INTO temp.new_vendor 
VALUES (10, "Thomas Superfood Store", "Fresh Focused", "Thomas", "Rosenthal")


Execution finished without errors.
Result: query executed successfully. Took 0ms, 1 rows affected
At line 12:
INSERT INTO temp.new_vendor 
VALUES (10, "Thomas Superfood Store", "Fresh Focused", "Thomas", "Rosenthal")

1	Chris's Sustainable Eggs & Meats	Eggs & Meats	Chris	Sylvan
2	Hernández Salsa & Veggies	Fresh Variety: Veggies & More	Maria	Hernández
3	Mountain View Vegetables	Fresh Variety: Veggies & More	Joseph	Yoder
4	Fields of Corn	Fresh Focused	Samuel	Smith
5	Seashell Clay Shop	Arts & Jewelry	Karen	Soula
6	Mother's Garlic & Greens	Fresh Variety: Veggies & More	Vera	Gordon
7	Marco's Peppers	Fresh Focused	Marco	Bokashi
8	Annie's Pies	Prepared Foods	Annie	Aquinas
9	Mediterranean Bakery	Prepared Foods	Kani	Hardi
10	Thomas Superfood Store	Fresh Focused	Thomas	Rosenthal

Execution finished without errors.
Result: 10 rows returned in 13ms
At line 9:
SELECT * 
FROM temp.new_vendor
