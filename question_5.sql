use sql_challenge;

/*
Write SQL to get the total Sales in year 2097,2098 and 2099 for all the
products as shown below.
*/

/*
create table sales(
id int,
product varchar(20),
sales_year int,
quantity_sold int)

insert into sales(id, product, sales_year, quantity_sold)
values(1,'Laptop',2097,2500),
(2,'Laptop',2098,3600),
(3,'Laptop',2099,4200),
(4,'Keyboard',2097,2300),
(5,'Keyboard',2098,4800),
(6,'Keyboard',2099,5000),
(7,'Mouse',2097,6000),
(8,'Mouse',2098,3400),
(9,'Mouse',2099,4600)
*/



--select * from sales;

select * 
	from (
		select product,
			sales_year,
			quantity_sold 
		from sales
	) base_table
pivot(
	sum(quantity_sold)
	for sales_year in 
		([2097],[2098],[2099])
) as result 
