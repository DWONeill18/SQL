/* How many entries in the countries table are from Africa? A = 56 */ 

SELECT COUNT(*)
FROM countries
WHERE continent = 'Africa';

/* What was the total population of the continent of Oceania in 2005? A = 32.66 */

SELECT ROUND(SUM(population), 2)
FROM countries
JOIN population_years
  ON countries.id = population_years.country_id
WHERE year = 2005 AND continent = 'Oceania';

/* What is the average population of countries in South America in 2003? A = 25.89 */

SELECT ROUND(AVG(population), 2)
FROM countries
JOIN population_years
  ON countries.id = population_years.country_id
WHERE year = 2003 AND continent = 'South America';

/* What country had the smallest population in 2007? 
A = Niue */

SELECT name, population
FROM countries
JOIN population_years
  ON countries.id = population_years.country_id
WHERE year = 2007 AND population IS NOT NULL
ORDER BY population
LIMIT 1;

/* What is the average population of Poland during the time period covered by this dataset? A = 38.56 */

SELECT ROUND(AVG(population), 2)
FROM countries
JOIN population_years
  ON countries.id = population_years.country_id
WHERE name = 'Poland';


/* How many countries have the word “The” in their name? A = 4 */

SELECT COUNT(*)
FROM countries
WHERE name LIKE '%The%';

/* What was the total population of each continent in 2010? */

SELECT continent, ROUND(SUM(population), 2) AS 'Total Population'
FROM countries
JOIN population_years
  ON countries.id = population_years.country_id
WHERE year = 2010
GROUP BY 1
ORDER BY 2 DESC;





