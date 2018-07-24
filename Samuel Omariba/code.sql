SELECT *
FROM survey
LIMIT 10;

SELECT question,
   COUNT(DISTINCT user_id)
FROM survey
GROUP BY 1;

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
   h.number_of_pairs,
   p.user_id IS NOT NULL AS 'is_purchase'
FROM quiz q
LEFT JOIN home_try_on as 'h'
   ON q.user_id = h.user_id
LEFT JOIN purchase as 'p'
   ON p.user_id = q.user_id
LIMIT 10;


WITH funnels as (
SELECT DISTINCT q.user_id,
   h.user_id IS NOT NULL AS 'is_home_try_on',
   h.number_of_pairs,
   p.user_id IS NOT NULL AS 'is_purchase'
FROM quiz q
LEFT JOIN home_try_on as 'h'
   ON q.user_id = h.user_id
LEFT JOIN purchase as 'p'
   ON p.user_id = q.user_id)
SELECT COUNT (*) AS 'num_quiz',
	SUM (is_home_try_on) as 'num_home_try_on',
  SUM (is_purchase) as 'num_purchase',
  1.0 * SUM (is_home_try_on)/COUNT (user_id) as 'quiz_to_home_try_on',
  1.0 * SUM (is_purchase)/ COUNT (user_id) as 'home_try_on_to_purchase'
  from funnels;