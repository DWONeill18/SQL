/* What are the years covered by the dataset? */

SELECT DISTINCT year
FROM population_years;

-- Add your additional queries below:

/* Largest population size for Gabon in this dataset*/

SELECT country, population, year
FROM population_years
WHERE country = 'Gabon'
ORDER BY population DESC
LIMIT 1;

/* What were the 10 lowest population countries in 2005? */

SELECT country
FROM population_years
WHERE year = 2005
ORDER BY population ASC
LIMIT 10;

/* What are all the distinct countries with a population of over 100M in 2010? */

SELECT DISTINCT country, population
FROM population_years
WHERE population > 100 AND year = 2010;

/* How many countries have the word "Islands" in their name? */

SELECT DISTINCT country
FROM population_years
WHERE country LIKE '%Islands%';

/*  Difference in population in Indonesia between 2000 and 2010 */

SELECT country, year, population
FROM population_years
WHERE country = 'Indonesia' AND (year = 2000 OR year = 2010); 


