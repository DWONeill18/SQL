/* */

 SELECT *
 FROM survey
 LIMIT 10;

 SELECT question, COUNT(DISTINCT user_id)
 FROM survey
 GROUP BY question;
 
 SELECT question, COUNT(DISTINCT user_id), (COUNT(user_id)*100)/500 AS 'Percentage'
 FROM survey
 GROUP BY question;

 SELECT *
 FROM quiz
 LIMIT 5;

 SELECT *
 FROM home_try_on
 LIMIT 5;

 SELECT *
 FROM purchase
 LIMIT 5;

SELECT DISTINCT q.user_id,
  h.user_id IS NOT NULL AS 'is_home_try_on',
  h.number_of_pairs AS 'number of pairs',
  p.user_id IS NOT NULL AS 'is_purchase'
FROM quiz AS 'q'
LEFT JOIN home_try_on AS 'h'
  ON q.user_id = h.user_id
LEFT JOIN purchase AS 'p'
  ON p.user_id = q.user_id
LIMIT 10;