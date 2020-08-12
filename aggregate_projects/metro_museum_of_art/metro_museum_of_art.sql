 SELECT *
 FROM met
 LIMIT 10;

 /* How many pieces are in the American Decorative Art collection? */

 SELECT COUNT(*)
 FROM met;

 /* Celery was considered a luxurious snack in the Victorian era (around the 1800s). Wealthy families served stalks of it in intricate glass vases.

Don’t believe it?

Count the number of pieces where the category includes ‘celery’. */

SELECT COUNT(*)
FROM met
WHERE category LIKE '%celery%';

/* Find the title and medium of the oldest piece(s) in the collection. */

SELECT title, medium, date
FROM met
ORDER BY 3
LIMIT 10;

/* Find the top 10 countries with the most pieces in the collection. */

SELECT COUNT(*), country
FROM met
GROUP BY 2
ORDER BY 1 DESC
LIMIT 10;

/* Find the categories HAVING more than 100 pieces. */

SELECT COUNT(*), category
FROM met
GROUP BY 2
HAVING COUNT(*) > 100;

/* Lastly, let’s look at some bling!

Count the number of pieces where the medium contains ‘gold’ or ‘silver’.

And sort in descending order. */

SELECT medium, COUNT(*)
FROM met
WHERE medium LIKE '%gold%' OR medium LIKE '%silver%'
GROUP BY 1
ORDER BY 2 DESC;




