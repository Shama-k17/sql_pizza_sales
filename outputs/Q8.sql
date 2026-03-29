#Join relevant tables to find the category-wise distribution of pizzas.

SELECT 
    category, COUNT(DISTINCT name) AS Total_Pizzas
FROM
    pizza_types
GROUP BY category;