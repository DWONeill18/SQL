 SELECT * 
 FROM orders
 LIMIt 10;

 /* How recent is this data?

Use DISTINCT to find out all the unique order_date values in this table.  */

SELECT DISTINCT order_date
FROM orders;

/* The special_instructions column stores the data where Davie’s Burgers customers leave a note for the kitchen or the delivery.

Instead of selecting all the columns using *, write a query that selects only the special_instructions column.

Limit the result to 20 rows. */

SELECT special_instructions
FROM orders
LIMIT 20;

/* 
There seem to be a lot of empty values in that column. That is because customers sometimes leave the notes section blank.

Can you edit the query so that we are only returning the special instructions that are not empty? */

SELECT special_instructions
FROM orders
WHERE special_instructions IS NOT NULL;

/* 
Let’s go even further and sort the instructions in alphabetical order (A-Z). */

SELECT special_instructions
FROM orders
WHERE special_instructions IS NOT NULL
ORDER BY special_instructions;

/* Let’s search for special instructions that have the word ‘sauce’. */

SELECT special_instructions
FROM orders
WHERE special_instructions LIKE '%sauce%';

/* Let’s search for special instructions that have the word ‘door’. */

SELECT special_instructions
FROM orders
WHERE special_instructions LIKE '%door%';

/* Let’s search for special instructions that have the word ‘box’. */

SELECT special_instructions
FROM orders
WHERE special_instructions LIKE '%box%';


/* Wow, some of these are marketing gold! But what are their order numbers?

Instead of just returning the special instructions, also return their order ids.

For more readability:

Rename id as ‘#’
Rename special_instructions as ‘Notes’ */

SELECT special_instructions AS 'Notes', id AS '#'
FROM orders
WHERE special_instructions LIKE '%box%';

