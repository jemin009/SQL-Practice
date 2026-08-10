-- employees table

select * from employees;

--1. Make the email column UNIQUE. 
ALTER TABLE employees
ADD CONSTRAINT email_unique
UNIQUE (email);

--2. Remove the UNIQUE constraint from the email column. 
alter table employees
drop constraint email_unique;

--3. Make the phone_number column UNIQUE. 
alter table employees
add constraint phone_number_unique
unique (phone_number);

--4. Remove the UNIQUE constraint from the phone_number column. 
alter table employees
drop constraint phone_number_unique;

--5
"""
Add a new column: 
aadhaar_number VARCHAR(12) 
"""
alter table employees
add column aadhar_number varchar(12);

--6. Make aadhaar_number UNIQUE. 
alter table employees
add constraint aadhar_number_unique
unique (aadhar_number);

--7. Remove the UNIQUE constraint from aadhaar_number. 
alter table employees
drop constraint aadhar_number_unique;

--8
"""
Add a new column: 
passport_number VARCHAR(20) 
"""
alter table employees
add column passport_number varchar(20);

--9. Make passport_number UNIQUE. 
alter table employees
add constraint passport_number_unique 
unique (passport_number);

--10. Remove the UNIQUE constraint from passport_number. 
alter table employees
drop constraint passport_number_unique;		