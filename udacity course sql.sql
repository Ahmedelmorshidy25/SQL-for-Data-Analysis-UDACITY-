/*select a.name , AVG(o.standard_qty) avg_stand, AVG(o.gloss_qty) avg_gloss, AVG(o.poster_qty) avg_post
from accounts a
join orders o
on o.account_id = a.id
group by a.name*/
/* 2 select a.name ,  AVG(o.standard_amt_usd) avg_stand, AVG(o.gloss_amt_usd) avg_gloss, AVG(o.poster_amt_usd) avg_post
from accounts a
join orders o
on a.id = o.account_id
group by a.name;*/
/* 3 select s.name , w.channel , count(w.occurred_at) countt
from web_events w
join accounts a
on w.account_id = a.id
join sales_reps s
on s.id = a.sales_rep_id
group by s.name , w.channel
order by count(w.occurred_at) desc;*/
/* 4 select r.name , w.channel , count(*) countt
from web_events w
join accounts a
on w.account_id = a.id
join sales_reps s
on s.id = a.sales_rep_id
join region r
on r.id = s.region_id
group by r.name , w.channel
order by count(w.occurred_at) desc;*/
/*select distinct a.id as "account id", r.id as "region id", 
a.name as "account name", r.name as "region name"
from accounts a
join sales_reps s
on s.id = a.sales_rep_id
join region r 
on r.id = s.region_id
order by a.id 
-------or------------ 
SELECT DISTINCT id, name
FROM accounts;*/
/*select s.id , a.name , COUNT(*) num_accounts
from sales_reps s
join accounts a
on a.sales_rep_id = s.id
GROUP BY s.id, a.name
order by s.id desc
--------------------or ------------ 
SELECT DISTINCT id, name
FROM sales_reps;*/
/* having 1 
select distinct s.id , s.name , count(a.id) num_accounts

from sales_reps s
join accounts a
on a.sales_rep_id = s.id
GROUP BY s.id, s.name
having count(a.id) > 5
ORDER BY num_accounts;
-----------------
2 - 3 :
select distinct a.id , a.name , count(o.id) num_orders
from orders o
join accounts a
on a.id = o.account_id
GROUP BY a.id, a.name
having count(o.id) > 20
ORDER BY num_orders desc
limit 1;*/
/* 4 - 5 - 6 - 7
select distinct a.id , a.name , sum(o.total_amt_usd) sum_orders
from orders o
join accounts a
on a.id = o.account_id
GROUP BY a.id, a.name
having sum(o.total_amt_usd) > 30000
ORDER BY sum_orders desc ;
-------------------------
select distinct a.id , a.name , sum(o.total_amt_usd) sum_orders
from orders o
join accounts a
on a.id = o.account_id
GROUP BY a.id, a.name
having sum(o.total_amt_usd) < 1000
ORDER BY sum_orders desc ;
--------------------------
select distinct a.id , a.name , sum(o.total_amt_usd) sum_orders
from orders o
join accounts a
on a.id = o.account_id
GROUP BY a.id, a.name
ORDER BY sum_orders desc 
limit 1 ;*/
/* 8 - 9
 select a.name , w.channel , count(*)
from web_events w
join accounts a
on w.account_id = a.id
where w.channel = 'facebook'
group by a.name , w.channel
having count(*) > 6
order by count(*) desc
limit 1; */
/* 10 
select a.id, a.name , w.channel , count(*)
from web_events w
join accounts a
on w.account_id = a.id
group by a.id, a.name , w.channel
order by count(*) desc;*/ 
/* DATE Functions 1 - 2 
SELECT YEAR(occurred_at) AS years , sum(total_amt_usd) total_for_orders 
FROM orders o
group by 1
order by 2 desc
limit 1;
-----------------
SELECT month(occurred_at) AS months , sum(total_amt_usd) total_for_orders 
FROM orders o
group by 1
order by 2 desc
limit 1;*/
/* 3
SELECT YEAR(occurred_at) AS years , count(o.id) total_for_orders 
FROM orders o
group by 1
order by 2 desc
limit 1;*/
/* 4 
SELECT month(occurred_at) AS months , count(o.id) total_for_orders 
FROM orders o
group by 1
order by 2 desc
limit 1;*/
/* 5 
SELECT   YEAR(occurred_at) AS years , month(occurred_at) months ,a.name , sum(gloss_amt_usd) total_for_orders 
FROM orders o
join accounts as a
on a.id = o.account_id
where a.name = 'Walmart'
group by 1 , 2
order by 4 desc*/
/* Quiz: CASE 1
 display for each order, the account ID,
 total amount of the order,
 and the level of the order - ‘Large’ or ’Small’ - depending on if the order is $3000 or more,
 or smaller than $3000.
 select o.id , o.account_id, sum(o.total_amt_usd) , case when sum(o.total_amt_usd) >= 3000 then 'large'
 else 'small' end as level_of_order
 from orders o
 join accounts a
 on a.id = o.account_id
 group by 1 , 2*/
