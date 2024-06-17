Create DATABASE PIZZAHUT;
use PIZZAHUT
select * from pizzas
Select * from pizza_types
Select * from orders
Select *from order_details

--- Retrive the total number of orders placed --
Select Count(order_id) as total_orders_placed from Orders;


--Calculate the total revenue generated from pizza sales.

Select 
Round(sum(order_details.quantity * pizzas.price),2) as Total_Sales
from order_details join pizzas on
pizzas.pizza_id = order_details.pizza_id;

---Identify the highest-priced pizza.

select Top 1 pizza_types.name , pizzas.price
From pizza_types join pizzas
on
pizza_types.pizza_type_id = pizzas.pizza_type_id order by pizzas.price DESC;

----Identify the most common pizza size ordered.
Select pizzas.size, Count(order_details.order_details_id) as order_count
From
pizzas join order_details ON pizzas.pizza_id = order_details.pizza_id group by pizzas.size 
Order By order_count DESC;

----List the top 5 most ordered pizza types along with their quantities.
Select Top 5 pizzas_types.name, sum(order_details.quantity) as Quantity 
from
pizza_types join pizzas on pizza_types.pizza_type_id = pizzas.pizza_type_id
join 
order_details on order_details.pizza_id = pizzas.pizza_id
Group by pizza_types.name order by Quantity DESC;
