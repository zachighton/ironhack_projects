# Lab | SQL Joins on multiple tables

# 	1	Write a query to display for each store its store ID, city, and country.

SELECT store_id, city, country FROM store
JOIN address USING(address_id)
JOIN city USING(city_id)
JOIN country USING(country_id);

#	2	Write a query to display how much business, in dollars, each store brought in.

SELECT store_id, sum(amount) as total_earnings FROM staff
JOIN payment USING(staff_id)
GROUP BY store_id;

#   3   What is the average running time of films by category?

SELECT name, AVG(length) as average_runtime FROM film
JOIN film_category USING(film_id)
JOIN category USING(category_id)
GROUP BY name;


#	4	Which film categories are longest?

SELECT name, AVG(length) as average_runtime FROM film
JOIN film_category USING(film_id)
JOIN category USING(category_id)
GROUP BY name
ORDER BY average_runtime DESC;


#	5	Display the most frequently rented movies in descending order.

SELECT title, COUNT(rental_id) as rental_freq FROM rental
JOIN inventory USING(inventory_id)
JOIN film USING(film_id)
GROUP BY title
ORDER BY rental_freq DESC;


#	6	List the top five genres in gross revenue in descending order.

SELECT name, SUM(amount) as gross_renvenue FROM category
JOIN film_category USING(category_id)
JOIN film USING(film_id)
JOIN inventory USING(film_id)
JOIN rental USING(inventory_id)
JOIN payment USING(rental_id)
GROUP BY name
ORDER BY gross_renvenue DESC;


#	7	Is "Academy Dinosaur" available for rent from Store 1?

SELECT title, store_id, return_date FROM film
JOIN inventory USING(film_id)
JOIN store USING(store_id)
JOIN rental USING(inventory_id)
WHERE store_id = 1 and title = 'Academy Dinosaur';


