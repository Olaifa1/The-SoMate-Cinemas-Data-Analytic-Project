create database [Pizza Data]
--
use [Pizza Data];

NOTE I USED THE IMPORT FLAT FILE WIZARD METHOD TO IMPORT ALL TEXT FILES INTO THE [Pizza Data] DATABASE
-- Using the The Import Flat File Wizard method
/**
After creating the database [Pizza Data],
Convert the .csv file to TEXT(TAB Delimited) (*.txt) file with tab as delimiter
Right click the database [Pizza Data]
A dropdown menu shows up
Click on "Task"
Click on Import flat file
Click the browse button to Browse the path of the file and click on the file
Where "DBNull.value cannot take null" error comes up,either you check your "null" box 
or if you don't want to have null value in your table, 
go back to your excel and do a proper normalization/seperation of  the tables 
till you successfully remoce all null values from your table.
Where "string" error, comes up, more often, 
the datatype used is smaller than one of the values in the table, 
change datatype with a bogger one. E.g from "tinyint" to Bigint or int.
**/
--
To view all the tables in the database [Pizza Data]
select *
from INFORMATION_SCHEMA.TABLES
--
--To view all the columns in the database [Pizza Data]
select *
from INFORMATION_SCHEMA.COLUMNS

-- To retrieve all the tables and columns in the "[Pizza Data]"
SELECT table_name = t.name, column_name = c.name
FROM sys.tables t
JOIN sys.columns c ON t.object_id = c.object_id;

select *
from customer_orders;
--
select *
from exclusions;
--
select *
from extras;
--
select *
from pizza_names;
--
select *
from pizza_recipe;
--
select *
from pizza_toppings;
--
select *
from runners;
--
select *
from runner_orders;
--


/**
QUESTION 2: Using the Pizza Data, write a query to show how many Pizzas were ordered.
**/
Select distinct count (order_id) total_pizzas_ordered
from customer_orders;


/**
QUESTION 3: Using the Pizza Data, 
write a query to show how many succesful orders were delivered by each runner.
**/

SELECT 
	runner_id, COUNT(order_id) AS number_of_successful_orders
FROM runner_orders
WHERE cancellation IS NULL
GROUP BY runner_id;

/**
QUESTION 5: Using the Pizza Data, 
write a query to show the number of each type of pizzas that was delivered.
**/

SELECT 
	pn.pizza_name, COUNT(co.order_id) AS pizza_deliveries
FROM runner_orders AS ro
LEFT JOIN customer_orders AS co 
ON ro.order_id = co.order_id
LEFT JOIN pizza_names AS pn
ON co.pizza_id = pn.pizza_id
WHERE ro.cancellation IS NULL
GROUP BY pn.pizza_name;



