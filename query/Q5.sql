#List the top 5 most ordered pizza types along with their quantities.

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

