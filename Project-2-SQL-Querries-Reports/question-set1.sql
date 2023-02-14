'Question 1
We want to understand more about the movies that families are watching.
The following categories are considered family movies: Animation, Children, Classics, Comedy, Family and Music.

Create a query that lists each movie, the film category it is classified in, and the number of times it has been rented out.'

SELECT film_title, category_name,  COUNT(film_title) film_count

FROM
	(SELECT f.title film_title,
     c.name category_name
    FROM    film_category fc
    JOIN    film f
    ON      fc.film_id = f.film_id
    JOIN    category c
    ON      fc.category_id = c.category_id
    JOIN 	inventory i
    ON		i.film_id = f.film_id
    JOIN	rental r
    ON		r.inventory_id = i.inventory_id) t1
  WHERE category_name IN ('Animation', 'Children', 'Classics', 'Comedy', 'Family', 'Music')
  GROUP BY 1, 2
  ORDER BY 2, 1


  "Question 2
  Now we need to know how the length of rental duration of these family-friendly movies compares to the duration that all movies are rented for.
  Can you provide a table with the movie titles and divide them into 4 levels (first_quarter, second_quarter, third_quarter, and final_quarter)
  based on the quartiles (25%, 50%, 75%) of the rental duration for movies across all categories?
  Make sure to also indicate the category that these family-friendly movies fall into.
  SELECT title, name, rental_duration, standard_quartile"


  SELECT title, name, rental_duration, standard_quartile

  FROM
  	(SELECT f.title title,
       c.name AS name,
       f.rental_duration rental_duration,
       NTILE(4) OVER(ORDER BY rental_duration) AS standard_quartile
      FROM    category c
      JOIN    film_category fc
      ON      c.category_id = fc.category_id
      JOIN    film f
      ON      f.film_id = fc.film_id) t1
    WHERE name IN ('Animation', 'Children', 'Classics', 'Comedy', 'Family', 'Music')
    GROUP BY 1, 2, 3, 4
    ORDER BY 4

   'or'

  	SELECT
        f.title title,
        c.name as name,
        f.rental_duration rental_duration,
        NTILE(4) OVER (ORDER BY rental_duration) AS standard_quartile
    FROM    category c
    JOIN    film_category fc
    ON      c.category_id = fc.category_id
    JOIN    film f
    ON      f.film_id = fc.film_id
    WHERE name IN ('Animation', 'Children', 'Classics', 'Comedy', 'Family', 'Music')




'Question 3
Finally, provide a table with the family-friendly film category, each of the quartiles,
and the corresponding count of movies within each combination of film category for each corresponding rental duration category.
The resulting table should have three columns:

Category
Rental length category
Count'

SELECT cat_name,qurts,COUNT(*)
FROM
	(SELECT film.title AS title,category.name AS cat_name,film.rental_duration,
	NTILE(4) OVER (ORDER BY film.rental_duration) as qurts
	FROM category
	JOIN film_category
	ON category.category_id=film_category.category_id
	JOIN film
	ON film.film_id=film_category.film_id
        WHERE category.name IN ('Animation', 'Children', 'Classics',    'Comedy', 'Family' , 'Music'))sub
GROUP BY 1,2
ORDER BY 1,2


SELECT name,standard_quartile,COUNT(*)
FROM
	(SELECT f.title AS title,c.name AS   name,f.rental_duration,
	NTILE(4) OVER (ORDER BY f.rental_duration) as standard_quartile
	FROM category c
	JOIN film_category fc
	ON c.category_id = fc.category_id
	JOIN film f
	ON f.film_id = fc.film_id
        WHERE c.name IN ('Animation', 'Children', 'Classics',  'Comedy', 'Family' , 'Music'))t1
GROUP BY 1,2
ORDER BY 1,2

SELECT name, standard_quartile, count(*)
FROM
	(SELECT f.title as title, c.name AS name, f.rental_duration,
    NTILE(4) OVER (ORDER BY f.rental_duration) AS standard_quartile
    FROM category c
    JOIN film_category fc
    ON c.category_id = fc.category_id
    JOIN film f
    ON f.film_id = fc.film_id
          WHERE c.name IN ('Animation', 'Children', 'Classics', 'Comedy', 'Family', 'Music'))t1
  GROUP BY 1,2
  ORDER BY 1,2
