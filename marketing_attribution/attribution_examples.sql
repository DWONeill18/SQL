/* First and Last-Touch Attribution */

/* Think of your favorite website: how did you find it? Did you use a search engine? Or click on an ad? Or follow a link in a blog post?

Web developers, marketers, and data analysts use that information to improve their sources (sometimes called channels or touchpoints) online. If an ad campaign drives a lot of visits to their site, then they know that source is working! We say that those visits are attributed to the ad campaign.

But how do websites capture that information? The answer is UTM parameters. These parameters capture when and how a user finds the site. Site owners use special links containing UTM parameters in their ads, blog posts, and other sources. When a user clicks one, a row is added to a database describing their page visit. You can see a common schema for a “page visits” table below and at this link.

user_id - A unique identifier for each visitor to a page
timestamp - The time at which the visitor came to the page
page_name - The title of the section of the page that was visited
utm_source - Identifies which touchpoint sent the traffic (e.g. google, email, or facebook)
utm_medium - Identifies what type of link was used (e.g. cost-per-click or email)
utm_campaign - Identifies the specific ad or email blast (e.g. retargetting-ad or weekly-newsletter)
In this lesson, you will learn how to use SQL, UTM parameters, and touch attribution to draw insights from this data! */

/* First touch example */

/* Find June’s rows in the table! Select all columns from the page_visits table, using a WHERE clause with:

user_id equals 10069 and
utm_source equals 'buzzfeed'. */


SELECT *
FROM page_visits
WHERE user_id = 10069 AND utm_source = 'buzzfeed';

/* Last Touch Example */

/*
June’s last touch — the exposure to CoolTShirts.com that led to a purchase — is attributed to facebook
She visited the checkout page at 08:12:01 and the purchase page at 08:13:01
*/


SELECT *
FROM page_visits
WHERE user_id = 10069;

