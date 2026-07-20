create table employees(
	employee_id serial primary key,
	employee_name varchar(50) not null,
	manager_id int,
	department varchar(30),
	salary int
);

insert into employees(employee_name, manager_id, department, salary)
values
('Amit', NULL, 'Management', 90000),
('Ravi', 1, 'IT', 60000),
('Priya', 1, 'HR', 55000),
('Neha', 2, 'IT', 45000),
('Karan', 2, 'IT', 40000),
('Sneha', 3, 'HR', 38000),
('Vikas', 2, 'IT', 35000),
('Pooja', 3, 'HR', 32000),
('Rahul', 4, 'IT', 30000),
('Anjali', 4, 'IT', 28000),
('Deepak', 5, 'IT', 27000),
('Meera', 6, 'HR', 26000),
('Rohit', 7, 'IT', 25000),
('Nisha', 8, 'HR', 24000),
('Arjun', 9, 'IT', 22000);

select * from employees;

-----------------------------------------------------------------------------------------------------

-- 1. Show employee name and their manager name. 
select 
	e.employee_name,
	m.employee_name
from employees e
join employees m
on e.manager_id = m.employee_id;

-- 2. Show all employees who have a manager. 
select
	employee_name
from employees
where manager_id is not null;

-- 3. Show all employees who do not have a manager. 
select
	employee_name
from employees
where manager_id is null;

-- 4. Show employee name and manager name only for employees in the IT department. 
select
	e.employee_name,
	m.employee_name as manager_name
from employees e
join employees m
on e.manager_id = m.employee_id
where e.department = 'IT';

-- 5. Show employee name and manager name where employee salary is greater than 
manager salary.
select
	e.employee_name,
	m.employee_name as manager_name
from employees e
join employees m
on e.manager_id = m.employee_id
where e.salary > m.salary;

-- 6. Show employee name and manager name where manager salary is greater than 
employee salary. 
select
	e.employee_name,
	e.salary,
	m.employee_name as manager_name,
	m.salary
from employees e
join employees m
on e.manager_id = m.employee_id
where m.salary > e.salary;

-- 7. Show employee name, employee salary, manager salary. 
select 
	e.employee_name,
	e.salary,
	m.salary as manager_salary
from employees e
join employees m
on e.manager_id = m.employee_id;

-- 8. Show employees and managers belonging to the same department. 
select 
	e.employee_name,
	m.employee_name
from employees e
join employees m
on e.manager_id = m.employee_id
where e.department = m.department;

-- 9. Show employees whose manager belongs to a different department. 
select 
	e.employee_name,
	m.employee_name
from employees e
join employees m
on e.manager_id = m.employee_id
where e.department != m.department;

-- 10. Show employee name and manager name sorted by manager name. 
select 
	e.employee_name,
	m.employee_name as manager_name
from employees e
join employees m
on e.manager_id = m.employee_id
order by m.employee_name;

-- 11. Show employees whose manager earns more than 50000. 
select 
	e.employee_name,
	m.salary as manager_salary
from employees e
join employees m
on e.manager_id = m.employee_id
where m.salary > 50000;

-- 12. Show employees whose manager earns less than 30000. 
select 
	e.employee_name,
	m.salary as manager_salary
from employees e
join employees m
on e.manager_id = m.employee_id
where m.salary < 30000;

-- 13. Show employee name and manager name where both salaries are equal. 
select 
	e.employee_name,
	m.salary as manager_salary
from employees e
join employees m
on e.manager_id = m.employee_id
where m.salary = e.salary;

-- 14. Show employees whose salary is at least double their manager's salary. 
select 
	e.employee_name,
	m.salary as manager_salary
from employees e
join employees m
on e.manager_id = m.employee_id
where e.salary = 2*m.salary;

-- 15. Show managers and the employees they manage. 
select 
	e.employee_name,
	m.employee_name as manager_name
from employees e
join employees m
on e.manager_id = m.employee_id;

-- 16. Count how many employees each manager manages. 
select 
	m.employee_name as manager_name,
	count(e.employee_name) as total_employees
from employees e
join employees m
on e.manager_id = m.employee_id
group by m.employee_name;

-- 17. Show the manager who manages the highest number of employees. 
select 
	m.employee_name as manager_name,
	count(e.employee_name) as total_employees
from employees e
join employees m
on e.manager_id = m.employee_id
group by m.employee_name
order by count(e.employee_name) desc
limit 1;

-- 18. Show employee-manager pairs where both belong to the Sales department. 
select 
	e.employee_name,
	m.employee_name
from employees e
join employees m
on e.manager_id = m.employee_id
where (e.department = m.department) and e.department = 'Sales';

-- 19. Show employee-manager pairs where employee salary differs from manager salary by more than 10000. 
select 
	e.employee_name,
	m.employee_name
from employees e
join employees m
on e.manager_id = m.employee_id
where e.salary >= m.salary;

-- 20. Show employee name, manager name, and salary difference. 
select 
	e.employee_name,
	m.employee_name as manager_name,
	abs(e.salary - m.salary) as salary_difference
from employees e
join employees m
on e.manager_id = m.employee_id;
