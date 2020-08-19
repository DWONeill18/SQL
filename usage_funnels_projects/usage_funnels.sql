/* Let’s build our first basic funnel!

Count the number of distinct user_id who answered each question_text.

You can do this by using a simple GROUP BY command.

What is the number of responses for each question? */

SELECT question_text, COUNT(DISTINCT user_id)
FROM survey_responses
GROUP BY question_text;

/* AB Testing */
/*
The Product team at Mattresses and More has created a new design for the pop-ups that they believe will lead more users to complete the workflow.

They’ve set up an A/B test where:

50% of users view the original control version of the pop-ups
50% of users view the new variant version of the pop-ups
Eventually, we’ll want to answer the question:

How is the funnel different between the two groups?

We will be using a table called onboarding_modals with the following columns:

user_id - the user identifier
modal_text - the modal step
user_action - the user response (Close Modal or Continue)
ab_group - the version (control or variant)
*/

/*
Using GROUP BY, count the number of distinct user_id‘s for each value of modal_text. 
This will tell us the number of users completing each step of the funnel.

This time, sort modal_text so that your funnel is in order.
*/

SELECT modal_text, COUNT(DISTINCT user_id)
FROM onboarding_modals
GROUP BY modal_text
ORDER BY modal_text;

/* The previous query combined both the control and variant groups.

We can use a CASE statement within our COUNT() aggregate so that we only count user_ids whose ab_group is equal to ‘control’: */

SELECT modal_text,
  COUNT(DISTINCT CASE
    WHEN ab_group = 'control' THEN user_id
    END) AS 'control_clicks'
FROM onboarding_modals
GROUP BY 1
ORDER BY 1;

/* Add an additional column to this query so that the number of clicks for the variant group can be shown. */

SELECT modal_text,
  COUNT(DISTINCT CASE
    WHEN ab_group = 'control' THEN user_id
    END) AS 'control_clicks',
  COUNT(DISTINCT CASE
    WHEN ab_group = 'variant' THEN user_id
    END) AS 'variant_clicks'
FROM onboarding_modals
GROUP BY 1
ORDER BY 1;



