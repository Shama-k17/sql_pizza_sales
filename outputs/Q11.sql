#Calculate the percentage contribution of each pizza type to total revenue.

SELECT 
    pizza_types.name AS NAME,
    ROUND(SUM(order_details.quantity * pizzas.price) / (SELECT 
                    SUM(pizzas.price * order_details.quantity) AS Revenue
                FROM
                    pizzas,
                    order_details
                WHERE
                    pizzas.pizza_id = order_details.pizza_id) * 100,
            2) AS Percentage
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.name
ORDER BY Percentage DESC;