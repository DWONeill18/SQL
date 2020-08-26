/* What is Churn?
A common revenue model for SaaS (Software as a service) companies is to charge a monthly subscription fee for access to their product.
Frequently, these companies aim to continually increase the number of users paying for their product.
One metric that is helpful for this goal is churn rate. Churn rate is the percent of subscribers that have canceled within a certain period, usually a month.
For a user base to grow, the churn rate must be less than the new subscriber rate for the same period.
To calculate the churn rate, we only will be considering users who are subscribed at the beginning of the month.
The churn rate is the number of these users who cancel during the month divided by the total number:

Churn
For example, suppose you were analyzing data for a monthly video streaming service called CodeFlix.
At the beginning of February, CodeFlix has 1,000 customers. In February, 250 of these customers cancel. The churn rate for February would be:

250 / 1000 = 25% churn rate */



/* In March, CodeFlix started with 2,000 customers. During the month, 100 of these customers canceled.

What is the March churn rate as a ratio?

Use a SELECT statement to calculate the answer. Be sure to use a decimal in your calculations to force a float answer. */

SELECT (100. / 2000);

/* A = 0.05 */

/* In April, CodeFlix started with 3,000 customers. During the month, 450 of these customers canceled.

The service added 500 new customers during the same period.

What is the April churn rate as a ratio?

On a new line, use a SELECT statement to calculate the answer. Be sure to use a decimal in your calculations to force a float answer. */

SELECT 450. / 3000;

/* A = 0.15 */

/* We’ve imported 4 months of data for a company from when they began selling subscriptions. This company has a minimum commitment of 1 month, so there are no cancellations in the first month.

The subscriptions table contains:

id
subscription_start
subscription_end
Use the methodology provided in the narrative to calculate the churn for January 2017. */


SELECT 1.0 * 
(
  SELECT COUNT(*)
  FROM subscriptions
  WHERE subscription_start < '2017-01-01'
  AND (
    subscription_end
    BETWEEN '2017-01-01'
    AND '2017-01-31'
  )
) / (
  SELECT COUNT(*) 
  FROM subscriptions 
  WHERE subscription_start < '2017-01-01'
  AND (
    (subscription_end >= '2017-01-01')
    OR (subscription_end IS NULL)
  )
) 
AS result;

/* Companies typically look at churn data over a period of many months. 
We need to modify the calculation a bit to make it easier to mold into a multi-month result. This is done by making use of WITH and CASE. */

/* To start, use WITH to create the group of customers that are active going into December */

WITH enrollments AS
(SELECT *
FROM subscriptions
WHERE subscription_start < '2017-01-01'
AND (
  (subscription_end >= '2017-01-01')
  OR (subscription_end IS NULL)
)),

/* Let’s create another temporary table that contains an is_canceled status for each of these customers. 
This will be 1 if they cancel in December and 0 otherwise (their cancellation date is after December or NULL). */

status AS
(SELECT
CASE
  WHEN (subscription_end > '2017-01-31')
    OR (subscription_end IS NULL) THEN 0
    ELSE 1
  END as is_canceled,

/* We could just COUNT() the rows to determine the number of users. 
However, to support the multiple month calculation, lets add a is_active column to the status temporary table.
 This uses the same condition we created enrollments with. This tells us if someone is active at the beginning of the month.*/

CASE
  WHEN subscription_start < '2017-01-01'
    AND (
      (subscription_end >= '2017-01-01')
      OR (subscription_end IS NULL)
    ) THEN 1
  ELSE 0
END as is_active
FROM enrollments
)

/* The last step is to do the math on the status table to calculate the month’s churn */

SELECT 1.0 * SUM(is_canceled) / SUM(is_active)
FROM status;

/* ///////////////////////////////////////////// */
/* Multiple Month: Create Months Temporary Table */
/* ///////////////////////////////////////////// */

/* Our single month calculation is now in a form that we can extend to a multiple month result. But first, we need months! */

/* We will be using the months as a temporary table (using WITH) in the churn calculation.

Create the months temporary table using WITH and SELECT everything from it so that you can see the structure.

We need a table for January, February, and March of 2017. */

