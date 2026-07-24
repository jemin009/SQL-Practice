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

-- 1. Show employee-manager pairs where employee belongs to HR and manager belongs to IT. 
select
	e.employee_id,
	e.manager_id
from employees e
join employees m
on e.manager_id = m.employee_id
where e.department = 'HR' 
and m.department = 'IT';

-- 2.Show employee-manager pairs where employee belongs to IT and manager belongs to HR. 
select	
	e.employee_name,
	m.employee_name as manager_name
from employees e
join employees m
on e.manager_id = m.employee_id
where e.department = 'IT' 
and m.department = 'HR';

-- 3. Show employee-manager pairs where employee belongs to Sales and manager belongs to Management. 
select	
	e.employee_name,
	m.employee_name as manager_name
from employees e
join employees m
on e.manager_id = m.employee_id
where e.department = 'Sales' 
and m.department = 'Management';

-- 4. Show employee-manager pairs where employee belongs to Marketing and manager belongs to IT. 
select	
	e.employee_name,
	m.employee_name as manager_name
from employees e
join employees m
on e.manager_id = m.employee_id
where e.department = 'Marketing' 
and m.department = 'IT';

-- 5. Show employee-manager pairs where employee and manager belong to different departments and employee salary is greater than manager salary.
select	
	e.employee_name,
	m.employee_name as manager_name
from employees e
join employees m
on e.manager_id = m.employee_id
where e.department != m.department
and e.salary > m.salary;

-- 6. Show employee-manager pairs where employee and manager belong to different departments and manager salary is greater than employee salary. 
select	
	e.employee_name,
	m.employee_name as manager_name
from employees e
join employees m
on e.manager_id = m.employee_id
where e.department != m.department
and m.salary > e.salary;

-- 7. Show employee-manager pairs where employee and manager belong to different departments and employee salary difference is greater than 10000.
select	
	e.employee_name,
	m.employee_name as manager_name
from employees e
join employees m
on e.manager_id = m.employee_id
where e.department != m.department
and abs(e.salary - m.salary) > 10000;

-- 8. Show employee-manager pairs where employee belongs to HR but manager does not belong to HR.
select	
	e.employee_name,
	m.employee_name as manager_name
from employees e
join employees m
on e.manager_id = m.employee_id
where e.department = 'HR' 
and m.department != 'HR';

-- 9. Show employee-manager pairs where manager belongs to Management but employee does not belong to Management. 
select	
	e.employee_name,
	m.employee_name as manager_name
from employees e
join employees m
on e.manager_id = m.employee_id
where m.department = 'Management' 
and e.department != 'Management';

-- 10. Show employee-manager pairs where employee and manager belong to different departments and sort the result by employee department. 
select	
	e.employee_name,
	m.employee_name as manager_name
from employees e
join employees m
on e.manager_id = m.employee_id
where e.department != m.department
order by e.department;