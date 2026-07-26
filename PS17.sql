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

--1. Show employee-manager pairs where employee earns more than manager by at least 5000. 
select 
	e.employee_name,
	m.employee_name as manager_name
from employees e
join employees m
on m.employee_id = e.manager_id
where (e.salary-m.salary) >= 5000;

--2. Show employee-manager pairs where employee earns more than manager by at least 8000. 
select 
	e.employee_name,
	m.employee_name as manager_name
from employees e
join employees m
on m.employee_id = e.manager_id
where (e.salary-m.salary) >= 8000;

--3.Show employee-manager pairs where employee earns more than manager by at least 15000. 
select 
	e.employee_name,
	m.employee_name as manager_name
from employees e
join employees m
on m.employee_id = e.manager_id
where (e.salary-m.salary) >= 15000;

--4. Show employee-manager pairs where employee earns more than manager by at least 20000. 
select 
	e.employee_name,
	m.employee_name as manager_name
from employees e
join employees m
on m.employee_id = e.manager_id
where (e.salary-m.salary) >= 20000;

--5. Show employee-manager pairs where employee earns more than manager by at least 25000. 
select 
	e.employee_name,
	m.employee_name as manager_name
from employees e
join employees m
on m.employee_id = e.manager_id
where (e.salary-m.salary) >= 25000;

--6. Show employee-manager pairs where employee earns more than manager by at least 50% of manager salary. 
select 
	e.employee_name,
	m.employee_name as manager_name
from employees e
join employees m
on m.employee_id = e.manager_id
where (e.salary-m.salary) >= (m.salary/2);

--7. Show employee-manager pairs where employee earns more than manager by at least double the manager salary. 
select 
	e.employee_name,
	m.employee_name as manager_name
from employees e
join employees m
on m.employee_id = e.manager_id
where (e.salary-m.salary) >= (m.salary*2);

--8. Show employee name, manager name and salary difference where employee earns more than manager. Sort by highest salary difference. 
select 
	e.employee_name,
	m.employee_name as manager_name,
	(e.salary - m.salary) as salary_diff
from employees e
join employees m
on m.employee_id = e.manager_id
where e.salary > m.salary
order by (e.salary - m.salary) desc;

--9.Show the employee-manager pair having the highest positive salary difference (employee earning more). 
select 
	e.employee_name,
	m.employee_name as manager_name,
	(e.salary - m.salary) as salary_diff
from employees e
join employees m
on m.employee_id = e.manager_id
where e.salary > m.salary
order by (e.salary - m.salary) desc
limit 1;

--10. Show employee-manager pairs where employee earns more than manager and both belong to different departments. 
select 
	e.employee_name,
	m.employee_name as manager_name,
	(e.salary - m.salary) as salary_diff
from employees e
join employees m
on m.employee_id = e.manager_id
where e.salary > m.salary
and m.department != e.department;