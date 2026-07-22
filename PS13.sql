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

-- 1. Show employees whose manager exists. 
SELECT 
	e.employee_name
FROM employees e
JOIN employees m
ON e.manager_id = m.employee_id;

-- 2. Show employees whose manager does not exist. 
SELECT 
	e.employee_name
FROM employees e
left JOIN employees m
ON e.manager_id = m.employee_id
where m.employee_id is null;

-- 3. Show employee name and manager name for employees in the HR department. 
SELECT 
	e.employee_name,
	m.employee_name
FROM employees e
left JOIN employees m
ON e.manager_id = m.employee_id
where e.department = 'HR';

-- 4. Show employee name and manager name for employees in the IT department. 
SELECT 
	e.employee_name,
	m.employee_name
FROM employees e
left JOIN employees m
ON e.manager_id = m.employee_id
where e.department = 'IT';

-- 5. Show employee-manager pairs where both belong to the HR department. 
SELECT 
	e.employee_name,
	m.employee_name
FROM employees e
left JOIN employees m
ON e.manager_id = m.employee_id
where e.department = 'HR' and m.department = 'HR';

-- 6. Show employee-manager pairs where both belong to the IT department. 
SELECT 
	e.employee_name,
	m.employee_name
FROM employees e
left JOIN employees m
ON e.manager_id = m.employee_id
where e.department = 'IT' and m.department = 'IT';

-- 7. Show employee-manager pairs where employee and manager belong to different 
departments. 
SELECT 
	e.employee_name,
	m.employee_name
FROM employees e
left JOIN employees m
ON e.manager_id = m.employee_id
where m.department <> e.department; 

-- 8. Show employee-manager pairs where manager belongs to the Management 
department. 
SELECT 
	e.employee_name,
	m.employee_name
FROM employees e
left JOIN employees m
ON e.manager_id = m.employee_id
where m.department = 'Management';

-- 9. Show employees whose salary is at least 1.5 mes their manager's salary. 
SELECT 
	e.employee_name,
	e.salary as employee_salary,
	m.salary as manager_salary
FROM employees e
left JOIN employees m
ON e.manager_id = m.employee_id
where e.salary >= m.salary*1.5;

-- 10. Show employees whose salary is at least 3 mes their manager's salary. 
SELECT 
	e.employee_name,
	e.salary as employee_salary,
	m.salary as manager_salary
FROM employees e
left JOIN employees m
ON e.manager_id = m.employee_id
where e.salary >= m.salary*3;

-- 11. Show employees whose salary is less than half of their manager's salary. 
SELECT 
	e.employee_name,
	e.salary as employee_salary,
	m.salary as manager_salary
FROM employees e
left JOIN employees m
ON e.manager_id = m.employee_id
where e.salary < m.salary/2;

-- 12. Show employees whose salary is exactly double their manager's salary. 
SELECT 
	e.employee_name,
	e.salary as employee_salary,
	m.salary as manager_salary
FROM employees e
left JOIN employees m
ON e.manager_id = m.employee_id
where e.salary = m.salary*2;

-- 13. Show employee-manager pairs where salary difference is greater than 5000. 
SELECT 
	e.employee_name,
	e.salary as employee_salary,
	m.salary as manager_salary
FROM employees e
left JOIN employees m
ON e.manager_id = m.employee_id
where abs(e.salary-m.salary) > 5000;

-- 14. Show employee-manager pairs where salary difference is greater than 20000. 
SELECT 
	e.employee_name,
	e.salary as employee_salary,
	m.salary as manager_salary
FROM employees e
left JOIN employees m
ON e.manager_id = m.employee_id
where abs(e.salary-m.salary) > 20000;

-- 15. Show employee-manager pairs where salary difference is less than 10000. 
SELECT 
	e.employee_name,
	e.salary as employee_salary,
	m.salary as manager_salary
FROM employees e
left JOIN employees m
ON e.manager_id = m.employee_id
where abs(e.salary-m.salary) < 10000;

-- 16. Show employee-manager pairs where salary difference is between 10000 and 30000. 
SELECT 
	e.employee_name,
	e.salary as employee_salary,
	m.salary as manager_salary
FROM employees e
left JOIN employees m
ON e.manager_id = m.employee_id
where abs(e.salary-m.salary) between 10000 and 30000;

-- 17. Show employee-manager pairs where employee earns more than manager by at least 
10000. 
SELECT 
    e.employee_name,
    e.salary AS employee_salary,
    m.salary AS manager_salary
FROM employees e
JOIN employees m
ON e.manager_id = m.employee_id
WHERE e.salary - m.salary >= 10000;

-- 18. Show employee-manager pairs where manager earns more than employee by at least 
15000. 
SELECT 
    e.employee_name,
    e.salary AS employee_salary,
    m.salary AS manager_salary
FROM employees e
JOIN employees m
ON e.manager_id = m.employee_id
WHERE m.salary - e.salary >= 15000;

-- 19. Show employee name, manager name and salary difference sorted by highest salary 
difference. 
SELECT 
    e.employee_name,
    e.salary AS employee_salary,
    m.salary AS manager_salary,
	abs(e.salary-m.salary) as salary_difference
FROM employees e
JOIN employees m
ON e.manager_id = m.employee_id
order by abs(e.salary-m.salary) desc;

-- 20. Show employee-manager pair having the highest salary difference. 
WHERE m.salary - e.salary >= 15000;