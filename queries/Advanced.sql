
/*
===========================================================
 🍕 Pizza Sales Analysis - Advanced SQL Queries
 Author: Shama K
 Description: This file contains advanced SQL queries 
 using window functions, subqueries, and analytical logic
 to derive deeper business insights.
===========================================================
*/

-- =========================================================
-- Q11: Calculate percentage contribution of each pizza type
-- =========================================================
SELECT 
    pt.name,
    ROUND(
        SUM(od.quantity * p.price) / (
            SELECT 
                SUM(p2.price * od2.quantity)
            FROM pizzas p2
            JOIN order_details od2 
                ON p2.pizza_id = od2.pizza_id
        ) * 100, 
    2) AS percentage_contribution
FROM pizza_types pt
JOIN pizzas p 
    ON pt.pizza_type_id = p.pizza_type_id
JOIN order_details od 
    ON od.pizza_id = p.pizza_id
GROUP BY pt.name
ORDER BY percentage_contribution DESC;

-- Insight:
-- This shows how much each pizza contributes to total revenue.
-- Helps identify high-impact products and revenue concentration.
-- A small number of pizzas contributing a large percentage indicates a strong product focus.



-- =========================================================
-- Q12: Analyze cumulative revenue over time (running total)
-- =========================================================
SELECT 
    order_date,
    SUM(daily_revenue) OVER (ORDER BY order_date) AS running_total
FROM (
    SELECT 
        o.order_date,
        SUM(od.quantity * p.price) AS daily_revenue
    FROM orders o
    JOIN order_details od 
        ON o.order_id = od.order_id
    JOIN pizzas p 
        ON od.pizza_id = p.pizza_id
    GROUP BY o.order_date
) AS sales;

-- Insight:
-- This represents cumulative revenue growth over time.
-- Helps track business performance trends and identify growth patterns.
-- A steady upward trend indicates consistent sales performance.



-- =========================================================
-- Q13: Top 3 pizzas by revenue within each category
-- =========================================================
SELECT 
    category,
    name,
    revenue
FROM (
    SELECT 
        pt.category,
        pt.name,
        SUM(od.quantity * p.price) AS revenue,
        RANK() OVER (
            PARTITION BY pt.category 
            ORDER BY SUM(od.quantity * p.price) DESC
        ) AS rnk
    FROM pizza_types pt
    JOIN pizzas p 
        ON pt.pizza_type_id = p.pizza_type_id
    JOIN order_details od 
        ON od.pizza_id = p.pizza_id
    GROUP BY pt.category, pt.name
) ranked_pizzas
WHERE rnk <= 3;

-- Insight:
-- Identifies top-performing pizzas within each category.
-- Helps understand category-level preferences and best-selling items.
-- Useful for targeted promotions and category-wise menu optimization.
