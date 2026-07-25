-- Create table 
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(50),
    manager_id INT,
    department VARCHAR(50),
    salary INT
);

-- Insert values 
INSERT INTO employees
(employee_id, employee_name, manager_id, department, salary)
VALUES
(1, 'Amit', NULL, 'Management', 90000),
(2, 'Ravi', 1, 'IT', 60000),
(3, 'Priya', 1, 'HR', 55000),
(4, 'Neha', 2, 'IT', 45000),
(5, 'Karan', 2, 'IT', 40000),
(6, 'Sneha', 3, 'HR', 38000),
(7, 'Vikas', 2, 'IT', 35000),
(8, 'Pooja', 3, 'HR', 32000),
(9, 'Rahul', 4, 'IT', 30000),
(10, 'Anjali', 4, 'IT', 28000),
(11, 'Deepak', 5, 'IT', 27000),
(12, 'Meera', 6, 'HR', 26000),
(13, 'Rohit', 7, 'IT', 25000),
(14, 'Nisha', 8, 'HR', 24000),
(15, 'Arjun', 9, 'IT', 22000);

select * from employees;
---------------------------------------------------------------------------------------

--1. Show employee-manager pairs where salary difference is greater than 3000. 
select 
	e.employee_name,
	m.employee_name as manager_name,
	abs(e.salary-m.salary) as salary_Dif
from employees e 
join employees m
on m.employee_id = e.manager_id
where abs(e.salary-m.salary) > 3000;

--2. Show employee-manager pairs where salary difference is greater than 8000. 
select 
	e.employee_name,
	m.employee_name as manager_name,
	abs(e.salary-m.salary) as salary_Dif
from employees e 
join employees m
on m.employee_id = e.manager_id
where abs(e.salary-m.salary) > 8000;

--3. Show employee-manager pairs where salary difference is less than 5000. 
select 
	e.employee_name,
	m.employee_name as manager_name,
	abs(e.salary-m.salary) as salary_Dif
from employees e 
join employees m
on m.employee_id = e.manager_id
where abs(e.salary-m.salary) < 5000;

--4. Show employee-manager pairs where salary difference is between 5000 and 15000. 
select 
	e.employee_name,
	m.employee_name as manager_name,
	abs(e.salary-m.salary) as salary_Dif
from employees e 
join employees m
on m.employee_id = e.manager_id
where abs(e.salary-m.salary) between 5000 and 15000; 

--5. Show employee-manager pairs where salary difference is between 10000 and 25000. 
select 
	e.employee_name,
	m.employee_name as manager_name,
	abs(e.salary-m.salary) as salary_Dif
from employees e 
join employees m
on m.employee_id = e.manager_id
where abs(e.salary-m.salary) between 10000 and 25000; 

--6. Show employee-manager pairs where salary difference is exactly 10000. 
select 
	e.employee_name,
	m.employee_name as manager_name,
	abs(e.salary-m.salary) as salary_Dif
from employees e 
join employees m
on m.employee_id = e.manager_id
where abs(e.salary-m.salary) = 10000; 

--7. Show employee-manager pairs where salary difference is greater than employee 
salary ÷ 2. 
select 
	e.employee_name,
	m.employee_name as manager_name,
	abs(e.salary-m.salary) as salary_Dif
from employees e 
join employees m
on m.employee_id = e.manager_id
where abs(e.salary-m.salary) > e.salary/2; 

--8. Show employee-manager pairs where salary difference is greater than manager 
salary ÷ 3. 
select 
	e.employee_name,
	m.employee_name as manager_name,
	abs(e.salary-m.salary) as salary_Dif
from employees e 
join employees m
on m.employee_id = e.manager_id
where abs(e.salary-m.salary) > e.salary/3; 

--9. Show employee name, manager name and salary difference sorted by lowest salary 
difference. 
select 
	e.employee_name,
	m.employee_name as manager_name,
	abs(e.salary-m.salary) as salary_Dif
from employees e 
join employees m
on m.employee_id = e.manager_id
order by abs(e.salary-m.salary);

--10. Show employee-manager pair having the 2nd highest salary difference. 
select 
	e.employee_name,
	m.employee_name as manager_name,
	abs(e.salary-m.salary) as salary_Dif
from employees e 
join employees m
on m.employee_id = e.manager_id
order by abs(e.salary-m.salary) desc
limit 1 
offset 1;