/* 2 
 display the number of orders in each of three categories, based on the total number of items in each order.
 The three categories are: 'At Least 2000', 'Between 1000 and 2000' and 'Less than 1000'.
 select o.id , case when sum(o.total) >= 2000 then 'At Least 2000'
 when sum(o.total) between 1000 and 2000 then 'Between 1000 and 2000'
 else 'Less than 1000' end as categories,
 from orders o
 join accounts a
 on a.id = o.account_id
 group by 1 */
/* 3 
We would like to understand 3 different levels of customers based on the amount associated with their purchases.
The top level includes anyone with a Lifetime Value (total sales of all orders) greater than 200,000 usd.
The second level is between 200,000 and 100,000 usd.
The lowest level is anyone under 100,000 usd.
Provide a table that includes the level associated with each account.
You should provide the account name, the total sales of all orders for the customer,and the level.
Order with the top spending customers listed first.
select a.name , sum(o.total_amt_usd) as total_sales, case when sum(o.total_amt_usd) > 200000 then 'top level'
when sum(o.total_amt_usd) < 200000 and sum(o.total_amt_usd) > 100000 then 'second level'
else 'lowest level' end as levels
from orders o
join accounts a
on o.account_id = a.id
group by 1
order by 2 desc*/
/* 4
to the first, but we want to obtain the total amount spent by customers only in 2016 and 2017.
 Keep the same levels as in the previous question. Order with the top spending customers listed first.
select a.id ,a.name , sum(o.total_amt_usd) as total_sales, case when sum(o.total_amt_usd) > 200000 then 'top level'
when sum(o.total_amt_usd) < 200000 and sum(o.total_amt_usd) > 100000 then 'second level'
else 'lowest level' end as levels,
year(o.occurred_at)
from orders o
join accounts a
on o.account_id = a.id
where year(o.occurred_at) > '2015'
group by 1 , 2 ,o.occurred_at
order by 3 desc*/
/* 5 
identify top performing sales reps, which are sales reps associated with more than 200 orders.
 Create a table with the sales rep name, the total number of orders,
 and a column with top or not depending on if they have more than 200 orders.
 Place the top sales people first in your final table.
SELECT s.name, COUNT(*) num_ords,
        CASE WHEN COUNT(*) > 200 THEN 'top'
        ELSE 'not' END AS sales_rep_level
FROM orders o
JOIN accounts a
ON o.account_id = a.id 
JOIN sales_reps s
ON s.id = a.sales_rep_id
GROUP BY s.name
ORDER BY 2 DESC;*/
/* 6 
We would like to identify top performing sales reps,
 which are sales reps associated with more than 200 orders or more than 750000 in total sales.
 The middle group has any rep with more than 150 orders or 500000 in sales.
 Create a table with the sales rep name, the total number of orders, total sales across all orders,
 and a column with top, middle, or low depending on this criteria.
 Place the top sales people based on dollar amount of sales first in your final table.
SELECT s.name, COUNT(*) num_ords , sum(o.total_amt_usd) totall ,
        CASE WHEN COUNT(*) > 200 or sum(o.total_amt_usd) > 750000 THEN 'top'
        when COUNT(*) > 150 or sum(o.total_amt_usd) > 500000 THEN 'middle'
        else 'low' end as levels
FROM orders o
JOIN accounts a
ON o.account_id = a.id 
JOIN sales_reps s
ON s.id = a.sales_rep_id
GROUP BY s.name
ORDER BY 3 DESC*/
/*We want to find the average number of events for each day for each channel.
 The first table will provide us the number of events for each day and channel,
 and then we will need to average these values together using a second query.
select channel , avg(event_count) avg_event
from ( select DATE(occurred_at) AS month_and_day , channel , count(*) event_count
from web_events w
group by 1 , 2 ) sub
group by 1 
order by 2 desc*/
/* Use DATE TRUNC to pull month level information about the first
order ever placed in the orders table.
SELECT DATE(MIN(o.occurred_at)) AS first_order_month
FROM orders o*/
/*Use the result of the previous query to
find only the orders that took place in the
same month and year as the first order,
and then pull the average for each type of
paper qty in this month.
SELECT AVG(standard_qty) avg_std, AVG(gloss_qty) avg_gls, AVG(poster_qty) avg_pst , SUM(total_amt_usd)
FROM orders
WHERE DATE(occurred_at) = 
     (SELECT DATE(MIN(occurred_at)) FROM orders);*/
