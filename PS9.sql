-- Create table products
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

-- Insert Values products
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

--Create table orders
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    product_id INT,
    quantity INT,
    order_date DATE,
    customer_name VARCHAR(50),
    payment_method VARCHAR(50),

    CONSTRAINT fk_product
        FOREIGN KEY (product_id)
        REFERENCES products(product_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

--Insert values orders
INSERT INTO orders
(order_id, product_id, quantity, order_date, customer_name, payment_method)
VALUES
(101,1,2,'2026-06-01','Rahul','UPI'),
(102,3,1,'2026-06-02','Amit','Credit Card'),
(103,2,1,'2026-06-03','Neha','Cash'),
(104,5,3,'2026-06-03','Riya','UPI'),
(105,7,2,'2026-06-04','Karan','Debit Card'),
(106,4,5,'2026-06-05','Priya','Cash'),
(107,8,1,'2026-06-06','Rohan','Credit Card'),
(108,6,2,'2026-06-07','Sneha','UPI'),
(109,9,1,'2026-06-08','Vikram','Net Banking'),
(110,10,1,'2026-06-09','Pooja','Debit Card'),
(111,1,1,'2026-06-10','Ankit','UPI'),
(112,2,2,'2026-06-11','Meera','Cash'),
(113,3,1,'2026-06-12','Yash','Credit Card'),
(114,5,1,'2026-06-13','Isha','UPI'),
(115,7,2,'2026-06-14','Arjun','Net Banking');

select * from products;
select * from orders;
------------------------------------------------------------------------------------------ 

-- 1. Show the most expensive product. 
select 
	product_name,
	price
from products
where price = (select max(price) from products);


-- 2. Show the cheapest product. 
select 
	product_name,
	price
from products
where price = (select min(price) from products);


-- 3. Show all products whose price is greater than the average product price. 
select 
	* 
from products
where price > (select avg(price) from products);


-- 4. Show all products whose price is less than the average product price. 
select 
	* 
from products
where price < (select avg(price) from products);


-- 5. Show products whose stock quan ty is greater than the average stock quantity. 
select 
	product_id,
	product_name,
	stock_quantity
from products
where stock_quantity > (select avg(stock_quantity) from products);


-- 6. Show products whose stock quan ty is less than the average stock quan ty. 
select 
	product_id,
	product_name,
	stock_quantity
from products
where stock_quantity < (select avg(stock_quantity) from products);


-- 7. Show orders having quan ty equal to the highest quan ty ordered. 
select
	order_id,
	customer_name,
	quantity
from orders
where quantity = (select max(quantity) from orders);


-- 8. Show orders having quan ty equal to the lowest quan ty ordered. 
select
	order_id,
	customer_name,
	quantity
from orders
where quantity = (select min(quantity) from orders);


-- 9. Show products whose price is equal to the second highest price. 
select 
	product_name,
	price
from products
where price = (select max(price) from products 
				where price < (select max(price) from products));


-- 10. Show products whose price is equal to the second lowest price. 
select 
	product_name,
	price
from products
where price = (select min(price) from products 
				where price > (select min(price) from products));


-- 11. Show all products belonging to the same category as the most expensive product. 
select 
	product_name,
	category
from products
where category = (
	select category from products
	where price = (select max(price) from products));


-- 12. Show all products belonging to the same category as the cheapest product. 
select 
	product_name,
	category
from products
where category = (
	select category from products
	where price = (select min(price) from products));


-- 13. Show customers who placed an order with quan ty greater than the average order quantity.
select 
	distinct customer_name
from orders
where quantity > (select avg(quantity) from orders);


-- 14. Show products whose price is greater than the minimum price in the table. 
select 
	product_name,
	price
from products
where price > (select min(price) from products);


-- 15. Show products whose stock quan ty is less than the maximum stock quan ty. 
select
	product_name,
	stock_quantity
from products
where stock_quantity < (select max(stock_quantity) from products);


-- 16. Show products whose price is between the minimum and maximum price. 
select 
	product_name,
	price
from products
where price between (select min(price) from products) and ((select max(price) from products));


-- 17. Show products whose price is not equal to the maximum price. 
select 
	product_name,
	price
from products
where price != (select max(price) from products);


-- 18. Show products whose stock quan ty is not equal to the minimum stock quan ty. 
select 
	product_name,
	stock_quantity
from products
where stock_quantity != (select min(stock_quantity) from products); 


-- 19. Show all orders for the product having the highest price. 
select
	o.order_id,
	o.customer_name,
	o.product_id
from orders o
where o.product_id = (
	select product_id from products
	where price = (select max(price)from products));


-- 20. Show all orders for the product having the lowest price. 
select
	o.order_id,
	o.customer_name,
	o.product_id
from orders o
where o.product_id = (
	select product_id from products
	where price = (select min(price)from products));
	