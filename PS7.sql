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

-- 1 Show product name, category, and a label: 
'''
-> Premium → price > 10000  
-> Standard → price between 3000 and 10000  
-> Budget → below 3000 
''' 
select 
	product_name, 
	category,
	case 
		when price > 10000 then 'Premium'
		when price between 3000 and 10000 then 'Standard'
		else 'Budget'
	end as price_label
from products;

-- 2 Show all products whose price is greater than the average price of their category. 
select
	p1.product_name,
	p1.category,
	p1.price
from products p1
where p1.price > (
	select avg(p2.price)
	from products p2
	where p2.category = p1.category
);

-- 3 Show the customer who placed the highest-value order. 
select
	o.customer_name,
	(o.quantity * p.price) as order_value
from orders o
join products p
on o.product_id = p.product_id
where (o.quantity * p.price) = (
	select max(o2.quantity * p2.price)
	from orders o2
	join products p2
	on o2.product_id = p2.product_id
);

------------------------------------------------------------------------------------------


