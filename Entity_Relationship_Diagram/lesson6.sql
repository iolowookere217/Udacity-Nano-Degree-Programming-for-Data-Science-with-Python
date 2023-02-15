"Aggregates in Window Functions with and without ORDER BY

Run the query that Derek wrote in the previous video in the first SQL Explorer below.
Keep the query results in mind; you'll be comparing them to the results of another query next."

--with order by
SELECT id,
       account_id,
       standard_qty,
       DATE_TRUNC('month', occurred_at) AS month,
       DENSE_RANK() OVER (PARTITION BY account_id ORDER BY DATE_TRUNC('month',occurred_at)) AS dense_rank,
       SUM(standard_qty) OVER (PARTITION BY account_id ORDER BY DATE_TRUNC('month',occurred_at)) AS sum_std_qty,
       COUNT(standard_qty) OVER (PARTITION BY account_id ORDER BY DATE_TRUNC('month',occurred_at)) AS count_std_qty,
       AVG(standard_qty) OVER (PARTITION BY account_id ORDER BY DATE_TRUNC('month',occurred_at)) AS avg_std_qty,
       MIN(standard_qty) OVER (PARTITION BY account_id ORDER BY DATE_TRUNC('month',occurred_at)) AS min_std_qty,
       MAX(standard_qty) OVER (PARTITION BY account_id ORDER BY DATE_TRUNC('month',occurred_at)) AS max_std_qty
FROM orders

--without order by
SELECT id,
       account_id,
       standard_qty,
       DATE_TRUNC('month', occurred_at) AS month,
       DENSE_RANK() OVER (PARTITION BY account_id ) AS dense_rank,
       SUM(standard_qty) OVER (PARTITION BY account_id) AS sum_std_qty,
       COUNT(standard_qty) OVER (PARTITION BY account_id) AS count_std_qty,
       AVG(standard_qty) OVER (PARTITION BY account_id) AS avg_std_qty,
       MIN(standard_qty) OVER (PARTITION BY account_id) AS min_std_qty,
       MAX(standard_qty) OVER (PARTITION BY account_id) AS max_std_qty
FROM orders


"The ORDER BY clause is one of two clauses integral to window functions.
The ORDER and PARTITION define what is referred to as the “window”—the ordered subset of data over which calculations are made.
Removing ORDER BY just leaves an unordered partition;
in our query's case, each column's value is simply an aggregation
(e.g., sum, count, average, minimum, or maximum) of all the standard_qty values in its respective account_id.

As Stack Overflow user mathguy explains:
The easiest way to think about this -
leaving the ORDER BY out is equivalent to 'ordering' in a way that all rows in the partition are "equal" to each other.
Indeed, you can get the same effect by explicitly adding the ORDER BY clause like this: ORDER BY 0 (or "order by" any constant expression),
or even, more emphatically, ORDER BY NULL."

SELECT id,
       account_id,
       DATE_TRUNC('year',occurred_at) AS year,
       DENSE_RANK() OVER account_year_window AS dense_rank,
       total_amt_usd,
       SUM(total_amt_usd) OVER account_year_window AS sum_total_amt_usd,
       COUNT(total_amt_usd) OVER account_year_window AS count_total_amt_usd,
       AVG(total_amt_usd) OVER account_year_window AS avg_total_amt_usd,
       MIN(total_amt_usd) OVER account_year_window AS min_total_amt_usd,
       MAX(total_amt_usd) OVER account_year_window AS max_total_amt_usd
FROM orders
WINDOW account_year_window AS (PARTITION BY account_id ORDER BY DATE_TRUNC('year',occurred_at))




'Instructor Notes

Let’s look at this again. We have broken down the syntax to explain LAG and LEAD functions separately.
check the word document (Lesson 6) for detailed explaination of LAG and LEAD Functions'



'Solutions: Comparing a Row to Previous Row
Comparing a Row to a Previous Row'
       SELECT occurred_at,
       total_amt_usd,
       LEAD(total_amt_usd) OVER (ORDER BY occurred_at) AS lead,
       LEAD(total_amt_usd) OVER (ORDER BY occurred_at) - total_amt_usd AS lead_difference
FROM (
SELECT occurred_at,
       SUM(total_amt_usd) AS total_amt_usd
  FROM orders
 GROUP BY 1
) sub


'Percentiles with Partitions'

"You can use partitions with percentiles to determine the percentile of a specific subset of all rows.
Imagine you're an analyst at Parch & Posey and you want to determine
the largest orders (in terms of quantity) a specific customer has made to encourage them to order more similarly sized large orders.
You only want to consider the NTILE for that customer's account_id."

'In the SQL Explorer below, write three queries (separately) that reflect each of the following:'

--Use the NTILE functionality to divide the accounts into 4 levels in terms of the amount of standard_qty for their orders.
--Your resulting table should have the account_id, the occurred_at time for each order,
--the total amount of standard_qty paper purchased, and one of four levels in a standard_quartile column.
SELECT
       account_id,
       occurred_at,
       standard_qty,
       NTILE(4) OVER (PARTITION BY account_id ORDER BY standard_qty) AS standard_quartile
  FROM orders
 ORDER BY account_id DESC

--Use the NTILE functionality to divide the accounts into two levels in terms of the amount of gloss_qty for their orders.
--Your resulting table should have the account_id, the occurred_at time for each order,
--total amount of gloss_qty paper purchased, and one of two levels in a gloss_half column.
SELECT
       account_id,
       occurred_at,
       gloss_qty,
       NTILE(2) OVER (PARTITION BY account_id ORDER BY gloss_qty) AS gloss_half
  FROM orders
 ORDER BY account_id DESC

--Use the NTILE functionality to divide the orders for each account into 100 levels in terms of the amount of total_amt_usd for their orders.
--Your resulting table should have the account_id, the occurred_at time for each order,
--the total amount of total_amt_usd paper purchased, and one of 100 levels in a total_percentile column.
SELECT
       account_id,
       occurred_at,
       total_amt_usd,
       NTILE(100) OVER (PARTITION BY account_id ORDER BY total_amt_usd) AS total_percentile
  FROM orders
 ORDER BY account_id DESC

'Note: To make it easier to interpret the results, order by the account_id in each of the queries.'



Percentiles with Partitions
1.

2.

3.
