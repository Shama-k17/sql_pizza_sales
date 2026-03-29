#Determine the top 3 most ordered pizza types based on revenue for each pizza category.

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
) t
WHERE rnk <= 3;