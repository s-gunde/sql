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