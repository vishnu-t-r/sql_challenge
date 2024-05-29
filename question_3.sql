use sql_challenge;

/*
Write a SQL to find all Employees who earn more than the average salary in their corresponding
department.
*/

/*
create table employee(
emp_id int,
emp_name varchar(20),
salary int,
dept_id int)

insert into employee(emp_id, emp_name, salary, dept_id)
values(1001,'Mark',60000,2),
(1002,'Antony',40000,2),
(1003,'Andrew',15000,1),
(1004,'Peter',35000,1),
(1005,'John',55000,1),
(1006,'Albert',25000,3),
(1007,'Donald',35000,3)
*/

select * from employee;

--Method 1

select * from employee e
where salary > (select avg(salary) from employee f
				where f.dept_id = e.dept_id
				group by dept_id)


--Method 2

with avg_dept_salary as(
select dept_id, avg(salary) as avg_salary
from employee
group by dept_id
)
select e.emp_id,
		e.emp_name,
		e.salary,
		e.dept_id
from employee e
left join avg_dept_salary aavg
on e.dept_id = aavg.dept_id
where e.salary > aavg.avg_salary