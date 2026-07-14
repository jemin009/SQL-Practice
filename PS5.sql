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
select upper(name) from products;

--2
select length(sku_code) from products;

--3
select name, left(sku_code,2) from products;

--4
select name, right(sku_code,4) from products;

--5
select concat(name,' - ',category) from products;

--6
select * from products
where category != 'Electronics'
and price > 1000;

--7
select * from products
where stock_quantity between 5 and 20;

--8
select * from products
where category in('Furniture','Audio','Wearables');

--9
select * from products
where name like 'B%';

--10
select * from products
where sku_code like '%44%';

--11
select count(*) from products;

--12
select sum(stock_quantity) from products;

--13
select min(price) as min_price, max(price) as max_price from products;

--14
select category, avg(price) as avg_price from products
group by category
having avg(price) > 3000;

--15
select upper(category) from products
order by category desc;

--16
select name, replace(sku_code,left(sku_code,2),'XX') from products;

--17
select concat_ws(' : ',name,category,sku_code) from products;

--18
select name,price from products
order by price
limit 1;

--19
select name,price from products
order by price desc
limit 1;

--20 
select category, count(name) from products
group by category
order by count(name) desc;
