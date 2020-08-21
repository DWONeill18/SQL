/* What is Churn?
A common revenue model for SaaS (Software as a service) companies is to charge a monthly subscription fee for access to their product. Frequently, these companies aim to continually increase the number of users paying for their product. One metric that is helpful for this goal is churn rate.

Churn rate is the percent of subscribers that have canceled within a certain period, usually a month. For a user base to grow, the churn rate must be less than the new subscriber rate for the same period.

To calculate the churn rate, we only will be considering users who are subscribed at the beginning of the month. The churn rate is the number of these users who cancel during the month divided by the total number:

Churn
For example, suppose you were analyzing data for a monthly video streaming service called CodeFlix. At the beginning of February, CodeFlix has 1,000 customers. In February, 250 of these customers cancel. The churn rate for February would be:

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