-- ============================================
-- PHASE 2: AGGREGATION & GROUPING
-- ============================================

-- Task 1: Total revenue and rentals by film category
SELECT c.name AS category, 
       SUM(p.amount) AS total_revenue,
       COUNT(r.rental_id) AS total_rentals
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
JOIN payment p ON r.rental_id = p.rental_id
GROUP BY c.name
ORDER BY total_revenue DESC;

-- Task 2: Categories with average rental rate above $3
SELECT c.name AS category, 
       AVG(f.rental_rate) AS avg_rate,
       COUNT(f.film_id) AS num_films
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
GROUP BY c.name
HAVING AVG(f.rental_rate) > 3
ORDER BY avg_rate DESC;

-- Task 3: Top 10 highest-grossing films
SELECT f.title,
       SUM(p.amount) AS revenue,
       COUNT(r.rental_id) AS rental_count
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
JOIN payment p ON r.rental_id = p.rental_id
GROUP BY f.title
ORDER BY revenue DESC
LIMIT 10;

-- Task 4: Staff performance - rentals processed and revenue handled
SELECT s.first_name, s.last_name,
       COUNT(r.rental_id) AS rentals_processed,
       SUM(p.amount) AS revenue_handled
FROM staff s
JOIN rental r ON s.staff_id = r.staff_id
JOIN payment p ON r.rental_id = p.rental_id
GROUP BY s.first_name, s.last_name
ORDER BY rentals_processed DESC;

-- Task 5: Classify films by length (Short/Medium/Long)
SELECT title, length,
       CASE 
           WHEN length < 60 THEN 'Short'
           WHEN length BETWEEN 60 AND 120 THEN 'Medium'
           ELSE 'Long'
       END AS film_length_category
FROM film
ORDER BY length DESC;

-- Task 6: Classify rentals as On Time / Late / Not Returned
SELECT rental_id, rental_date, return_date,
       CASE 
           WHEN return_date IS NULL THEN 'Not Returned'
           WHEN return_date::date - rental_date::date > 5 THEN 'Late'
           ELSE 'On Time'
       END AS return_status
FROM rental;