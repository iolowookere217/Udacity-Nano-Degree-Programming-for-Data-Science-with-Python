"Question 1:
We want to find out how the two stores compare in their count of rental orders during every month for all the years we have data for.
Write a query that returns the store ID for the store, the year and month and the number of rental orders each store has fulfilled for that month.
Your table should include a column for each of the following: year, month, store ID and count of rental orders fulfilled during that month."

SELECT   	EXTRACT('month'  FROM rental_date) AS Rental_month,
			    EXTRACT('year'   FROM rental_date) AS Rental_year,
     		  str.store_id as Store_ID,
          count(r.rental_id) as count_rentals

FROM rental AS r
JOIN staff AS stf
ON  r.staff_id = stf.staff_id
JOIN store AS str
ON str.store_id = stf.store_id

group by 1, 2, 3
order by 1


"Question 2
We would like to know who were our top 10 paying customers,
how many payments they made on a monthly basis during 2007,
and what was the amount of the monthly payments.
Can you write a query to capture the customer name, month and year of payment,
and total payment amount for each month by these top 10 paying customers?


WITH t1 AS
  (SELECT c.customer_id,
          sum(amount) pay_amount
   FROM payment p
   JOIN customer c ON c.customer_id = p.customer_id
   WHERE date_part('year', payment_date) = 2007
   GROUP BY 1
   ORDER BY 2 DESC
   LIMIT 10),
t2 AS
  (SELECT date_trunc('month', payment_date) payment_month,
          t1.customer_id,
          p.amount
   FROM t1
   JOIN payment p ON t1.customer_id = p.customer_id
   JOIN customer c ON c.customer_id = p.customer_id)
Select
concat(EXTRACT('year' FROM t2.payment_month), '-0', EXTRACT('month' FROM t2.payment_month)) AS pay_month, CONCAT(c.first_name, ' ', c.last_name) as full_name,
COUNT(*) AS count_per_month,
SUM(amount) AS pay_amount
FROM t2
JOIN customer c ON c.customer_id = t2.customer_id
GROUP BY 1,2
ORDER BY 2



















SELECT r.rental_date as pay_mon, CONCAT(first_name, ' ', last_name) as fullname, p.amount as pay_amount

FROM rental AS r
JOIN customer AS c
ON  c.customer_id = r.customer_id
JOIN payment AS p
ON  p.customer_id = c.customer_id

order by 2, 1




WITH t1 AS
  (SELECT c.customer_id,
          sum(amount) total_payment
   FROM payment p
   JOIN customer c ON c.customer_id = p.customer_id
   WHERE date_part('year', payment_date) = 2007
   GROUP BY 1
   ORDER BY 2 DESC
   LIMIT 10),
t2 AS
  (SELECT date_trunc('month', payment_date) payment_month,
          t1.customer_id,
          p.amount
   FROM t1
   JOIN payment p ON t1.customer_id = p.customer_id
   JOIN customer c ON c.customer_id = p.customer_id)

SELECT t2.payment_month, CONCAT(c.first_name, ' ', c.last_name) as full_name,
COUNT(*) AS count_per_month,
SUM(amount) AS total_payment
FROM t2
JOIN customer c ON c.customer_id = t2.customer_id
GROUP BY 1,2
ORDER BY 2



SELECT date_trunc('month', payment_date) payment_month, COUNT(*) AS count_per_month, SUM(amount) AS total_payment

FROM
(SELECT date_trunc('month', payment_date) payment_month,
        t1.customer_id,
        p.amount
 FROM t1
 JOIN payment p ON t1.customer_id = p.customer_id
 JOIN customer c ON c.customer_id = p.customer_id)sub
