-- employees table
select * from employees;

--1
"""
Add a new column: 
email VARCHAR(100) 
"""
alter table employees
add column email varchar(100);

--2
"""
Make the column 
email 
NOT NULL. 
"""
alter table employees
alter column email
set not null;

--3
"""
Remove the NOT NULL constraint from 
email 
"""
alter table employees
alter column email
drop not null;

--4
"""
Add a new column: 
phone_number VARCHAR(15) 
"""
alter table employees
add column phone_number varchar(15);

--5
"""
Make 
phone_number 
NOT NULL. 
"""
alter table employees
alter column phone_number
set not null;

--6
"""
Remove the NOT NULL constraint from 
phone_number 
"""
alter table employees
alter column phone_number
drop not null;

