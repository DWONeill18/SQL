/* Building Funnels */

/* First, we want to combine the information from the three tables (browse, checkout, purchase)
into one table with the following schema: */

/* Each row will represent a single user:

If the user has any entries in checkout, then is_checkout will be True.
If the user has any entries in purchase, then is_purchase will be True.
If we use an INNER JOIN to create this table, we’ll lose information from any customer who does not have a row in the checkout or purchase table.

Therefore, we’ll need to use a series of LEFT JOIN commands. */

SELECT DISTINCT b.browse_date,
b.user_id, c.user_id IS NOT NULL AS 'is_checkout',
p.user_id IS NOT NULL AS 'is_purchase'
FROM browse AS 'b'
LEFT JOIN checkout AS 'c'
  ON b.user_id = c.user_id
LEFT JOIN purchase AS 'p'
  ON c.user_id = p.user_id
LIMIT 50;

/* Let’s query from this funnels table and calculate overall conversion rates. */

WITH funnels AS (
  SELECT DISTINCT b.browse_date,
     b.user_id,
     c.user_id IS NOT NULL AS 'is_checkout',
     p.user_id IS NOT NULL AS 'is_purchase'
  FROM browse AS 'b'
  LEFT JOIN checkout AS 'c'
    ON c.user_id = b.user_id
  LEFT JOIN purchase AS 'p'
    ON p.user_id = c.user_id)
SELECT COUNT(user_id), SUM(is_checkout),
  SUM(is_purchase) AS 'num_purchase',
  1.0 * SUM(is_checkout) / COUNT(user_id) AS '% Users b-c',
  1.0 * SUM(is_purchase) / SUM(is_checkout) AS '% Users c-p'
FROM funnels;

/* The management team suspects that conversion from checkout to purchase changes as the browse_date gets closer to Christmas Day.

We can make a few edits to this code to calculate the funnel for each browse_date using GROUP BY. */


WITH funnels AS (
  SELECT DISTINCT b.browse_date,
     b.user_id,
     c.user_id IS NOT NULL AS 'is_checkout',
     p.user_id IS NOT NULL AS 'is_purchase'
  FROM browse AS 'b'
  LEFT JOIN checkout AS 'c'
    ON c.user_id = b.user_id
  LEFT JOIN purchase AS 'p'
    ON p.user_id = c.user_id)
SELECT browse_date, 
   COUNT(*) AS 'num_browse',
   SUM(is_checkout) AS 'num_checkout',
   SUM(is_purchase) AS 'num_purchase',
   1.0 * SUM(is_checkout) / COUNT(user_id) AS 'browse_to_checkout',
   1.0 * SUM(is_purchase) / SUM(is_checkout) AS 'checkout_to_purchase'
FROM funnels
GROUP BY browse_date
ORDER BY browse_date;

/* In this lesson, we learned how to build a funnel from a single table, compare funnels for A/B tests, and create a funnel from multiple tables using LEFT JOIN. */