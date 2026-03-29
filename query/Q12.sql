#Analyze the cumulative revenue generated over time.

select order_date,sum(Sales_Day) over (order by order_date) As Running_total
from
(SELECT 
    orders.order_date,
    SUM(order_details.quantity * pizzas.price) As Sales_Day
FROM
    order_details
        JOIN
    pizzas ON order_details.pizza_id = pizzas.pizza_id
      JOIN
    orders ON order_details.order_id = orders.order_id
      
GROUP BY orders.order_date
order by orders.order_date) as Sales;