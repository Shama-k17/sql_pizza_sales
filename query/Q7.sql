#Determine the distribution of orders by hour of the day.

SELECT 
    COUNT(order_id), HOUR(order_time)
FROM
    orders
GROUP BY HOUR(order_time);