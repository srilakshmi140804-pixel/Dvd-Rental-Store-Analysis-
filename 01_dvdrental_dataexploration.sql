-- ============================================
-- PHASE 1: DATA EXPLORATION & FOUNDATIONS
-- ============================================

-- Task 1: Preview the customer table
SELECT * FROM customer LIMIT 10;

-- Task 2: Preview the film table
SELECT * FROM film LIMIT 10;

-- Task 3: Films longer than 2 hours, sorted by length
SELECT title, length, rating
FROM film
WHERE length > 120
ORDER BY length DESC;

-- Task 4: Unique film ratings in the catalog
SELECT DISTINCT rating FROM film;

-- Task 5: Unique languages used
SELECT DISTINCT language_id FROM film;

-- Task 6: Total number of customers
SELECT COUNT(*) AS total_customers FROM customer;

-- Task 7: Total revenue from all payments
SELECT SUM(amount) AS total_revenue FROM payment;

-- Task 8: Average, min, and max rental rate
SELECT 
    AVG(rental_rate) AS avg_price,
    MIN(rental_rate) AS min_price,
    MAX(rental_rate) AS max_price
FROM film;

-- Task 9: Average rental duration (days)
SELECT AVG(rental_duration) AS avg_rental_days FROM film;

-- Task 10: Snapshot of PG-13 films
SELECT 
    COUNT(*) AS total_films,
    AVG(rental_rate) AS avg_price,
    AVG(length) AS avg_runtime
FROM film
WHERE rating = 'PG-13';