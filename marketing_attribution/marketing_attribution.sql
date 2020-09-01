/*
First-touch query
*/

WITH first_touch AS (
    SELECT user_id,
        MIN(timestamp) as first_touch_at
    FROM page_visits
    GROUP BY user_id)
SELECT ft.user_id,
    ft.first_touch_at,
    pv.utm_source,
		pv.utm_campaign
FROM first_touch ft
JOIN page_visits pv
    ON ft.user_id = pv.user_id
    AND ft.first_touch_at = pv.timestamp;

/* Getting familiar with CoolTShirts */

SELECT COUNT(DISTINCT utm_campaign)
FROM page_visits;

SELECT COUNT(DISTINCT utm_source)
FROM page_visits;

SELECT DISTINCT utm_campaign, utm_source
FROM page_visits
ORDER BY utm_source;

SELECT DISTINCT page_name
FROM page_visits
ORDER BY page_name;

/* What is the user journey? */

/* How many first touches is each campaign responsible for? */

WITH first_touch AS (
    SELECT user_id,
        MIN(timestamp) as first_touch_at
    FROM page_visits
    GROUP BY user_id),
ft_attr AS (
  SELECT ft.user_id,
      ft.first_touch_at,
      pv.utm_source,
		  pv.utm_campaign
  FROM first_touch ft
  JOIN page_visits pv
     ON ft.user_id = pv.user_id
     AND ft.first_touch_at = pv.timestamp
)
SELECT ft_attr.utm_source,
       ft_attr.utm_campaign,
       COUNT(*)
FROM ft_attr
GROUP BY 2
ORDER BY 3 DESC;

/* How many last touches is each campaign ressponsbile for? */

WITH last_touch AS (
    SELECT user_id,
        MAX(timestamp) as last_touch_at
    FROM page_visits
    GROUP BY user_id),
lt_attr AS (
  SELECT lt.user_id,
      lt.last_touch_at,
      pv.utm_source,
		  pv.utm_campaign
  FROM last_touch lt
  JOIN page_visits pv
     ON lt.user_id = pv.user_id
     AND lt.last_touch_at = pv.timestamp
)
SELECT lt_attr.utm_source, 
       lt_attr.utm_campaign,
       COUNT(*)
FROM lt_attr
GROUP BY 2
ORDER BY 3 DESC;

/* How many visitors make a purchase? */

SELECT COUNT(DISTINCT user_id)
FROM page_visits
WHERE page_name = '4 - purchase';

/* How many last touches on the purchase page is each campaign responsible for? */

WITH last_touch AS (
    SELECT user_id,
        MAX(timestamp) as last_touch_at
    FROM page_visits
    WHERE page_name = '4 - purchase' ----- WHERE clause on the last touch temp table
    GROUP BY user_id),
lt_attr AS (
  SELECT lt.user_id,
      lt.last_touch_at,
      pv.utm_source,
		  pv.utm_campaign
  FROM last_touch lt
  JOIN page_visits pv
     ON lt.user_id = pv.user_id
     AND lt.last_touch_at = pv.timestamp
)
SELECT lt_attr.utm_source, 
       lt_attr.utm_campaign,
       COUNT(*)
FROM lt_attr
GROUP BY 2
ORDER BY 3 DESC;

/* CoolTShirts can re-invest in 5 campaigns. Given your findings in the project, which should they pick and why? */

/* By ordering and limiting to 5 rows the last query we can see which 5 campaigns produced the most last-touch purchase page hits.
This is ideal cause the user is more likely to purchase something if they hit his page, so campaigns that get them there are the
most profitable. */
