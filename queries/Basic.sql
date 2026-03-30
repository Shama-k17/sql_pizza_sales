/*
===========================================================
 🍕 Pizza Sales Analysis - Basic SQL Queries
 Author: Shama K
 Description: This file contains basic SQL queries used to
 analyze pizza sales data.
===========================================================
*/

---========================================================
 ---Q1 Retrieve the total number of orders placed.
---========================================================
SELECT 
    COUNT(order_id) AS Total_Orders
FROM
    orders;

-- Insight:
-- The total number of orders indicates overall customer demand and business activity level.
-- A higher number of orders reflects strong sales volume and customer engagement.

---=========================================================
---Q2 Calculate the total revenue generated from pizza sales.
---===========================================================  

SELECT 
    SUM(pizzas.price * order_details.quantity) AS Revenue
FROM
    pizzas,
    order_details
WHERE
    pizzas.pizza_id = order_details.pizza_id;

---or use joins

SELECT 
    SUM(p.price * od.quantity) AS revenue
FROM 
  pizzas p
JOIN order_details od 
    ON p.pizza_id = od.pizza_id;

-- Insight:
-- Total revenue represents the overall financial performance of the business.
-- This metric helps evaluate business growth and profitability.
---================================================================
---Q3 Identify the highest-priced pizza.
---================================================================
SELECT 
    pizzas.price, pizza_types.name
FROM
    pizzas
        JOIN
    pizza_types ON pizza_types.pizza_type_id = pizzas.pizza_type_id
ORDER BY price DESC
LIMIT 1;

-- Insight:
-- The highest-priced pizza helps identify premium products in the menu.
-- These items can contribute significantly to revenue despite lower order volume.
---===============================================================
---Q4 Identify the most common pizza size ordered.
---===============================================================
SELECT 
    pizzas.size, COUNT(order_details.order_details_id) as Total_orders
FROM
    pizzas
        JOIN
    order_details ON pizzas.pizza_id = order_details.pizza_id
GROUP BY (size)
ORDER BY COUNT(*) DESC
LIMIT 1;

-- Insight:
-- The most frequently ordered pizza size reflects customer preference.
-- This insight can help optimize inventory and pricing strategies.
---==========================================================================
---Q5 List the top 5 most ordered pizza types along with their quantities.
---==========================================================================
SELECT 
    PT.name,SUM(O.quantity) AS quantity_total
FROM
    pizza_types PT
        JOIN
    pizzas P ON P.pizza_type_id = PT.pizza_type_id
        JOIN
    order_details O ON O.pizza_id = P.pizza_id
GROUP BY PT.name
ORDER BY quantity_total DESC
Limit 5;

-- Insight:
-- The top ordered pizzas highlight customer favorites and best-performing products.
-- These items are key drivers of sales and should be prioritized in marketing and promotions.

