use sql_challenge;

/*
Write a SQL which will explode the above data into single unit level records.
*/

/*
create table order_tab(
order_id varchar(20),
product_id varchar(20),
quantity int)

insert into order_tab(order_id, product_id, quantity)
values('ODR1','PRD1',5),
('ODR2','PRD2',1),
('ODR3','PRD3',3)
*/

--select * from order_tab;

with cte as(
select order_id, product_id, quantity, 1 as new_quantity
from order_tab

union all

select c.order_id, c.product_id, (c.quantity-1) as quantity, new_quantity
from cte c
where c.quantity > 1
)
select order_id,
		product_id,
		new_quantity as quantity
from cte
order by order_id, product_id
--option (maxrecursion 10)




