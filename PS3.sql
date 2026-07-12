-- Create table
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    name VARCHAR(100),
    sku_code VARCHAR(20) UNIQUE,
    price DECIMAL(10,2),
    stock_quantity INT,
    is_available BOOLEAN,
    category VARCHAR(50),
    added_on DATE,
    last_update TIME,
    price_tag VARCHAR(20)
);

-- Insert Values
INSERT INTO products (product_id,name,sku_code,price,stock_quantity,is_available,category,added_on,last_update,price_tag) VALUES
(1,'Wireless Mouse','WM123456',699.99,50,TRUE,'Electronics','2026-05-21','06:02:03','Morerate'),
(2,'Mechanical Keyboard','MK987654',2499.00,30,TRUE,'Electronics','2026-05-21','06:02:03','Expensive'),
(3,'Gaming Headset','GH456789',1899.50,20,TRUE,'Electronics','2026-05-21','06:02:03','Expensive'),
(4,'USB Cable','UC112233',199.00,100,TRUE,'Accessories','2026-05-21','06:02:03','Cheap'),
(5,'Laptop Stand','LS445566',899.99,15,TRUE,'Accessories','2026-05-21','06:02:03','Morerate'),
(6,'Smart Watch','SW778899',4999.00,10,TRUE,'Wearables','2026-05-21','06:02:03','Expensive'),
(7,'Bluetooth Speaker','BS665544',1599.00,25,TRUE,'Audio','2026-05-21','06:02:03','Expensive'),
(8,'Office Chair','OC223344',7499.99,5,TRUE,'Furniture','2026-05-21','06:02:03','Expensive'),
(9,'Study Table','ST556677',5999.00,7,TRUE,'Furniture','2026-05-21','06:02:03','Expensive'),
(10,'LED Monitor','LM998877',12499.00,8,TRUE,'Electronics','2026-05-21','06:02:03','Expensive');

select * from products;

--1
select name, stock_quantity from products;

--2
select * from products
where price > 1500;

--3
select * from products
where category = 'Accessories';

--4
select * from products
order by stock_quantity desc;

--5
select * from products
limit 4;

--6
select * from products
limit 4
offset 3;

--7
select distinct is_available from products;

--8
select category, count(*) from products
group by category;

--9
select category, count(*) from products
group by category
having count(*)>2;

--10
select category, avg(stock_quantity) from products
group by category;

--11
select * from products
where price > 1000
and stock_quantity < 20;

--12
select * from products
where category = 'Furniture'
or price > 10000;

--13
select name as product_name, price as product_price from products;

--14
select category, price from products
order by category, 
price desc;

--15
select name, price from products
order by price desc
limit 3;