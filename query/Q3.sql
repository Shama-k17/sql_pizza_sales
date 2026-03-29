#Identify the highest-priced pizza.

SELECT 
    pizzas.price, pizza_types.name
FROM
    pizzas
        JOIN
    pizza_types ON pizza_types.pizza_type_id = pizzas.pizza_type_id
ORDER BY price DESC
LIMIT 1;