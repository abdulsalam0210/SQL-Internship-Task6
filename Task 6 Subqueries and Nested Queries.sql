-- Task 6: Subqueries and Nested Queries
-- Author: Abdul Salam (alexabdul413@gmail.com)

USE ecommerce;

-- 1️ SCALAR SUBQUERY — Display product name and its category
SELECT name AS product_name,
       (SELECT name FROM categories WHERE categories.category_id = products.category_id) AS category_name
FROM products;

-- 2️ SIMPLE SUBQUERY WITH WHERE
-- Show all products priced above the average price
SELECT name, price
FROM products
WHERE price > (SELECT AVG(price) FROM products);

-- 3️ CORRELATED SUBQUERY
-- Find users who have placed more than one order
SELECT username
FROM users u
WHERE (SELECT COUNT(*) FROM orders o WHERE o.user_id = u.user_id) > 1;

-- 4️ SUBQUERY WITH IN
-- Show products that have been ordered at least once
SELECT name
FROM products
WHERE product_id IN (SELECT product_id FROM order_items);

-- 5️ SUBQUERY WITH EXISTS
-- Show users who have placed at least one order
SELECT username
FROM users u
WHERE EXISTS (SELECT 1 FROM orders o WHERE o.user_id = u.user_id);

-- 6️ NESTED SUBQUERY IN FROM
-- Calculate average order amount per user, and filter those above global average
SELECT username, avg_amount
FROM (
    SELECT u.username, AVG(o.total_amount) AS avg_amount
    FROM orders o
    JOIN users u ON o.user_id = u.user_id
    GROUP BY u.username
) AS user_avg
WHERE avg_amount > (SELECT AVG(total_amount) FROM orders);

-- 7️ SUBQUERY WITH MULTIPLE LEVELS
-- Show the highest priced product per category
SELECT name, price, category_id
FROM products
WHERE price = (
    SELECT MAX(price)
    FROM products AS p2
    WHERE p2.category_id = products.category_id
);

-- 8️ SUBQUERY IN SELECT (Derived Data)
-- Show each product and number of times it was ordered
SELECT p.name AS product_name,
       (SELECT COUNT(*) FROM order_items oi WHERE oi.product_id = p.product_id) AS total_orders
FROM products AS p;

-- ✅ End of Task 6 Script
