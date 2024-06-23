-- 1.Rank films by length (filter out the rows with nulls or zeros in length column). Select only columns title, length and rank in your output.
SELECT 
    title, 
    length, 
    RANK() OVER (ORDER BY length DESC) AS film_rank
FROM 
    film
WHERE 
    length IS NOT NULL 
    AND length > 0;

-- 2.Rank films by length within the rating category (filter out the rows with nulls or zeros in length column). In your output, only select the columns title, length, rating and rank.

SELECT 
    title, 
    length, 
    rating, 
    RANK() OVER (PARTITION BY rating ORDER BY length DESC) AS film_rank
FROM 
    film
WHERE 
    length IS NOT NULL 
    AND length > 0;
    
    -- 3.How many films are there for each of the categories in the category table? 
    SELECT
       c.name AS category_name, 
        COUNT(fc.film_id) AS film_count
    FROM 
         category c
    JOIN 
         film_category fc ON c.category_id = fc.category_id
    GROUP BY 
         c.name;
-- 4.Which actor has appeared in the most films?     
SELECT 
    a.first_name AS actor_name, 
    COUNT(fa.film_id) AS film_count
FROM 
    actor a
JOIN 
    film_actor fa ON a.actor_id = fa.actor_id
GROUP BY 
    a.first_name
ORDER BY 
    film_count DESC
LIMIT 10;

-- 5.Which is the most active customer (the customer that has rented the most number of films)?
SELECT 
    c.first_name AS customer_name, 
    COUNT(r.rental_id) AS rental_count
FROM 
    customer c
JOIN 
    rental r ON c.customer_id = r.customer_id
GROUP BY 
    customer_name
ORDER BY 
    rental_count DESC
LIMIT 10;

-- 6.Which is the most rented film?
SELECT 
    f.title AS film_title, 
    COUNT(r.rental_id) AS rental_count
FROM 
    film f
JOIN 
    inventory i ON f.film_id = i.film_id
JOIN 
    rental r ON i.inventory_id = r.inventory_id
GROUP BY 
    f.film_id, film_title
ORDER BY 
    rental_count DESC
LIMIT 1;



SELECT * FROM customer;
SELECT * FROM rental;