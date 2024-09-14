--SELECT
/* 1. Write a query that returns everything in the customer table. */
SELECT *
FROM customer

1	Alejandro	Costa	M8Y
2	Mei	Chen	M1L
3	Amir	Khan	M4H
4	Leyla	Abadi	M1L
5	Hiro	Yamamoto	M1L
6	Sofia	Rodríguez	M4H
7	Anwar	Ali	M6C
8	Khaled	Naser	M6C
9	Zuri	Okoro	M1L
10	Taylor	Park	M8Y
11	Sofia	Petrov	M4H
12	Jalen	Carter	M1L
13	Abigail	Harris	M3H
14	Jack	Wise	M8Y
15	Carlos	Diaz	M6C
16	Iva	Kienzler	M1L
17	Jeri	Mitchell	M8Y
18	Anjali	Kumar	M1L
19	Salil	Hassan	M6C
20	Johannes	Paulson	M4H
21	Yoojung	Kim	M4H
22	Julio	da Silva	M1L
23	Jessica	Connor	M4H
24	Dylan	O''Connor	M4H ---added extra quote as a escape sequence
25	Lea	Fischer	M1L
26	Richard	Côté	M6C

Execution finished without errors.
Result: 26 rows returned in 20ms
At line 1:
SELECT *
FROM customer



/* 2. Write a query that displays all of the columns and 10 rows from the customer table, 
sorted by customer_last_name, then customer_first_ name. */
SELECT *
FROM customer
ORDER BY customer_last_name, customer_first_name
LIMIT 10

customer_id	customer_first_name	customer_last_name	customer_postal_code
4	Leyla	Abadi	M1L
7	Anwar	Ali	M6C
12	Jalen	Carter	M1L
2	Mei	Chen	M1L
23	Jessica	Connor	M4H
1	Alejandro	Costa	M8Y
26	Richard	Côté	M6C
15	Carlos	Diaz	M6C
25	Lea	Fischer	M1L
13	Abigail	Harris	M3H

Execution finished without errors.
Result: 10 rows returned in 12ms
At line 1:
SELECT *
FROM customer
ORDER BY customer_last_name, customer_first_name
LIMIT 10

