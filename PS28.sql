-- Create Table
CREATE TABLE employee (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    department VARCHAR(50),
    salary NUMERIC(10,2),
    hire_date DATE
);

-- Insert Values
INSERT INTO employee VALUES
(101,'Rahul','Patel','Sales',45000,'2022-01-15'),
(102,'Neha','Shah','HR',52000,'2021-11-20'),
(103,'Amit','Joshi','IT',61000,'2020-09-10'),
(104,'Riya','Mehta','Finance',58000,'2019-05-25'),
(105,'Jay','Desai','Marketing',47000,'2023-02-12');

select * from employee;

-----------------------------------------------------------------------------------------------------------------------------

--1
"""
Add a new column named: 
Email 

Data type: 
VARCHAR(100)
"""
alter table employee
add column email varchar(100);

--2
"""
Add a new column: 
phone_number 

Datatype: 
VARCHAR(15)
"""
alter table employee
add column phone_number varchar(15);

--3
"""
Rename column 
Department 

to 
department_name
"""
alter table employee 
rename column department
to department_name;

--4
"""
Rename column 
Salary 

to 
monthly_salary
"""
alter table employee 
rename column salary
to monthly_salary;

--5
"""
Change datatype of 
phone_number 

from 
VARCHAR(15) 

to 
VARCHAR(20) 
"""
alter table employee
alter column phone_number
type varchar(15);

--6
"""
Drop column 
phone_number
"""
alter table employee
drop column phone_number;

--7
"""
Rename table 
Employees 

to 
employee_details
"""
alter table employee
rename to employee_details;

--8
"""
Rename table 
employee_details 

back to 
employees
"""
alter table employee_details
rename to employee;

--9
"""
Add a new column 
City 

Datatype: 
VARCHAR(50)
"""
alter table employee
add column city varchar(50);

--10
"""
Drop column 
city
"""
alter table employee
drop column city;