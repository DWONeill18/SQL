
/* Distinct neighborhoods */

SELECT DISTINCT neighborhood
FROM nomnom;

/* Distinct Cuisine */

SELECT DISTINCT cuisine
FROM nomnom;

/* Chinese takeout */
SELECT *
FROM nomnom
WHERE cuisine = 'Chinese';

/* Restaaurants with reviews of 4+ */

SELECT name, review
FROM nomnom
WHERE review >= 4;

/* Fancy italien dinner date */

SELECT name, cuisine, price
FROM nomnom
WHERE cuisine = 'Italian'
AND price = '$$$';

/* Restaurant with word 'meatball' */

SELECT name
FROM nomnom
WHERE name LIKE '%meatball%';

/* Spots in Midtown. Downtown and Chinatown */

SELECT *
FROM nomnom
WHERE neighborhood = 'Midtown'
OR neighborhood = 'Downtown'
OR neighborhood = 'Chinatown';

/* Health grade pending restaurants */

SELECT name, health
FROM nomnom
WHERE health is NULL;

/* Top 10 Restaurants */

SELECT *
FROM nomnom
ORDER BY review DESC
LIMIT 10;

/* Changing ratings */

SELECT name, Review,
  CASE
    WHEN review > 4.5 THEN 'Extraordinary'
    WHEN review > 4 THEN 'Excellent'
    WHEN review > 3 THEN 'Good'
    WHEN review > 2 THEN 'Fair'
    ELSE 'Poor'
  END AS 'updated review'

FROM nomnom
ORDER BY review DESC;


