"Finding Matched and Unmatched Rows with FULL OUTER JOIN

You’re not likely to use FULL JOIN (which can also be written as FULL OUTER JOIN) too often,
but the syntax is worth practicing anyway.
LEFT JOIN and RIGHT JOIN each return unmatched rows from one of the tables—FULL JOIN returns unmatched rows from both tables.
FULL JOIN is commonly used in conjunction with aggregations to understand the amount of overlap between two tables.'

Say you're an analyst at Parch & Posey and you want to see:

each account who has a sales rep and each sales rep that has an account (all of the columns in these returned rows will be full)
but also each account that does not have a sales rep and each sales rep that does not have an account (some of the columns in these returned rows will be empty)
This type of question is rare, but FULL OUTER JOIN is perfect for it."

--In the following SQL Explorer, write a query with FULL OUTER JOIN to fit the above described Parch & Posey scenario
--(selecting all of the columns in both of the relevant tables, accounts and sales_reps) then answer the subsequent multiple choice quiz.
SELECT *
  FROM accounts
 FULL JOIN sales_reps ON accounts.sales_rep_id = sales_reps.id

"If unmatched rows existed (they don't for this query), you could isolate them by adding the following line to the end of the query:"

WHERE accounts.sales_rep_id IS NULL OR sales_reps.id IS NULL

"To elaborate on the rarity of FULL OUTER JOINS in practice, this Stack Overflow answer is helpful: When is a good situation to use a full outer join?"



'Video: JOINs with Comparison Operators
Joining without an Equals Sign

Expert Tip
If you recall from earlier lessons on joins, the join clause is evaluated before the where clause;
filtering in the join clause will eliminate rows before they are joined,
while filtering in the WHERE clause will leave those rows in and produce some nulls.'


"Inequality JOINs'
The query in Derek's video was pretty long. Let's now use a shorter query to showcase the power of joining with comparison operators.

Inequality operators (a.k.a. comparison operators) don't only need to be date times or numbers,
they also work on strings! You'll see how this works by completing the following quiz,
which will also reinforce the concept of joining with comparison operators."

--In the following SQL Explorer,
--write a query that left joins the accounts table and the sales_reps tables on each sale rep's ID number
--and joins it using the < comparison operator on accounts.primary_poc and sales_reps.name, like so: accounts.primary_poc < sales_reps.name
--The query results should be a table with three columns: the account name (e.g. Johnson Controls),
--the primary contact name (e.g. Cammy Sosnowski), and the sales representative's name (e.g. Samuel Racine).
--Then answer the subsequent multiple choice question.

SELECT accounts.name as account_name,
       accounts.primary_poc as poc_name,
       sales_reps.name as sales_rep_name
  FROM accounts
  LEFT JOIN sales_reps
    ON accounts.sales_rep_id = sales_reps.id
   AND accounts.primary_poc < sales_reps.name

Self JOINs
'Expert Tip
This comes up pretty commonly in job interviews.
Self JOIN logic can be pretty tricky -- you can see here that our join has three conditional statements.
It is important to pause and think through each step when joining a table to itself.'

'QUIZ QUESTION'
--What use case below is appropriate for self joins?
'when you want to show both parent and child relationships within a family treated
we use self join in cases when two events both occur, one after another'


'Self JOINs
One of the most common use cases for self JOINs is in cases where two events occurred, one after another.
As you may have noticed in the previous video, using inequalities in conjunction with self JOINs is common.'

--Modify the query from the previous video, which is pre-populated in the SQL Explorer below,
--to perform the same interval analysis except for the web_events table. Also:
--change the interval to 1 day to find those web events that occurred after, but not more than 1 day after, another web event
--add a column for the channel variable in both instances of the table in your query
SELECT we1.id AS we_id,
       we1.account_id AS we1_account_id,
       we1.occurred_at AS we1_occurred_at,
       we1.channel AS we1_channel,
       we2.id AS we2_id,
       we2.account_id AS we2_account_id,
       we2.occurred_at AS we2_occurred_at,
       we2.channel AS we2_channel
  FROM web_events we1
 LEFT JOIN web_events we2
   ON we1.account_id = we2.account_id
  AND we1.occurred_at > we2.occurred_at
  AND we1.occurred_at <= we2.occurred_at + INTERVAL '1 day'
ORDER BY we1.account_id, we2.occurred_at

'You can find more on the types of INTERVALS (and other date related functionality) in the Postgres documentation here.'


--What use case below is it appropriate to use a union?
'when yoy want to determine all reason students are late.
Currently, each late reason is maintained within tables correponding to the grade the student is in

That's right! The table with the students' information needs to be appended with the late reasons.
It requires no aggregation or filter, but all duplicates need to be removed.
So the final use case is the one where the UNION operator makes the most sense.'


'Appending Data via UNION'
--Write a query that uses UNION ALL on two instances (and selecting all columns) of the accounts table.
--Then inspect the results and answer the subsequent quiz.
SELECT *
    FROM accounts

UNION ALL

SELECT *
  FROM accounts

'Nice! UNION only appends distinct values. More specifically, when you use UNION, the dataset is appended,
and any rows in the appended table that are exactly identical to rows in the first table are dropped.
If you’d like to append all the values from the second table, use UNION ALL. You’ll likely use UNION ALL far more often than UNION.'


'Pretreating Tables before doing a UNION'
--Add a WHERE clause to each of the tables that you unioned in the query above,
--filtering the first table where name equals Walmart and filtering the second table where name equals Disney.
--Inspect the results then answer the subsequent quiz.
SELECT *
    FROM accounts
    WHERE name = 'Walmart'

UNION ALL

SELECT *
  FROM accounts
  WHERE name = 'Disney'

'Performing Operations on a Combined Dataset'
--Perform the union in your first query (under the Appending Data via UNION header) in a common table expression and name it double_accounts.
--Then do a COUNT the number of times a name appears in the double_accounts table.
--If you do this correctly, your query results should have a count of 2 for each name.
WITH double_accounts AS (
    SELECT *
      FROM accounts

    UNION ALL

    SELECT *
      FROM accounts
)

SELECT name,
       COUNT(*) AS name_count
 FROM double_accounts
GROUP BY 1
ORDER BY 2 DESC


"How You Can and Can't Control Performance

One way to make a query run faster is to reduce the number of calculations that need to be performed.
Some of the high-level things that will affect the number of calculations a given query will make include:

Table size
Joins
Aggregations
Query runtime is also dependent on some things that you can’t really control related to the database itself:

Other users running queries concurrently on the database
Database software and optimization (e.g., Postgres is optimized differently than Redshift)"

Additional Practice Resources
If you would like to get more practice writing SQL queries, there are several great websites to practice writing SQL queries.
Here are a couple we recommend: HackerRank and ModeAnalytics. We strongly recommend these.
The skill test by AnalyticsVidhya is a fun test to take too.

"You will need to create a profile for HackerRank and create an account for Mode Analytics, 
but these are excellent routes to gain more practice and learn more advanced skills along the way.
If you come across exercises that require knowledge on concepts you haven't learned yet,
feel free to google them. Spending time practicing, making mistakes and learning from it - that is the best way to become a master at anything!

See you in the next lesson!"
