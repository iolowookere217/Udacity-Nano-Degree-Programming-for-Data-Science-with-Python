--Try pulling all the data from the accounts table, and all the data from the orders table.
SELECT orders.*, accounts.*
FROM accounts
JOIN orders
ON accounts.id = orders.account_id;

--Try pulling standard_qty, gloss_qty, and poster_qty from the orders table, and the website and the primary_poc from the accounts table.
SELECT orders.standard_qty, orders.gloss_qty,
       orders.poster_qty,  accounts.website,
       accounts.primary_poc
FROM orders
JOIN accounts
ON orders.account_id = accounts.id

--Provide a table for all web_events associated with account name of Walmart.
--There should be three columns. Be sure to include the primary_poc, time of the event, and the channel for each event.
--Additionally, you might choose to add a fourth column to assure only Walmart events were chosen.
SELECT a.primary_poc, w.occurred_at, w.channel, a.name
FROM web_events w
JOIN accounts a
ON w.account_id = a.id
WHERE a.name = 'Walmart';
--Provide a table that provides the region for each sales_rep along with their associated accounts.
--Your final table should include three columns: the region name, the sales rep name, and the account name.
--Sort the accounts alphabetically (A-Z) according to account name.
SELECT r.name region, s.name rep, a.name account
FROM sales_reps s
JOIN region r
ON s.region_id = r.id
JOIN accounts a
ON a.sales_rep_id = s.id
ORDER BY a.name;
--Provide the name for each region for every order, as well as the account name and the unit price they paid (total_amt_usd/total) for the order.
--Your final table should have 3 columns: region name, account name, and unit price.
--A few accounts have 0 for total, so I divided by (total + 0.01) to assure not dividing by zero.
SELECT r.name region, a.name account,
       o.total_amt_usd/(o.total + 0.01) unit_price
FROM region r
JOIN sales_reps s
ON s.region_id = r.id
JOIN accounts a
ON a.sales_rep_id = s.id
JOIN orders o
ON o.account_id = a.id;


'Questions AND MY SOLUTIONS'
--Provide a table that provides the region for each sales_rep along with their associated accounts.
--This time only for the Midwest region. Your final table should include three columns: the region name, the sales rep name, and the account name.
--Sort the accounts alphabetically (A-Z) according to account name.
select r.name as RegionName,
s.name as SalesRepName,
a.name as AccountName
from region r
join sales_reps s
on s.region_id = r.id
join accounts a
on a.sales_rep_id = s.id
order by AccountName

--Provide a table that provides the region for each sales_rep along with their associated accounts.
--This time only for accounts where the sales rep has a first name starting with S and in the Midwest region.
--Your final table should include three columns: the region name, the sales rep name, and the account name.
--Sort the accounts alphabetically (A-Z) according to account name.
select r.name as RegionName,
s.name as SalesRepName,
a.name as AccountName
from region r
join sales_reps s
on s.region_id = r.id
join accounts a
on a.sales_rep_id = s.id
where s.name like 'S%'and r.name in ('Midwest')
order by AccountName

--Provide a table that provides the region for each sales_rep along with their associated accounts.
--This time only for accounts where the sales rep has a last name starting with K and in the Midwest region.
--Your final table should include three columns: the region name, the sales rep name, and the account name.
--Sort the accounts alphabetically (A-Z) according to account name.
select r.name as RegionName,
s.name as SalesRepName,
a.name as AccountName
from region r
join sales_reps s
on s.region_id = r.id
join accounts a
on a.sales_rep_id = s.id
where s.name like '% K%'and r.name in ('Midwest')
order by AccountName


--Provide the name for each region for every order,
--as well as the account name and the unit price they paid (total_amt_usd/total) for the order.
--However, you should only provide the results if the standard order quantity exceeds 100.
--Your final table should have 3 columns: region name, account name, and unit price.
--In order to avoid a division by zero error, adding .01 to the denominator here is helpful total_amt_usd/(total+0.01).
select r.name as RegionName,
o.total_amt_usd/(o.total+0.01) as Price,
a.name as AccountName,
o.standard_qty StandardQTY
from region r
join sales_reps s
on s.region_id = r.id
join accounts a
on a.sales_rep_id = s.id
join orders o
on o.account_id = a.id
where o.standard_qty > 100

