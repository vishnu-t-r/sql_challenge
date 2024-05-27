use sql_challenge;

/*
(a) Write a SQL to get all the products that got sold on both the days and the number of times the
product is sold.

(b) Write a SQL to get products that was ordered on 02-May-2099 but not on 01-May-2099
*/

/*
create table Orders(
 Order_Date date,
 Order_Id varchar(10) ,
 Product_Id varchar(10) ,
 Quantity int ,
 Price int 
) 

insert into orders (Order_Date, Order_Id, Product_Id, Quantity, Price) 
values ('2099-05-01','ODR1', 'PROD1', 5, 5),
   ('2099-05-01','ODR2', 'PROD2', 2, 10),
   ('2099-05-01','ODR3', 'PROD3', 10, 25),
   ('2099-05-01','ODR4', 'PROD1', 20, 5),
   ('2099-05-02','ODR5', 'PROD3', 5, 25),
   ('2099-05-02','ODR6', 'PROD4', 6, 20),
   ('2099-05-02','ODR7', 'PROD1', 2, 5),
   ('2099-05-02','ODR8', 'PROD5', 1, 50),
   ('2099-05-02','ODR9', 'PROD6', 2, 50),
   ('2099-05-02','ODR10','PROD2', 4, 10)
   */

select * from orders;


--(a) Write a SQL to get all the products that got sold on both the days and the number of times the
--product is sold, and the quantity sold.

--Method 1

select Product_Id, 
		count(*) as product_sold_count,
		sum(Quantity) as Total_quantity_sold
from orders
group by Product_Id
having count(distinct Order_Date) >= 2

--Method 2

select Product_Id, 
		count(*) as product_sold_count,
		sum(Quantity) as Total_quantity_sold
from orders
where Product_Id in (
			select Product_Id from (
				select Product_Id,Order_Date
				from Orders
				group by Product_Id,Order_Date
				) a 
				group by Product_Id
				having count(Order_Date) >= 2
			
			)
group by Product_Id


--Method 3

with dist_prod_date as(
select Product_Id,Order_Date
from Orders
group by Product_Id,Order_Date
),
choose_prod as(
select product_id, count(order_date) as sold_days 
from dist_prod_date
group by product_id
having count(order_date) > = 2
)
select Product_Id, 
		count(*) as product_sold_count,
		sum(Quantity) as Total_quantity_sold
from Orders
where Product_Id in (select Product_Id from choose_prod)
group by Product_Id


--(b) Write a SQL to get products that was ordered on 02-May-2024 but not on 01-May-2024

select * from orders

select distinct product_id
from orders
where Product_Id not in (select distinct Product_Id 
						from orders where order_date = '2099-05-01')
and Order_Date = '2099-05-02'

