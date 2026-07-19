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

-- 1. Show products whose price is equal to the third highest price. 
select
	product_name,
	price
from products
where price = (select max(price)from products
				where price < (select max(price)from products
					where price < (select max(price)from products)));

-- 2. Show products whose price is equal to the third lowest price. 
select
	product_name,
	price
from products
where price = (select min(price)from products
				where price > (select min(price)from products
				where price > (select min(price)from products)));

-- 3. Show all products belonging to the same category as the second highest priced 
product.  
select
	product_name,
	category
from products
where category = (select category from products
					where price = (select max(price)from products
					where price < (select max(price)from products)));

-- 4. Show all products belonging to the same category as the second lowest priced 
product. 
select 
	product_name,
	price 
from products
where category = (select category from products
					where price = (select min(price) from products
					where price > (select min(price) from products)));

-- 5. Show orders for the product having the second highest price. 
SELECT 
    o.order_id,
    o.customer_name,
    o.product_id
FROM orders o
WHERE product_id = (SELECT product_id FROM products
    					WHERE price = (SELECT MAX(price) FROM products
        				WHERE price < (SELECT MAX(price) FROM products)));

-- 6. Show orders for the product having the second lowest price. 
SELECT 
    o.order_id,
    o.customer_name,
    o.product_id
FROM orders o
WHERE product_id = (SELECT product_id FROM products
    					WHERE price = (SELECT min(price) FROM products
        				WHERE price > (SELECT min(price) FROM products)));

-- 7. Show all products belonging to the category of the product having the highest stock 
quantity. 
SELECT 
	product_name, 
	category, 
	stock_quantity
FROM products
WHERE category = (SELECT category FROM products
    				WHERE stock_quantity = (SELECT MAX(stock_quantity) FROM products));

-- 8. Show all products belonging to the category of the product having the lowest stock 
quantity. 
SELECT 
	product_name, 
	category, 
	stock_quantity
FROM products
WHERE category = (SELECT category FROM products
    				WHERE stock_quantity = (SELECT min(stock_quantity) FROM products));

-- 9. Show orders for the product having the highest stock quantity. 
SELECT 
	o.order_id, 
	o.product_id
FROM orders o
WHERE product_id = (SELECT product_id FROM products
    					WHERE stock_quantity = (SELECT MAX(stock_quantity) FROM products));

-- 10. Show orders for the product having the lowest stock quantity. 
SELECT 
	o.order_id, 
	o.product_id
FROM orders o
WHERE product_id = (SELECT product_id FROM products
    					WHERE stock_quantity = (SELECT min(stock_quantity) FROM products));

-- 11. Show products belonging to the same category as the product having the highest 
price among Electronics products. 
select 
	product_name,
	category,
	price
from products
where category = (select category from products
					where price = (select max(price) from products
					where category = 'Electronics'));

-- 12. Show products belonging to the same category as the product having the lowest 
price among Electronics products. 
select 
    product_name,
    category,
    price
from products
where category = (select category from products
                    where price = (select min(price) from products
                    where category = 'Electronics'));

-- 13. Show orders placed for products belonging to the category of the most expensive 
product. 
SELECT o.order_id, o.product_id
FROM orders o
WHERE product_id IN (SELECT product_id FROM products
    					WHERE category = (SELECT category FROM products
        				WHERE price = (SELECT MAX(price) FROM products)));

-- 14. Show orders placed for products belonging to the category of the cheapest product. 
SELECT o.order_id, o.product_id
FROM orders o
WHERE product_id IN (SELECT product_id FROM products
    					WHERE category = (SELECT category FROM products
        				WHERE price = (SELECT min(price) FROM products)));


-- 15. Show products whose category matches the category of the product having the 
highest stock quantity. 
select 
	product_name,
	stock_quantity
from products
where category = (select category from products
					where stock_quantity = (select max(stock_quantity) from products));

-- 16. Show products whose category matches the category of the product having the 
lowest stock quantity. 
select 
	product_name,
	stock_quantity
from products
where category = (select category from products
					where stock_quantity = (select min(stock_quantity) from products));

-- 17. Show all orders for the product whose price is exactly the average product price. 
select 
	o.order_id,
	o.product_id
from orders o
where o.product_id = (select product_id from products 
						where price = (select avg(price) from products));

-- 18. Show all products from the category of the product whose price is closest to the 
average product price. 
SELECT 
    product_name,
    category
FROM products
WHERE category = (SELECT category FROM product
					ORDER BY ABS(price - (SELECT AVG(price) FROM products))
					ASC LIMIT 1);

-- 19. Show orders for the product having the third highest price. 
select 
	o.order_id,
	o.product_id
from orders o
where o.product_id = (select product_id from products
						where price = (select max(price) from products
						where price < (select max(price) from products
						where price < (select max(price) from products))));

-- 20. Show orders for the product having the third lowest price. 
select 
	o.order_id,
	o.product_id
from orders o
where o.product_id = (select product_id from products
						where price = (select min(price) from products
						where price > (select min(price) from products
						where price > (select min(price) from products))));