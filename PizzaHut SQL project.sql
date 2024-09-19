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
Select Top 5 pizza_types.name, sum(order_details.quantity) as Quantity 
from
pizza_types join pizzas on pizza_types.pizza_type_id = pizzas.pizza_type_id
join 
order_details on order_details.pizza_id = pizzas.pizza_id
Group by pizza_types.name order by Quantity DESC;


---Join the necessary tables to find the total quantity of each pizza category ordered.

Select pizza_types.category, sum(order_details.quantity) as Quantity 
from 
pizza_types join pizzas 
on pizza_types.pizza_type_id = pizzas.pizza_type_id join 
order_details on order_details.pizza_id = pizzas.pizza_id 
group by pizza_types.category order by Quantity DESC;

---Determine the distribution of orders by hour of the day.
Select * from orders
SELECT 
    DATEPART(HOUR, time) AS OrderHour,
    COUNT(order_id) AS OrderCount
FROM 
    orders
GROUP BY 
    DATEPART(HOUR,time)
ORDER BY 
    OrderHour;

---Join relevant tables to find the category-wise distribution of pizzas.	
SELECT * from pizza_types
SELECT 
	category , Count(name) as CountofName from pizza_types 
	Group BY 
	category;

---Group the orders by date and calculate the average number of pizzas ordered per day.
select * from orders
Select Avg(quantity) as AvgQuantity from 
   (SELECT orders.date, sum(order_details.quantity) as quantity
   from orders join order_details
   on orders.order_id = order_details.order_id group by orders.date) as oredr_quantity	;

---Determine the top 3 most ordered pizza types based on revenue.
   SELECT Top 3 pizza_types.name , sum(order_details.quantity * pizzas.price) as Revenue 
   from pizza_types join pizzas 
   on pizzas.pizza_type_id = pizza_types.pizza_type_id 
   Join order_details on order_details.pizza_id = pizzas.pizza_id 
   Group by pizza_types.name order by Revenue DESC;