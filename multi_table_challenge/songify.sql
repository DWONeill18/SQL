/* Let’s see which plans are used by which premium members!

The column membership_plan_id in premium_users should match the column id in plans.

Join plans and premium_users and select:

user_id from premium_users
description from plans */

SELECT user_id, description
FROM premium_users
JOIN plans
  ON premium_users.membership_plan_id = plans.id;

/*  Let’s see the titles of songs that were played by each user!

The column song_id in plays should match the column id in songs.

Join plays to songs and select:

user_id from plays
play_date from plays
title from songs */

SELECT user_id, play_date, title
FROM plays
JOIN songs
  ON plays.song_id = songs.id;

/*
Which users aren’t premium users?

Use a LEFT JOIN to combine users and premium_users and select id from users.

The column id in users should match the column user_id in premium_users.

Use a WHERE clause to limit the results to users where premium_users.user_id IS NULL.
This will remove premium users and leave you with only free users. */

SELECT id
FROM users
LEFT JOIN premium_users
    ON users.id = premium_users.user_id
WHERE premium_users.user_id IS NULL;

/* We’ve used a WITH statement to create two temporary tables:

january contains all song plays from January 2017
february contains all song plays from February 2017 */

/* Use a left join to combine january and february on user_id and select user_id from january.

Add the a WHERE statement to find which users played songs in January, but not February: */

WITH january AS (
  SELECT *
  FROM plays
  WHERE strftime("%m", play_date) = '01'
),
february AS (
  SELECT *
  FROM plays
  WHERE strftime("%m", play_date) = '02'

)
SELECT january.user_id
FROM january
LEFT JOIN february
    ON january.user_id = february.user_id
WHERE february.user_id IS NULL;