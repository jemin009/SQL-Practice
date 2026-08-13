-- employees table
select * from employees;

--1
"""
Add a new column: 
employee_code INT 
"""
alter table employees
add column emploee_code int;

--2. Make employee_code the PRIMARY KEY. 
alter table employees
add constraint employee_code_primary
primary key (emploee_code);

--3. Remove the PRIMARY KEY constraint from employee_code. 
alter table employees
drop constraint employee_code_primary;

--4
"""
Add a new column: 
employee_number INT 
"""
alter table employees
add column employee_number int;

--5. Make employee_number the PRIMARY KEY. 
alter table employees
add constraint employee_number_primary
primary key (employee_number);

--6. Remove the PRIMARY KEY constraint from employee_number. 
alter table employees 
drop constraint employee_number_primary;

--7
"""
Add a new column: 
staff_id INT 
"""
alter table employees
add column staff_id int;

--8. Make staff_id the PRIMARY KEY. 
alter table employees
add constraint staf_id_primary
primary key (staff_id);

--9. Remove the PRIMARY KEY constraint from staff_id. 
alter table employees
drop constraint staff_id_primary; 

--10
"""
Add a new column: 
record_id INT 
Then make it the PRIMARY KEY using a separate statement.
"""
alter table employees
add column record_id int;