/*More Subqueries Quizzes*/
/* 1 
Provide the name of the sales_rep
 in each region with the largest amount of total_amt_usd sales.
 select region_name , max(total_amt) 
 from (select a.name , r.name region_name, sum(o.total_amt_usd) total_amt
       from sales_reps s
	   join region r
	   on r.id = s.region_id
       join accounts a
       on a.sales_rep_id = s.id
       join orders o 
       on o.account_id = a.id
       group by 1 , 2 ) t1
 group by 1*/
/* 2
For the region with the largest (sum) of sales total_amt_usd,
 how many total (count) orders were placed?
 
select r.name region_name , count(total) total_counts
from orders o
join accounts a
on o.account_id = a.id
join sales_reps s
on a.sales_rep_id = s.id
join region r
on r.id = s.region_id
group by 1
having sum(total_amt_usd) = (
select max(sum_amt)
 from (select r.name region_name ,  sum(o.total_amt_usd) sum_amt
              from orders o
                join accounts a
                on o.account_id = a.id
                join sales_reps s
                on a.sales_rep_id = s.id
                join region r
				on r.id = s.region_id
                group by 1 ) t1)*/
/* 3 
How many accounts had more total purchases than the account name 
which has bought the most standard_qty paper throughout their lifetime as a customer?

select count(*)
from(select a.name
from orders o
join accounts a
on a.id = o.account_id
group by 1
having sum(total) > ( select total
from (
select a.name , sum(o.standard_qty) std_qty , sum(o.total) total
from orders o
join accounts a
on a.id = o.account_id
group by 1
order by 2 desc
limit 1) sub1))counter_tab;*/
/* 4 
For the customer that spent the most (in total over their lifetime as a customer) total_amt_usd,
how many web_events did they have for each channel?

select a.name , w.channel , count(*)
from web_events w
join accounts a
on w.account_id = a.id and a.id = (select id 
                          from (select a.id ,a.name ,  sum(o.total_amt_usd) total_spent
                                from orders o
							    join accounts a
                                on a.id = o.account_id
								group by 1, 2
                                order by 3 desc
								limit 1) inner_sub )
group by 1 ,2
order by 3 desc;*/
/* 5 
What is the lifetime average amount spent in terms of total_amt_usd for the top 10 total spending accounts?

select avg(total_spent)
from (
select a.name , a.id , sum(o.total_amt_usd) total_spent
from orders o
join accounts a
on a.id = o.account_id
group by 1,2
order by 3 desc
limit 10 ) sub1*/
/* 6 
What is the lifetime average amount spent in terms of **total_amt_usd**,
 including only the companies that spent more per order,
 on average, than the average of all orders.
select avg(avg_amt) 
from 
( select a.name ,  o.account_id , avg(total_amt_usd) avg_amt
from orders o 
join accounts a
on o.account_id = a.id
group by 1 ,2
having avg(o.total_amt_usd) > 
( select avg(o.total_amt_usd) avg_all
from orders o ) ) sub1*/
/* CTE WITH  */
/* 1 
Provide the name of the sales_rep in each region with the largest amount of total_amt_usd sales.

with t1 as ( select r.name reg_name, sum(total_amt_usd) total_amt
FROM sales_reps s
      JOIN accounts a
      ON a.sales_rep_id = s.id
      JOIN orders o
      ON o.account_id = a.id
      JOIN region r
      ON r.id = s.region_id
      GROUP BY r.name),
t2 as (
  select max(total_amt) as max_total
  from t1
)*/
/* 2 
For the region with the largest sales total_amt_usd, how many total orders were placed? 
select r.name , count(o.total) total_counts
FROM sales_reps s
      JOIN accounts a
      ON a.sales_rep_id = s.id
      JOIN orders o
      ON o.account_id = a.id
      JOIN region r
      ON r.id = s.region_id
      GROUP BY r.name
having SUM(o.total_amt_usd) = (SELECT *  FROM t2);*/
/* 3 
For the account that purchased the most (in total over their lifetime as a customer) standard_qty paper,
 how many accounts still had more in total purchases?
with t1 as ( select a.name , sum(o.standard_qty) std_qty, sum(total) total
 from orders o
 join accounts a
 on a.id = o.account_id
 group by 1
 order by 2 desc
 limit 1 ) , 
t2 as ( SELECT a.name
      FROM orders o
      JOIN accounts a
      ON a.id = o.account_id
      group by 1
      having sum(o.total) > ( select total from t1 )
)
select count(*)
from t2*/
/* 4 
For the customer that spent the most
 (in total over their lifetime as a customer) total_amt_usd,
 how many web_events did they have for each channel?
 with t1 as (select a.id , a.name , sum(total_amt_usd) total
 from orders o
 join accounts a
 on a.id = o.account_id
 group by 1 , 2
 order by 3 desc
 limit 1 )
 select a.name , w.channel , count(*)
 from accounts a
 join web_events w
 on w.account_id = a.id and a.id = ( select id from t1 )
 group by 1 , 2
 order by 3 desc*/
