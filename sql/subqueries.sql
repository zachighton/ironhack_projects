# Monday Lab - Subqueries

# 1. How many copies of the film Hunchback Impossible exist in the inventory system?

SELECT COUNT(*) FROM (SELECT * FROM inventory
WHERE film_id IN (SELECT film_id FROM film
WHERE title = 'Hunchback Impossible'))s1;

# 2. List all films whose length is longer than the average of all the films.

SELECT * FROM film
WHERE length > (SELECT AVG(length) FROM film);

# 3. Use subqueries to display all actors who appear in the film Alone Trip.

# with a join

SELECT actor_id, first_name, last_name FROM actor
JOIN film_actor USING(actor_id)
WHERE film_id = (SELECT film_id FROM film
WHERE title = 'Alone Trip');

# with only subqueries

SELECT actor_id, first_name, last_name FROM actor
WHERE actor_id IN 
(SELECT actor_id FROM film_actor
 WHERE film_id = (SELECT film_id FROM film
WHERE title = 'Alone Trip'));


# 4. Sales have been lagging among young families, and you wish to target all family movies for a promotion. 
# Identify all movies categorized as family films.

# just with subqueries

SELECT * FROM film 
WHERE film_id IN (
SELECT film_id from film_category
WHERE category_id = (SELECT category_id FROM category
WHERE name = 'Family'));

# with a join

SELECT * FROM film
JOIN film_category USING(film_id)
WHERE category_id = (SELECT category_id FROM category
WHERE name = 'Family');

# 5. Get name and email from customers from Canada using subqueries. Do the same with joins.
# Note that to create a join, you will have to identify the correct tables with their primary keys and foreign keys, 
# that will help you get the relevant information.

#with joins

SELECT first_name, last_name, email, country FROM customer
JOIN address USING(address_id)
JOIN city USING(city_id)
JOIN country USING(country_id)
WHERE country = 'Canada';

# without joins

SELECT first_name, last_name, email FROM customer
WHERE address_id IN
(SELECT address_id FROM address
WHERE city_id IN (SELECT city_id FROM city 
WHERE country_id = (SELECT country_id 
FROM country WHERE country = 'Canada')));


# 6. Which are films starred by the most prolific actor? 
# Most prolific actor is defined as the actor that has acted in the most number of films. 
# First you will have to find the most prolific actor and then use that actor_id to find the 
# different films that he/she starred.

# with a join

SELECT title FROM film_actor
JOIN film USING(film_id)
WHERE actor_id = (SELECT actor_id FROM (SELECT film_actor.actor_id, COUNT(film_id) as no_films FROM film_actor
JOIN actor USING(actor_id)
GROUP BY film_actor.actor_id
ORDER BY no_films DESC
LIMIT 1)s1);

# only with sub queries

SELECT title FROM film
WHERE film_id iN 
(SELECT film_id FROM film_actor
WHERE actor_id = (SELECT actor_id FROM (SELECT film_actor.actor_id, COUNT(film_id) as no_films FROM film_actor
GROUP BY film_actor.actor_id
ORDER BY no_films DESC
LIMIT 1)s1));

# 7. Films rented by most profitable customer. You can use the customer table 
# and payment table to find the most profitable customer ie the customer that has made the largest sum of payments

SELECT title FROM film
WHERE film_id IN 
(SELECT film_id FROM inventory 
WHERE inventory_id IN (
SELECT inventory_id FROM rental
WHERE customer_id = (
SELECT customer_id FROM (
SELECT SUM(amount) as spending, customer_id FROM payment
GROUP BY customer_id
ORDER BY spending DESC
LIMIT 1)s1)));

# 8. Customers who spent more than the average payments.

SELECT first_name, last_name FROM customer
WHERE customer_id IN (
SELECT customer_id FROM (
SELECT customer_id, SUM(amount) FROM payment
GROUP BY customer_id
HAVING SUM(amount) > 
(SELECT AVG(total) FROM 
(SELECT customer_id, SUM(amount) as total FROM payment
GROUP BY customer_id)s1))s1);