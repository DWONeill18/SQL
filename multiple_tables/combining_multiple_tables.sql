/* Combining multiple tables */

SELECT *
FROM orders
JOIN customers
  ON orders.customer_id = customers.customer_id
WHERE description = 'Fashion Magazine';

/* Inner Joins */

/* When we perform a simple JOIN (often called an inner join) our result only includes rows that match our ON condition. */

SELECT COUNT(*)
FROM newspaper;

SELECT COUNT(*)
FROM online;

SELECT COUNT(*)
FROM newspaper
JOIN online
  ON newspaper.id = online.id;

/* Left Joins */

/* A left join will keep all rows from the first table, regardless of whether there is a matching row in the second table. */

SELECT *
FROM newspaper
LEFT JOIN online
  ON newspaper.id = online.id
WHERE online.id IS NULL;

/* Primary Key v Foreign Key */

/* Primary keys have a few requirements:

- None of the values can be NULL.
- Each value must be unique (i.e., you can’t have two customers with the same customer_id in the customers table).
- A table can not have more than one primary key column. */

/* When the primary key for one table appears in a different table, it is called a foreign key. */

SELECT *
FROM students
JOIN classes
  ON students.class_id = classes.id;

/* Cross Join */

/* Combine all rows in one table with all rows of another */

/* Suppose we wanted to know how many users were subscribed during each month of the year. 
For each month (1, 2, 3) we would need to know if a user was subscribed. Follow the steps 
below to see how we can use a CROSS JOIN to solve this problem. */

SELECT month,
  COUNT(*)
FROM newspaper
CROSS JOIN months
WHERE start_month <= month AND end_month >= month
GROUP BY month;

/* Union */

/* Sometiems we want to stack one dataset on top of the other. Well the UNION operator allows us to do that. */

SELECT *
FROM newspaper
UNION
SELECT *
FROM online;

/* WITH */

/* The WITH statement allows us to perform a separate query (such as aggregating customer's subscriptions).
previous_results is the alias that we will use to reference any columns from the query inside of the WITH clause.
We can then go on to do what we want with this temporary table (such as joining another table). */
WITH previous_query AS (
  SELECT customer_id,
    COUNT(subscription_id) AS 'subscriptions'
  FROM orders
  GROUP BY customer_id
)
SELECT customers.customer_name,
  previous_query.subscriptions
FROM previous_query
JOIN customers
  ON customers.customer_id = previous_query.customer_id;