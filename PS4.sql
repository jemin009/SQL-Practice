-- Create table
create table store_items(
item_id serial primary key,
item_name varchar(100) not null,
brand varchar(50),
price numeric(10,2) check(price>=0),
stock int check(stock>=0),
category text,
rating numeric(2,1),
is_available boolean default TRUE
);

-- Insert values 
insert into store_items(item_name,brand,price,stock,category,rating,is_available)
values ('Wireless Mouse','Logitech',799,45,'Electronics',4.5,TRUE), 
		('Gaming Keyboard','Redragon',2499,15,'Electronics',4.7,TRUE), 
		('Office Chair','GreenSoul',8999,5,'Furniture',4.3,TRUE), 
		('Study Table','Ikea',5999,8,'Furniture',4.1,TRUE), 
		('Water Bottle','Milton',399,60,'Accessories',4.0,TRUE), 
		('Laptop Stand','Portronics',999,20,'Accessories',4.2,TRUE), 
		('Bluetooth Speaker','Boat',1799,12,'Audio',4.4,TRUE), 
		('Smart Watch','Noise',4999,7,'Wearables',4.6,TRUE), 
		('Notebook Pack','Classmate',299,100,'Stationery',4.1,TRUE), 
		('LED Monitor','Samsung',12499,4,'Electronics',4.8,TRUE);	

-- Show table
select * from store_items;

----- QnA ---------------------------------------------------------------------------------------------
--1
select item_name, price from store_items;

--2
select * from store_items 
where price > 5000;

--3
select * from store_items
where stock < 10;

--4
select * from store_items
where category != 'Electronics';

--5
select * from store_items
where price between 500 and 3000;

--6
select * from store_items
where category in ('Furniture','Electronics');

--7
select * from store_items
where brand like 'S%';

--8
select * from store_items
where item_name like '%Watch%';

--9
select distinct category from store_items;

--10
select category, count(*) from store_items
group by category;

--11
select category, count(*) from store_items
group by category
having count(*)>2;

--12
select category, avg(price) from store_items
group by category;

--13
select * from store_items
order by category, 
price desc;

--14
select * from store_items
order by price desc
limit 5;

--15
select item_name from store_items
where stock < 15
and price > 2000;