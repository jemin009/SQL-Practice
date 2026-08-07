
CREATE TABLE employees ( 
employee_id INT PRIMARY KEY, 
first_name VARCHAR(50), 
last_name VARCHAR(50), 
department VARCHAR(50), 
salary NUMERIC(10,2), 
hire_date DATE 
);

INSERT INTO employees VALUES 
(101,'Rahul','Patel','Sales',45000,'2022-01-15'), 
(102,'Neha','Shah','HR',52000,'2021-11-20'), 
(103,'Amit','Joshi','IT',61000,'2020-09-10'), 
(104,'Riya','Mehta','Finance',58000,'2019-05-25'), 
(105,'Jay','Desai','Marketing',47000,'2023-02-12');

--1
"""
Add a column: 
status VARCHAR(20) 

Default value: 
'Active' 
"""
alter table employees
add column status varchar(20) default 'Active';

--2
"""
Add a column: 
country VARCHAR(50) 

Default value: 
'India' 
"""
alter table employees
add column country varchar(50) default 'India';

--3
"""
Change the default value of 
status 

from 
'Active' 

to 
'Working' 
"""
alter table employees
alter column status set default 'Working';

--4
"""
Remove the default value from 
country 
"""
alter table employees
alter column country
drop default;

--5
"""
Add a column 
bonus NUMERIC(10,2) 

Default value: 
0 
"""
alter table employees
add column bonus numeric(10,2) default 0;

--6
"""
Change the default value of 
bonus 

to 
5000 
"""
alter table employees
alter column bonus 
set default 5000;



