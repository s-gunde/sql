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