/* 5 
What is the lifetime average amount spent in terms of total_amt_usd
for the top 10 total spending accounts? 
with t1 as (select a.id , a.name , sum(total_amt_usd ) total_spent
from orders o
join accounts a
on a.id = o.account_id
group by 1,2
order by 3 desc
limit 10)
select avg(total_spent)
from t1*/
/*  What is the lifetime average amount spent in terms of **total_amt_usd**,
 including only the companies that spent more per order,
 on average, than the average of all orders. 
with t1 as (select a.name  , avg(total_amt_usd) avg_spent
 from orders o join accounts a
 on o.account_id = a.id 
 group by 1 
 order by 2 desc) ,
t2 as ( select o.account_id, avg(total_amt_usd) avg_amt
 from orders o join accounts a
 on o.account_id = a.id
group by 1
 having avg(total_amt_usd) > ( select avg(avg_spent) from t1 ) )
select avg(avg_amt)
from t2*/
/*----------------- LEFT & RIGHT ---------------*/
/* 1 
In the accounts table, there is a column holding the website for each company.
 The last three digits specify what type of web address they are using.
 A list of extensions (and pricing) is provided here(opens in a new tab).
 Pull these extensions and provide how many of each website type exist in the accounts table. 
select right(website, 3) , count(*) counts_
from accounts a
group by 1
order by 2 desc*/
/* 2 
There is much debate about how much the name
 (or even the first letter of a company name)
 (opens in a new tab) matters.
 Use the accounts table to pull the first letter of each company name
 to see the distribution of company names that begin with each letter (or number).
 select left(upper(a.name), 1) , count(*)
 from accounts a
 group by 1 */
