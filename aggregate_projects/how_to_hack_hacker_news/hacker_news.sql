/* Pre-Gaming for Aggregates */

/* What are the top 5 stories with the highest score? */

SELECT title, score
FROM hacker_news
ORDER BY score DESC
LIMIT 5;

/* Hacker News Moderating */

/* Recent studies have found that online forums tend to be dominated by a small percentage of their users (1-9-90 Rule). */

/* First, find the total score of all the stories. */

SELECT SUM(score)
FROM hacker_news;

/* Next, we need to pinpoint the users who have accumulated a lot of points across their stories.

Find the individual users who have gotten combined scores of more than 200, and their combined scores. */

SELECT user, SUM(score) AS total
FROM hacker_news
GROUP BY user
HAVING total > 200
ORDER BY 2 DESC;

/* Then, we want to add these users’ scores together and divide by the total to get the percentage. (517, 309, 304, 282)

So, is Hacker News dominated by these users? */

SELECT (517 + 309 + 304 + 282) / 6366.0;

/* Oh no! While we are looking at the power users, some users are rickrolling — tricking readers into clicking on a link to a funny video and claiming that it links to information about coding.

The url of the video is:

https://www.youtube.com/watch?v=dQw4w9WgXcQ

How many times has each offending user posted this link? */

SELECT user, COUNT(*)
FROM hacker_news
WHERE url = 'https://www.youtube.com/watch?v=dQw4w9WgXcQ'
GROUP BY 1
ORDER BY 2 DESC;

/* Which sites feed hacker News? */

/* 
Hacker News stories are essentially links that take users to other websites.

Which of these sites feed Hacker News the most:

_GitHub, Medium, or New York Times?_

First, we want to categorize each story based on their source. */

/*
SELECT CASE
  WHEN url LIKE '%github.com%' THEN 'GitHub'
  WHEN url LIKE '%medium.com%' THEN 'Medium'
  WHEN url LIKE '%nytimes.com%' THEN 'New York Times'
  ELSE 'Other'
  END AS 'Source'
FROM hacker_news;
*/

/* Next, build on the previous query:

Add a column for the number of stories from each URL using COUNT(). */

SELECT CASE
  WHEN url LIKE '%github.com%' THEN 'GitHub'
  WHEN url LIKE '%medium.com%' THEN 'Medium'
  WHEN url LIKE '%nytimes.com%' THEN 'New York Times'
  ELSE 'Other'
  END AS 'Source', COUNT(*)
FROM hacker_news
GROUP BY 1
ORDER BY 2 DESC;

/* What's the best time to post a story? */

/* Every submitter wants their story to get a high score so that the story makes it to the front page, but…

What’s the best time of the day to post a story on Hacker News? */

SELECT timestamp
FROM hacker_news
LIMIT 10;

/* Format is YYYY-MM-DD HH:MM:SS if you ignore the T and Z */

/* SQLite comes with a strftime() function - a very powerful function that allows you to return a formatted date. */

SELECT timestamp,
  strftime('%H', timestamp)
FROM hacker_news  
GROUP BY 1
LIMIT 20;

/* Okay, now we understand how strftime() works. Let’s write a query that returns three columns:

The hours of the timestamp
The average score for each hour
The count of stories for each hour */

SELECT strftime('%H', timestamp), AVG(score), COUNT(*)
FROM hacker_news
GROUP BY 1
ORDER BY 1;

/* Let’s edit a few things in the previous query:

Round the average scores (ROUND()).
Rename the columns to make it more readable (AS).
Add a WHERE clause to filter out the NULL values in timestamp.

Take a look at the result again:

What are the best hours to post a story on Hacker News? */

SELECT strftime('%H', timestamp) AS 'Hour',
  ROUND(AVG(score), 1) AS 'Average Score',
  COUNT(*) AS 'No. of Stories'
FROM hacker_news
WHERE timestamp is NOT NULL
GROUP BY 1
ORDER BY 1;