--Provide the name for each region for every order,
--as well as the account name and the unit price they paid (total_amt_usd/total) for the order.
--However, you should only provide the results if the standard order quantity exceeds 100 and the poster order quantity exceeds 50.
--Your final table should have 3 columns: region name, account name, and unit price. Sort for the SMALLEST unit price first.
--In order to avoid a division by zero error, adding .01 to the denominator here is helpful (total_amt_usd/(total+0.01).
select r.name as RegionName,
o.total_amt_usd/(o.total+0.01) as Price,
a.name as AccountName,
o.standard_qty StandardQTY
from region r
join sales_reps s
on s.region_id = r.id
join accounts a
on a.sales_rep_id = s.id
join orders o
on o.account_id = a.id
where o.standard_qty > 100 and o.poster_qty > 50
order by price
--Provide the name for each region for every order,
--as well as the account name and the unit price they paid (total_amt_usd/total) for the order.
--However, you should only provide the results if the standard order quantity exceeds 100 and the poster order quantity exceeds 50.
--Your final table should have 3 columns: region name, account name, and unit price. Sort for the LARGEST unit price first.
--In order to avoid a division by zero error, adding .01 to the denominator here is helpful (total_amt_usd/(total+0.01).
select r.name as RegionName,
o.total_amt_usd/(o.total+0.01) as Price,
a.name as AccountName,
o.standard_qty StandardQTY
from region r
join sales_reps s
on s.region_id = r.id
join accounts a
on a.sales_rep_id = s.id
join orders o
on o.account_id = a.id
where o.standard_qty > 100 and o.poster_qty > 50
order by price desc

What are the different channels used by account id 1001?
Your final table should have only 2 columns: account name and the different channels.
You can try SELECT DISTINCT to narrow down the results to only the unique values.
select distinct (a.name, w.channel)
from (accounts a, web_events w)
where a.id = 1001

Find all the orders that occurred in 2015.
Your final table should have 4 columns: occurred_at, account name, order total, and order total_amt_usd.


'UDACITY SOLUTIONS TO LESSON 2 QUESTIONS'

--Provide a table that provides the region for each sales_rep along with their associated accounts.
--This time only for the Midwest region.
Your final table should include three columns: the region name, the sales rep name, and the account name.
Sort the accounts alphabetically (A-Z) according to account name.
SELECT r.name region, s.name rep, a.name account
FROM sales_reps s
JOIN region r
ON s.region_id = r.id
JOIN accounts a
ON a.sales_rep_id = s.id
WHERE r.name = 'Midwest'
ORDER BY a.name;

--Provide a table that provides the region for each sales_rep along with their associated accounts.
--This time only for accounts where the sales rep has a first name starting with S and in the Midwest region.
--Your final table should include three columns: the region name, the sales rep name, and the account name.
--Sort the accounts alphabetically (A-Z) according to account name.
SELECT r.name region, s.name rep, a.name account
FROM sales_reps s
JOIN region r
ON s.region_id = r.id
JOIN accounts a
ON a.sales_rep_id = s.id
WHERE r.name = 'Midwest' AND s.name LIKE 'S%'
ORDER BY a.name;

--Provide a table that provides the region for each sales_rep along with their associated accounts.
--This time only for accounts where the sales rep has a last name starting with K and in the Midwest region.
--Your final table should include three columns: the region name, the sales rep name, and the account name.
--Sort the accounts alphabetically (A-Z) according to account name.
SELECT r.name region, s.name rep, a.name account
FROM sales_reps s
JOIN region r
ON s.region_id = r.id
JOIN accounts a
ON a.sales_rep_id = s.id
WHERE r.name = 'Midwest' AND s.name LIKE '% K%'
ORDER BY a.name;

--Provide the name for each region for every order, as well as the account name and the unit price they paid (total_amt_usd/total) for the order.
--However, you should only provide the results if the standard order quantity exceeds 100.
--Your final table should have 3 columns: region name, account name, and unit price.
SELECT r.name region, a.name account, o.total_amt_usd/(o.total + 0.01) unit_price
FROM region r
JOIN sales_reps s
ON s.region_id = r.id
JOIN accounts a
ON a.sales_rep_id = s.id
JOIN orders o
ON o.account_id = a.id
WHERE o.standard_qty > 100;

--Provide the name for each region for every order, as well as the account name and the unit price they paid (total_amt_usd/total) for the order.
--However, you should only provide the results if the standard order quantity exceeds 100 and the poster order quantity exceeds 50.
--Your final table should have 3 columns: region name, account name, and unit price. Sort for the smallest unit price first.
SELECT r.name region, a.name account, o.total_amt_usd/(o.total + 0.01) unit_price
FROM region r
JOIN sales_reps s
ON s.region_id = r.id
JOIN accounts a
ON a.sales_rep_id = s.id
JOIN orders o
ON o.account_id = a.id
WHERE o.standard_qty > 100 AND o.poster_qty > 50
ORDER BY unit_price;

--Provide the name for each region for every order, as well as the account name and the unit price they paid (total_amt_usd/total) for the order.
--However, you should only provide the results if the standard order quantity exceeds 100 and the poster order quantity exceeds 50.
--Your final table should have 3 columns: region name, account name, and unit price. Sort for the largest unit price first.
SELECT r.name region, a.name account, o.total_amt_usd/(o.total + 0.01) unit_price
FROM region r
JOIN sales_reps s
ON s.region_id = r.id
JOIN accounts a
ON a.sales_rep_id = s.id
JOIN orders o
ON o.account_id = a.id
WHERE o.standard_qty > 100 AND o.poster_qty > 50
ORDER BY unit_price DESC;

--What are the different channels used by account id 1001?
--Your final table should have only 2 columns: account name and the different channels.
--You can try SELECT DISTINCT to narrow down the results to only the unique values.
SELECT DISTINCT a.name, w.channel
FROM accounts a
JOIN web_events w
ON a.id = w.account_id
WHERE a.id = '1001';

--Find all the orders that occurred in 2015.
--Your final table should have 4 columns: occurred_at, account name, order total, and order total_amt_usd.
SELECT o.occurred_at, a.name, o.total, o.total_amt_usd
FROM accounts a
JOIN orders o
ON o.account_id = a.id
WHERE o.occurred_at BETWEEN '01-01-2015' AND '01-01-2016'
ORDER BY o.occurred_at DESC;



'RECAP
Primary and Foreign Keys
You learned a key element for JOINing tables in a database has to do with primary and foreign keys:

primary keys - are unique for every row in a table.
These are generally the first column in our database (like you saw with the id column for every table in the Parch & Posey database).

foreign keys - are the primary key appearing in another table, which allows the rows to be non-unique.

Choosing the set up of data in our database is very important, but not usually the job of a data analyst. This process is known as Database Normalization.

JOINs
In this lesson, you learned how to combine data from multiple tables using JOINs. The three JOIN statements you are most likely to use are:

JOIN - an INNER JOIN that only pulls data that exists in both tables.
LEFT JOIN - pulls all the data that exists in both tables, as well as all of the rows from the table in the FROM even if they do not exist in the JOIN statement.
RIGHT JOIN - pulls all the data that exists in both tables, as well as all of the rows from the table in the JOIN even if they do not exist in the FROM statement.
There are a few more advanced JOINs that we did not cover here, and they are used in very specific use cases. UNION and UNION ALL, CROSS JOIN, and the tricky SELF JOIN.
These are more advanced than this course will cover, but it is useful to be aware that they exist, as they are useful in special cases.

Alias
You learned that you can alias tables and columns using AS or not using it.
This allows you to be more efficient in the number of characters you need to write,
while at the same time you can assure that your column headings are informative of the data in your table.

Looking Ahead
The next lesson is aimed at aggregating data. You have already learned a ton,
but SQL might still feel a bit disconnected from statistics and using Excel like platforms.
Aggregations will allow you to write SQL code that will allow for more complex queries, which assist in answering questions like:

Which channel generated more revenue?
Which account had an order with the most items?
Which sales_rep had the most orders? or least orders? How many orders did they have?'