WITH months AS
(SELECT
  '2017-01-01' AS first_day,
  '2017-01-31' AS last_day
UNION
SELECT
  '2017-02-01' AS first_day,
  '2017-02-28' AS last_day
UNION
SELECT
  '2017-03-01' AS first_day,
  '2017-03-31' AS last_day
)
SELECT *
FROM months;

/* /////////////////////////////////////////// */
/* Multiple Month: Cross Join Months and Users */
/* /////////////////////////////////////////// */

/* Now that we have a table of months, we will join it to the subscriptions table. 
This will result in a table containing every combination of month and subscription.

Ultimately, this table will be used to determine the status of each subscription in each month. */

cross_join AS
(SELECT *
FROM subscriptions
CROSS JOIN months)
SELECT *
FROM cross_join
LIMIT 100;



---------------------------
WITH months AS
(SELECT
  '2017-01-01' as first_day,
  '2017-01-31' as last_day
UNION
SELECT
  '2017-02-01' as first_day,
  '2017-02-28' as last_day
UNION
SELECT
  '2017-03-01' as first_day,
  '2017-03-31' as last_day
),
cross_join AS
(SELECT *
FROM subscriptions
CROSS JOIN months),
status AS
(SELECT id, first_day as month,
CASE
  WHEN (subscription_start < first_day)
    AND (
      subscription_end > first_day
      OR subscription_end IS NULL
    ) THEN 1
  ELSE 0
END as is_active
FROM cross_join)
SELECT *
FROM status
LIMIT 100;


----------------------------------
ITH months AS
(SELECT
  '2017-01-01' as first_day,
  '2017-01-31' as last_day
UNION
SELECT
  '2017-02-01' as first_day,
  '2017-02-28' as last_day
UNION
SELECT
  '2017-03-01' as first_day,
  '2017-03-31' as last_day
),
cross_join AS
(SELECT *
FROM subscriptions
CROSS JOIN months),
status AS
(SELECT id, first_day as month,
CASE
  WHEN (subscription_start < first_day)
    AND (
      subscription_end > first_day
      OR subscription_end IS NULL
    ) THEN 1
  ELSE 0
END as is_active,
CASE 
  WHEN subscription_end BETWEEN first_day AND last_day THEN 1
  ELSE 0
END as is_canceled
FROM cross_join)
SELECT *
FROM status

----------------------------------------

WITH months AS
(SELECT
  '2017-01-01' as first_day,
  '2017-01-31' as last_day
UNION
SELECT
  '2017-02-01' as first_day,
  '2017-02-28' as last_day
UNION
SELECT
  '2017-03-01' as first_day,
  '2017-03-31' as last_day
),
cross_join AS
(SELECT *
FROM subscriptions
CROSS JOIN months),
status AS
(SELECT id, first_day as month,
CASE
  WHEN (subscription_start < first_day)
    AND (
      subscription_end > first_day
      OR subscription_end IS NULL
    ) THEN 1
  ELSE 0
END as is_active,
CASE 
  WHEN subscription_end BETWEEN first_day AND last_day THEN 1
  ELSE 0
END as is_canceled
FROM cross_join),
status_aggregate AS
(SELECT
  month,
  SUM(is_active) as active,
  SUM(is_canceled) as canceled
FROM status
GROUP BY month)
SELECT *
FROM status_aggregate;

---------------------------

WITH months AS
(SELECT
  '2017-01-01' as first_day,
  '2017-01-31' as last_day
UNION
SELECT
  '2017-02-01' as first_day,
  '2017-02-28' as last_day
UNION
SELECT
  '2017-03-01' as first_day,
  '2017-03-31' as last_day
),
cross_join AS
(SELECT *
FROM subscriptions
CROSS JOIN months),
status AS
(SELECT id, first_day as month,
CASE
  WHEN (subscription_start < first_day)
    AND (
      subscription_end > first_day
      OR subscription_end IS NULL
    ) THEN 1
  ELSE 0
END as is_active,
CASE 
  WHEN subscription_end BETWEEN first_day AND last_day THEN 1
  ELSE 0
END as is_canceled
FROM cross_join),
status_aggregate AS
(SELECT
  month,
  SUM(is_active) as active,
  SUM(is_canceled) as canceled
FROM status
GROUP BY month)
SELECT
  month,
  1.0 * canceled/active AS churn_rate
FROM status_aggregate;