/* 3 
Use the accounts table and a CASE statement to create two groups:
 one group of company names that start with a number and a second group of those company names that start with a letter.
 What proportion of company names start with a letter?
SELECT 
    first_,
    sum_,
    (sum_ * 100.0 / total_count) AS percentage
FROM (
    SELECT 
        CASE 
            WHEN LEFT(UPPER(a.name), 1) IN ('0', '1', '2', '3', '4', '5', '6', '7', '8', '9') THEN 'num' 
            ELSE 'letter' 
        END AS first_,
        COUNT(*) AS sum_,
        (SELECT COUNT(*) FROM accounts) AS total_count
    FROM accounts a
    GROUP BY 1
) subquery;*/
/* 4 
Consider vowels as a, e, i, o, and u.
 What proportion of company names start with a vowel, and what percent start with anything else?
select vowels , counts_ , ( counts_ * 100 / total ) as percentage 
from (select case when left(a.name , 1 ) in ('a' , 'e' , 'i' , 'o','u') then 'with' else 'not' end as vowels ,
count(*) counts_ , (SELECT COUNT(*) FROM accounts) total
from accounts a
group by 1) sub1*/
/* ------- POSITION, STRPOS, & SUBSTR - AME DATA AS QUIZ 1 ------*/
/* 1 
Use the accounts table to create first and last name columns that hold the first and last names for the primary_poc.
select left(primary_poc, position(' ' in primary_poc) -1) first_name,
       right(primary_poc,length(primary_poc)-position(' ' in primary_poc)) last_name,primary_poc
from accounts a*/
/* 2 
Now see if you can do the same thing for every rep name in the sales_reps table.
 Again provide first and last name columns.
select s.name , left(s.name , position(' ' in s.name)-1) first_name , 
                right(s.name,length(s.name) - position(' ' in s.name)) last_name 
from sales_reps s*/
/* ------ CONCAT -------*/
/* 1 
Each company in the accounts table wants to create an email address for each primary_poc.
 The email address should be the first name of the primary_poc .
 last name primary_poc @ company name .com.
with t1 as (select left(primary_poc, position( ' ' in primary_poc) -1 ) first_name ,
       right(primary_poc , length(primary_poc) - position( ' ' in primary_poc) ) last_name ,
       a.name
from accounts a )
select concat(first_name , '.' , last_name , '@' , name , '.com' ) email
from t1*/
/* 2 
You may have noticed that in the previous solution some of the company names include spaces,
 which will certainly not work in an email address.
 See if you can create an email address that will work by removing all of the spaces in the account name
 but otherwise your solution should be just as in question 1.
 Some helpful documentation is here 
 
with t1 as (select left(primary_poc, position( ' ' in primary_poc) -1 ) first_name ,
       right(primary_poc , length(primary_poc) - position( ' ' in primary_poc) ) last_name ,
       a.name
from accounts a )
select concat(first_name , '.' , last_name , '@' , REPLACE(name, ' ', '') , '.com' ) email
from t1*/
/* 3
We would also like to create an initial password,
which they will change after their first log in.
The first password will be the first letter of the primary_poc's first name (lowercase),
then the last letter of their first name (lowercase), the first letter of their last name (lowercase),
the last letter of their last name (lowercase), the number of letters in their first name,
the number of letters in their last name,
and then the name of the company they are working with, all capitalized with no spaces.

with t1 as (select left(primary_poc, position( ' ' in primary_poc) -1 ) first_name ,
       right(primary_poc, length(primary_poc) - position( ' ' in primary_poc)) last_name , name
from accounts a )
select first_name , last_name , concat(first_name , '.' , last_name , '@' , replace(name,' ' ,''), '.com') email , 
       concat(left(lower(first_name),1) ,right(lower(first_name),1) , left(lower(last_name), 1) ,right(lower(last_name),1),length(first_name),length(last_name),replace(upper(name),' ' ,'')) passwords
from t1*/
/* -------------- Quiz: COALESCE --------------*/
/* 1 - 2 - 3 - 4 
SELECT coalesce(o.id,a.id) filled_id , a.* ,COALESCE(o.account_id, a.id) account_id ,  coalesce(o.standard_qty,0) filled_standard_qty, coalesce(o.gloss_qty,0) filled_gloss_qty,coalesce(o.poster_qty,0) filled_poster_qty,coalesce(o.standard_amt_usd,0) filled_standard_amt_usd,coalesce(o.gloss_amt_usd,0) filled_gloss_amt_usd,coalesce(o.poster_amt_usd,0) filled_poster_amt_usd, coalesce(o.total_amt_usd,0) filled_total_amt_usd
FROM accounts a
LEFT JOIN orders o
ON a.id = o.account_id
WHERE o.total IS NULL;*/
/* 5 
SELECT count(a.id)
FROM accounts a
LEFT JOIN orders o
ON a.id = o.account_id*/
/* 6 
SELECT coalesce(o.id,a.id) filled_id ,a.name, a.website, a.lat, a.primary_poc, a.sales_rep_id,COALESCE(o.account_id, a.id) account_id ,  coalesce(o.standard_qty,0) filled_standard_qty, coalesce(o.gloss_qty,0) filled_gloss_qty,coalesce(o.poster_qty,0) filled_poster_qty,coalesce(o.standard_amt_usd,0) filled_standard_amt_usd,coalesce(o.gloss_amt_usd,0) filled_gloss_amt_usd,coalesce(o.poster_amt_usd,0) filled_poster_amt_usd, coalesce(o.total_amt_usd,0) filled_total_amt_usd
FROM accounts a
LEFT JOIN orders o
ON a.id = o.account_id
order by 1 asc */
/* --------- Window Functions ---------*/
/* ---------OVER and PARTITION BY -----*/
/* select o.standard_amt_usd , year(occurred_at) ,
       sum(standard_amt_usd) over (partition by year(occurred_at) order by occurred_at) as running_total
from orders o*/
/* ----------- Quiz: ROW_NUMBER & RANK -----------*/
/*select id , account_id , total , rank() over ( partition by account_id order by total desc ) total_rank
from orders*/
/* Quiz: Aliases for Multiple Window Functions

SELECT id,
       account_id,
       standard_qty,
       month(occurred_at) AS month,
       DENSE_RANK() OVER account_year_window AS dense_rank_,
       SUM(standard_qty) OVER account_year_window AS sum_std_qty,
       COUNT(standard_qty) OVER account_year_window AS count_std_qty,
       AVG(standard_qty) OVER account_year_window AS avg_std_qty,
       MIN(standard_qty) OVER account_year_window AS min_std_qty,
       MAX(standard_qty) OVER account_year_window AS max_std_qty
FROM orders
window account_year_window as (PARTITION BY account_id ORDER BY month(occurred_at))*/
/* Quiz: Comparing a Row to Previous Row 

SELECT occurred_at,
       total_amt_usd,
       LEAD(total_amt_usd) OVER (ORDER BY occurred_at) AS lead_,
       LEAD(total_amt_usd) OVER (ORDER BY occurred_at) - total_amt_usd AS lead_difference
FROM (
SELECT occurred_at,
       SUM(total_amt_usd) AS total_amt_usd
  FROM orders 
 GROUP BY 1
 ) sub*/
