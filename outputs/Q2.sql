#Calculate the total revenue generated from pizza sales.


SELECT 
    SUM(pizzas.price * order_details.quantity) AS Revenue
FROM
    pizzas,
    order_details
WHERE
    pizzas.pizza_id = order_details.pizza_id;