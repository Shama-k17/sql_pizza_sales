/*
===========================================================
 🍕 Pizza Sales Analysis - Intermediate SQL Queries
 Author: Shama K
 Description: This file contains intermediate-level SQL 
 queries to analyze pizza sales data and derive insights.
===========================================================
*/

-- =========================================================
-- Q6: Find the total quantity of pizzas ordered per category
-- =========================================================
SELECT 
    pt.category, 
    SUM(od.quantity) AS total_quantity
FROM pizza_types pt
JOIN pizzas p 
    ON pt.pizza_type_id = p.pizza_type_id
JOIN order_details od 
    ON od.pizza_id = p.pizza_id
GROUP BY pt.category
ORDER BY total_quantity DESC;

-- Insight:
-- This shows which pizza category is most popular in terms of quantity sold.
-- Categories with higher quantities indicate stronger customer preference and demand.



-- =========================================================
-- Q7: Determine the distribution of orders by hour of the day
-- =========================================================
SELECT 
    HOUR(order_time) AS order_hour,
    COUNT(order_id) AS total_orders
FROM orders
GROUP BY order_hour
ORDER BY order_hour;

-- Insight:
-- This reveals peak ordering hours during the day.
-- Helps identify high-demand time slots for staffing and operational planning.



-- =========================================================
-- Q8: Find category-wise distribution of pizzas (menu variety)
-- =========================================================
SELECT 
    category, 
    COUNT(DISTINCT name) AS total_pizzas
FROM pizza_types
GROUP BY category
ORDER BY total_pizzas DESC;

-- Insight:
-- This shows how pizzas are distributed across different categories.
-- Categories with more variety may attract a wider range of customers.



-- =========================================================
-- Q9: Calculate the average number of pizzas ordered per day
-- =========================================================
SELECT 
    AVG(daily_quantity) AS avg_daily_orders
FROM (
    SELECT 
        o.order_date, 
        SUM(od.quantity) AS daily_quantity
    FROM orders o
    JOIN order_details od 
        ON o.order_id = od.order_id
    GROUP BY o.order_date
) AS daily_orders;

-- Insight:
-- This metric represents the average daily demand for pizzas.
-- Useful for forecasting, inventory planning, and resource allocation.



-- =========================================================
-- Q10: Top 3 most ordered pizzas based on revenue
-- =========================================================
SELECT 
    pt.name,
    SUM(od.quantity * p.price) AS revenue
FROM pizza_types pt
JOIN pizzas p 
    ON pt.pizza_type_id = p.pizza_type_id
JOIN order_details od 
    ON od.pizza_id = p.pizza_id
GROUP BY pt.name
ORDER BY revenue DESC
LIMIT 3;

-- Insight:
-- Identifies the highest revenue-generating pizzas.
-- These are key products that significantly impact overall business performance
-- and should be prioritized in marketing and promotions.