/* Quiz: Percentiles -- Percentiles with Partitions*/
/* 1 
Use the NTILE functionality to divide the accounts into 4 levels in terms of the amount of standard_qty for their orders.
Your resulting table should have the account_id, the occurred_at time for each order, the total amount of standard_qty paper purchased,
and one of four levels in a standard_quartile column.

select account_id,occurred_at,standard_qty,ntile(4) over (PARTITION BY account_id order by standard_qty ) as standard_quartile
from orders o
ORDER BY account_id DESC;*/
/* 2 
Use the NTILE functionality to divide the accounts into two levels in terms of the amount of gloss_qty for their orders.
 Your resulting table should have the account_id, the occurred_at time for each order,
 the total amount of gloss_qty paper purchased, and one of two levels in a gloss_half column. 
 
 select account_id ,
        occurred_at ,
        gloss_qty ,
        ntile(2) over ( partition by account_id order by gloss_qty) as gloss_half
 from orders o
 order by 1 desc ;*/
/* 3 
Use the NTILE functionality to divide the orders for each account into 100 levels in terms of the amount of total_amt_usd for their orders.
Your resulting table should have the account_id, the occurred_at time for each order, the total amount of total_amt_usd paper purchased,
and one of 100 levels in a total_percentile column. 
select account_id ,
       occurred_at ,
       total_amt_usd ,
       ntile(100) over ( partition by account_id order by total_amt_usd ) as total_percentile
from orders
order by 1 desc*/
/* --------- Quiz: FULL OUTER JOIN ---------- */
/* 
 *** note : mysql doesn't support full join directly , we can do it by using left and right join ( both ) with union .
 
Say you're an analyst at Parch & Posey and you want to see:
each account who has a sales rep and each sales rep that has an account (all of the columns in these returned rows will be full)
but also each account that does not have a sales rep and each sales rep that does not have an account (some of the columns in these returned rows will be empty)
select *
from accounts a
left join sales_reps s
on s.id = a.sales_rep_id
union
select * 
from accounts a
right join sales_reps s
on s.id = a.sales_rep_id
where s.id is null or a.sales_rep_id is null */
/* ----- Quiz: JOINs with Comparison Operators ---- */
/* 
write a query that left joins the accounts table and the sales_reps tables on each sale rep's ID number
and joins it using the < comparison operator on accounts.primary_poc and sales_reps.name 

select a.name acc_name , primary_poc , s.name s_name
from accounts a
left join sales_reps s
on a.sales_rep_id = s.id and a.primary_poc < s.name*/

/*Self JOINs

select w1.id w1_id,
       w1.account_id w1_acc_id,
       w1.occurred_at w1_time,
       w1.channel w1_channel ,
       w2.id w2_id,
       w2.account_id w2_acc_id,
       w2.occurred_at w2_time,
       w2.channel w2_channel
from web_events w1
left join web_events w2 
on w1.account_id = w2.account_id
and w1.occurred_at > w2.occurred_at
and w1.occurred_at <= w2.occurred_at + interval 1 day
order by w1.account_id , w2.occurred_at*/
/* Appending Data via UNION

Write a query that uses UNION ALL on two instances (and selecting all columns) of the accounts table.
Then inspect the results and answer the subsequent quiz.

with double_accounts as (select *
from accounts a1
union all
select *
from accounts a2)

select name, count(*) name_count
from double_accounts
group by 1
order by 2 desc*/
-- the last 
/* SELECT 
    COALESCE(orders.date, web_events.date) AS date,
    orders.active_sales_reps,
    orders.orders,
    web_events.web_visits
FROM (
    SELECT 
        DATE(o.occurred_at) AS date,
        COUNT(a.sales_rep_id) AS active_sales_reps,
        COUNT(o.id) AS orders
    FROM accounts a
    JOIN orders o
    ON o.account_id = a.id
    GROUP BY DATE(o.occurred_at)
) orders
LEFT JOIN (
    SELECT 
        DATE(we.occurred_at) AS date,
        COUNT(we.id) AS web_visits
    FROM web_events_full we
    GROUP BY DATE(we.occurred_at)
) web_events
ON web_events.date = orders.date

UNION

SELECT 
    COALESCE(orders.date, web_events.date) AS date,
    orders.active_sales_reps,
    orders.orders,
    web_events.web_visits
FROM (
    SELECT 
        DATE(o.occurred_at) AS date,
        COUNT(a.sales_rep_id) AS active_sales_reps,
        COUNT(o.id) AS orders
    FROM accounts a
    JOIN orders o
    ON o.account_id = a.id
    GROUP BY DATE(o.occurred_at)
) orders
RIGHT JOIN (
    SELECT 
        DATE(we.occurred_at) AS date,
        COUNT(we.id) AS web_visits
    FROM web_events_full we
    GROUP BY DATE(we.occurred_at)
) web_events
ON web_events.date = orders.date

ORDER BY date DESC;*/


